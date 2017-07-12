(*
Rough emulation of iptables' command-line arguments to generate C# code that could
be inserted into our reference switch for compilation by Kiwi to run on NetFPGA.

Nik Sultana, Cambridge University Computer Lab, April 2016

Example usage:
 ./iptablet.byte -p udp --src='!192.168.2.2' --sport=30:34 --dport=50:52 --dst='192.168.4.4'
*)

open Getopt

type protocol = Tcp | Udp | Icmp | All
type port_range = int * int option
(*type policy = Accept | Drop*)
(*NOTE By default the policy is Drop, and the user indicates what to Accept*)

(*bools indicate negation*)
type address_opt = (bool * Ipaddr.V4.t) option
type port_range_opt = (bool * port_range) option

let parse_address address_s =
  if address_s.[0] = '!' then
    (false,
     String.sub address_s 1 (String.length address_s - 1)
     |> Ipaddr.V4.of_string_exn)
  else (true, Ipaddr.V4.of_string_exn address_s)

let parse_ports ports_s =
  let parse_ports' ports_s =
    let split =
      Str.split (Str.regexp ":") ports_s
      |> List.map int_of_string
    in if List.length split = 1 then
      (List.hd split, None)
    else if List.length split = 2 then
      (*FIXME code style*)
      (List.hd split, Some (List.hd (List.tl split)))
    else failwith "Could not parse port range"
in
  if ports_s.[0] = '!' then
    (false,
     String.sub ports_s 1 (String.length ports_s - 1)
     |> parse_ports')
  else (true, parse_ports' ports_s)

let parse_protocol protocol_s =
  match protocol_s with
  | "tcp" -> Tcp
  | "udp" -> Udp
  | "icmp" -> Icmp
  | "all" -> All
  | _ -> failwith ("Unrecognised protocol: " ^ protocol_s)

let src_add = ref (None : address_opt)
and dst_add = ref (None : address_opt)
and src_port = ref (None : port_range_opt)
and dst_port = ref (None : port_range_opt)
and protocol = ref (None : protocol option)

(*Generalises atmost_once from Getopt, from string to 'a*)
let atmost_once (r : 'a option ref) exn (parse : string -> 'a) : ((string -> unit) option) =
  Some (fun x ->
   match !r with
   | None -> r := Some (parse x)
   | Some _ -> raise exn)

let param_specs = 
  [
    ('p', nolong, None,
     atmost_once protocol (Error "Duplicate" (*FIXME most suitable exn?*))
       parse_protocol);
    (noshort, "src", None,
     atmost_once src_add (Error "Duplicate" (*FIXME most suitable exn?*)) parse_address);
    (noshort, "dst", None,
     atmost_once dst_add (Error "Duplicate" (*FIXME most suitable exn?*)) parse_address);
    (noshort, "sport", None,
     atmost_once src_port (Error "Duplicate" (*FIXME most suitable exn?*)) parse_ports);
    (noshort, "dport", None,
     atmost_once dst_port (Error "Duplicate" (*FIXME most suitable exn?*)) parse_ports);
  ]

(*Get the spec from the user*)
let _ = parse_cmdline param_specs print_endline;;

(*Now check the spec a bit, and turn it into C#, possibly making references to
  our "API" (consisting of names of functions and constsants).*)
if !protocol = None then
  (*FIXME not sure if this is strictly necessary*)
  failwith "Must specify protocol"
;;

(*Check that constraints make sense*)
if !src_port <> None || !dst_port <> None then
  if !protocol <> Some Tcp && !protocol <> Some Udp then
    failwith "To constrain over ports you must specify either TCP or UDP"
;;

(*NOTE these names relate to our "API"*)
let proto_TCP_K = "proto_TCP";;
let proto_UDP_K = "proto_UDP";;
let proto_ICMP_K = "proto_ICMP";;
let endian_conversion s = "littlel(" ^ s ^ ")"

let protocol_predicate =
  match !protocol with
  | Some Tcp -> proto_TCP_K
  | Some Udp -> proto_UDP_K
  | Some Icmp -> proto_ICMP_K
  | Some All -> proto_TCP_K ^ " | " ^ proto_UDP_K ^ " | " ^ proto_ICMP_K
  | _ -> failwith "Unrecognised protocol"
;;

let to_ul s = "(ulong)(" ^ s ^ ")"
let to_ul_const s = s ^ "UL"

let src_address_K = "src_address";;
let dst_address_K = "dst_address";;
let addr_decl offset addr_r kiwi_level_var =
  match !addr_r with
  | None -> ""
  | Some (_, addr) ->
    let addr_s =
      Ipaddr.V4.to_string addr in
    let addr_i_s =
      Ipaddr.V4.to_int32 addr
      |> Int32.to_string
    in
      offset ^ "ulong " ^ kiwi_level_var ^ " = 0UL;\n" ^
      offset ^ "// " ^ kiwi_level_var ^ " set to " ^ addr_s ^ "\n" ^
      offset ^ "unchecked { " ^ kiwi_level_var ^ " = " ^ to_ul addr_i_s ^ "; }"

let addr_predicate addr_r addr_var kiwi_level_var =
  match !addr_r with
  | None -> "true"
  | Some (b, _(*we have stored the address in a variable identified by addr_var*)) ->
    if b then "(" ^ kiwi_level_var ^ " == " ^ endian_conversion addr_var ^ ")"
    else "(" ^ kiwi_level_var ^ " != " ^ endian_conversion addr_var ^ ")"

let ports_predicate port_r kiwi_level_var =
  match !port_r with
  | None -> "true"
  | Some (b, (p, pr_opt)) ->
    begin
    let p_s = string_of_int p
    in match pr_opt with
    | None ->
      if b then
        "(" ^ kiwi_level_var ^ " == " ^ endian_conversion (to_ul_const p_s) ^ ")"
      else "(" ^ kiwi_level_var ^ " != " ^ endian_conversion (to_ul_const p_s) ^ ")"
    | Some pr ->
      let pr_s = string_of_int pr in
      let pred =
        "((" ^ kiwi_level_var ^ " >= " ^ endian_conversion (to_ul_const p_s) ^ ")" ^ " && " ^
        "(" ^ kiwi_level_var ^ " <= " ^ endian_conversion (to_ul_const pr_s) ^ "))"
      in
        if b then pred
        else "(! " ^ pred ^ ")"
    end

let other_predicates =
  addr_predicate src_add src_address_K "src_ip<<32" ^ " && " ^
  "\n\t\t" ^ addr_predicate dst_add dst_address_K "dst_ip<<32" ^ " && " ^
  "\n\t\t" ^ ports_predicate src_port "app_src_port<<48" ^ " && " ^
  "\n\t\t" ^ ports_predicate dst_port "app_dst_port<<48"

let head = "// NOTE: This function was automatically generated using iptablet. Do not edit.\nstatic public bool Test() {\n\tbool result = false;\n"
let foot = "\treturn result;\n}"
let body =
   addr_decl "\t" src_add src_address_K ^ "\n" ^
   addr_decl "\t" dst_add dst_address_K ^ "\n" ^
  "\tresult = " ^ protocol_predicate ^ ";\n" ^
  "\tresult &= " ^ other_predicates ^ ";\n"
;;

(*Print the generated code*)
head ^ body ^ foot
|> print_endline

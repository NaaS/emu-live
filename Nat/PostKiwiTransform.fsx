open System
open System.IO
open System.Text.RegularExpressions
open System.Numerics

let last n (str:string) = str.Substring(str.Length - n, n)

let private main (args: string []) =
    if (args.Length <> 1) || (not <| File.Exists args.[0]) then
        failwith "Please provide a file path"

    let displayPrefix = "$display(\""
    let displayRegex = new Regex(Regex.Escape(displayPrefix))
    let mutable uid = 0

    let lines = File.ReadLines args.[0]
    let lines' =
        lines
        // Insert unique identifiers into display statements
        |> Seq.map (fun line ->
            displayRegex.Replace(line, fun m ->
                let rv = sprintf "%s#%d# " displayPrefix uid
                uid <- uid + 1
                rv
            )
        )
        // Fix incorrect constants (should be temp - FIXME)
        |> Seq.map (fun line -> line.Replace("TENNTC6_13_V_5 <= 32'sd10+$unsigned(TENNTC6_13_V_5", "TENNTC6_13_V_5 <= 32'sh010a+$unsigned(TENNTC6_13_V_5"))
        |> Seq.map (fun line -> line.Replace("TENNTC6_13_V_4 <= 32'sd10+$unsigned(TENNTC6_13_V_4", "TENNTC6_13_V_4 <= 32'sh010a+$unsigned(TENNTC6_13_V_4"))
        |> Seq.map (fun line -> line.Replace("rtl_unsigned_bitextract12(", "/*rtl_unsigned_bitextract12*/("))
        |> Seq.map (fun line -> line.Replace("rtl_sign_extend16(", "/*rtl_sign_extend16*/("))

    File.WriteAllLines(sprintf "%s.out" args.[0], lines')

let GetArgs initialArgs  =
    let rec find args matches =
        match args with
        | hd::_ when hd = "--" -> List.toArray (matches)
        | hd::tl -> find tl (hd::matches)
        | [] -> Array.empty
    find (List.rev (Array.toList initialArgs) ) []
fsi.CommandLineArgs |> GetArgs |> main

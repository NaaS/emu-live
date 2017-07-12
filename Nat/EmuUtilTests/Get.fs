(*
Get : unit tests for the EmuUtil.NetFPGA_Util.GetBytes method
Jonny Shipton, Cambridge University Computer Lab, August 2016

This software was developed by the University of Cambridge,
Computer Laboratory under EPSRC NaaS Project EP/K034723/1 

Use of this source code is governed by the Apache 2.0 license; see LICENSE file
*)

namespace EmuUtilTests.NetFPGA_Util

open FsCheck
open FsCheck.Xunit
open global.Xunit
open Swensen.Unquote.Assertions

open EmuUtil

module Get =
    // Array for const tests - the data has no meaning
    let dataArr =
        [|  0x0706050403020100uL;
            0x0f0e0d0c0b0a0908uL;
            0x1716151413121110uL; |]

    // Const tests for GetBytes(...)
    [<Fact>]
    let ``GetBytes(dataArr, 0, 8)`` () =
        // Check that the first 8 bytes are equivalent to the first ulong in the array
        NetFPGA_Util.GetBytes(dataArr, 0, 8) =! dataArr.[0]

    [<Fact>]
    let ``GetBytes(dataArr, 2, 8)`` () =
        // Check that getting 8 bytes across a boundary (meaning data is in two different ulongs) works
        NetFPGA_Util.GetBytes(dataArr, 2, 8) =! 0x0908070605040302uL

    [<Fact>]
    let ``GetBytes(dataArr, 2, 6)`` () =
        // Check that getting 6 bytes at an offset of 2 works
        NetFPGA_Util.GetBytes(dataArr, 2, 6) =! 0x070605040302uL

    [<Fact>]
    let ``GetBytes(dataArr, 2, 4)`` () =
        // Check that getting 4 bytes at an offset of 2 works. This checks that the bits are masked properly,
        // as the requested data is in the middle with bits either side.
        NetFPGA_Util.GetBytes(dataArr, 2, 4) =! 0x05040302uL

    [<Fact>]
    let ``GetBytes(dataArr, 3, 6)`` () =
        // Check that getting 6 bytes at an offset of 3 works. This is an odd offset, and also crosses a
        // boundary (so data is in two different ulongs)
        NetFPGA_Util.GetBytes(dataArr, 3, 6) =! 0x080706050403uL

    // Generator of random data for GetBytes(...) parameters
    let getGen =
        Arb.fromGen
            (gen {
                // Generate an array of size 1-4
                let! len = Gen.choose (1, 4)
                let! arr = Gen.arrayOfLength len Arb.from<uint64>.Generator
                // Generate a valid offset
                let! offset = Gen.choose (0, len * 8 - 1)
                // Generate a valid length
                let! length = Gen.choose (1, System.Math.Min(8, len * 8 - offset))
                return (arr, offset, length)
            })

    // 'Reference' implementation of GetBytes for testing against
    let altGet (data:uint64[], offset, length) =
        let bytes =
            data
            |> Seq.map System.BitConverter.GetBytes
            |> Seq.concat
            |> Seq.skip offset
            |> Seq.take length
            |> Seq.append <| Array.zeroCreate 8 // Make sure the resulting array is at least 8 bytes
            |> Seq.toArray
        System.BitConverter.ToUInt64 (bytes, 0)

    // Test GetBytes(...) against the reference impl on random data
    [<Property>]
    let ``GetBytes(dataArr, offset, length) works with random data`` () =
        Prop.forAll getGen (fun ((data, offset, length) as p) ->
            NetFPGA_Util.GetBytes(data, offset, length) =! altGet p
        )

    // Tests for altGet (the reference Get implementation), just to make sure. They are the same as the const tests for GetBytes above
    [<Fact>]
    let ``altGet(dataArr, 0, 8)`` () =
        altGet(dataArr, 0, 8) =! dataArr.[0]

    [<Fact>]
    let ``altGet(dataArr, 2, 8)`` () =
        altGet(dataArr, 2, 8) =! 0x0908070605040302uL

    [<Fact>]
    let ``altGet(dataArr, 2, 6)`` () =
        altGet(dataArr, 2, 6) =! 0x070605040302uL

    [<Fact>]
    let ``altGet(dataArr, 2, 4)`` () =
        altGet(dataArr, 2, 4) =! 0x05040302uL

    [<Fact>]
    let ``altGet(dataArr, 3, 6)`` () =
        altGet(dataArr, 3, 6) =! 0x080706050403uL

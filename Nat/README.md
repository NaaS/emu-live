NAT
=====

This directory contains the code for a NAT implementation using Emu/Kiwi for NetFPGA.

Directory Structure
--------------------
```
Nat
|
+---EmuUtil         - Utility functionality like bit fiddling
|
+---EmuUtilTests    - Unit tests for fiddly parts of EmuUtil
|
+---mn_test         - Python scripts for testing with Pax
|
+---Mocks           - Classes to emulate Emu/NetFPGA behaviour for running in sw
|
+---[Files]         - The NAT implementation
```

Dependencies
-------------

The EmuUtilTests project relies on [Xunit](https://xunit.github.io/),
[Unquote](http://www.swensensoftware.com/unquote) and
[FsCheck](https://fscheck.github.io/FsCheck/). These are all automatically
resolved at build time by [Paket](http://fsprojects.github.io/Paket/), a .NET package manager.

As with Emu, the NAT implementation is completely reliant on
[Kiwi](http://www.cl.cam.ac.uk/~djg11/kiwi/) to target the
[NetFPGA](http://netfpga.org/) platform. *This revision of the NAT has only been tested using
the git SHA 995b276f89a72ac323468214357803890c62df44 revision of Kiwi, and relies on very
fragile workarounds that may no longer work or indeed be necessary.*

The NAT implementation can also be run in software via [Pax](https://github.com/niksu/pax),
and the test scripts in `mn_test` are for running on Pax in [Mininet](http://mininet.org/).


Building
--------
1. build Emu (by running `make emu` in the emu directory).
2. build [Pax](https://github.com/niksu/pax) following the instructions provided with it.
3. set the following environment variables: `PAX` to point to pax directory, and `HPRLS` to point to Kiwi's bitbucket folder.


Testing
--------

The unit tests in `EmuUtilTests` use Xunit, and so can be run with the Visual Studio test
runner after installing the `xunit.runner.visualstudio` nuget package, or alternately, by
running the [`test.sh`](EmuUtilTests/test.sh) script. These tests (currently) mostly check
the behaviour of bit twiddling utility methods, which are well suited to unit testing.

The NAT implementation can be tested fairly easily and quickly by compiling with the Release
configuration (`xbuild /p:Configuration=Release Nat.sln`) and running the Mininet test script.
This can be done by running `sudo PAX=[path to Pax repo clone] python mn_test/nat_topo.py test`;
if not running in X windows then remember to include `--no-X` before `test`.
Currently this script only tests a single TCP connection, but could be easily
extended for UDP or more complex tests if needed.

Workflow
---------

The Debug configuration can be used to run the NAT with hardcoded packet data for step-through
debugging or comparison with the simulation output. The data is hardcoded inside the
Bootstrap.cs file.

To compile to Verilog with Kiwi, run `make out/Nat.v` from inside the `emu` folder. This takes
around 3.5 minutes on my laptop. This uses the `Kiwi` configuration, which mostly just means
that the KIWI constant symbol is defined, which conditionally compiles some code.

There is a post-processing step that is run by the Makefile - `PostKiwiTransform.fsx`.
This consists of various text-replace operations to (very hack-ily) workaround bugs in Kiwi.
Ideally this script will become unnecessary as the bugs are fixed in Kiwi.

Once compiled to Verilog, copy `Nat.v` to the kiwi_src folder (a different machine for me) and
run `make Nat`. This will hook the NAT implementation into the Emu workflow. The simulation
test can then be run with
`$SUME_FOLDER/tools/scripts/nf_test.py sim --major simple --minor experiment`. The hardware
tests can be run in a similar fashion - follow the readme in `netfpga_src`.

The NAT implementation can also be tested in Mininet by running the Release configuration on
Pax. This can be useful for larger scale testing, such as with `netcat`.

When a problem arises, it is often best to try and resolve it using the quickest-turn-around
development cycle which you can. By this I mean for logic errors, use the Debug configuration
so that you can test changes within seconds - don't go all the way to simulation just to
realise you have missed a digit from a constant, for example. This may involve copying the
packet data from the simulation test script (print the hex with `str(pkt).encode("HEX")`)
into the `Bootstrap` class.

When debugging discrepancies between the expected and actual output, first check your logic
works when running in sw (with the Debug configuration), and that the data used matches that
used in the simulation test script. If it does, then it means that the problem most likely
lies with Kiwi. It may be that a simple change to your code will workaround/fix it, or it
may be that there is deeper problem. Try to isolate the Verilog that matches the C# around the
area where the problem is, using print statements. Try to correlate the Verilog expressions
with your C#, being aware that logic is flattened, and constants propagated.

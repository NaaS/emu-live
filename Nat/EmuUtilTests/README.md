EmuUtilTests
=============

This project contains unit tests for the [EmuUtil](../EmuUtil) project.

Unquote
--------

The tests use [Unquote](https://github.com/SwensenSoftware/unquote)
to get more readable output when tests fail. The `=!` operator is equivalent to
`Assert.equal`.

xUnit and FsCheck
------------------

[xUnit](https://xunit.github.io/) is the main unit test framework used, and the runner
called in `test.sh` is the xUnit console runner. xUnit tests have the `[<Fact>]` annotation.

[FsCheck](https://fscheck.github.io/FsCheck/) is similar to QuickCheck for Haskell - it
runs the tests with random data. Tests that use FsCheck have the `[<Property>]` annotation.

Since there needs to be some way of validating the result of the test, and the expected
result cannot be hardcoded like in a constant test, alternative implementations of the methods
being tested are used. These implementations favour clarity and correctness over performance,
or approach the problem from a different direction, so that problems (e.g. logic errors) that
appear in the original method don't appear in the alternative reference method.

Sometimes tests need data to be more structured than purely random data. FsCheck facilitates
this through custom [generators](https://fscheck.github.io/FsCheck/TestData.html). This allows
dependencies between values, such as ensuring that the value of a `index` parameter is inside
the range of a `array` parameter. Of course, it is good to test invalid parameters as well.

Get.fs
-------

This file contains tests for the `NetFPGA_Util.GetBytes` method. There are a few tests
that test it with some constant data, with constant offsets and lengths (check the comments
in each test), and some that use FsCheck to test with random data, offsets, and lengths.

The tests that use FsCheck use the `getGen` generator to test the method with random values.
You can read [this](http://blog.ploeh.dk/2015/09/08/ad-hoc-arbitraries-with-fscheckxunit/)
to learn more about the style.

Set.fs
-------

This file contains tests for the `NetFPGA_Util.SetBytes` method. This file has almost
identical structure to `Get.fs`, since the methods being tested are very similar. The main
differences are that the test data is copied before the `SetBytes` method is called so that
the original data isn't changed.
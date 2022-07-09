# What’s X3?

X3 is yet another XML parser project. It hopes to compete with libxml2
by being more cross-platform, maybe faster but not slower, and having
more up-to-date utilities like `xsltproc` that understands XSLT 3.

## Project Goals

The followings are the goals set forth by X3. To be a successful
project, they are expected to be met.⁠[1]

-   ❏ A C++20 library for easily managing XML documents without having
    to drop down to C level, nor spending indefinite amounts of time
    writing a wrapper around a C API to keep our future sanity.

-   ❏ Provide up-to-date command-line tooling around XML that understand
    new standards: `x3sltproc`, `x3validate`, `x3query`, `x3format`.

-   ❏ A stable C API that can be used from shared objects/DLLs allowing
    usage from other languages through classic C extensions.

-   ❏ Heavy testing to provide as close to standard expected behavior as
    possible, mutation and fuzz testing to ensure compliance and
    security.

-   ❏ Extensions, because you always need extensions, with a flag to
    turn them off, that only mostly works. (i.e. GCC’s
    `-pedantic-errors`)

-   ❏ All the while being at least as fast as the libxml2 library.

Since the project relies on Intel’s Hyperscan, compatibility is
restricted to x86 systems, however, on the operating system level at
least the followings should work: FreeBSD, OpenBSD, NetBSD, Windows
10/11, Linux. New Macs are therefore not supported because ARM, if, for
some reason in the future, the project gains an increased amount of
contributors a new non-Hyperscan backend could be written to support Mn
(*n* ∈ ℕ) Macs.

## What does the name mean?

There are multiple interpretations:

-   the project aims to replace or at least compete with libxml2, hence
    it’s an xml library that’s a version above libxml2, hence X**3**.

-   X3 is an Xml parser that’s made in C++. Now C++ is sometimes
    stylized as CXX, because of fear of the plus symbols fucking things
    up. By adding all things together, we’d have the X⁠++ library, but
    with the ++ stylized to XXX. While this’d be a funny name, people
    don’t appreciate humor, so this can be written as *X*<sup>3</sup>,
    which in ASCII could be written lazily as just X3.

-   X11 existing by itself is not confusing enough, we need a thing
    that’s almost the same name, but has nothing to do with it.

# Building

Basic CMake build, at least from the user’s perspective. On the
developer’s side the CMake script is doing through indefinite hoops to
make everything work as it should, but for many that’s irrelevant.
Because of this, if the following three-step process doesn’t build and
install X3 on **your** machine, open a ticket as the anonymous user.

The incantation is the default CMake, three-step dance:

    cmake -B_build -S. -DCMAKE_BUILD_TYPE=Release
    cmake --build _build
    cmake --build _build --target install 

-   This step may optionally need to be run with elevated privileges.

## Compiler/Platform support

The entirety of X3 should build on all major platforms. Because of the
Ragel dependency of Hyperscan, Windows/MSVC combo is not supported,
until a work-around is found.[2]

## Running tests

If you wish to make sure X3 works correctly on your system, you can run
the test-suite. For this, the followings are recommended:

    cmake -B_build-test -S. -DCMAKE_BUILD_TYPE=Debug 
    cmake --build _build
    pushd _build
    ctest 
    popd

-   Here you can specify any combination of `-DX3_BUILD_TESTS=1`,
    `-DX3_BUILD_MUTATION=1`, `-DX3_BUILD_FUZZ=1`, and
    `-DX3_BUILD_BENCHMARKS=1`. (If something is not available on your
    platform, you’ll be warned about it, and the flag will be ignored.)

-   The time taken here heavily depends on which flags you specified
    above.

# Contributing

If you wish to, for some reason or another, contribute to the project,
the build enviroment should be set up as described above.

After implemetning a feature, fixing a bug, etc. you and opening a
ticket about it, just use a diff program to create (or figure out how
`fossil diff` works) a patch and provide it in a comment to the ticket.
(Or a forum message, but tickets are preferred.)

After review, your patch will be applied to the source, and you’ll be
added to a list of constributors. (Unless explicitly opting out.)

If you seem to be all about the project and provide multiple
high-quality patches to the source, you can be given a developer account
on the fossil server. After that point you’ll be able to directly push
your changes to the main repository. This is a Core contributor status.

## Contributor bootstrap

Contributors may want to use the provided `bootstrap.cmake` file to set
up fossil hooks in a way that preforms multiple checks on commits. This
entails things like formatting, checking if documentation is up-to-date
(this feature is a guide-line at best and not implemented at worst), and
updating a git mirror (if you are running one).

This script can be configured using CMake variables, all of which are
documented at the beginning of the file, so read that.

# GitHub mirror

If you are reading this on GitHub, you are looking at a read-only mirror
of the main repository. The actual repository is run on Fossil, not git,
and is available at <https://vcs.isdevnet.com/x3>

For this reason, PR-s are not accepted on GitHub. If you want to supply
a patch, open a new ticket as the anonymous user and paste the patch
file there. This also encourages smaller patches, not gigantic rewrites
that likely wouldn’t be accepted anyways.

[1] I know full well they won’t be.

[2] Maybe porting their build to CMake. It shouldn’t be that hard, then
we could easily integrate it.

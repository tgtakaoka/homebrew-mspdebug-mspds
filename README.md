homebrew-mspdebug-mspds
======================

The [Homebrew][] formulae of `mspdebug-head` [MSPDEBUG][], and
`msp-ds` [MSP Debug Stack][].

For Linux, the following packages are necessary to compile these formulae.

 * libhidapi-dev
 * libusb-1.0-0-dev
 * libusb-dev
 * libudev-dev
 * libboost-filesystem-dev
 * libboost-thread-dev
 * libreadline-dev

To get everything, execute the following commands.

    $ brew tap tgtakaoka/mspdebug-mspds
    $ brew install --HEAD mspdebug-head

Version:

    mspdebug-head-HEAD
    msp-ds-3.15.1.1_1 (with dumpdb)

[Homebrew]: https://brew.sh/
[MSPDEBUG]: https://dlbeer.co.nz/mspdebug/
[MSP Debug Stack]: https://www.ti.com/tool/download/MSPDS-OPEN-SOURCE

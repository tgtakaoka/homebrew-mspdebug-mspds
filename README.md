homebrew-tinyos-msp430
======================

The [Homebrew][] formulae of [TinyOS for small MSP430 chips][].  This
repository includes `nesc-gcc` [nesC][], `tinyos-tools` and
`tinyos-main` [TinyOS][], `tinyos-prod` [TinyOS prod][],
`tinyos-msp430`, `mspdebug-head` [MSPDEBUG][], and `msp-ds` [MSP Debug
Stack][].

To get everything, execute the following commands.

    $ brew tap tgtakaoka/tinyos-msp430
    $ brew install --HEAD tinyos-msp430

Version:

    nesc-gcc-HEAD
    tinyos-tools-HEAD
    tinyos-main-HEAD (branch msp430-elf)
    tinyos-prod-HEAD (branch tp-master)
    tinyos-msp430-HEAD
    mspdebug-head-HEAD (chipinfo.db from slac460x)
    msp-ds-slac460x_2 (with dumpdb)

[Homebrew]: https://brew.sh/
[TinyOS for small MSP430 chips]: https://github.com/tgtakaoka/tinyos-msp430
[nesC]: https://github.com/tinyos/nesc
[TinyOS]: http://tinyos.net
[TinyOS prod]: http://github.com/tp-freeforall/prod
[MSPDEBUG]: https://dlbeer.co.nz/mspdebug/
[MSP Debug Stack]: http://www.ti.com/tool/mspds

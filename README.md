homebrew-tinyos-msp430
======================

The [Homebrew][] formulae of [TinyOS for small MSP430 chips][].  This
repository includes `nesc-gcc` [nesC][], `tinyos-tools` and
`tinyos-prod` [TinyOS prod][], `tinyos-msp430`, `mspdebug-head`
[MSPDEBUG][], and `msp-ds` [MSP Debug Stack][].

To get everything, execute the following commands.

    $ brew tap tgtakaoka/tinyos-msp430
    $ brew install --HEAD tinyos-msp430

Version:

    nesc-gcc-HEAD
    tinyos-tools-HEAD (branch tp-master)
    tinyos-prod-HEAD (branch tp-master)
    tinyos-msp430-HEAD
    mspdebug-head-HEAD (chipinfo.db from slac460x)
    msp-ds-3.15.0.1_1 (with dumpdb)

[Homebrew]: https://brew.sh/
[TinyOS for small MSP430 chips]: https://github.com/tgtakaoka/tinyos-msp430
[nesC]: https://github.com/tinyos/nesc
[TinyOS prod]: https://github.com/tp-freeforall/prod
[MSPDEBUG]: https://dlbeer.co.nz/mspdebug/
[MSP Debug Stack]: http://www.ti.com/tool/mspds

homebrew-tinyos-msp430
======================

The [Homebrew][] formulae of [TinyOS for small MSP430 chips][].  This
repository includes `nesc-gcc` [nesC][], `tinyos-tools` and
`tinyos-main` [TinyOS][], `tinyos-msp430`, `mspdebug-head`
[MSPDEBUG][], and `msp-ds` [MSP Debug Stack][].

To get everything, execute the following commands.

    $ brew tap tgtakaoka/tinyos-msp430
    $ brew install --HEAD tinyos-msp430

Version:

    nesc-gcc-HEAD
    tinyos-tools-HEAD
    tinyos-main-HEAD (branch msp430-elf)
    tinyos-msp430-HEAD
    mspdebug-head-HEAD
    msp-ds-slac460x

[Homebrew]: https://brew.sh/
[TinyOS for small MSP430 chips]: https://github.com/tgtakaoka/tinyos-msp430
[nesC]: https://github.com/tinyos/nesc
[TinyOS]: http://tinyos.net
[MSPDEBUG]: https://dlbeer.co.nz/mspdebug/
[MSP Debug Stack]: http://www.ti.com/tool/mspds
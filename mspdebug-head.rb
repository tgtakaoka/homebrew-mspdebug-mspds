class MspdebugHead < Formula
  desc "Debugger for use with MSP430 MCUs"
  homepage "https://dlbeer.co.nz/mspdebug/"
  head "https://github.com/dlbeer/mspdebug.git"

  depends_on "hidapi" if OS.mac?
  depends_on "libusb-compat" if OS.mac?
  depends_on "msp-ds"

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-tinyos-msp430/master/patches/mspdebug-head-patches.tar.xz"
    sha256 "ad8e16941df50104d3b2fd6ca5a775ce4066df32581ecb83314bf88e95e986d8"
    apply "mspdebug-head-fix_lowercase_disasm.patch"
  end
  if OS.mac?
    patch do 
      url "https://raw.githubusercontent.com/tgtakaoka/homebrew-tinyos-msp430/master/patches/mspdebug-head-patches.tar.xz"
      sha256 "ad8e16941df50104d3b2fd6ca5a775ce4066df32581ecb83314bf88e95e986d8"
      apply "mspdebug-head-osx_brew.patch"
      apply "mspdebug-head-osx_dylib-name.patch"
    end
  end

  def install
    ENV.append_to_cflags "-I#{Formula["hidapi"].opt_include}/hidapi" if OS.mac?
    ENV.append_to_cflags "-I/usr/include/hidapi" if OS.linux?
    system "make", "PREFIX=#{prefix}", "install"
  end

  def caveats
    if OS.mac?
      <<~EOS
          You may want to add the following path to load libmsp430.dylib.
            $ export DYLD_FALLBACK_LIBRARY_PATH=$(brew --prefix)/lib
          You may need to install a kernel extension if you're having trouble with
          RF2500-like devices such as the TI Launchpad:
          https://dlbeer.co.nz/mspdebug/faq.html#rf2500_osx
      EOS
    elsif OS.linux?
      <<~EOS
          You may want to set group and mode of msdebug by
            $ sudo chgrp serial $(brew --prefix mspdebug-head)/bin/mspdebug
            $ sudo chmod g+s $(brew --prefix mspdebug-head)/bin/mspdebug
      EOS
    end
  end

  test do
    system bin/"mspdebug", "--help"
  end
end

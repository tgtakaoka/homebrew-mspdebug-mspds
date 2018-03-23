class MspdebugHead < Formula
  desc "Debugger for use with MSP430 MCUs"
  homepage "https://dlbeer.co.nz/mspdebug/"
  head "https://github.com/dlbeer/mspdebug.git"

  depends_on "hidapi" if OS.mac?
  depends_on "libusb-compat" if OS.mac?

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-msp430/mspgcc4/mspdebug-current-osx_brew.patch"
    sha256 "962891f483117d6e7e342333a4dd50b333feb89ff9ab192d9980fd1ec3d19c65"
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-msp430/mspgcc4/mspdebug-enhance_dis_lowercase.patch"
    sha256 "97754e4f844e13cfc14777a5493f5776863a2fac863dbe650882c02372311321"
  end

  def install
    ENV.append_to_cflags "-I#{Formula["hidapi"].opt_include}/hidapi" if OS.mac?
    ENV.append_to_cflags "-I/usr/include/hidapi" if OS.linux?
    system "make", "PREFIX=#{prefix}", "install"
  end

  def caveats; <<~EOS
    You may need to install a kernel extension if you're having trouble with
    RF2500-like devices such as the TI Launchpad:
      https://dlbeer.co.nz/mspdebug/faq.html#rf2500_osx
    EOS
  end

  test do
    system bin/"mspdebug", "--help"
  end
end

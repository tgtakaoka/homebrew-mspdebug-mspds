class MspDs < Formula
  desc "MSP Debug Stack Open Source Package"
  homepage "http://www.ti.com/tool/mspds"
  url "http://www.ti.com/lit/sw/slac460y/slac460y.zip"
  sha256 "d3c5a50444d8d6ab9456fecf2a8ebbc9a391fa9447120d20aaa76c62bc5cc9b8"
  version "slac460y"
  revision 1

  depends_on "hidapi" if OS.mac?
  depends_on "libusb-compat" if OS.mac?
  depends_on "boost" if OS.mac?

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-tinyos-msp430/master/patches/msp-ds-slac460y-1-patches.tar.xz"
    sha256 "8946205f4d419fb421b16a7d16b5d27c427c879909f338a0fc547167f60f9ce2"
    apply "msp-ds-slac460y-boost.patch"
    apply "msp-ds-slac460y-dumpdb.patch"
  end

  def install
    args = []
    if OS.linux?
      # Make hid-libusb.o
      linux_dir = "ThirdParty/hidapi-hidapi-0.8.0-rc1/linux"
      Dir.chdir linux_dir do
        system "make", "-f", "Makefile-manual", "hid.o"
        FileUtils.cp "hid.o", buildpath/"ThirdParty/lib64/hid-libusb.o"
      end

      suffix = ".so"
      hidapi_h = "/usr/include/hidapi/hidapi.h"
    end
    if OS.mac?
      suffix = ".dylib"
      args << "BOOST_DIR=#{Formula["boost"].opt_prefix}"
      hidapi_h = Formula["hidapi"].include/"hidapi/hidapi.h"
      inreplace "Makefile", "-lboost_thread", "-lboost_thread-mt"
    end
    (buildpath/"ThirdParty/include").install_symlink hidapi_h

    system "make", *args
    system "make", "msp-ds-dumpdb"

    lib.install "libmsp430#{suffix}"
    bin.install "msp-ds-dumpdb"
  end
end

class MspDs < Formula
  desc "MSP Debug Stack Open Source Package"
  homepage "https://www.ti.com/tool/download/MSPDS-OPEN-SOURCE"
  url "https://software-dl.ti.com/msp430/msp430_public_sw/mcu/msp430/MSPDS/3_15_1_001/export/MSPDebugStack_OS_Package_3_15_1_1.zip"
  sha256 "e3a59a98c43de7a92e5814d8c3304026165e6d2551e60acaca1f08c6b1a4bac8"
  version "3.15.1.1"
  revision 1

  depends_on "hidapi" if OS.mac?
  depends_on "libusb-compat" if OS.mac?
  depends_on "boost" if OS.mac?

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-mspdebug-mspds/master/patches/msp-ds-3.15.0.1-dumpdb.patch"
    sha256 "da5d99a46b594a0fcbc1bdd1df454f094537d5b2a2415bf6f83b5a0f05201b83"
  end

  def install
    args = []
    if OS.linux?
      Dir.chdir (buildpath/"ThirdParty/lib64") do
        libusb_a = Dir.glob("/usr/lib/**/libhidapi-libusb.a")[0]
        system "ar", "x", libusb_a
        (buildpath/"ThirdParty/lib64").install_symlink "hid.o" => "hid-libusb.o"
      end
      suffix = ".so"
      hidapi_h = Dir.glob("/usr/include/**/hidapi.h")[0]
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

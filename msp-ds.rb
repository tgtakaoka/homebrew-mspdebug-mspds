class MspDs < Formula
  desc "MSP Debug Stack Open Source Package"
  homepage "http://www.ti.com/tool/mspds"
  url "http://www.ti.com/lit/sw/slac460x/slac460x.zip"
  version "slac460x-2"
  sha256 "c6bf24338b50f6ce8f6f0127ec2673e10add251e0a89e894fd30897eaa4e0cbc"

  depends_on "hidapi" if OS.mac?
  depends_on "libusb-compat" if OS.mac?
  depends_on "boost" if OS.mac?

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-tinyos-msp430/master/patches/msp-ds-slac460x-2-patches.tar.xz"
    sha256 "601abcd99e3376953dd9cbf1d70c734dd2906ea6ade5d7888083f1e527e36803"
    apply "msp-ds-slac460x-boost.patch"
    apply "msp-ds-slac460x-dumpdb.patch"
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
      inreplace "Makefile", "-lusb-1.0", "-ludev"
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

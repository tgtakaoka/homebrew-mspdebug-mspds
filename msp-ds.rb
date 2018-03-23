class MspDs < Formula
  desc "MSP Debug Stack Open Source Package"
  homepage "http://processors.wiki.ti.com/index.php/MSPDS_Open_Source_Package"
  url "http://www.ti.com/lit/sw/slac460x/slac460x.zip"
  version "slac460x"
  sha256 "c6bf24338b50f6ce8f6f0127ec2673e10add251e0a89e894fd30897eaa4e0cbc"

  depends_on "hidapi" if OS.mac?
  depends_on "libusb-compat" if OS.mac?
  depends_on "boost" if OS.mac?

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-tinyos-msp430/master/patches/msp-ds-slac460x-patches.tar.xz"
    sha256 "f83cf76fa0aeebc9256cd6fd5aa9998fbde243d4fdfdcdc6ee3a74023221265d"
    apply "msp-ds-slac460x-boost.patch"
  end

  def install
    args = []
    if OS.linux?
      # Make hid-libusb.o
      linux_dir = "ThirdParty/hidapi-hidapi-0.8.0-rc1/linux"
      Dir.chdir linux_dir do
        inreplace "Makefile-manual", "hid.o", "hid-libusb.o"
        FileUtils.cp "hid.c", "hid-libusb.c"
        system "make", "-f", "Makefile-manual"
      end
      (buildpath/"ThirdParty/lib64").install "#{linux_dir}/hid-libusb.o"

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

    lib.install "libmsp430#{suffix}"
  end
end

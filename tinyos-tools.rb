class TinyosTools < Formula
  desc "Development tools for TinyOS"
  homepage "http://tinyos.net"
  head "https://github.com/tgtakaoka/tinyos-main.git"

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-tinyos-msp430/master/tinyos-current_jdk.patch"
    sha256 "d0b7b66a29eb78f0bea42cdcb4d5e9a4f8699a72a0e09d22248bce9f63a8bffc"
  end

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on :java => :build
  depends_on "python" if OS.mac?
  depends_on "nesc-gcc" => :head

  def install
    ENV.remove_from_cflags(/ ?-I\/usr\/include\/linux/) if OS.linux?
    Dir.chdir "tools" do
      system "./Bootstrap"
      system "./configure",
	     "--prefix=#{prefix}",
	     "--disable-debug",
	     "--disable-dependency-tracking",
	     "--disable-nls"
      ENV.deparallelize
      system "make"
      system "make", "install"
    end
  end
end

class TinyosTools < Formula
  desc "Development tools for TinyOS"
  homepage "http://tinyos.net"
  head "https://github.com/tp-freeforall/prod.git", :branch => "tp-master"

  depends_on "automake" => :build if OS.mac?
  depends_on "autoconf" => :build if OS.mac?
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

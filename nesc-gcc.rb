class NescGcc < Formula
  desc "Programming language for deeply networked systems"
  homepage "https://github.com/tinyos/nesc"
  head "https://github.com/tinyos/nesc.git"

  depends_on "automake" => :build if OS.mac?
  depends_on "autoconf" => :build if OS.mac?
  depends_on :java => :build
  depends_on "gcc" if OS.mac?

  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/homebrew-tinyos-msp430/master/patches/nesc-compile_isystem.patch"
    sha256 "172b2f287f2b5da4c9dcd0de83ab677c42e1bd053c33be45681210384dc45e49"
  end

  def install
    # nesc is unable to build in parallel because multiple emacs instances
    # lead to locking on the same file
    ENV.deparallelize
    ENV.remove_from_cflags(/ ?-I\/usr\/include\/linux/) if OS.linux?

    system "./Bootstrap"
    system "./configure",
           "--disable-debug",
           "--disable-dependency-tracking",
           "--prefix=#{prefix}"
    system "make"
    system "make", "install"

    if ENV.compiler == :clang
      gcc = Formula["gcc"]
      gcc_suffix = gcc.version.to_s.slice(/\d/)
      gcc_name = gcc.bin/"gcc-#{gcc_suffix}"
      inreplace bin/"nescc", /\$gcc = ".*";/, "$gcc = \"#{gcc_name}\";"
    end
  end
end

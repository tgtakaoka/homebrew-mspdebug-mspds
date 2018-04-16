class NescGcc < Formula
  desc "Programming language for deeply networked systems"
  homepage "https://github.com/tinyos/nesc"
  head "https://github.com/tinyos/nesc.git"

  if OS.mac?
    patch do
      url "https://raw.githubusercontent.com/tgtakaoka/scripts-tinyos-msp430/master/nesc-current-osx_restrict.patch"
      sha256 "58b2364b67e1c4b78582361149aafe423be6b8e7b5224fc9b446007cf3fe60b6"
    end
  end
  patch do
    url "https://raw.githubusercontent.com/tgtakaoka/scripts-tinyos-msp430/master/nesc-current-fix_isystem.patch"
    sha256 "b26fe85550eb2925b07f16a28abb59a6fdeb5620cdbc97ac05e4a286212fb4eb"
  end

  depends_on "automake" => :build if OS.mac?
  depends_on "autoconf" => :build if OS.mac?
  depends_on :java => :build
  depends_on "gcc" if OS.mac?

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

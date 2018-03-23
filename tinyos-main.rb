class TinyosMain < Formula
  desc "TinyOS source"
  homepage "http://tinyos.net"
  head "https://github.com/tgtakaoka/tinyos-main.git", :branch => "msp430-elf"

  def install
    dest = (prefix/"source")
    dest.install Pathname.pwd.children
    (dest/".brew_home").rmtree
  end

  def caveats
    "You have to define export TINYOS_ROOT_DIR=$(brew --prefix #{name})/source"
  end
end

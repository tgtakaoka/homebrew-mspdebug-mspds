class TinyosMsp430 < Formula
  desc "TinyOS source for small MSP430"
  homepage "http://github.com/tgtakaoka/tinyos-msp430"
  head "https://github.com/tgtakaoka/tinyos-msp430.git", :branch => "master", :shallow => false

  depends_on "tinyos-prod" => :head
  depends_on "tinyos-tools" => :head

  def install
    dest = (prefix/"source")
    dest.install Pathname.pwd.children
    (dest/".brew_home").rmtree
  end

  def caveats
    "You have to define export TINYOS_ROOT_DIR_ADDITIONAL=$(brew --prefix #{name})/source"
  end
end

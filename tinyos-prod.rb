class TinyosProd < Formula
  desc "TinyOS prod source"
  homepage "https://github.com/tp-freeforall/prod"
  head "https://github.com/tgtakaoka/tinyos-prod.git", :branch => "tp-master", :shallow => false

  def install
    dest = (prefix/"source")
    dest.install Pathname.pwd.children
    (dest/".brew_home").rmtree
  end

  def caveats
    "You have to define export TINYOS_ROOT_DIR=$(brew --prefix #{name})/source"
  end
end

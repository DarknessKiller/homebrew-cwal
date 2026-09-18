class Cwal < Formula
  desc "Blazing-fast pywal-like color palette generator written in C"
  homepage "https://github.com/nitinbhat972/cwal"
  url "https://github.com/nitinbhat972/cwal/archive/refs/tags/v0.10.1.tar.gz"
  sha256 "f69d64e99ef654677bf9175b2951fc5ee708f9e38d1c3917660ad512f5f52edb"
  license "GPL-3.0-only"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  depends_on "imagemagick"
  depends_on "libimagequant"
  depends_on "luajit"

  def install
    inreplace "config.h", '#define INSTALL_DIR "/usr"', "#define INSTALL_DIR \"#{prefix}\""
    system ENV.cc, "nob.c", "-o", "nob"
    system "./nob", "build"
    system "./nob", "install"
  end

  test do
    assert_match "cwal v#{version}", shell_output("#{bin}/cwal --version")
  end
end

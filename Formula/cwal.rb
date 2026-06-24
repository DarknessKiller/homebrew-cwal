class Cwal < Formula
  desc "Blazing-fast pywal-like color palette generator written in C"
  homepage "https://github.com/nitinbhat972/cwal"
  url "https://github.com/nitinbhat972/cwal/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "a60461081f1ffa6cab187cecea82edc5ff7883c1d0cfccbcf6c3b3838753a36f"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build
  depends_on "pkgconf" => :build

  depends_on "imagemagick"
  depends_on "libimagequant"
  depends_on "luajit"

  def install
    system "cmake", "-B", "build", "-DCMAKE_BUILD_TYPE=Release", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_match "cwal v#{version}", shell_output("#{bin}/cwal --version")
  end
end

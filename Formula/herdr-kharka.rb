class HerdrKharka < Formula
  desc "Writes what a machine's herdr runs into kharka, on every change"
  homepage "https://github.com/jakobbeyer/herdr-kharka"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.0/herdr-kharka-aarch64-apple-darwin.tar.xz"
      sha256 "225b1189b7c6a2261d95f59a22541aa36d80f2f62c78b61604862ed1f21a1c84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.0/herdr-kharka-x86_64-apple-darwin.tar.xz"
      sha256 "14d13821b25279e7ec031f889fa8a16819d5243364f1822e2d219aef4a730403"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.0/herdr-kharka-aarch64-unknown-linux-musl.tar.xz"
      sha256 "dcc148f73603c9d412d4caf6fa43ff069bff3a4c057983b4ffbe02496db3e0d1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.0/herdr-kharka-x86_64-unknown-linux-musl.tar.xz"
      sha256 "834ed9060d282a162e5a9f17566e089cfae2b4e9a2fcea63da215c3ad8e61341"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "herdr-kharka"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "herdr-kharka"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "herdr-kharka"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "herdr-kharka"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

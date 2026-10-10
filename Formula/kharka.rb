class Kharka < Formula
  desc "A small local-first JSON store: every machine keeps a full replica, one hub orders and spreads the changes"
  homepage "https://github.com/jakobbeyer/kharka"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.0/kharka-aarch64-apple-darwin.tar.xz"
      sha256 "cba1eb7cd3685d3f128a55fb9d3357bbc3c42f5eb5dd39e94cc66c71832835ea"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.0/kharka-x86_64-apple-darwin.tar.xz"
      sha256 "4ec4977ab9e21afba0559f3d0a4e6f9017161524cf11e208125cb3d1de1e0156"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.0/kharka-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a042251a9af6c6e2462f3596f36d00f181e8e0ce3297050a64228913e6ce7e56"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.0/kharka-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f42ee3be32bbcfb7fd3138c958528cf3057e619d7bfcd3e7323c4213ab8ea0c3"
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
      bin.install "kharka"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kharka"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kharka"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kharka"
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

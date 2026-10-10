class Kharka < Formula
  desc "A small local-first JSON store: every machine keeps a full replica, one hub orders and spreads the changes"
  homepage "https://github.com/jakobbeyer/kharka"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.1/kharka-aarch64-apple-darwin.tar.xz"
      sha256 "477d076e6c6dc7a4487b9f05a15e197f9273e6563f46b5344d8d8b0a9d43b19e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.1/kharka-x86_64-apple-darwin.tar.xz"
      sha256 "00693480c6f4351d73d7877cb388b8f47bc5bbc542288981325b2ec26c28cd7d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.1/kharka-aarch64-unknown-linux-musl.tar.xz"
      sha256 "74fe1173b0dbb9bc04909bc9dfc9bbf2ff8cd4123f8854733d700cac6c0ce22d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/kharka/releases/download/v0.1.1/kharka-x86_64-unknown-linux-musl.tar.xz"
      sha256 "c377f3399849a96f00b705d2c8d35494ba9f7c2b7aea286024a8c7be702ba161"
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

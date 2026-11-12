class HerdrKharka < Formula
  desc "Writes what a machine's herdr runs into kharka, on every change"
  homepage "https://github.com/jakobbeyer/herdr-kharka"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.1/herdr-kharka-aarch64-apple-darwin.tar.xz"
      sha256 "1ce5ed4ff1a07f0675daf57f9dcf3f2077927e2f5a2fc376b1a7ebc3b5e80d91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.1/herdr-kharka-x86_64-apple-darwin.tar.xz"
      sha256 "46385cfdc33f36bf6e9b2098ca3b28e7efb6fcd6a819f99a4d9408f94117b0d5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.1/herdr-kharka-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f980dfa348a48444f576cb4a0bfa7dbde34728fe171f33415835e1afe678b83a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.1/herdr-kharka-x86_64-unknown-linux-musl.tar.xz"
      sha256 "62b8da47f4b6db508ddbbc0d1465a5a81aeebcd25d4676f9b410d5a51c658bc9"
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

class HerdrKharka < Formula
  desc "Writes what a machine's herdr runs into kharka, on every change"
  homepage "https://github.com/jakobbeyer/herdr-kharka"
  version "0.3.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.2/herdr-kharka-aarch64-apple-darwin.tar.xz"
      sha256 "22bf2028cd8d2d649dc71ea54d15a5774edd16c96e7aa09a7d90a9f7d6c39721"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.2/herdr-kharka-x86_64-apple-darwin.tar.xz"
      sha256 "f0bc339128c577d7b5b1883a8262806ed76efd1374cf06feb696680907898006"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.2/herdr-kharka-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a0a5abc2671db2c6e8fc52847ce82cc4c7449ae3951019b3cc185c2e2a51f6af"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.3.2/herdr-kharka-x86_64-unknown-linux-musl.tar.xz"
      sha256 "8543b2fd379558cd4cc641554a13110694501e7ff8bda9e60007532dbeacb3a2"
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

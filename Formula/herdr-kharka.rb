class HerdrKharka < Formula
  desc "Writes what a machine's herdr runs into kharka, on every change"
  homepage "https://github.com/jakobbeyer/herdr-kharka"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.1/herdr-kharka-aarch64-apple-darwin.tar.xz"
      sha256 "23c22446a76df1db3125a8f6c73a90956f6c3d809ef1402b5b5ee68e0ff873c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.1/herdr-kharka-x86_64-apple-darwin.tar.xz"
      sha256 "61c1b858d5f672a480bdcd0d6ad7c7dd6cc4412d9f0cab24bac05b47f09803f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.1/herdr-kharka-aarch64-unknown-linux-musl.tar.xz"
      sha256 "892901ca85b17aba6101727cc47fdc265d707d63f33de6ee49fd34dddb5bf365"
    end
    if Hardware::CPU.intel?
      url "https://github.com/jakobbeyer/herdr-kharka/releases/download/v0.2.1/herdr-kharka-x86_64-unknown-linux-musl.tar.xz"
      sha256 "95d3eee0db58fd25b051b79413b17bac3a553d59cd28c11262827c1f1cde54df"
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

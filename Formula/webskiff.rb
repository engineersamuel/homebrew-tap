class Webskiff < Formula
  desc "Keyboard-first Chromium browser for your terminal"
  homepage "https://github.com/engineersamuel/webskiff"
  url "https://github.com/engineersamuel/webskiff/archive/05f274b1ff5bb217befd0913617f28c1fe7da292.tar.gz"
  version "0.9.2"
  sha256 "26b601da2417e1a48f930921adee14e1c830a4e25c4d9309bacaff954effacc1"
  license "MIT"

  depends_on "rust" => :build

  depends_on arch: :arm64
  depends_on :macos

  on_macos do
    depends_on macos: :ventura
  end

  resource "zebkit" do
    url "https://github.com/ikey4u/zebkit/releases/download/v0.4.0/zebkit-0.4.0-aarch64-apple-darwin.tar.xz"
    sha256 "b94bf42c6485b6226b667fe5cdb80f341b24d1a4a1d41297039d79ccd02945c8"
  end

  def install
    resource("zebkit").stage do
      (buildpath/"engine").install Dir["*"]
    end
    ENV["ZEBKIT_DIR"] = (buildpath/"engine").to_s
    ENV["WEBSKIFF_BUILD_COMMIT"] = "05f274b1ff5bb217befd0913617f28c1fe7da292"
    ENV["CARGO_HTTP_USER_AGENT"] = "OpenAI File Downloader, XaiImageApiFetch/1.0"
    system "cargo", "install", *std_cargo_args(root: libexec), "--bin", "webskiff"
    # Cargo's build-script layout can change; install the verified resource directly.
    (libexec/"bin/zebkit").install "engine/Zebkit.framework"
    bin.write_exec_script libexec/"bin/webskiff"
    (bin/"webskiff").chmod 0755
    pkgshare.install "config.example.toml", "LICENSE", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match "webskiff #{version}", shell_output("#{bin}/webskiff --version")
    assert_match "Usage: webskiff", shell_output("#{bin}/webskiff --help")
  end
end

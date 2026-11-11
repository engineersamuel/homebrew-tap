class Webskiff < Formula
  desc "Keyboard-first Chromium browser for your terminal"
  homepage "https://github.com/engineersamuel/webskiff"
  url "https://github.com/engineersamuel/webskiff/archive/e3da589825c0b577db93707f02ba0e3b2f2cee0c.tar.gz"
  version "0.1.0-beta.4"
  sha256 "dcd98e9a4977bf0320fd31c268281a091ac9807d93aa767e90a9501ad332fce9"
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
    ENV["WEBSKIFF_BUILD_COMMIT"] = "e3da589825c0b577db93707f02ba0e3b2f2cee0c"
    ENV["CARGO_HTTP_USER_AGENT"] = "OpenAI File Downloader, XaiImageApiFetch/1.0"
    system "cargo", "install", *std_cargo_args(root: libexec), "--bin", "webskiff"
    (libexec/"bin").install "target/release/zebkit"
    bin.write_exec_script libexec/"bin/webskiff"
    (bin/"webskiff").chmod 0755
    pkgshare.install "config.example.toml", "LICENSE", "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match "webskiff #{version}", shell_output("#{bin}/webskiff --version")
    assert_match "Usage: webskiff", shell_output("#{bin}/webskiff --help")
  end
end

class Oxvelte < Formula
  desc "ESLint-compatible Svelte linter written in Rust. Same rules/diags, 4-25x faster"
  homepage "https://github.com/btbutts/oxvelte-rs"
  url "https://github.com/btbutts/oxvelte-rs/releases/download/v0.4.0/oxvelte-0.4.0.tar.gz"
  sha256 "e1b9f0ec48f2a856099db84ee10d5b67bd3fc4264c89fb2921c2c6847a821631"
  license "MIT"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "rust" => :build

  def fetch
    system "cargo", "fetch", *std_cargo_fetch_args
  end

  def install
    # Remove unrecognized options if they cause configure to fail
    # https://docs.brew.sh/rubydoc/Formula.html#std_configure_args-instance_method
    system "cargo", "install", *std_cargo_args, "--verbose"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test oxvelte`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system bin/"program", "do", "something"`.
    assert_match "oxvelte", shell_output("#{bin}/oxvelte --help")
  end
end

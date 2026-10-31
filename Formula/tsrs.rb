class Tsrs < Formula
  desc "Rust port of the TypeScript 7 type checker"
  homepage "https://github.com/oxc-project/tsrs"
  url "https://github.com/oxc-project/tsrs/archive/refs/tags/v0.20.1.tar.gz"
  sha256 "4152361791d4019dc18eb9dee85f5905679b2d4a2fe030faebc23eddd80953a7"
  license "Apache-2.0"

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
    assert_match "tsrs", shell_output("#{bin}/tsrs --help")
  end
end

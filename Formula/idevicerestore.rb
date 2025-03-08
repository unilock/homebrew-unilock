class Idevicerestore < Formula
  desc "Restore firmware files to iOS devices"
  homepage "https://www.libimobiledevice.org/"
  license "LGPL-3.0-only"
  head "https://github.com/libimobiledevice/idevicerestore.git", branch: "master"

  livecheck do
    skip "upstream has inconsistent tags"
  end

  keg_only "it can conflict with homebrew/core"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build

  depends_on "curl"
  depends_on "libzip"

  depends_on "libimobiledevice-glue"
  depends_on "libimobiledevice"
  depends_on "libirecovery"
  depends_on "libplist"
  depends_on "libtatsu"

  def install
    args = %w[
      --disable-debug
      --disable-dependency-tracking
      --disable-silent-rules
    ]

    system "./autogen.sh", *std_configure_args, *args
    system "make"
    system "make", "install"
  end

  test do
    assert_equal "idevicerestore #{version}\n", shell_output("#{bin}/idevicerestore -v")
  end
end
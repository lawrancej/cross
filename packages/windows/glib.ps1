$package = @{
    TITLE="GLib"
    DESCRIPTION="A general-purpose utility library."
    CHECK="libglib-2.0-0.dll"
    URL="http://www.gtk.org/download/win32.php"
    DEPENDS=@()
    DOWNLOAD="http://ftp.gnome.org/pub/gnome/binaries/win32/gtk+/2.24/gtk+-bundle_2.24.10-20120208_win32.zip"
    DESTFILE="gtk+-bundle_2.24.10-20120208_win32.zip"
    INSTALL="glib"
    ADDPATH="bin"
}
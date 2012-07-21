$package = @{
    TITLE="GNU Aspell English Dictionary"
    DESCRIPTION="Spell checker."
    CHECK="C:\Program Files\Aspell\dict\en-only.rws"
    URL="http://aspell.net/win32/"
    DEPENDS=@("aspell")
    DOWNLOAD="http://ftp.gnu.org/gnu/aspell/w32/Aspell-en-0.50-2-3.exe"
    DESTINATION="Aspell-en.exe"
    INSTALL="aspell-en"
    REMOVE="unins001.exe"
}

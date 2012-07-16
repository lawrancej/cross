$package = @{
    TITLE="LibreOffice"
    DESCRIPTION="Free office suite"
    CHECK="C:\Program Files\LibreOffice 3.5\program\soffice.exe"
    URL="http://www.libreoffice.org/download/"
    DEPENDS=@()
    DOWNLOAD="http://download.documentfoundation.org/libreoffice/stable/3.5.5/win/x86/LibO_3.5.5_Win_x86_install_multi.msi"
    DESTFILE="libreoffice.msi"
}
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USERES("dxSkinProject1.res");
USEPACKAGE("rtl.bpi");
USEPACKAGE("vcl.bpi");
USEPACKAGE("dxGDIPlusC14.bpi");
USEPACKAGE("dxCoreC14.bpi");
USEPACKAGE("cxLibraryC14.bpi");
USEPACKAGE("dxSkinsCoreC14.bpi");
USEUNIT("dxSkinProject1.pas");
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
        return 1;
}
//---------------------------------------------------------------------------
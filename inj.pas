unit inj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Unit_main, Dialogs, StdCtrls, ExtCtrls;

type
  Tinjector = class(TForm)
    path: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    injectbtn: TButton;
    OpenDialog1: TOpenDialog;
    procedure injectbtnClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  injector: Tinjector;

implementation

uses Res;

{$R *.dfm}

procedure Tinjector.injectbtnClick(Sender: TObject);
var
  Size, hThread, TID: Cardinal;
  BaseAddress: pointer;
  pThreadStartRoutine: Pointer;
  DLLPath: pChar;
  ThreadID: DWord;
  resp: boolean;
begin
  if phandle <> 0 then
  begin
  Resp := False;
  if (pHandle <> 0) then
  begin
    DLLPath := pChar(ExtractFilePath(path.text));
    BaseAddress := VirtualAllocEx(pHandle, nil, Length(DllPath) + 1, MEM_COMMIT, PAGE_READWRITE );
    if BaseAddress <> nil then
    begin
       if WriteProcessMemory(pHandle, BaseAddress, DllPath, Length(DllPath) + 1, Size) then
       begin
        if Length(DLLPath) + 1 = Size then
         begin
           hThread := CreateRemoteThread(pHandle, nil, 0, GetProcAddress(LoadLibrary('kernel32.dll'), 'LoadLibraryA' ), BaseAddress, 0, ThreadID);
           Resp := hThread <> 0;
           WaitForSingleObject(pHandle, 10000);
         end;
       end;
       VirtualFreeEx(pHandle, BaseAddress, 0, MEM_RELEASE);
     end;
  end;
  if resp
  then ShowMessage('Injection Sucess!')
  else ShowMessage('Injection failed.');
  end
  else ShowMessage('Must open a process first.');
  injector.Hide;
end;

procedure Tinjector.Button1Click(Sender: TObject);
begin
OpenDialog1.Execute;
path.Text := OpenDialog1.FileName;
end;

end.

unit modder;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Unit_main, Dialogs, StdCtrls, ExtCtrls, TLHelp32;

type
  Tmemmod = class(TForm)
    address: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    applybtn: TButton;
    Label2: TLabel;
    vartype: TComboBox;
    Label3: TLabel;
    value: TEdit;
    procedure cancelbtnClick(Sender: TObject);
    procedure applybtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  memmod: Tmemmod;

implementation

{$R *.dfm}

procedure Tmemmod.cancelbtnClick(Sender: TObject);
begin
memmod.Close;
end;

procedure Tmemmod.applybtnClick(Sender: TObject);
var buf: PChar;
    addr, bytes, Wr: Cardinal;
    f: Real;
    floa: single;
    i, intout: integer;
    floatout: real;
    resu: boolean;
    strout: array [1..255] of char;
begin
if phandle <> 0 then
begin
f := 0;
floa := 0;
case vartype.ItemIndex of
0: bytes := 1;
1: bytes := 2;
2: bytes := 3;
3: bytes := sizeof(floa);
4: bytes := sizeof(f);
5: bytes := length(value.text) + 1;
end;

addr := StrToInt(Trim('$'+Address.Text));

if vartype.ItemIndex <= 2 then
begin
  intout := StrToInt(Trim(Value.text));
  resu := WriteProcessMemory(PHandle, Ptr(addr), @intout, bytes, Wr);
end;

if vartype.ItemIndex = 3 then
begin
  floatout := StrToFloat(Trim(Value.text));
  resu := WriteProcessMemory(PHandle, Ptr(addr), @floatout, bytes, Wr);
end;

if vartype.ItemIndex = 4 then
begin
  floatout := StrToFloat(Trim(Value.text));
  resu := WriteProcessMemory(PHandle, Ptr(addr), @floatout, bytes, Wr);
end;

if vartype.ItemIndex = 5 then
begin
  for i:=1 to bytes do
  begin
    strout[i] := value.text[i];
  end;
  resu := WriteProcessMemory(PHandle, Ptr(addr), @strout, bytes, Wr);
end;

if resu
then ShowMessage(IntToStr(Wr) + ' bytes poked!')
else ShowMessage('Data poke failed.');

address.Text := '';
value.Text := '';
vartype.ItemIndex := 0;
end
else ShowMessage('Must open a process first.');
memmod.Hide;
end;

procedure Tmemmod.FormShow(Sender: TObject);
begin
  //memmod.Position := poScreenCenter;
end;

end.

unit watcher;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TLHelp32, Dialogs, Grids, ValEdit, StdCtrls, ExtCtrls, ComCtrls, Unit_main, Buttons;

type
  Tmemview = class(TForm)
    addresseslist: TListView;
    Panel1: TPanel;
    addressedit: TEdit;
    valuelabel: TLabel;
    typecombo: TComboBox;
    ListUpdater: TTimer;
    addbtn: TBitBtn;
    delbtn: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    moduleedit: TEdit;
    Label4: TLabel;
    lengthedit: TEdit;
    Label5: TLabel;
    procedure FormShow(Sender: TObject);
    procedure addbtnClick(Sender: TObject);
    procedure addresseditChange(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure typecomboChange(Sender: TObject);
    procedure delbtnClick(Sender: TObject);
    procedure ListUpdaterTimer(Sender: TObject);
    procedure moduleeditChange(Sender: TObject);
    procedure lengtheditChange(Sender: TObject);
    procedure addresseslistDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  memview: Tmemview;

implementation

uses Res, modder;

{$R *.dfm}

function GetModuleBaseAddress(iProcId: Cardinal; DLLName: String): Cardinal;

var

hSnap: THandle; // Process snapshot handle.

xModule: ModuleEntry32; // Module information structure.

begin

Result:= 0; // If the result of the function is 0, it didn't find the base address.

// i.e.. the dll isn't loaded.

hSnap:= CreateToolHelp32Snapshot(TH32CS_SNAPMODULE, iProcId); // Creates a module

// snapshot of the

// game process.

xModule.dwSize:= SizeOf(xModule); // Needed for Module32First/Next to work.

If Module32First(hSnap, xModule) Then Begin // Gets the first module.

While Module32Next(hSnap, xModule) Do // Loops through the rest of the modules.

If AnsiUpperCase(xModule.szModule) = AnsiUpperCase(DLLName) Then // If this is the module we want...

Result:= Cardinal(xModule.modBaseAddr); // Save the base address it in result.

End;

CloseHandle(hSnap); // Free the handle.

end;

procedure Tmemview.FormShow(Sender: TObject);
begin
  memview.Top := main.top + main.height + 25;
  memview.Left := main.left + main.width - memview.Width;
  ListUpdater.Enabled := true;
end;

procedure Tmemview.addbtnClick(Sender: TObject);
var
  itm: TListItem;
begin
  itm := addresseslist.Items.Add;
  itm.Caption := IntToHex(StrToInt('$'+Trim(addressedit.text))+GetModuleBaseAddress(PID,Trim(moduleedit.Text)),8);
  if typecombo.Text <> 'String'
  then itm.SubItems.Add(typecombo.Text)
  else itm.SubItems.Add(typecombo.Text+'['+Trim(lengthedit.text)+']');
  itm.SubItems.Add(StringReplace(valuelabel.Caption,'= ','',[rfReplaceAll, rfIgnoreCase]));
  addressedit.Text := '';
  moduleedit.Text := '';
  valuelabel.Caption := '= ???';
  typecombo.ItemIndex := 0;
  lengthedit.Visible := false;
  label5.Visible := false;
end;

procedure Tmemview.addresseditChange(Sender: TObject);
var bytesread, addrs: cardinal;
    intout, strlen: integer;
    doubleout: real;
    floatout: single;
    charout: array [1..255] of char;
    strout: string;
    strptr: PChar;
begin
  if (length(Trim(lengthedit.text)) > 0) and (length(Trim(lengthedit.text)) < 4) then
  begin
    strlen := StrToInt(Trim(lengthedit.text));
  end
  else begin
    strlen := 0;
  end;

  if (length(Trim(addressedit.Text)) > 0) and (length(Trim(addressedit.Text)) < 8) then
  begin
    try
      addrs := StrToInt(Trim('$'+addressedit.Text));
      case typecombo.ItemIndex of
      0: ReadprocessMemory(PHandle, Ptr(addrs), @intout, 1, bytesread);
      1: ReadprocessMemory(PHandle, Ptr(addrs), @intout, 2, bytesread);
      2: ReadprocessMemory(PHandle, Ptr(addrs), @intout, 4, bytesread);
      3: ReadprocessMemory(PHandle, Ptr(addrs), @floatout, sizeof(floatout), bytesread);
      4: ReadprocessMemory(PHandle, Ptr(addrs), @doubleout, sizeof(doubleout), bytesread);
      5: ReadprocessMemory(PHandle, Ptr(addrs), @charout, strlen, bytesread);
      end;
      case typecombo.ItemIndex of
      0: valuelabel.Caption := '= '+IntToStr(intout);
      1: valuelabel.Caption := '= '+IntToStr(intout);
      2: valuelabel.Caption := '= '+IntToStr(intout);
      3: valuelabel.Caption := '= '+FormatFloat('0.###############', floatout);
      4: valuelabel.Caption := '= '+FormatFloat('0.###############', doubleout);
      5: begin
          strptr := Addr(charout);
          SetString(strout, strptr, bytesread);
          valuelabel.Caption := '= '+strout;
         end;
      end;
    except
      valuelabel.Caption := '= ???';
    end;
  end;
end;

procedure Tmemview.FormHide(Sender: TObject);
begin
  ListUpdater.Enabled := false;
end;

procedure Tmemview.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListUpdater.Enabled := false;
end;

procedure Tmemview.typecomboChange(Sender: TObject);
begin
  memview.addresseditChange(self);
  if typecombo.ItemIndex = 5 then
  begin
    lengthedit.Visible := true;
    label5.Visible := true;
  end
  else begin
    lengthedit.Visible := false;
    label5.Visible := false;
  end;
end;

procedure Tmemview.delbtnClick(Sender: TObject);
begin
addresseslist.DeleteSelected;
end;

procedure Tmemview.ListUpdaterTimer(Sender: TObject);
var n, i: integer;
    bytesread, addrs: cardinal;
    intout: integer;
    floatout: single;
    doubleout: real;
    strout, typestr, typestraux: string;
    charout: array [1..255] of char;
    strptr: PChar;
begin
  n := addresseslist.Items.Count;
  if n > 0 then
  begin

    for i:=n-1 downto 0 do
    begin

      typestr := '';
      addrs := 0;

      if i >= 0 then
      begin
        addrs := StrToInt('$'+addresseslist.Items.Item[i].Caption);
        typestr := addresseslist.Items.Item[i].SubItems.Strings[0];
      end
      else begin
        break;
      end;

      if typestr = 'Byte' then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @intout, 1, bytesread);
        addresseslist.Items.Item[i].SubItems.Strings[1] := IntToStr(intout);
      end;

      if typestr = '2 Bytes' then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @intout, 2, bytesread);
        addresseslist.Items.Item[i].SubItems.Strings[1] := IntToStr(intout);
      end;

      if typestr = '4 Bytes' then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @intout, 4, bytesread);
        addresseslist.Items.Item[i].SubItems.Strings[1] := IntToStr(intout);
      end;

      if typestr = 'Float' then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @floatout, sizeof(floatout), bytesread);
        addresseslist.Items.Item[i].SubItems.Strings[1]:= FormatFloat('0.###############', floatout);
      end;

      if typestr = 'Double' then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @doubleout, sizeof(doubleout), bytesread);
        addresseslist.Items.Item[i].SubItems.Strings[1]:= FormatFloat('0.###############', doubleout);
      end;

      if typestr[1] = 'S' then
      begin
        typestraux := StringReplace(typestr,'String[','',[rfReplaceAll, rfIgnoreCase]);
        typestraux := StringReplace(typestraux,']','',[rfReplaceAll, rfIgnoreCase]);
        ReadprocessMemory(PHandle, Ptr(addrs), @charout, StrToInt(typestraux), bytesread);
        strptr := Addr(charout);
        SetString(strout, strptr, bytesread);
        addresseslist.Items.Item[i].SubItems.Strings[1] := strout;
      end;

    end;
  end;
end;

procedure Tmemview.moduleeditChange(Sender: TObject);
begin
  memview.addresseditChange(self);
end;

procedure Tmemview.lengtheditChange(Sender: TObject);
begin
  memview.addresseditChange(self);
end;

procedure Tmemview.addresseslistDblClick(Sender: TObject);
begin
  if addresseslist.Items.Count > 0 then
  begin
    if addresseslist.Selected.Caption <> '' then
    begin
      memmod.address.text := addresseslist.Selected.Caption;
      if addresseslist.Selected.SubItems.Strings[0] = 'Byte'
      then memmod.vartype.ItemIndex := 0;
      if addresseslist.Selected.SubItems.Strings[0] = '2 Bytes'
      then memmod.vartype.ItemIndex := 1;
      if addresseslist.Selected.SubItems.Strings[0] = '4 Bytes'
      then memmod.vartype.ItemIndex := 2;
      if addresseslist.Selected.SubItems.Strings[0] = 'Float'
      then memmod.vartype.ItemIndex := 3;
      if addresseslist.Selected.SubItems.Strings[0] = 'Double'
      then memmod.vartype.ItemIndex := 4;
      if addresseslist.Selected.SubItems.Strings[0] = 'String'
      then memmod.vartype.ItemIndex := 5;
      memmod.value.Text := addresseslist.Selected.SubItems.Strings[1];
      memmod.Show;
    end;
  end;
end;

end.

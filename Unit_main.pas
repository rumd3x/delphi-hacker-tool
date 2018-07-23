unit Unit_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  TlHelp32, Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, Math, psAPI;

type
  Tmain = class(TForm)
    StatusBar1: TStatusBar;
    mainpanel: TPanel;
    refreshbtn: TSpeedButton;
    processcombo: TComboBox;
    searchpanel: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    byte1: TRadioButton;
    byte2: TRadioButton;
    byte4: TRadioButton;
    doublec: TRadioButton;
    scanbtn: TButton;
    valueinput: TEdit;
    float: TRadioButton;
    strings: TRadioButton;
    cancelbtn: TButton;
    scantype: TComboBox;
    openbtn: TButton;
    nextbtn: TButton;
    addrmodbtn: TSpeedButton;
    valueinput1: TEdit;
    valueinput2: TEdit;
    Label3: TLabel;
    injectbtn: TSpeedButton;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label4: TLabel;
    scanprogress: TProgressBar;
    SpeedButton3: TSpeedButton;
    procedure openbtnClick(Sender: TObject);
    procedure refreshbtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure scanbtnClick(Sender: TObject);
    procedure byte1Click(Sender: TObject);
    procedure byte2Click(Sender: TObject);
    procedure byte4Click(Sender: TObject);
    procedure floatClick(Sender: TObject);
    procedure cancelbtnClick(Sender: TObject);
    procedure doublecClick(Sender: TObject);
    procedure stringsClick(Sender: TObject);
    procedure addrmodbtnClick(Sender: TObject);
    procedure scantypeChange(Sender: TObject);
    procedure nextbtnClick(Sender: TObject);
    procedure injectbtnClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure processcomboChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
  private
    function processExists(exeFileName: string; var id: Cardinal): Boolean;
  public
    { Public declarations }
  end;

const cwChop : Word = $1F32;
      ChopMasks = $0032;

var
  main: Tmain;
  PID: Cardinal;
  restype, cancel, bytes, PHandle: integer;

implementation

uses Res, modder, inj, watcher, blockview;


{$R *.dfm}

function NTSetPrivilege(sPrivilege: string; bEnabled: Boolean): Boolean; 
var 
  hToken: THandle; 
  TokenPriv: TOKEN_PRIVILEGES; 
  PrevTokenPriv: TOKEN_PRIVILEGES; 
  ReturnLength: Cardinal; 
begin 
  Result := True; 
  // Only for Windows NT/2000/XP and later. 
  if not (Win32Platform = VER_PLATFORM_WIN32_NT) then Exit; 
  Result := False; 

  // obtain the processes token 
  if OpenProcessToken(GetCurrentProcess(), 
    TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then 
  begin 
    try 
      // Get the locally unique identifier (LUID) . 
      if LookupPrivilegeValue(nil, PChar(sPrivilege), 
        TokenPriv.Privileges[0].Luid) then 
      begin 
        TokenPriv.PrivilegeCount := 1; // one privilege to set 

        case bEnabled of 
          True: TokenPriv.Privileges[0].Attributes  := SE_PRIVILEGE_ENABLED; 
          False: TokenPriv.Privileges[0].Attributes := 0; 
        end; 

        ReturnLength := 0; // replaces a var parameter 
        PrevTokenPriv := TokenPriv; 

        // enable or disable the privilege 

        AdjustTokenPrivileges(hToken, False, TokenPriv, SizeOf(PrevTokenPriv), 
          PrevTokenPriv, ReturnLength); 
      end; 
    finally 
      CloseHandle(hToken); 
    end; 
  end; 
  // test the return value of AdjustTokenPrivileges. 
  Result := GetLastError = ERROR_SUCCESS; 
  if not Result then 
    raise Exception.Create(SysErrorMessage(GetLastError));
end;

function GetMemUse(h: integer): Cardinal;
var
  MemCounters: TProcessMemoryCounters;
begin
  Result := 0;
  MemCounters.cb := SizeOf(MemCounters);
  if GetProcessMemoryInfo(h,@MemCounters,SizeOf(MemCounters))
  then Result := MemCounters.WorkingSetSize;
end;

Function GetX87SW: word;
ASM
  FStSW [Result]
End;

function IsFloat(value:variant):Boolean;
var temp, errorPos :integer;
begin
  Val(Value, temp, errorPos);
  result := (errorPos = 0);
end;

function TruncWouldGiveException(S : AnsiString) : boolean;
var IntrPending: word;
begin
  IntrPending := GetX87SW and $00FF;
  Result := (($FF-ChopMasks) and IntrPending) <> 0;
  If result then
    Application.MessageBox(PChar(s), 'Trunc would give exception', 0);
end;

function Tmain.processExists(exeFileName: string; var id: Cardinal): Boolean;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := False; 
  while Integer(ContinueLoop) <> 0 do 
  begin 
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
      UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
      UpperCase(ExeFileName))) then 
    begin 
      Result := True;
      id := FProcessEntry32.th32ProcessID;
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


procedure Tmain.openbtnClick(Sender: TObject);
begin
  if openbtn.Caption = 'Open' then
  begin
    if processExists(processcombo.text{processcombo.Items[processcombo.ItemIndex]}, PID) then
    begin
      statusbar1.Panels.Items[1].Text := processcombo.Items[processcombo.ItemIndex] + ' is open.';
      openbtn.Caption := 'Close';
      processcombo.Enabled := false;
      refreshbtn.Enabled := false;
      NTSetPrivilege('SeDebugPrivilege',true);
      PHandle := OpenProcess($1f0fff,False,PID);
      scanbtn.Enabled := true;
      nextbtn.Enabled := false;
    end;
  end
  else begin
    statusbar1.Panels.Items[1].Text := processcombo.Items[processcombo.ItemIndex] + ' closed.';
    openbtn.Caption := 'Open';
    processcombo.Enabled := true;
    refreshbtn.Enabled := true;
    CloseHandle(PHandle);
    scanbtn.Enabled := false;
  end;
end;

procedure Tmain.refreshbtnClick(Sender: TObject);
var
  Snapshot: THandle;
  pe: TProcessEntry32;
begin
  processcombo.Clear;
  Snapshot := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  try
    pe.dwSize := SizeOf(pe);
    if Process32First(Snapshot, pe) then
      while Process32Next(Snapshot, pe)
      do ProcessCombo.Items.Add(pe.szExeFile);
  finally
    CloseHandle(Snapshot);
  end;
end;

procedure Tmain.FormShow(Sender: TObject);
begin
  DecimalSeparator := '.';
  Application.UpdateFormatSettings := false;
  refreshbtn.Click;
  bytes := 4;
  restype := 1;
end;

procedure Tmain.scanbtnClick(Sender: TObject);
var roundfloatinput, roundfloatinput1, roundfloatinput2, intinput, intinput1, intinput2, max, address: Integer;
    floatinput, floatinput1, floatinput2: Real;
    datafloat: single;
    datadouble: real;
    x: cardinal;
    memresptr: Pointer;
    dataint: Integer;
    datastr: array [1..255] of char;
    stroutput, strinput: string;
    strptr: PChar;
    itm: TListItem;
    rounddatafloat: Int64;
begin
  scanbtn.Enabled := false;
  valueinput.Enabled := false;
  scanbtn.Enabled := false;
  scantype.Enabled := false;
  byte1.Enabled := false;
  byte2.Enabled := false;
  byte4.Enabled := false;
  doublec.Enabled := false;
  float.Enabled := false;
  strings.Enabled := false;

  statusbar1.Panels.Items[1].Text := 'Initializing...';
  {Max := GetMemUse(pHandle);
  memresptr := VirtualAlloc(nil,max+1,MEM_RESERVE or MEM_COMMIT,PAGE_READWRITE);
  if (memresptr <> nil) then
  begin
    if ReadprocessMemory(PHandle, Ptr($20001), memresptr, max-$20000, x)
    then ShowMessage('Copied Sucessfully: '+IntToStr(x div 1024)+'KB')
    else ShowMessage('Failed to copy '+IntToStr(max div 1024)+'KB');
  end
  else begin
    ShowMessage('Failed to allocate '+IntToStr(max div 1024)+'KB');
    cancel := 1;
  end;}

  cancelbtn.enabled := true;

  if restype = 1 then
  begin
    intinput := StrToInt(Trim(valueinput.Text));
    intinput1 := StrToInt(Trim(valueinput1.Text));
    intinput2 := StrToInt(Trim(valueinput2.Text));

    if intinput2 < intinput1 then
    begin
      intinput1 := intinput1 + intinput2;
      intinput2 := intinput1 - intinput2;
      intinput1 := intinput1 - intinput2;
    end;

  end;

  if restype = 2 then
  begin
    floatinput := StrToFloat(Trim(valueinput.Text));
    floatinput1 := StrToFloat(Trim(valueinput1.Text));
    floatinput2 := StrToFloat(Trim(valueinput2.Text));

    if floatinput2 < floatinput1 then
    begin
      floatinput1 := floatinput1 + floatinput2;
      floatinput2 := floatinput1 - floatinput2;
      floatinput1 := floatinput1 - floatinput2;
    end;

    roundfloatinput := Round(floatinput);
    roundfloatinput1 := Round(floatinput1);
    roundfloatinput2 := Round(floatinput2);
  end;

  if restype = 3
  then strinput := ValueInput.Text;

  result.Show;
  x := 0;
  address := $10000;
  openbtn.Enabled := false;
  result.resultlist.Clear;
  repeat
    Application.ProcessMessages;
    statusbar1.Panels.Items[1].Text := 'Searching... ' + IntToStr(address * 100 div max) + '% (' + IntToStr(address div bytes) + ' out of ' + IntToStr(max div bytes) + ').';
    scanprogress.Position := address * 100 div max;
    if restype = 1 then
    begin
      ReadprocessMemory(PHandle, Ptr(address), @dataint, bytes, x);
      if x > 0 then
      begin
      if scantype.ItemIndex = 0 then
        begin
         if dataint = intinput
         then begin
          itm := result.resultlist.Items.Add;
          itm.Caption := IntToHex(address,8);
          itm.SubItems.Add(IntToStr(dataint));
         end;
        end;
        if scantype.ItemIndex = 1 then
        begin
         if dataint > intinput
         then begin
          itm := result.resultlist.Items.Add;
          itm.Caption := IntToHex(address,8);
          itm.SubItems.Add(IntToStr(dataint));
         end;
        end;
        if scantype.ItemIndex = 2 then
        begin
         if dataint < intinput
         then begin
          itm := result.resultlist.Items.Add;
          itm.Caption := IntToHex(address,8);
          itm.SubItems.Add(IntToStr(dataint));
         end;
        end;
        if scantype.ItemIndex = 3 then
        begin
         if (dataint <= intinput2) and (dataint >= intinput1)
         then begin
          itm := result.resultlist.Items.Add;
          itm.Caption := IntToHex(address,8);
          itm.SubItems.Add(IntToStr(dataint));
         end;
        end;
        if scantype.ItemIndex = 4 then
        begin
         if dataint <> intinput
         then begin
          itm := result.resultlist.Items.Add;
          itm.Caption := IntToHex(address,8);
          itm.SubItems.Add(IntToStr(dataint));
         end;
        end;
      end;
    end;

    if restype = 2 then
    begin
      if bytes = 4 then
      begin
      if ReadprocessMemory(PHandle, Ptr(address), @datafloat, bytes, x) then
        begin
          if (x > 0) and
             (not IsNaN(datafloat)) and
             (datafloat <> Infinity) and
             (IsFloat(datafloat)) then
          begin
            rounddatafloat := Round(datafloat);
            if scantype.ItemIndex = 0 then
            begin
              if rounddatafloat = roundfloatinput then
              begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datafloat));
              end;
            end;
            if scantype.ItemIndex = 1 then
            begin
              if rounddatafloat > roundfloatinput
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datafloat));
              end;
            end;
            if scantype.ItemIndex = 2 then
            begin
              if rounddatafloat < roundfloatinput
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datafloat));
              end;
            end;
            if scantype.ItemIndex = 3 then
            begin
              if (rounddatafloat <= roundfloatinput2) and (Rounddatafloat >= roundfloatinput1)
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datafloat));
              end;
            end;
            if scantype.ItemIndex = 4 then
            begin
              if rounddatafloat <> roundfloatinput
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datafloat));
              end;
            end;
          end;
        end;
      end
      else begin
        if ReadprocessMemory(PHandle, Ptr(address), @datadouble, bytes, x) then
        begin
          if (x > 0) and
             (not IsNaN(datadouble)) and
             (datadouble <> Infinity) and
             (IsFloat(datadouble)) then
          begin
            rounddatafloat := Round(datadouble);
            if scantype.ItemIndex = 0 then
            begin
              if rounddatafloat = roundfloatinput then
              begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datadouble));
              end;
            end;
            if scantype.ItemIndex = 1 then
            begin
              if rounddatafloat > roundfloatinput
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datadouble));
              end;
            end;
            if scantype.ItemIndex = 2 then
            begin
              if rounddatafloat < roundfloatinput
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datadouble));
              end;
            end;
            if scantype.ItemIndex = 3 then
            begin
              if (rounddatafloat <= roundfloatinput2) and (Rounddatafloat >= roundfloatinput1)
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datadouble));
              end;
            end;
            if scantype.ItemIndex = 4 then
            begin
              if rounddatafloat <> roundfloatinput
              then begin
                itm := result.resultlist.Items.Add;
                itm.Caption := IntToHex(address,8);
                itm.SubItems.Add(FormatFloat('0.###############', datadouble));
              end;
            end;
          end;
        end;
      end;
    end;

    if restype = 3 then
    begin
      ReadprocessMemory(PHandle, Ptr(address), @datastr, bytes, x);
      if x > 0 then
      begin
        strptr := addr(datastr);
        SetString(stroutput, strptr, bytes);
        if stroutput = strinput then
        begin
          itm := result.resultlist.Items.Add;
          itm.Caption := IntToHex(address,8);
          itm.SubItems.Add(stroutput);
        end;
      end;
    end;

    if restype <> 3 then
    begin
     if x <> 0
     then address := address + x
     else address := address + bytes;
    end
    else  address := address + 1;


  until (address >= Max) or (cancel = 1);

  if cancel <> 1
  then statusbar1.Panels.Items[1].Text := 'Done! (' + IntToStr(result.resultlist.Items.Count) + ' Matches)'
  else statusbar1.Panels.Items[1].Text := 'Search stopped.';

  if result.resultlist.Items.Count > 0
  then begin
    nextbtn.Enabled := true;
    result.Caption := 'Search Matches ['+ IntToStr(result.resultlist.Items.Count) +' Matches]';
  end
  else begin
    nextbtn.Enabled := false;
    result.Caption := 'Search Matches';
  end;

  cancelbtn.Enabled := false;
  openbtn.Enabled := true;
  scanbtn.Enabled := true;
  valueinput.Enabled := true;
  byte1.Enabled := true;
  byte2.Enabled := true;
  byte4.Enabled := true;
  doublec.Enabled := true;
  float.Enabled := true;
  strings.Enabled := true;
  scantype.Enabled := true;

  cancel := 0;

end;

procedure Tmain.byte1Click(Sender: TObject);
begin
bytes := 1;
restype := 1;
scantype.Enabled := true;
nextbtn.Enabled := false;
end;

procedure Tmain.byte2Click(Sender: TObject);
begin
nextbtn.Enabled := false;
bytes := 2;
restype := 1;
scantype.Enabled := true;
end;

procedure Tmain.byte4Click(Sender: TObject);
begin
bytes := 4;
restype := 1;
scantype.Enabled := true;
nextbtn.Enabled := false;
end;

procedure Tmain.floatClick(Sender: TObject);
var f: single;
begin
bytes := sizeof(f);
restype := 2;
scantype.Enabled := true;
nextbtn.Enabled := false;
end;

procedure Tmain.cancelbtnClick(Sender: TObject);
begin
cancel := 1;
end;

procedure Tmain.doublecClick(Sender: TObject);
var f: real;
begin
bytes := sizeof(f);
restype := 2;
scantype.Enabled := true;
nextbtn.Enabled := false;
end;

procedure Tmain.stringsClick(Sender: TObject);
begin
restype := 3;
scantype.ItemIndex := 0;
scantype.Enabled := false;
bytes := length(Trim(valueinput.text));
valueinput.Visible := true;
nextbtn.Enabled := false;
end;

procedure Tmain.addrmodbtnClick(Sender: TObject);
begin
  if memmod.Visible
  then memmod.Hide
  else memmod.Show;
end;

procedure Tmain.scantypeChange(Sender: TObject);
begin
  if scantype.ItemIndex = 3
  then valueinput.Visible := false
  else valueinput.Visible := true;
end;

procedure Tmain.nextbtnClick(Sender: TObject);
var roundfloatinput, roundfloatinput1, roundfloatinput2, rounddatafloat, intinput, intinput1, intinput2, i, oldcount: integer;
    floatinput, floatinput1, floatinput2: real;
    datafloat: single;
    datadouble: real;
    x, address: Cardinal;
    dataint: Integer;
    datastr: array [1..255] of char;
    StrPtr: PChar;
    strinput, stroutput: string;
    resultlist2: TListView;
    itm: TListItem;
begin

  scanbtn.Enabled := false;
  valueinput.Enabled := false;
  scanbtn.Enabled := false;
  scantype.Enabled := false;
  byte1.Enabled := false;
  byte2.Enabled := false;
  byte4.Enabled := false;
  doublec.Enabled := false;
  float.Enabled := false;
  strings.Enabled := false;
  cancelbtn.enabled := true;

  floatinput := 0;
  floatinput1 := 0;
  floatinput2 := 0;
  intinput := 0;
  intinput1 := 0;
  intinput2 := 0;

  if restype = 1 then
  begin
    intinput := StrToInt(Trim(valueinput.Text));
    intinput1 := StrToInt(Trim(valueinput1.Text));
    intinput2 := StrToInt(Trim(valueinput2.Text));

    if intinput2 < intinput1 then
    begin
      intinput1 := intinput1 + intinput2;
      intinput2 := intinput1 - intinput2;
      intinput1 := intinput1 - intinput2;
    end;

  end;

  if restype = 2 then
  begin
    floatinput := StrToFloat(Trim(valueinput.Text));
    floatinput1 := StrToFloat(Trim(valueinput1.Text));
    floatinput2 := StrToFloat(Trim(valueinput2.Text));

    if floatinput2 < floatinput1 then
    begin
      floatinput1 := floatinput1 + floatinput2;
      floatinput2 := floatinput1 - floatinput2;
      floatinput1 := floatinput1 - floatinput2;
    end;

    roundfloatinput := Round(floatinput);
    roundfloatinput1 := Round(floatinput1);
    roundfloatinput2 := Round(floatinput2);

  end;

  if restype = 3
  then strinput := ValueInput.Text;

  result.Show;
  x := 0;
  openbtn.Enabled := false;

  i := result.resultlist.Items.Count - 1;
  oldcount := i;

  resultlist2 := TListView.CreateParented(result.resultlist.Handle);
  resultlist2.Columns := result.resultlist.Columns;
  resultlist2.Clear;
  resultlist2.Visible := false;

  while (i >= 0) or (cancel <> 1) do
  begin

    Application.ProcessMessages;

    statusbar1.Panels.Items[1].Text := 'Refining Matches.. ' + IntToStr(100 - i * 100 div oldCount) + '%';

    if i >= 0
    then address := StrToInt('$'+result.resultlist.Items.Item[i].Caption)
    else break;

    if restype = 1 then
    begin
      if ReadprocessMemory(PHandle, Ptr(address), @dataint, bytes, x) then
      begin
        if x > 0 then
        begin
          if scantype.ItemIndex = 0 then
          begin
           if dataint = intinput
           then begin
            itm := resultlist2.Items.Add;
            itm.Caption := IntToHex(address,8);
            itm.SubItems.Add(IntToStr(dataint));
           end;
          end;
          if scantype.ItemIndex = 1 then
          begin
           if dataint > intinput
           then begin
            itm := resultlist2.Items.Add;
            itm.Caption := IntToHex(address,8);
            itm.SubItems.Add(IntToStr(dataint));
           end;
          end;
          if scantype.ItemIndex = 2 then
          begin
           if dataint < intinput
           then begin
            itm := resultlist2.Items.Add;
            itm.Caption := IntToHex(address,8);
            itm.SubItems.Add(IntToStr(dataint));
           end;
          end;
          if scantype.ItemIndex = 3 then
          begin
           if (dataint <= intinput2) and (dataint >= intinput1)
           then begin
            itm := resultlist2.Items.Add;
            itm.Caption := IntToHex(address,8);
            itm.SubItems.Add(IntToStr(dataint));
           end;
          end;
          if scantype.ItemIndex = 4 then
          begin
           if dataint <> intinput
           then begin
            itm := resultlist2.Items.Add;
            itm.Caption := IntToHex(address,8);
            itm.SubItems.Add(IntToStr(dataint));
           end;
          end;
        end;
      end;
    end;

    if restype = 2 then
    begin
      if bytes = 4 then
      begin
        ReadprocessMemory(PHandle, Ptr(address), @datafloat, bytes, x);
        if  (x > 0) and
            (not IsNaN(datafloat)) and
            (datafloat <> Infinity) and
            (IsFloat(datafloat)) then
        begin
          rounddatafloat := Round(datafloat);
          if scantype.ItemIndex = 0 then
          begin
            if roundfloatinput = rounddatafloat then
            begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 1 then
          begin
            if roundfloatinput > rounddatafloat
            then begin
              itm := resultlist2.Items.Add;
                itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 2 then
          begin
            if roundfloatinput < rounddatafloat
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 3 then
          begin
            if (rounddatafloat <= roundfloatinput2) and (rounddatafloat >= roundfloatinput1)
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 4 then
          begin
            if rounddatafloat <> roundfloatinput
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
        end;
        end
        else begin
        ReadprocessMemory(PHandle, Ptr(address), @datadouble, bytes, x);
        if (x > 0) and
           (not IsNaN(datadouble)) and
           (datadouble <> Infinity) and
           (IsFloat(datadouble)) then
        begin
          rounddatafloat := Round(datadouble);
          if scantype.ItemIndex = 0 then
          begin
            if roundfloatinput = rounddatafloat then
            begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 1 then
          begin
            if rounddatafloat > roundfloatinput
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 2 then
          begin
            if rounddatafloat < roundfloatinput
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 3 then
          begin
            if (rounddatafloat <= roundfloatinput2) and (rounddatafloat >= roundfloatinput1)
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
          if scantype.ItemIndex = 4 then
          begin
            if rounddatafloat <> roundfloatinput
            then begin
              itm := resultlist2.Items.Add;
              itm.Caption := IntToHex(address,8);
              itm.SubItems.Add(IntToStr(dataint));
            end;
          end;
        end;
      end;
    end;

    if restype = 3 then
    begin
      if ReadprocessMemory(PHandle, Ptr(address), @datastr, bytes, x) then
      begin
        if x > 0 then
        begin
          strptr := addr(datastr);
          SetString(stroutput, strptr, bytes);
          if CompareStr(stroutput,strinput) = 0 then
          begin
            itm := resultlist2.Items.Add;
            itm.Caption := IntToHex(address,8);
           itm.SubItems.Add(IntToStr(dataint));
          end;
        end;
      end;
    end;

    i := i - 1;

  end;

  result.resultlist.clear;
  result.resultlist.Items := resultlist2.Items;
  result.resultlist.Refresh;
  result.resultlist.Repaint;

  result.Refresh;
  result.Repaint;

  if cancel <> 1
  then statusbar1.Panels.Items[1].Text := 'Done! (' + IntToStr(result.resultlist.Items.Count) + ' Matches)'
  else statusbar1.Panels.Items[1].Text := 'Search stopped.';

  if result.resultlist.Items.Count > 0
  then begin
    nextbtn.Enabled := true;
    result.Caption := 'Search Matches ['+ IntToStr(result.resultlist.Items.Count) +' Matches]';
  end
  else begin
    nextbtn.Enabled := false;
    result.Caption := 'Search Matches';
  end;

  cancelbtn.Enabled := false;
  openbtn.Enabled := true;
  scanbtn.Enabled := true;
  valueinput.Enabled := true;
  byte1.Enabled := true;
  byte2.Enabled := true;
  byte4.Enabled := true;
  doublec.Enabled := true;
  float.Enabled := true;
  strings.Enabled := true;
  scantype.Enabled := true;

  cancel := 0;
end;

procedure Tmain.injectbtnClick(Sender: TObject);
begin
  if injector.Visible
  then injector.hide
  else injector.Show;
end;

procedure Tmain.SpeedButton1Click(Sender: TObject);
begin
  if result.Visible
  then result.Hide
  else result.Show;
end;

procedure Tmain.processcomboChange(Sender: TObject);
begin
  statusbar1.Panels.Items[1].Text := processcombo.Items[processcombo.ItemIndex] + ' is selected.';
end;

procedure Tmain.SpeedButton2Click(Sender: TObject);
begin
if memview.visible
then memview.Hide
else memview.Show;
end;

procedure Tmain.SpeedButton3Click(Sender: TObject);
begin
  memblock.show;
end;

end.

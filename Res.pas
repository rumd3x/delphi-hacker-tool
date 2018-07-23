unit Res;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, Menus, Unit_main;

type
  Tresult = class(TForm)
    resultlist: TListView;
    Panel1: TPanel;
    ListUpdater: TTimer;
    procedure FormShow(Sender: TObject);
    procedure resultlistChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure resultlistInsert(Sender: TObject; Item: TListItem);
    procedure resultlistDeletion(Sender: TObject; Item: TListItem);
    procedure ListUpdaterTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure resultlistDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  result: Tresult;

implementation

uses watcher;

{$R *.dfm}

procedure Tresult.FormShow(Sender: TObject);
begin
  result.Top := main.top + main.Height div 2 - result.Height div 2;
  result.Left := main.Left + main.Width + 25;
  if resultlist.Items.Count <> 0
  then result.Caption := 'Search Matches ['+ IntToStr(resultlist.Items.Count) +' Matches]'
  else result.Caption := 'Search Matches';
  ListUpdater.Enabled := true;
end;

procedure Tresult.resultlistChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if resultlist.Items.Count <> 0
  then result.Caption := 'Search Matches ['+ IntToStr(resultlist.Items.Count) +' Matches]'
  else result.Caption := 'Search Matches';
end;

procedure Tresult.resultlistInsert(Sender: TObject; Item: TListItem);
begin
  if resultlist.Items.Count <> 0
  then result.Caption := 'Search Matches ['+ IntToStr(resultlist.Items.Count) +' Matches]'
  else result.Caption := 'Search Matches';
end;

procedure Tresult.resultlistDeletion(Sender: TObject; Item: TListItem);
begin
  if resultlist.Items.Count <> 0
  then result.Caption := 'Search Matches ['+ IntToStr(resultlist.Items.Count) +' Matches]'
  else result.Caption := 'Search Matches';
end;

procedure Tresult.ListUpdaterTimer(Sender: TObject);
var n, i: integer;
    bytesread, addrs: cardinal;
    intout: integer;
    floatout: single;
    doubleout: real;
begin
  n := resultlist.Items.Count;
  if (n > 0) and (n <= 1000) then
  begin

    for i:=n-1 downto 0 do
    begin

      if i >= 0 then
      begin
        addrs := StrToInt('$'+resultlist.Items.Item[i].Caption);
      end
      else begin
        break;
      end;

      if restype = 1 then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @intout, bytes, bytesread);
        resultlist.Items.Item[i].SubItems.Strings[0] := IntToStr(intout);
      end;

      if (restype = 2) and (bytes = 4) then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @floatout, bytes, bytesread);
        resultlist.Items.Item[i].SubItems.Strings[0] := FormatFloat('0.###############', floatout);
      end;

      if (restype = 2) and (bytes = 8) then
      begin
        ReadprocessMemory(PHandle, Ptr(addrs), @doubleout, sizeof(doubleout), bytesread);
        resultlist.Items.Item[i].SubItems.Strings[0] := FormatFloat('0.###############', doubleout);
      end;

    end;
  end;
end;

procedure Tresult.FormHide(Sender: TObject);
begin
  ListUpdater.Enabled := false;
end;

procedure Tresult.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ListUpdater.Enabled := false;
end;

procedure Tresult.resultlistDblClick(Sender: TObject);
var itm: TListitem;
begin
  if resultlist.Items.Count > 0 then
  begin
  if resultlist.Selected.Caption <> '' then
  begin
  itm := memview.addresseslist.Items.Add;
  itm.Caption := resultlist.Selected.Caption;
  if restype = 1
  then itm.SubItems.Add(IntToStr(bytes)+' Bytes');
  if (restype = 2) and (bytes = 4)
  then itm.SubItems.Add('Float');
  if (restype = 2) and (bytes = 8)
  then itm.SubItems.Add('Double');
  if (restype = 3)
  then itm.SubItems.Add('String['+IntToStr(bytes)+']');
  itm.SubItems.Add(resultlist.Selected.SubItems.Strings[0]);
  memview.Show;
  end;
  end;
end;

end.

object result: Tresult
  Left = 194
  Top = 332
  BorderStyle = bsToolWindow
  Caption = 'Search Matches'
  ClientHeight = 380
  ClientWidth = 269
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnClose = FormClose
  OnHide = FormHide
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 269
    Height = 381
    BevelInner = bvLowered
    TabOrder = 0
    object resultlist: TListView
      Left = 2
      Top = 2
      Width = 263
      Height = 375
      BevelInner = bvLowered
      BevelOuter = bvRaised
      BorderStyle = bsNone
      Columns = <
        item
          Caption = 'Address'
          Width = 100
        end
        item
          Alignment = taCenter
          Caption = 'Value'
          Width = 140
        end>
      ColumnClick = False
      GridLines = True
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = resultlistChange
      OnDblClick = resultlistDblClick
      OnDeletion = resultlistDeletion
      OnInsert = resultlistInsert
    end
  end
  object ListUpdater: TTimer
    Enabled = False
    Interval = 25
    OnTimer = ListUpdaterTimer
    Left = 240
  end
end

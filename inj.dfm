object injector: Tinjector
  Left = 1150
  Top = 132
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Dll Injector'
  ClientHeight = 81
  ClientWidth = 201
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 201
    Height = 81
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 48
      Height = 13
      Caption = 'DLL Path:'
    end
    object path: TEdit
      Left = 16
      Top = 22
      Width = 129
      Height = 21
      Hint = 'DLL Path'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
    end
    object Button1: TButton
      Left = 160
      Top = 22
      Width = 25
      Height = 21
      Hint = 'Search for dll..'
      Caption = '...'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Button1Click
    end
    object injectbtn: TButton
      Left = 63
      Top = 51
      Width = 75
      Height = 19
      Caption = 'Inject'
      TabOrder = 2
      OnClick = injectbtnClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Library Files (.dll)|*.dll'
    Options = [ofHideReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 8
    Top = 48
  end
end

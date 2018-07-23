object memmod: Tmemmod
  Left = 527
  Top = 130
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Memory Editor'
  ClientHeight = 120
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 121
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 10
      Width = 41
      Height = 13
      Caption = 'Address:'
    end
    object Label2: TLabel
      Left = 19
      Top = 37
      Width = 27
      Height = 13
      Caption = 'Type:'
    end
    object Label3: TLabel
      Left = 16
      Top = 64
      Width = 30
      Height = 13
      Caption = 'Value:'
    end
    object address: TEdit
      Left = 54
      Top = 8
      Width = 121
      Height = 21
      BiDiMode = bdLeftToRight
      CharCase = ecUpperCase
      ParentBiDiMode = False
      TabOrder = 0
    end
    object applybtn: TButton
      Left = 56
      Top = 92
      Width = 73
      Height = 19
      Caption = 'Apply'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = applybtnClick
    end
    object vartype: TComboBox
      Left = 54
      Top = 34
      Width = 121
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = 'Byte'
      Items.Strings = (
        'Byte'
        '2 Bytes'
        '4 Bytes'
        'Float'
        'Double'
        'String')
    end
    object value: TEdit
      Left = 54
      Top = 60
      Width = 121
      Height = 21
      TabOrder = 3
    end
  end
end

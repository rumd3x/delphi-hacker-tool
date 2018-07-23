object memblock: Tmemblock
  Left = 1386
  Top = 130
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Memory Block Viewer'
  ClientHeight = 216
  ClientWidth = 352
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Lucida Console'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 11
  object allpanel: TPanel
    Left = 0
    Top = 0
    Width = 353
    Height = 217
    BevelInner = bvLowered
    TabOrder = 0
    object address0: TLabel
      Left = 8
      Top = 72
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object address1: TLabel
      Left = 8
      Top = 96
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object address2: TLabel
      Left = 8
      Top = 120
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object address3: TLabel
      Left = 8
      Top = 144
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object address4: TLabel
      Left = 8
      Top = 168
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object address5: TLabel
      Left = 8
      Top = 192
      Width = 56
      Height = 11
      Caption = '00000000'
    end
    object numheader: TPanel
      Left = 16
      Top = 48
      Width = 305
      Height = 25
      BevelOuter = bvNone
      TabOrder = 1
      object byte2lbl: TLabel
        Left = 112
        Top = 6
        Width = 42
        Height = 11
        Caption = '2Bytes'
      end
      object floatlbl: TLabel
        Left = 224
        Top = 6
        Width = 35
        Height = 11
        Caption = 'Float'
      end
      object byte4lbl: TLabel
        Left = 168
        Top = 6
        Width = 42
        Height = 11
        Caption = '4Bytes'
      end
      object byte1: TLabel
        Left = 64
        Top = 6
        Width = 28
        Height = 11
        Caption = 'Byte'
      end
      object doublelbl: TLabel
        Left = 271
        Top = 6
        Width = 42
        Height = 11
        Caption = 'Double'
      end
    end
    object charheader: TPanel
      Left = 0
      Top = 48
      Width = 313
      Height = 25
      BevelOuter = bvNone
      TabOrder = 2
      object hexblbl: TLabel
        Left = 96
        Top = 6
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object hexolbl: TLabel
        Left = 304
        Top = 6
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object hexnlbl: TLabel
        Left = 288
        Top = 6
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object hexmlbl: TLabel
        Left = 272
        Top = 6
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object hexllbl: TLabel
        Left = 256
        Top = 6
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object hexklbl: TLabel
        Left = 240
        Top = 6
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object hexjlbl: TLabel
        Left = 224
        Top = 6
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object hexilbl: TLabel
        Left = 208
        Top = 6
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object hexhlbl: TLabel
        Left = 192
        Top = 6
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
      object hexglbl: TLabel
        Left = 176
        Top = 6
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object hexflbl: TLabel
        Left = 160
        Top = 6
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object hexelbl: TLabel
        Left = 144
        Top = 6
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object hexdlbl: TLabel
        Left = 128
        Top = 6
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object hexclbl: TLabel
        Left = 112
        Top = 6
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object hexalbl: TLabel
        Left = 80
        Top = 6
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
    end
    object charspanel: TPanel
      Left = 64
      Top = 71
      Width = 249
      Height = 137
      BevelOuter = bvNone
      TabOrder = 0
      Visible = False
      object Label10: TLabel
        Left = 112
        Top = 1
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object Label9: TLabel
        Left = 128
        Top = 1
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
      object Label8: TLabel
        Left = 144
        Top = 1
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object Label7: TLabel
        Left = 160
        Top = 1
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object Label6: TLabel
        Left = 176
        Top = 1
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object Label5: TLabel
        Left = 191
        Top = 1
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object Label4: TLabel
        Left = 208
        Top = 1
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object Label3: TLabel
        Left = 224
        Top = 1
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object Label2: TLabel
        Left = 240
        Top = 1
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object Label16: TLabel
        Left = 16
        Top = 1
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
      object Label15: TLabel
        Left = 32
        Top = 1
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object Label14: TLabel
        Left = 48
        Top = 1
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object Label13: TLabel
        Left = 64
        Top = 1
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object Label12: TLabel
        Left = 80
        Top = 1
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object Label11: TLabel
        Left = 96
        Top = 1
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object Label1: TLabel
        Left = 128
        Top = 25
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
      object Label17: TLabel
        Left = 144
        Top = 25
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object Label18: TLabel
        Left = 160
        Top = 25
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object Label19: TLabel
        Left = 176
        Top = 25
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object Label20: TLabel
        Left = 191
        Top = 25
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object Label21: TLabel
        Left = 208
        Top = 25
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object Label22: TLabel
        Left = 224
        Top = 25
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object Label23: TLabel
        Left = 240
        Top = 25
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object Label24: TLabel
        Left = 16
        Top = 25
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
      object Label25: TLabel
        Left = 32
        Top = 25
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object Label26: TLabel
        Left = 48
        Top = 25
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object Label27: TLabel
        Left = 64
        Top = 25
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object Label28: TLabel
        Left = 80
        Top = 25
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object Label29: TLabel
        Left = 96
        Top = 25
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object Label30: TLabel
        Left = 112
        Top = 25
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object Label32: TLabel
        Left = 144
        Top = 49
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object Label31: TLabel
        Left = 128
        Top = 49
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
      object Label33: TLabel
        Left = 160
        Top = 49
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object Label34: TLabel
        Left = 176
        Top = 49
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object Label35: TLabel
        Left = 191
        Top = 49
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object Label36: TLabel
        Left = 208
        Top = 49
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object Label37: TLabel
        Left = 112
        Top = 73
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object Label38: TLabel
        Left = 224
        Top = 49
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object Label39: TLabel
        Left = 96
        Top = 73
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object Label40: TLabel
        Left = 80
        Top = 73
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object Label41: TLabel
        Left = 64
        Top = 73
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object Label42: TLabel
        Left = 48
        Top = 73
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object Label43: TLabel
        Left = 32
        Top = 73
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object Label44: TLabel
        Left = 16
        Top = 73
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
      object Label45: TLabel
        Left = 240
        Top = 73
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object Label46: TLabel
        Left = 224
        Top = 73
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object Label47: TLabel
        Left = 208
        Top = 73
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object Label48: TLabel
        Left = 191
        Top = 73
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object Label49: TLabel
        Left = 240
        Top = 49
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object Label50: TLabel
        Left = 176
        Top = 73
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object Label51: TLabel
        Left = 160
        Top = 73
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object Label52: TLabel
        Left = 144
        Top = 73
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object Label53: TLabel
        Left = 16
        Top = 49
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
      object Label54: TLabel
        Left = 32
        Top = 49
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object Label55: TLabel
        Left = 48
        Top = 49
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object Label56: TLabel
        Left = 64
        Top = 49
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object Label57: TLabel
        Left = 80
        Top = 49
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object Label58: TLabel
        Left = 96
        Top = 49
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object Label59: TLabel
        Left = 112
        Top = 49
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object Label60: TLabel
        Left = 128
        Top = 73
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
      object Label61: TLabel
        Left = 128
        Top = 97
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
      object Label62: TLabel
        Left = 144
        Top = 97
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object Label63: TLabel
        Left = 160
        Top = 97
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object Label64: TLabel
        Left = 176
        Top = 97
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object Label65: TLabel
        Left = 191
        Top = 97
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object Label66: TLabel
        Left = 208
        Top = 97
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object Label67: TLabel
        Left = 112
        Top = 121
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object Label68: TLabel
        Left = 224
        Top = 97
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object Label69: TLabel
        Left = 96
        Top = 121
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object Label70: TLabel
        Left = 80
        Top = 121
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object Label71: TLabel
        Left = 64
        Top = 121
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object Label72: TLabel
        Left = 48
        Top = 121
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object Label73: TLabel
        Left = 32
        Top = 121
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object Label74: TLabel
        Left = 16
        Top = 121
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
      object Label75: TLabel
        Left = 240
        Top = 121
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object Label76: TLabel
        Left = 224
        Top = 121
        Width = 7
        Height = 11
        Caption = 'E'
        Visible = False
      end
      object Label77: TLabel
        Left = 208
        Top = 121
        Width = 7
        Height = 11
        Caption = 'D'
        Visible = False
      end
      object Label78: TLabel
        Left = 191
        Top = 121
        Width = 7
        Height = 11
        Caption = 'C'
        Visible = False
      end
      object Label79: TLabel
        Left = 240
        Top = 97
        Width = 7
        Height = 11
        Caption = 'F'
        Visible = False
      end
      object Label80: TLabel
        Left = 176
        Top = 121
        Width = 7
        Height = 11
        Caption = 'B'
        Visible = False
      end
      object Label81: TLabel
        Left = 160
        Top = 121
        Width = 7
        Height = 11
        Caption = 'A'
        Visible = False
      end
      object Label82: TLabel
        Left = 144
        Top = 121
        Width = 7
        Height = 11
        Caption = '9'
        Visible = False
      end
      object Label83: TLabel
        Left = 16
        Top = 97
        Width = 7
        Height = 11
        Caption = '1'
        Visible = False
      end
      object Label84: TLabel
        Left = 32
        Top = 97
        Width = 7
        Height = 11
        Caption = '2'
        Visible = False
      end
      object Label85: TLabel
        Left = 48
        Top = 97
        Width = 7
        Height = 11
        Caption = '3'
        Visible = False
      end
      object Label86: TLabel
        Left = 64
        Top = 97
        Width = 7
        Height = 11
        Caption = '4'
        Visible = False
      end
      object Label87: TLabel
        Left = 80
        Top = 97
        Width = 7
        Height = 11
        Caption = '5'
        Visible = False
      end
      object Label88: TLabel
        Left = 96
        Top = 97
        Width = 7
        Height = 11
        Caption = '6'
        Visible = False
      end
      object Label89: TLabel
        Left = 112
        Top = 97
        Width = 7
        Height = 11
        Caption = '7'
        Visible = False
      end
      object Label90: TLabel
        Left = 128
        Top = 121
        Width = 7
        Height = 11
        Caption = '8'
        Visible = False
      end
    end
    object settingspan: TPanel
      Left = 2
      Top = 2
      Width = 343
      Height = 47
      BevelOuter = bvNone
      TabOrder = 3
      object addrlbl: TLabel
        Left = 171
        Top = 8
        Width = 41
        Height = 13
        Caption = 'Address:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object disptyplbl: TLabel
        Left = 11
        Top = 8
        Width = 64
        Height = 13
        Caption = 'Display Type:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object displaytype: TComboBox
        Left = 11
        Top = 24
        Width = 145
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = 'Decimal'
        Items.Strings = (
          'Decimal'
          'Hexadecimal'
          'Char')
      end
      object gobtn: TButton
        Left = 299
        Top = 24
        Width = 33
        Height = 19
        Caption = 'Go'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object address: TEdit
        Left = 171
        Top = 24
        Width = 121
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
    end
    object Button1: TButton
      Left = 328
      Top = 71
      Width = 17
      Height = 17
      Caption = '/\'
      TabOrder = 4
    end
    object Button2: TButton
      Left = 328
      Top = 189
      Width = 17
      Height = 17
      Caption = '\/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Lucida Console'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
    end
  end
  object Timer1: TTimer
    Left = 320
    Top = 65528
  end
end

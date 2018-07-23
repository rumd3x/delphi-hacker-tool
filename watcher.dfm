object memview: Tmemview
  Left = 746
  Top = 130
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Memory Watcher'
  ClientHeight = 218
  ClientWidth = 367
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
    Width = 369
    Height = 217
    BevelInner = bvLowered
    TabOrder = 0
    object valuelabel: TLabel
      Left = 8
      Top = 51
      Width = 27
      Height = 13
      Caption = '= ???'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 41
      Height = 13
      Caption = 'Address:'
    end
    object Label2: TLabel
      Left = 240
      Top = 8
      Width = 27
      Height = 13
      Caption = 'Type:'
    end
    object Label3: TLabel
      Left = 112
      Top = 8
      Width = 86
      Height = 13
      Caption = 'Module: (Optional)'
    end
    object Label4: TLabel
      Left = 104
      Top = 24
      Width = 9
      Height = 20
      Caption = '+'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 200
      Top = 52
      Width = 36
      Height = 13
      Caption = 'Lenght:'
      Visible = False
    end
    object addresseslist: TListView
      Left = 0
      Top = 73
      Width = 369
      Height = 152
      BevelInner = bvLowered
      BevelOuter = bvRaised
      BevelKind = bkSoft
      BorderStyle = bsNone
      Columns = <
        item
          Caption = 'Address'
          Width = 85
        end
        item
          Alignment = taCenter
          Caption = 'Type'
          Width = 75
        end
        item
          Alignment = taCenter
          Caption = 'Value'
          Width = 185
        end>
      ColumnClick = False
      GridLines = True
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = addresseslistDblClick
    end
    object addressedit: TEdit
      Left = 8
      Top = 24
      Width = 97
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = addresseditChange
    end
    object typecombo: TComboBox
      Left = 240
      Top = 24
      Width = 97
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 3
      Text = 'Byte'
      OnChange = typecomboChange
      Items.Strings = (
        'Byte'
        '2 Bytes'
        '4 Bytes'
        'Float'
        'Double'
        'String')
    end
    object addbtn: TBitBtn
      Left = 344
      Top = 24
      Width = 19
      Height = 19
      TabOrder = 5
      OnClick = addbtnClick
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FDFEFEF9FCFCFFFDFFFFFAFDF0F6F3E9F5EEEFF5F2FFF9FBFFFCFEFBFCFCFDFF
        FEFFFFFFFFFFFF000000FFFFFFFEFFFEFDFDFEFFFBFCC1EAD678D5AB4ACA943F
        C78B4ACB9578D5ABC2E9D5FDF7FAFBFBFCFFFFFFFFFFFF000000FDFEFDFDFCFE
        F5F6F781D8AD23C07E16BD7B2AC4873DC8922CC28217BE7924BF7E81D7AAF1F4
        F1FBFBFBFEFFFE000000FBFDFCFEF9FB7CD3A419BC7928C3871BBE7E9BE2C5FF
        FFFFA0D5A31CBA7328C38A1BBC767CD3A2F9F5F7FAFCFC000000FFFEFFB5E3C4
        1DBB762AC3892CC38718BE7D9FE2C8FFFFFFA7D6A41ABB7329C58928C38A1FBA
        72B5E0C1FFFBFF000000FDF9F96BCC931BC07E17BE7D19BE7E0DBB749BE1C6FF
        FFFFA0D49E0FB66919BF801ABF7C1DC0806ACA8FF8F3F4000000E3EFE24BC583
        4BCF9B9BE1C3A2E3C6A7E3C7E0F5EAFFFFFFDBEDD5A5E0C1A2E4CA9ADDB84BC4
        874BC682DFE9DC000000D7EAD642C27A68D8AFFFFFFFFFFFFFFFFFFFFFFFFFFA
        FCFAFFFFFFFFFFFFFFFFFFFFFCF763C68042C37ED5E3D0000000E2ECDB45C178
        60CB92B5E1BABEE5C7B7E2C1DEF1E3FFFFFFDAECD3B5DFBDBCE6C8B3DDB15AC3
        7F49C079DEE6D5000000F9F8F869BC644FB35355B96359BD6F52BD6AB7E2C2FF
        FFFFABD39D4FB85E59BF6F55B96350B45368BB60F4F2F1000000FFFFFFAED298
        409E1965B95A5FB96152B760B7E2BEFFFFFFB0D6A150B45760B96266B757429D
        16AACF95FFFBFF000000FDFCFBF9F6FA71B14D469C1667B24856AD3EB3DAA9FF
        FFFFABD29752AA3768B248459B1570B14DF5F2F6FCFCFB000000FEFEFDFCFCFE
        EDF0EA70AE4E42940F55A02267AD3F73B54D65AC3D54A02143940F70AE4EE9EC
        E6FBFBFCFEFEFE000000FFFFFFFEFFFEFDFCFEF6F6F7ABCE996CA847559A264D
        971D559B276CA847ABCC98F4F2F4FBFAFCFFFFFEFFFFFF000000FFFFFFFFFFFF
        FDFEFCFBFCFAFFFEFFF8F5F8DEE6D9D2E2CADDE5D8F6F3F6FFFCFFFBFCFAFEFD
        FDFFFFFFFFFFFF000000}
    end
    object delbtn: TBitBtn
      Left = 344
      Top = 48
      Width = 19
      Height = 19
      TabOrder = 6
      OnClick = delbtnClick
      Glyph.Data = {
        06030000424D060300000000000036000000280000000F0000000F0000000100
        180000000000D002000000000000000000000000000000000000FFFFFFFFFFFE
        6D71D21518BEA1A4DBFFFFFFFAFAFDFEFEFEFBFBFEFFFFFFA3A6DE1317BD696E
        CEFFFFFEFFFFFF000000FFFFFF7A7DD81B1BD22A29D90F11BAA1A5DAFFFFFFF8
        F8FDFFFFFFA5A9DE0F11BA2726D51A1AD1777BD3FFFFFF000000696ECF1919D2
        2E2DDA2D2CD82A28D80709B49B9FD7FFFFFFA0A4DC070AB52523D22E2DD92E2D
        DA1A19D16B6FD00000002024C63534E12928D52C2CD83031D92E2ED91518B968
        6EC81618B92727D23131DA2B2AD82929D63130DE272ACC000000A2A6DE3335D7
        3A3AE13232D83637DB3B3CDD393ADB2122CD3536D83B3CDD3535DA3131D83332
        DD3738DCA8ABE2000000FFFFFFA5A9DD3538D94343E43F40DC4343DE4646DF4A
        4AE14646DF4242DD3E3FDC3D3DE0393BDEABAEE4FFFFFF000000FCFCFFFFFFFF
        A2A6DD4345DC4C4CE34C4CE04E4EE14E4EE14D4DE04B4BE04949E14345DDA7AA
        E2FFFFFFFCFCFE000000FEFEFEFAFAFEFFFFFF777CD14444DE5758E45657E357
        58E45656E35656E34242DE757AD0FFFFFFFAF9FEFEFEFE000000FCFBFEFFFFFF
        A6A9DE2D2EC55556E25E5FE66060E66161E65F5FE65B5CE45859E62D2FC69DA1
        D8FFFFFFFAFAFD000000FFFFFFA4A8DD1517B94A4ADC6364E76565E76A6AE86E
        6DE96868E86363E75F5FE65252E31316B89EA2D8FFFFFF000000999DD91416B8
        4848DB6465E96565E76F6FE97373ED6565E97171ED6C6CE86262E65E5FE65150
        E31416B79CA0D7000000272BC44949DF5D5EE66161E66D6EE87170EF5A5CE280
        85D35A5CE26D6DEE6A69E75D5DE55859E34D4CE32024BF0000007E82D64445E2
        5E5EE86565E56C6BEF4B4EE0A9ADDFFFFFFFA9ADDF4A4CDF6767EE6061E35A5A
        E74142E2757AD4000000FFFFFD8085D64546E26665EF4A4CDFAAADDFFFFFFFFB
        FBFFFFFFFFADB1E14D4FE16161ED4648E48387D9FFFFFC000000FFFFFFFFFFFC
        797ED43E42D2A0A4DCFFFFFFFDFCFFFEFEFEFCFCFFFFFFFFADB0E13E42D27A7F
        D6FFFFFDFFFFFF000000}
    end
    object moduleedit: TEdit
      Left = 112
      Top = 24
      Width = 113
      Height = 21
      TabOrder = 2
      OnChange = moduleeditChange
    end
    object lengthedit: TEdit
      Left = 240
      Top = 48
      Width = 97
      Height = 21
      TabOrder = 4
      Text = '5'
      Visible = False
      OnChange = lengtheditChange
    end
  end
  object ListUpdater: TTimer
    Enabled = False
    Interval = 25
    OnTimer = ListUpdaterTimer
    Left = 344
    Top = 65528
  end
end

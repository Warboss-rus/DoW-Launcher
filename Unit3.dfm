object Form4: TForm4
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' GiFR'
  ClientHeight = 364
  ClientWidth = 395
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 120
  TextHeight = 16
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 393
    Height = 73
    Caption = #1051#1086#1082#1072#1083#1080#1079#1072#1094#1080#1103
    TabOrder = 0
    object Label1: TLabel
      Left = 5
      Top = 16
      Width = 86
      Height = 16
      Caption = #1051#1086#1082#1072#1083#1080#1079#1072#1094#1080#1103': '
    end
    object ComboBox1: TComboBox
      Left = 3
      Top = 38
      Width = 286
      Height = 24
      TabOrder = 0
      Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1103#1079#1099#1082
    end
    object BInstallLocale: TButton
      Left = 295
      Top = 38
      Width = 90
      Height = 25
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = BInstallLocaleClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 79
    Width = 393
    Height = 58
    Caption = #1058#1072#1089#1082#1073#1072#1088
    TabOrder = 1
    object ComboBox2: TComboBox
      Left = 3
      Top = 24
      Width = 286
      Height = 24
      TabOrder = 0
      Text = #1042#1099#1073#1077#1088#1080#1090#1077' '#1090#1072#1089#1082#1073#1072#1088
    end
    object BInstallTaskbar: TButton
      Left = 295
      Top = 24
      Width = 90
      Height = 25
      Caption = #1059#1089#1090#1072#1085#1086#1074#1080#1090#1100
      TabOrder = 1
      OnClick = BInstallTaskbarClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 143
    Width = 393
    Height = 185
    Caption = #1055#1086#1076#1082#1083#1102#1095#1072#1077#1084#1099#1077' '#1084#1086#1076#1099' (coming soon)'
    TabOrder = 2
    object ScrollBar1: TScrollBar
      Left = 369
      Top = 17
      Width = 21
      Height = 129
      Enabled = False
      Kind = sbVertical
      PageSize = 0
      TabOrder = 0
      OnChange = ScrollBar1Change
    end
    object BEnableAll: TButton
      Left = 3
      Top = 151
      Width = 120
      Height = 25
      Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100' '#1074#1089#1077
      Enabled = False
      TabOrder = 1
    end
    object BDisableAll: TButton
      Left = 129
      Top = 151
      Width = 120
      Height = 25
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100' '#1074#1089#1077
      Enabled = False
      TabOrder = 2
    end
    object BDownload: TButton
      Left = 256
      Top = 152
      Width = 134
      Height = 25
      Caption = #1057#1082#1072#1095#1072#1090#1100' '#1084#1086#1076#1099
      Enabled = False
      TabOrder = 3
      OnClick = BDownloadClick
    end
    object StringGrid1: TStringGrid
      Left = 3
      Top = 17
      Width = 366
      Height = 129
      Enabled = False
      FixedCols = 0
      RowCount = 2
      TabOrder = 4
      ColWidths = (
        91
        70
        70
        62
        64)
    end
  end
  object BClose: TButton
    Left = 280
    Top = 334
    Width = 110
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 3
    OnClick = BCloseClick
  end
end

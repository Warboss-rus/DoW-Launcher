object Form6: TForm6
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  ClientHeight = 199
  ClientWidth = 216
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label3: TLabel
    Left = 4
    Top = 80
    Width = 61
    Height = 17
    AutoSize = False
    Caption = #1071#1079#1099#1082
    Transparent = False
  end
  object Label1: TLabel
    Left = 8
    Top = 131
    Width = 34
    Height = 16
    Caption = #1095#1077#1088#1077#1079
  end
  object Label2: TLabel
    Left = 122
    Top = 131
    Width = 39
    Height = 16
    Caption = #1089#1077#1082#1091#1085#1076
  end
  object CBLanguage: TComboBox
    Left = 71
    Top = 78
    Width = 137
    Height = 24
    ItemIndex = 0
    TabOrder = 3
    Text = 'Russian'
    OnChange = CBLanguageChange
    Items.Strings = (
      'Russian'
      'English')
  end
  object CBUnlocker: TCheckBox
    Left = 2
    Top = 55
    Width = 206
    Height = 17
    Caption = #1057#1082#1088#1099#1074#1072#1090#1100' unlocker'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = CBUnlockerClick
  end
  object CBClose: TCheckBox
    Left = 2
    Top = 32
    Width = 210
    Height = 17
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086' '#1087#1086#1089#1083#1077' '#1079#1072#1087#1091#1089#1082#1072
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object CBplayableonly: TCheckBox
    Left = 2
    Top = 8
    Width = 203
    Height = 17
    Hint = 
      #1057#1082#1088#1099#1074#1072#1077#1090' '#1084#1086#1076#1099', '#1082#1086#1090#1086#1088#1099#1077' '#1085#1077#1074#1086#1079#1084#1086#1078#1085#1086' '#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1090#1100' '#1080#1079' '#1084#1077#1085#1102' '#1076#1086#1087#1086#1083#1085#1077#1085#1080 +
      #1081
    Margins.Left = 4
    Margins.Top = 4
    Margins.Right = 4
    Margins.Bottom = 4
    Caption = #1057#1082#1088#1099#1074#1072#1090#1100' '#1085#1077#1080#1075#1088#1072#1073#1077#1083#1100#1085#1099#1077
    TabOrder = 0
  end
  object CBDeleteCombiner: TCheckBox
    Left = 2
    Top = 108
    Width = 191
    Height = 17
    Caption = #1059#1076#1072#1083#1103#1090#1100' '#1082#1086#1084#1073#1072#1081#1085#1077#1088
    TabOrder = 4
  end
  object Edit1: TEdit
    Left = 55
    Top = 131
    Width = 41
    Height = 24
    TabOrder = 5
    Text = '5'
    OnExit = Edit1Exit
    OnKeyPress = Edit1KeyPress
  end
  object BCloseSettings: TButton
    Left = 2
    Top = 161
    Width = 206
    Height = 32
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 6
    OnClick = BCloseSettingsClick
  end
end

object Form5: TForm5
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' Local.ini'
  ClientHeight = 86
  ClientWidth = 228
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 1
    Top = 7
    Width = 76
    Height = 17
    AutoSize = False
    Caption = #1056#1072#1079#1088#1077#1096#1077#1085#1080#1077
    Transparent = False
  end
  object Label2: TLabel
    Left = 142
    Top = 7
    Width = 6
    Height = 16
    Caption = 'x'
  end
  object EWidth: TEdit
    Left = 83
    Top = 5
    Width = 49
    Height = 24
    TabOrder = 0
    Text = '0'
  end
  object EHeight: TEdit
    Left = 158
    Top = 5
    Width = 49
    Height = 24
    TabOrder = 1
    Text = '0'
  end
  object CBAntialias: TCheckBox
    Left = 100
    Top = 35
    Width = 114
    Height = 17
    Caption = #1057#1075#1083#1072#1078#1080#1074#1072#1085#1080#1077
    TabOrder = 3
  end
  object CBFullScreen: TCheckBox
    Left = 2
    Top = 35
    Width = 92
    Height = 17
    Caption = #1042' '#1086#1082#1085#1077
    TabOrder = 2
  end
  object CBTeam: TCheckBox
    Left = -3
    Top = 58
    Width = 132
    Height = 17
    Caption = 'fullres_teamcolour'
    TabOrder = 4
  end
  object BSaveLocal: TButton
    Left = 135
    Top = 55
    Width = 86
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 5
    OnClick = BSaveLocalClick
  end
end

object Holsted: THolsted
  Left = 0
  Top = 0
  Caption = #1061#1086#1083#1089#1090#1077#1076' '#1057
  ClientHeight = 525
  ClientWidth = 806
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Code: TMemo
    Left = 8
    Top = 64
    Width = 337
    Height = 393
    Lines.Strings = (
      'Code')
    TabOrder = 0
  end
  object ResultAnalys: TMemo
    Left = 394
    Top = 64
    Width = 383
    Height = 249
    Lines.Strings = (
      'ResultAnalys')
    TabOrder = 1
  end
  object LoadFromFile: TButton
    Left = 8
    Top = 8
    Width = 145
    Height = 25
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1080#1079' '#1092#1072#1081#1083#1072
    TabOrder = 2
    OnClick = LoadFromFileClick
  end
  object DeleteComments: TButton
    Left = 328
    Top = 8
    Width = 145
    Height = 25
    Caption = #1059#1076#1072#1083#1077#1085#1080#1077' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1077#1074
    TabOrder = 3
    OnClick = DeleteCommentsClick
  end
  object Analys: TButton
    Left = 568
    Top = 8
    Width = 155
    Height = 25
    Caption = #1040#1085#1072#1083#1080#1079
    TabOrder = 4
    OnClick = AnalysClick
  end
  object Operators: TMemo
    Left = 351
    Top = 352
    Width = 219
    Height = 129
    Lines.Strings = (
      'Operators')
    TabOrder = 5
  end
  object Operands: TMemo
    Left = 576
    Top = 352
    Width = 219
    Height = 129
    Lines.Strings = (
      'Operands')
    TabOrder = 6
  end
  object OperandsList: TStringGrid
    Left = 576
    Top = 352
    Width = 219
    Height = 129
    BorderStyle = bsNone
    ColCount = 2
    DefaultColWidth = 120
    DragMode = dmAutomatic
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 7
    RowHeights = (
      24)
  end
  object OperatorsList: TStringGrid
    Left = 351
    Top = 352
    Width = 219
    Height = 129
    BorderStyle = bsNone
    ColCount = 2
    DefaultColWidth = 120
    DragMode = dmAutomatic
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Century Gothic'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 8
    RowHeights = (
      24)
  end
  object LoadFile: TOpenDialog
    Left = 208
    Top = 8
  end
end

unit HolstedC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,RegExpr, Vcl.Grids,math;

type
  THolsted = class(TForm)
    Code: TMemo;
    ResultAnalys: TMemo;
    LoadFromFile: TButton;
    DeleteComments: TButton;
    Analys: TButton;
    LoadFile: TOpenDialog;
    Operators: TMemo;
    Operands: TMemo;
    OperandsList: TStringGrid;
    OperatorsList: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure LoadFromFileClick(Sender: TObject);
    procedure DeleteCommentsClick(Sender: TObject);
    procedure AnalysClick(Sender: TObject);
  private
    procedure RegexOperandsAndOperators;
    procedure ComputeParameters;
    Procedure Recording ( Grid : TstringGrid ; Memo :TMemo);
    procedure findRegex(findLine:string; var Grid:TStringGrid; n:Byte);
  public
    { Public declarations }
  end;

var
  Holsted: THolsted;


implementation

{$R *.dfm}



procedure THolsted.AnalysClick(Sender: TObject);
begin
    RegexOperandsAndOperators;
    ComputeParameters;
    Recording ( OperandsList , Operands );
    Recording ( OperatorsList , Operators);
    Analys.Enabled := false;
end;



procedure THolsted.ComputeParameters;
var
   i : Byte;
   uniqueOperators,uniqueOperands:Integer;
   countOperators, countOperands:Integer;
   DictionaryProgram : Double;
   LengthProgram : Double;
   VolumeProgram : Double;
   PotencionalVolumeProgtram : Double;
   TheoreticalLengthProgtram : Double;
   LVLProgram : Double;
   LVL2Program : Double;
   InformationContentProgram : Double;
   NumberOfSolutions : Double;
   RealLengthProgram : Double;
begin
   if (OperatorsList.RowCount > 1) and (OperandsList.RowCount > 1) then
   begin
      OperatorsList.FixedRows := 1;
      if (OperandsList.RowCount > 1)  then
      begin
         OperandsList.FixedRows := 1;
         uniqueOperators := OperatorsList.RowCount - 1;
         uniqueOperands := OperandsList.RowCount - 1;
         countOperators := 0;
         for i := 1 to uniqueOperators do
            countOperators := countOperators + StrToInt(OperatorsList.cells[1,i]);
         countOperands := 0;
         for i := 1 to uniqueOperands do
            countOperands := countOperands + StrToInt(OperandsList.cells[1,i]);
         end;
      end;
      DictionaryProgram :=  uniqueOperators +  uniqueOperands;
      LengthProgram :=  countOperands + countOperators ;
      VolumeProgram :=  LengthProgram * Log2(DictionaryProgram);
      PotencionalVolumeProgtram :=  DictionaryProgram * Log2(DictionaryProgram);
      TheoreticalLengthProgtram := (uniqueOperators * Log2(uniqueOperators))+ (uniqueOperands * Log2(uniqueOperands));
      LVLProgram := PotencionalVolumeProgtram / VolumeProgram ;
      LVL2Program := (2 * uniqueOperands)/(uniqueOperators * countOperands);
      InformationContentProgram := LVL2Program * VolumeProgram;
      NumberOfSolutions := TheoreticalLengthProgtram * log2(DictionaryProgram / LVLProgram);
      RealLengthProgram  := VolumeProgram * VolumeProgram / PotencionalVolumeProgtram;
      with ResultAnalys do
        begin
          ResultAnalys.Lines.Add('����� ���������� ���������� ��������� =  ' + IntToStr(uniqueOperators)+#13 + #10);
          ResultAnalys.Lines.Add('����� ���������� ��������� ��������� =  ' + IntToStr(uniqueOperands)+#13 + #10);
          ResultAnalys.Lines.Add('O���� ����� ���������� � ��������� =  ' + IntToStr(countOperators)+#13 + #10);
          ResultAnalys.Lines.Add('O���� ����� ��������� � ��������� =  ' + IntToStr(countOperands) +#13 + #10);
          ResultAnalys.Lines.Add('������� ��������� =  ' + FloatToStr(DictionaryProgram)+#13 + #10);
          ResultAnalys.Lines.Add('����� ��������� =  ' + FloatToStr(LengthProgram)+#13 + #10);
          ResultAnalys.Lines.Add('����� ��������� =  ' + FloatToStr(VolumeProgram)+#13 + #10);
          ResultAnalys.Lines.Add('������������� ����� ��������� =  ' + FloatToStr(PotencionalVolumeProgtram)+#13 + #10);
          ResultAnalys.Lines.Add('������������� ����� ��������� =  ' + FloatToStr(TheoreticalLengthProgtram)+#13 + #10);
          ResultAnalys.Lines.Add('������� ��������� =  ' + FloatToStr(LVLProgram)+#13 + #10);
          ResultAnalys.Lines.Add('������� ���������[2] =  ' + FloatToStr(LVL2Program)+#13 + #10);
          ResultAnalys.Lines.Add('�������������� ���������� ��������� =  ' + FloatToStr(InformationContentProgram)+#13 + #10);
          ResultAnalys.Lines.Add('����� ��������� ���������������� ������� =  ' + FloatToStr(NumberOfSolutions)+#13 + #10);
          ResultAnalys.Lines.Add('�������� ����� ��������� =  ' + FloatToStr(RealLengthProgram)+#13 + #10);
        end;
end;


procedure THolsted.findRegex(findLine : string; var Grid:TStringGrid; n:Byte);
var
   RegExp : TRegExpr;
   count , i: Integer;
   line : string;
   flag :Boolean;
begin
   RegExp := TRegExpr.Create;
   RegExp.InputString := Code.Text;
   RegExp.Expression := findLine;
   line := ' ';
   if RegExp.Exec(code.Text) then
      repeat
         line := RegExp.Match[n];
         i := 1;
         flag := false;
         while (i <= Grid.rowCount - 1) and (not flag) do
         begin
            if (Grid.Cells[0,i] = line) then
            begin
               count := strtoint(Grid.Cells[1,i]) + 1;
               Grid.Cells[1,i] := IntToStr(count);
               flag := True;
            end
            else
               inc(i);
         end;
         if (not flag) then
            with Grid do
            begin
               RowCount := RowCount + 1;
               Cells[0,RowCount-1] := line;
               Cells[1,RowCount-1] := '1';
            end
         else
      until not RegExp.ExecNext;
   RegExp.Free;
end;


procedure THolsted.RegexOperandsAndOperators;
begin
   findRegex('\b(break|case|continue|default|do|else|enum|for|goto|if)\b',operatorsList,1);
   findRegex('\b(return|sizeof|struct|switch|union|while)\b',operatorsList,1);
   findRegex('\b(true|false|const|volatile)\b',operatorsList,1);
   findRegex('(\.|\,|;)',operatorsList,1);
   findRegex('\b(register|static|typedef|virtual)\b',operatorsList,1);
   findRegex('\b(boolean|char|double|float|string|int|byte|long|short|void)\b',operandsList,1);
   findRegex('\b(unsigned boolean|unsigned char|unsigned double|unsigned float|unsigned string|unsigned int|unsigned byte|unsigned long|unsigned short|unsigned void)\b',operandsList,1);
   findRegex('\b(boolean |int |void |string |byte |char |float |double |long |short )[a-zA-Z_].*?\b',operandsList,0);
   findRegex('(\+=|-=|\*=|\/=|%=|\|=|\^=|->|\+{1,2}|-{1,2}|={1,2}|%|<{1,3})',operatorsList,1);
   findRegex('(%=|>=|<{1,3}=|>{1,3}=|\*|>{1,3}|&{1,2}|\|{1,2})',operatorsList,1);
   findRegex('(''[a-zA-Z0-9_].*?'')',operatorsList,1);
   findRegex('(\d+)',operatorsList,1);
   findRegex('[\?]',operandsList,0);
end;

procedure THolsted.DeleteCommentsClick(Sender: TObject);
var
   FindStringWithDoubleSlash : TRegExpr;
   FindMultilineComment : TRegExpr;
begin
   FindStringWithDoubleSlash := TRegExpr.Create;
   FindStringWithDoubleSlash.Expression :=  '(\/\*(.*?)\*\/)|(//(.*?)\n)';
      repeat
      until not FindStringWithDoubleSlash.ExecNext;
   Code.Text:=FindStringWithDoubleSlash.Replace(code.Text, '', true);
   FindMultilineComment := TRegExpr.Create;
   FindMultilineComment.Expression :=  '"""\s*(.*?)\s*\"""';
      repeat
      until not FindMultilineComment.ExecNext;
   Code.Text := FindMultilineComment.Replace(code.Text, '', true);
end;

Procedure THolsted.Recording ( Grid : TstringGrid ; Memo :TMemo);
var
  i : byte;
  temp : string;
begin
   for I := 1 to Grid.rowCount - 1 do
     begin
       temp := Grid.Cells[0,i];
       Memo.Lines.add(temp);
     end;

end;

procedure THolsted.FormCreate(Sender: TObject);
begin
    Code.Clear;
    ResultAnalys.Clear;
    OperandsList.Visible := False;
    OperatorsList.Visible := False;
end;

procedure THolsted.LoadFromFileClick(Sender: TObject);
begin
   LoadFile.Filter := 'TxtFiles|*.txt';
   if (LoadFile.Execute) then
      begin
         Code.Lines.LoadFromFile(LoadFile.FileName);
      end;
end;

end.

{
FFT Algo For Delphi ;)
By M.Aek Progs (Angedevil AD)
}

unit Unit3;

interface

uses
  Winapi.Windows,System.VarCmplx,System.Character,System.Math, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}













function invv(n: integer; llen: Integer): integer;
var
  count, revn: integer;
begin

revn:=n;
count:=llen-1;
n := n shr 1;
while n > 0 do
begin
revn := (revn shl 1) or (n and 1);
dec(count);
n := n shr 1;
end;
Result := ((revn shl count) and ((1 shl llen) - 1));

end;















procedure FFT(var comparr:array of variant;len:longint);
var
val,j, llen: Integer;
c,tmp,ev,od,exp: variant;
N,NN,i,evenidx,oddidx:longint;
term: double;
itmp:integer;
count :integer;
varr:integer;
begin
llen := round(Log2(len+1));

form3.memo1.Lines.Add('Log2:');
form3.memo1.Lines.Add(inttostr(llen));

//swap bits
for j := 1 to len do
begin

val := invv(j,llen);

if val>j then begin
tmp:= comparr[j];
comparr[j]:= comparr[val];
comparr[val]:= tmp;
end;

end;

//after swap
form3.memo1.lines.add('After Swap:');
form3.memo1.lines.add('');
for j := 0 to len do begin
c:=comparr[j];
form3.memo1.Text:=form3.memo1.Text +'('+floattostr(c.real)+','+floattostr(c.imaginary)+')'  + '  ';
end;


//FFT
N:= len+1;
NN:=2;
while(NN<=N) do begin
i:=0;
while (i<N) do begin
for j := 0 to NN div 2 -1 do begin
evenidx:= i+j;
oddidx:= i+j+(NN div 2);
ev:= comparr[evenidx];
od:= comparr[oddidx];
term:= -2*PI*j/NN;
exp:= varcomplexcreate(cos(term),sin(term))*od;

comparr[evenidx]:=ev +exp;
comparr[oddidx]:=ev-exp;


end;

i:= i+NN;
end;

NN:= NN shl 1;
end;




end;








function isnum(s:string):boolean;
var
i:integer;
begin
result := true;
for I := 1 to strlen(pchar(s)) do
if not (isnumber(s,i)) then begin
result := false;
break;
end;


end;





procedure TForm3.Button1Click(Sender: TObject);
var
arr: array of double;
len: longint;
i,stp,idx:longint;
str: string;
cmp: array of variant;
c:variant;
strnum:string;
begin

if ((strlen(pchar(edit1.Text))<=0) and (edit1.Text='')) then
exit;

len := strlen(pchar(edit1.Text));
setlength(arr,len);
setlength(cmp,len);
str := edit1.Text;

//get arr
stp := 0;
for I := 0 to len do begin

if(str[i+1] = ' ') then begin
if ((strnum)<>'') and (isnum(strnum))then
arr[stp] := strtoint(strnum);

strnum:='';
inc(stp);
continue;
end;

strnum := strnum + str[i+1];
end;

idx := str.LastDelimiter(' ');
for I := idx to len do
strnum:=strnum+str[i];

arr[stp] := strtofloat(strnum);


len := stp;


//
//show arr
memo1.Lines.Add('input:');
for I := 0 to len do begin
memo1.Text:=memo1.Text + floattostr(arr[i])+ '  ';
end;
memo1.Lines.Add('');






for I := 0 to len do begin
cmp[i] := varcomplexcreate(arr[i]);//
end;



//show complexe
memo1.Lines.Add('Complex num:');
for I := 0 to len do begin
c:=cmp[i];
memo1.Text:=memo1.Text +'('+floattostr(c.real)+','+floattostr(c.imaginary)+')'  + '  ';
end;


fft(cmp,len);


memo1.Lines.Add('');
//show complexe
memo1.Lines.Add('result:');
for I := 0 to len do begin
c:=cmp[i];
strnum :=   '('+floattostr(c.real)+','+floattostr(c.imaginary)+')';
form3.Memo1.Lines.Add(strnum);
end;




finalize(arr);
finalize(cmp);
end;

end.

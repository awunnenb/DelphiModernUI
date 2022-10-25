program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {RoundedForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TRoundedForm, RoundedForm);
  Application.Run;
end.

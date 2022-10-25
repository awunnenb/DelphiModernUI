unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.Buttons, Vcl.StdCtrls, Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.Imaging.jpeg, dxGDIPlusClasses
  ;

type
  TRoundedForm = class(TForm)
    pnlNav: TPanel;
    pnlMain: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label3: TLabel;
    Shape1: TShape;
    Edit1: TEdit;
    Panel3: TPanel;
    Panel4: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Image2: TImage;
    Label6: TLabel;
    Label7: TLabel;
    Image3: TImage;
    Panel5: TPanel;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label8: TLabel;
    Panel6: TPanel;
    Image4: TImage;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Panel7: TPanel;
    Image5: TImage;
    Panel8: TPanel;
    Image6: TImage;
    Image7: TImage;
    Image8: TImage;
    Image9: TImage;
    Image11: TImage;
    ProgressBar1: TProgressBar;

    procedure FormCreate(Sender: TObject);
    procedure WMMouseMove(var Msg : TWMMouseMove); message WM_MOUSEMOVE;
    procedure WMNCMouseLeave(var Msg : TMessage); message WM_NCMOUSELEAVE;
    procedure WMNCButtonDown(var Msg : TWMNCLButtonDown); message WM_NCLBUTTONDOWN;
    procedure WMNCButtonUp(var Msg : TWMNCLButtonUp); message WM_NCLBUTTONUP;
    procedure WMSYSCommand(var Msg : TWMSysCommand); message WM_SYSCOMMAND;

    procedure pnlMainMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure pnlMainMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SpeedButton6Click(Sender: TObject);
  private
    { Private-Deklarationen }
     FRgnHandle       : HRGN;
      FRgnTop          : Integer;
      FRgnBottom       : Integer;
      FRgnRight        : Integer;
      FRgnLeft         : Integer;
      FRgnCorner       : Integer;
      FMouseLeaveCount : Integer;
      FNCLButtonDown   : Boolean;
      FMousePoint: TPoint;
      FFormPoint: TPoint;
      procedure DeleteRegion;
      procedure CreateRegion;
      procedure SetMouseEvents;

  public
    { Public-Deklarationen }
  end;

var
  RoundedForm: TRoundedForm;

implementation

{$R *.dfm}


procedure TRoundedForm.CreateRegion;
begin
  BorderStyle := bsNone;
  if FRgnHandle <> 0 then DeleteObject(FRgnHandle);
  with RoundedForm.BoundsRect do
  begin
    FRgnHandle := CreateRoundRectRgn(0, 0, Right - Left + 1, Bottom - Top + 1,
                  FRgnCorner, FRgnCorner);
  end;

  if SetWindowRGN(Handle, FRgnHandle, True)=0 then DeleteObject(FRgnHandle);
end;

procedure TRoundedForm.DeleteRegion;
begin
  if FRgnHandle <> 0 then
  begin
    BorderStyle := bsToolWindow;
    SetWindowRGN(Handle, 0, True);
    DeleteObject(FRgnHandle);
    FRgnHandle := 0;
  end;
end;

procedure TRoundedForm.FormCreate(Sender: TObject);
begin
  SetMouseEvents;
  FRgnTop    := GetSystemMetrics(SM_CYCAPTION) +
                GetSystemMetrics(SM_CYFRAME) +
                GetSystemMetrics(SM_CYFRAME);
  FRgnBottom := GetSystemMetrics(SM_CYFRAME) +
                GetSystemMetrics(SM_CYFRAME);
  FRgnRight  := GetSystemMetrics(SM_CXFRAME) +
                GetSystemMetrics(SM_CXFRAME);
  FRgnLeft   := GetSystemMetrics(SM_CXFRAME) +
                GetSystemMetrics(SM_CXFRAME);
  FRgnCorner := 15;
  CreateRegion;
end;

procedure TRoundedForm.pnlMainMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (GetKeyState(VK_LBUTTON) < 0) then
  begin
    FMousePoint := Mouse.CursorPos;
    FFormPoint  := System.Classes.Point(Left, Top);
  end;
end;

procedure TRoundedForm.pnlMainMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if (GetKeyState(VK_LBUTTON) < 0) then
  begin
    RoundedForm.left := Mouse.CursorPos.X - (FMousePoint.X - FFormPoint.X);
    RoundedForm.top := Mouse.CursorPos.Y - (FMousePoint.Y - FFormPoint.Y);
  end;
end;

procedure TRoundedForm.SetMouseEvents;
var i: integer;
begin
  for i:=0 to self.ComponentCount-1 do
  begin
    if (self.Components[i] is TPanel) then
    begin
      TPanel(self.Components[i]).OnMouseDown:= pnlMainMouseDown;
      TPanel(self.Components[i]).OnMouseMove:= pnlMainMouseMove;
    end;
    if (self.Components[i] is TLabel) then
    begin
      TLabel(self.Components[i]).OnMouseDown:= pnlMainMouseDown;
      TLabel(self.Components[i]).OnMouseMove:= pnlMainMouseMove;
    end;
    if (self.Components[i] is TImage) then
    begin
      TImage(self.Components[i]).OnMouseDown:= pnlMainMouseDown;
      TImage(self.Components[i]).OnMouseMove:= pnlMainMouseMove;
    end;
  end;
end;

procedure TRoundedForm.SpeedButton6Click(Sender: TObject);
begin
  close;
end;

procedure TRoundedForm.WMMouseMove(var Msg: TWMMouseMove);
begin
    if (Msg.YPos < GetSystemMetrics(SM_CYSIZEFRAME)) or
       (Msg.YPos > (Height - 55)) or
       (Msg.XPos < 10) or
       (Msg.XPos > (Width - 25)) then
    begin
      DeleteRegion;
    end else if (Msg.YPos >= 10) then
    begin
      CreateRegion;
    end;
    inherited;
end;

procedure TRoundedForm.WMNCButtonDown(var Msg: TWMNCLButtonDown);
begin
    FNCLButtonDown := TRUE;
    inherited;
end;

procedure TRoundedForm.WMNCButtonUp(var Msg: TWMNCLButtonUp);
begin
    FNCLButtonDown := FALSE;
    inherited;
end;

procedure TRoundedForm.WMNCMouseLeave(var Msg: TMessage);
begin
    Inc(FMouseLeaveCount);
    if (FRgnHandle = 0) and (not FNCLButtonDown) then
        CreateRegion;
    inherited;
end;

procedure TRoundedForm.WMSYSCommand(var Msg: TWMSysCommand);
begin
    if Msg.CmdType = SC_RESTORE then
        CreateRegion;
    inherited;
end;

end.

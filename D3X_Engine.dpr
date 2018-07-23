program D3X_Engine;

uses
  Forms,
  Unit_main in 'Unit_main.pas' {main},
  Res in 'Res.pas' {result},
  modder in 'modder.pas' {memmod},
  inj in 'inj.pas' {injector},
  watcher in 'watcher.pas' {memview},
  blockview in 'blockview.pas' {memblock};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'D3X Engine';
  Application.CreateForm(Tmain, main);
  Application.CreateForm(Tresult, result);
  Application.CreateForm(Tmemmod, memmod);
  Application.CreateForm(Tinjector, injector);
  Application.CreateForm(Tmemview, memview);
  Application.CreateForm(Tmemblock, memblock);
  Application.Run;
end.

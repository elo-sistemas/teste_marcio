unit cep.testes;

interface

uses
  DUnitX.TestFramework,
  cep.model.factory, FireDAC.Comp.Client;

type
  [TestFixture]
  cep = class

  private
    FCep: TModelFactory;
  public
    [Setup]
    procedure Setup;

    [TearDown]
    procedure TearDown;

    [Test]
    procedure prc_tratarApiCep;

    [Test]
    procedure prc_tratarViaCep;

    [Test]
    procedure prc_tratarApiAwesomeApi;

  end;

implementation

uses
  System.SysUtils;

procedure cep.prc_tratarApiAwesomeApi;
var
  LMemTableApiAwesomeApi: TFDMemTable;
  LResultado: string;
  LRetorno: String;

begin
   {$REGION 'ApiAwesomeApi'}
   LMemTableApiAwesomeApi := TFDMemTable.Create(nil);
   LRetorno  :=  'CEP:       31920160End:       Rua Tr�s BicasBairro:    Dom JoaquimUF:        MGCidade:    Belo HorizonteLatitude:  -19.87972Longitude: '+
                 '-43.91421IBGE:      ';

   LResultado := TModelFactory
                   .New
                   .ApiAwesomeApi
                   .fnc_AwesomeApi('31920160', LMemTableApiAwesomeApi);
   LResultado := StringReplace(LResultado, ''#$D#$A'', '', [rfReplaceAll]);
   Assert.IsTrue(LResultado = LRetorno, 'TModelFactory.ApiAwesomeApi retornou um erro');
   {$endregion}

end;

procedure cep.prc_tratarApiCep;
var
  LMemTableApiCep: TFDMemTable;
  LResultado: string;
  LRetorno: String;

begin
   {$REGION 'ApiCep'}
   LMemTableApiCep := TFDMemTable.Create(nil);
   LRetorno  :=  'Cep     : 31920-160Estado  : MGCidade  : Belo HorizonteBairro  : Dom JoaquimEnd     : Rua Tr�s Bicas';


   LResultado := TModelFactory
                   .New
                   .ApiCep
                   .fnc_ApiCep('31920160', LMemTableApiCep);
   LResultado := StringReplace(LResultado, ''#$D#$A'', '', [rfReplaceAll]);
   Assert.IsTrue(LResultado = LRetorno, 'TModelFactory.ApiCep retornou um erro');
   {$endregion}

end;

procedure cep.prc_tratarViaCep;
var
  LMemTableApiViaCep: TFDMemTable;
  LResultado: string;
  LRetorno: String;

begin
   {$REGION 'ViaCep'}
   LMemTableApiViaCep := TFDMemTable.Create(nil);
   LRetorno  :=  'CEP:       31920-160End:       Rua Tr�s BicasCompl:     Bairro:    Dom JoaquimCidade:    Belo HorizonteUF:        MGCod. IBGE: 3106200';


   LResultado := TModelFactory
                   .New
                   .ViaCep
                   .fnc_ViaCep('31920160', LMemTableApiViaCep);
   LResultado := StringReplace(LResultado, ''#$D#$A'', '', [rfReplaceAll]);
   Assert.IsTrue(LResultado = LRetorno, 'TModelFactory.ViaCep retornou um erro');
   {$endregion}

end;

procedure cep.Setup;
begin
   FCep := TModelFactory.create;
end;

procedure cep.TearDown;
begin
   FCep.Free;
end;

initialization
  TDUnitX.RegisterTestFixture(cep);

end.

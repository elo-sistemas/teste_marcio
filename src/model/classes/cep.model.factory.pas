{
   Autor: M�rcio Camilo
   Data: 06/09/2024
   Motivo: Classe respons�vel por retornar m�todos de outras classes sem designar sua origem
           e retornar para view
 }
unit cep.model.factory;

interface

uses
   cep.model.interfaces;

type
  TModelFactory = class(TInterfacedObject, iFactory)
  private

  public
     constructor create;
     destructor destroy; override;
     class function New: iFactory;

     function ViaCep: iViaCep;
     function ApiCep: iApiCep;
     function ApiAwesomeApi: iAwesomeApi;
  end;

implementation

uses
   cep.model.viacep,
   cep.model.apicep,
   cep.model.awesomeApi;

{ TModelFactory }

function TModelFactory.ApiAwesomeApi: iAwesomeApi;
begin
   Result := TModelawesomeApi.New;
end;

function TModelFactory.ApiCep: iApiCep;
begin
   Result := TModelApiCep.New;
end;

constructor TModelFactory.create;
begin

end;

destructor TModelFactory.destroy;
begin

  inherited;
end;

class function TModelFactory.New: iFactory;
begin
   Result := Self.Create;

end;

function TModelFactory.ViaCep: iViaCep;
begin
   Result := TModelViaCep.New;
end;

end.

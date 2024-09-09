{
   Autor: M�rcio Camilo
   Data: 06/09/2024
   Motivo: Retornar um cep via viacep
 }

unit cep.model.viacep;

interface

uses
  cep.model.interfaces,
  FireDAC.Comp.Client,
  System.SysUtils;

type
  TModelViaCep = class(TInterfacedObject, iViaCep)
  private

  public
     constructor create;
     destructor destroy; override;
     class function New: iViaCep;
     function fnc_ViaCep(Value: String; aDataSet: TFDMemTable): String;

  end;

implementation

uses
   RESTRequest4D,
   DataSet.Serialize.Adapter.RESTRequest4D;

{ TModelPessoa }

constructor TModelViaCep.create;
begin

end;

destructor TModelViaCep.destroy;
begin

  inherited;
end;

class function TModelViaCep.New: iViaCep;
begin
   Result := Self.Create;
end;

function TModelViaCep.fnc_ViaCep(Value: String; aDataSet: TFDMemTable): String;
var
   Resp : IResponse;
begin
   if Value.Length <> 8 then
   begin
      Result := 'CEP inv�lido';
      exit;
   end;

   Resp := TRequest.New.BaseURL('viacep.com.br/ws')
              .Resource(Value + '/json')
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(aDataSet))
              .Get;

   if ( (Resp.StatusCode = 503) or (Resp.StatusCode = 403)) then //site fora do ar Service Unavailable ou n�o autorizado
   begin
      Result := 'viacep';
      Exit
   end

   else
   begin
      if Resp.StatusCode = 200 then
      begin
         if Resp.Content.IndexOf('erro') > 0 then
            Result := 'CEP n�o encontrado'
         else
         begin
            Result := 'CEP:       ' + aDataSet.FieldByName('cep').AsString + sLineBreak         +
                      'End:       ' + aDataSet.FieldByName('logradouro').AsString + sLineBreak  +
                      'Compl:     ' + aDataSet.FieldByName('complemento').AsString + sLineBreak +
                      'Bairro:    ' + aDataSet.FieldByName('bairro').AsString + sLineBreak      +
                      'Cidade:    ' + aDataSet.FieldByName('localidade').AsString + sLineBreak  +
                      'UF:        ' + aDataSet.FieldByName('uf').AsString + sLineBreak          +
                      'Cod. IBGE: ' + aDataSet.FieldByName('ibge').AsString;
         end;

      end;

   end;

end;

end.

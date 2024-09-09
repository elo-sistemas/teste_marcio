{
   Autor: M�rcio Camilo
   Data: 06/09/2024
   Motivo: Retornar um cep via awesomeapi
 }

unit cep.model.awesomeApi;

interface

uses
  cep.model.interfaces,
  FireDAC.Comp.Client,
  System.SysUtils;

type
  TModelawesomeApi  = class(TInterfacedObject, iAwesomeApi)
  private

  public
     constructor create;
     destructor destroy; override;
     class function New: iAwesomeApi;
     function fnc_AwesomeApi(Value: String; aDataSet: TFDMemTable): String;

  end;

implementation

uses
   RESTRequest4D,
   DataSet.Serialize.Adapter.RESTRequest4D;

{ TModelPessoa }

constructor TModelawesomeApi.create;
begin

end;

destructor TModelawesomeApi.destroy;
begin

  inherited;
end;

class function TModelawesomeApi.New: iAwesomeApi;
begin
   Result := Self.Create;
end;

function TModelawesomeApi.fnc_AwesomeApi(Value: String; aDataSet: TFDMemTable): String;
var
   Resp : IResponse;
begin
   {$REGION 'fnc_AwesomeApi'}
   if Value.Length <> 8 then
   begin
      Result := 'CEP inv�lido';
      exit;
   end;

   Resp := TRequest.New.BaseURL('https://cep.awesomeapi.com.br')   //https://cep.awesomeapi.com.br/json/05424020
              .Resource('/json/'+Value)
              .Accept('application/json')
              .Adapters(TDataSetSerializeAdapter.New(aDataSet))
              .Get;

   if ( (Resp.StatusCode = 503) or (Resp.StatusCode = 403)) then //site fora do ar Service Unavailable ou n�o autorizado
   begin
      Result := 'awesomeApi';
      Exit

   end

   else
   begin
      if Resp.StatusCode = 200 then
      begin
         if Resp.Content.IndexOf('erro') > 0 then
         begin
            Result := 'CEP n�o encontrado';
            Exit
         end

         else
         begin
            Result := 'CEP:       ' + aDataSet.FieldByName('cep').AsString + sLineBreak         +
                      'End:       ' + aDataSet.FieldByName('address').AsString + sLineBreak  +
                      'Bairro:    ' + aDataSet.FieldByName('district').AsString + sLineBreak      +
                      'UF:        ' + aDataSet.FieldByName('state').AsString + sLineBreak          +
                      'Cidade:    ' + aDataSet.FieldByName('city').AsString + sLineBreak  +
                      'Latitude:  ' + aDataSet.FieldByName('lat').AsString + sLineBreak +
                      'Longitude: ' + aDataSet.FieldByName('lng').AsString + sLineBreak +
                      'IBGE:      ' + aDataSet.FieldByName('city_ibge').AsString;
         end;

      end;

   end;
   {$endregion}

end;



end.

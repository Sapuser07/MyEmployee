namespace BGSW.Common;


type GUID : String(32);

//Define currency Code
type Amount: Decimal(10,2) @(
semantic.amount.currencyCode : 'CurrencyCode',
sap.unit: 'CurrencyCode'//Formatting for Currency. Ex 400 => $400
);

//Aspect - Collection of fields
//It's quite similar to the .Include statement in SAP ABAP.
aspect Payscale {
    CurrencyCode: String(4);
    NetSalary: Amount;
    HRA:Amount;
    NPS:Amount;
    Tax:Amount;
    BonusAmount:Amount;
    VariablePay:Amount;
 }



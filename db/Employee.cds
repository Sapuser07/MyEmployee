//Namespaces provide a mechanism for isolating groups of resources, such as an employee table that can exist in multiple namespaces
//Its uniquly Identify in a Project Level
//===>How to translate UI applicaiton 
//https://port4004-workspaces-ws-mv6kr.us10.trial.applicationstudio.cloud.sap/btpcamp/webapp/index.html?sap-ui-language=de


namespace BGSW.Employee; //A DB stands for a Database

// How to Use the Reusable Library
// To use it, you need to import the library via Using annotation.
// {...} -> Indicate the namespace
// '' -> Provide the path to the library
using {BGSW.Common as Common} from './CommonDT';
using {
  cuid,
  managed,
  Country
} from '@sap/cds/common';

//Context refers to the purpose of the database table and defines its category.
context EmployeeCollection {

  //Table View 1: Employee 
  entity EmployeeDetails : cuid, managed {
        //Data Type - https://cap.cloud.sap/docs/cds/cdl
        //key NODE_KEY    : Common.GUID; //Imported from Reuse Lib
        EmpID       : Integer  @(title: '{i18n>EMP_EMPID}');  
        //Localized annotations are utilized for translating database values.
        Name        : localized String(80) @(title: '{i18n>EMP_Name}');  
        Role        : localized String(80) @(title: '{i18n>EMP_Role}');  
        Email       : String(80) @(title: '{i18n>EMP_Email}');
        Phone       : Integer @(title: '{i18n>EMP_Phone}');
        Department  : localized String(80) @(title: '{i18n>EMP_Department}');
        DOJ         : DateTime @(title: '{i18n>EMP_DOJ}');
        Status      : String(1) @(title: '{i18n>EMP_Status}');
        //Association with Employee Address Table - Farward Navigation
        //As per Design, AddressGUID will connect with Primary key (NODE_KEY) of Employee Address table
        //AddressGUID : Association to one EmployeeAddress; //FK Relationship
        AddressGUID : Association to one EmployeeAddress; //FK Relationship
        SalaryGUID  : Association to one Payscale; //FK Relationship
  }

//Table View 1: Employee Address
  entity EmployeeAddress : cuid, managed {
    HouseNo    : Integer;
    Street     : localized String(60);
    City       : localized String(60);
    State      : String(2);
    Country    : Country;
    PostalCode : Integer;
    //$self represent the Primary key of current database table. Ex: NODE_KEY of EmployeeAddress table.
    Employee   : Composition of one EmployeeDetails
                   on Employee.AddressGUID = $self; //Backward Relationship to Employee
  }


//Table View 1: Employee Payscale
  entity Payscale : cuid, managed, Common.Payscale //Common.Payscale imports the aspect structure during runtime
  {
    Employee : Association to one EmployeeDetails
                 on Employee.SalaryGUID = $self; //Backward Relationship to Employee
  }

}


context EmployeeEntryExit {

//Table View 4: Employee Entry Exit
  entity WFOTracking : cuid {
    //key NODE_KEY : Common.GUID;
        EmpID    : Integer;
        InTime   : DateTime;
        OutTime  : DateTime;
  }
}


//How to Test
//---------> CDS Deploy --to sqlite
//---------> Once the DB is deployed, a new file named db.sqlite will be created in the project folder.
//---------> Copy relative path of db.sqlite : NjsProj/db.sqlite
//---------> Go to SQLTool -> Add New Connection ->click on SQLite
//---------> Connect Name: MyProjDB
//---------> Database File: NjsProj/db.sqlite

//How to Compile the DB
//--------->cds compile <DB Path> -2 <DBNme>
//--------->cds compile db/Employee.cds -2 sql


//How to Add data
//---------> cds add data

//Name Space
namespace BGSW.Query;

//Import Tables using Namespace
using {
    BGSW.Employee.EmployeeCollection.EmployeeDetails as EmpDetails,
    BGSW.Employee.EmployeeCollection.EmployeeAddress as EmpAddress,
    BGSW.Employee.EmployeeCollection.Payscale as EmpPayscale,
    BGSW.Employee.EmployeeEntryExit.WFOTracking as EntryExit
} from './Employee';


//Context
context CDSViews {

    //View-0: For Entry Exit
    define view ![EntryExitData] as
        select from EntryExit {
            EmpID,
            InTime,
            OutTime
        }


    //View-1: For Employee
    define view ![EmployeeData] as

    //Specify the Table Name
        select from EmpDetails

        //BOC for Mixin
        mixin {
            //View on view
            WFO : Association[ * ] to EntryExitData
                      on WFO.EmpID = $projection.EmployeeID
        }
        into
        //EOC for Mixin
        {

                //Specify te list of fields
            key EmpID as ![EmployeeID],
                Name,
                Role,
                Email,
                Phone,
                Department,
                DOJ,
                Status
        };

    //OVS with Translation
    define view ![EmployeeOVS] as
        select from EmpDetails {

            //Employee ID Translation
            @EndUserText.label: [{
                language: 'EN',
                text    : 'Employee ID'
            }, {
                language: 'DE',
                text    : 'Mitarbeiter-ID'
            }]
            EmpID as ![Employee ID],

            //Employee Name - Translation
            @EndUserText.label: [{
                language: 'EN',
                text    : 'Name'
            }, {
                language: 'DE',
                text    : 'Name'
            }]
            Name
        }

    //View-2: For Employee Address
    define view ![EmpAddressData] as
        select from EmpAddress {
            HouseNo,
            Street,
            City,
            State,
            Country,
            PostalCode
        }


    // //View-3: For Employee Pay Scale
    define view ![EmpPayscaleData] as
        select from EmpPayscale {
            Employee.EmpID as ![EmployeeID], //Association at run time
            CurrencyCode   as ![Currency Code],
            NetSalary,
            HRA,
            NPS,
            Tax,
            BonusAmount,
            VariablePay
        };
        //group by
           // Employee.EmpID;
            //NetSalary,
            //HRA;

}

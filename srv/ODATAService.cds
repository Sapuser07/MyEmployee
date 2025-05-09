//Service Definition
//------>Note: Service Definition and Service Implementation name must be same.
//Service will Start the Server and create a local host to run the application

using {BGSW.Employee.EmployeeCollection as EmployeeColl} from '../db/Employee';


//@ Path: To specify the full path of the service
service ODATAService @(path: 'CatalogService') {

    //Export for ODATA Service
    //------>Collection with same node not allowed mutltiple times
    entity EmployeeSet @(
        odata.draft.enabled         : true,
        Common.DefaultValuesFunction: 'loadInitials'
    )                     as
        projection on EmployeeColl.EmployeeDetails {
            *,
            case Status
                when
                    'A'
                then
                    'Active'
                when
                    'R'
                then
                    'Resigned'
                when
                    'M'
                then
                    'Maternity Leave'
                when
                    'P'
                then
                    'Paternity Leave'
            end as statusDesc : String(20),

            case Status
                when
                    'A'
                then
                    '1'
                when
                    'R'
                then
                    '2'
                when
                    'M'
                then
                    '3'
                when
                    'P'
                then
                    '4'
            end as Icons      : Integer
        }


    function loadInitials() returns EmployeeAddSet;


    entity EmployeeAddSet as projection on EmployeeColl.EmployeeDetails
                             //Instance Bound Action
        actions {

           // @Common.SideEffects: {TargetProperties: ['in/GROSS_AMOUNT'], }


            action boots() returns EmployeeAddSet;
        }
//entity EmployeePayscale as projection on EmployeeColl.Payscale; //Employee Payscale


}

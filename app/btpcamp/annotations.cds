using ODATAService as service from '../../srv/ODATAService';

annotate service.EmployeeSet with @(

    //Selection Parameters : Advance Filter
    UI.SelectionFields: [

        EmpID,
        Name,
        Role,
        Email,
        Phone,
        Department,
        DOJ,
        Status,
        createdAt,
        createdBy,
        modifiedAt,
        modifiedBy
    ],


    //Result View
    UI.LineItem       : [
        {
            $Type: 'UI.DataField',
            Value: EmpID,
        },
        {
            $Type: 'UI.DataField',
            Value: Name,
        },
        {
            $Type: 'UI.DataField',
            Value: Status,
        },
        {
            $Type: 'UI.DataField',
            Value: Role,
        },
        {
            $Type: 'UI.DataField',
            Value: Email,
        },
        {
            $Type: 'UI.DataField',
            Value: Phone,
        },
        {
            $Type: 'UI.DataField',
            Value: Department,
        },
        {
            $Type: 'UI.DataField',
            Value: DOJ,
        },
        {
            $Type: 'UI.DataField',
            Value: createdAt,
        },
        {
            $Type: 'UI.DataField',
            Value: createdBy,
        }
    ],

    //Tile of the Result View
    UI.HeaderInfo     : {
        TypeName      : 'Employee Master',
        TypeNamePlural: 'Employee Master',
        Title         : {Value: EmpID, },
        Description   : {Value: Name}

    }
);


//Default Value
annotate service.EmployeeSet with {
    Email @(
        Common.Text: Email,
        ValueList.entity: service.Email
    )
}


//Create Search help/F4
@cds.odata.valuelist
annotate service.EmployeeSet with @(
    UI.Identification:[
        {
            $Type : 'UI.DataField',
            Value : Department,
        },
         {
            $Type : 'UI.DataField',
            Value : EmpID,
        },
    ]
);

sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'btp/app/btpcamp/test/integration/FirstJourney',
		'btp/app/btpcamp/test/integration/pages/EmployeeSetList',
		'btp/app/btpcamp/test/integration/pages/EmployeeSetObjectPage'
    ],
    function(JourneyRunner, opaJourney, EmployeeSetList, EmployeeSetObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('btp/app/btpcamp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheEmployeeSetList: EmployeeSetList,
					onTheEmployeeSetObjectPage: EmployeeSetObjectPage
                }
            },
            opaJourney.run
        );
    }
);
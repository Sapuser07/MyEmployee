module.exports = cds.service.impl(async function () {

    const { EmployeeAddSet } = this.entities;


    ///generic handler - BEFORE Employee data is UPDATEd check (validation)
    // this.before(['CREATE', 'UPDATE'], EmployeeSet, (req, res) => {
    //     console.log("aa gaya " + req.data.salaryAmount);
    //     if (parseFloat(req.data.salaryAmount) >= 1000000) {
    //         req.error(500, "Salary must be less than 1 mn");
    //     }
    // });

    this.on('boots', async (req, res) => {
        try {
            //since its instance bound we will get the key
            const ID = req.params[0];
            console.log("Bro this is your key " + JSON.stringify(ID));
            //start a transaction using cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
            const tx = await cds.tx(req);
            let test = await tx.update(EmployeeAddSet).with({
                Status: 'X' //{ '+=': 20000 }
            }).where(ID);
            let reply = await tx.read(EmployeeAddSet).where(ID);
            return reply;

        } catch (error) {
            res.error(500, "Run time exception");
        }
    });


    this.on('loadInitials', async (req,res) => {
        try {
            return {
                Status : 'A'
            };
           
        } catch (error) {
            return "Error aa gaya " + error.toString();
        }
    });


    // this.on('getLargestOrder', async (req, res) => {
    //     try {
    //         //start a transaction using cds ql - https://cap.cloud.sap/docs/node.js/cds-tx
    //         const tx = await cds.tx(req);
    //         let reply = await tx.read(POs).orderBy({ "GROSS_AMOUNT": 'desc' })
    //             .limit(1);


    //         return reply;

    //     } catch (error) {
    //         return "Error aa gaya " + error.toString();
    //     }
    // });

})
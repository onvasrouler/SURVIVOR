const { mainDB, soulConnection } = require("../../database/mongo");
const api_formatter = require("../../middleware/api-formatter.js");

exports.get_all = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    try {
        const data = await soulConnection.collection(req.params.COLLECTIONNAME).find({}).toArray();
        if (data[0]["date"]) {
            data.forEach((element) => {
                const oldDate = element["date"].split("-");
                element["date"] = `${oldDate[2]}-${oldDate[1]}-${oldDate[0]}`;
            });
        }
        return api_formatter(req, res, 200, "success", "données la db recup avec succès", data, null, null);
    } catch (error) {
        return api_formatter(req, res, 500, "errorOccured", "Erreur lors de la récupération des données", null, error, null);
    }
};

exports.soul_connection_api = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    try {
        params = req.params.ID;
        formatPng = false;
        if (params.includes(".png")) {
            params = params.split(".png")[0];
            formatPng = true;
        }
        const collectionQuery = { [`${req.params.COLLECTIONNAME}_id`]: params };
        const soulData = await soulConnection.collection(req.params.COLLECTIONNAME).findOne(collectionQuery);
        if (!soulData)
            return api_formatter(req, res, 404, "notFound", "data not found", null, null, null);
        if (req.params.COLLECTIONNAME.includes("image") && formatPng) {
            try {
                if (!soulData) {
                    return api_formatter(req, res, 404, "notFound", "picture not found", null, null, null);
                }
                res.setHeader('Content-Type', 'image/png');
                res.send(soulData["image"].buffer);
            } catch (error) {
                console.error(error);
                return api_formatter(req, res, 500, "errorOccured", "Error occured when trying to get data", null, error, null);
            }
        } else {
            if (soulData["date"]) {
                const oldDate = soulData["date"].split("-");
                soulData["date"] = `${oldDate[2]}-${oldDate[1]}-${oldDate[0]}`;
            }
            return api_formatter(req, res, 200, "success", "successfully received data", soulData, null, null);
        }
    } catch (error) {
        console.error(error);
        return api_formatter(req, res, 500, "errorOccured", "Error occured when trying to get data", null, error, null);
    }

};

exports.internal_api_get_all = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);

    try {
        const data = await mainDB.collection("users").find({}).toArray();
        let buffer = [];
        data.forEach((element) => {
            buffer.push({
                "username": element.username,
                "email": element.email,
                "role": element.role,
                "creationIp": element.creationIp,
                "lastConnection": element.lastConnection,
                "unique_id": element.unique_id
            });
        });
        return api_formatter(req, res, 200, "success", "successfully received data", buffer, null, null);
    } catch (error) {
        return api_formatter(req, res, 500, "errorOccured", "Error occured when trying to get data", null, error, null);
    }
}

exports.internal_api_get_one = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);

    try {
        const data = await mainDB.collection("users").findOne({
            $or: [
                { unique_id: req.params.ID },
                { username: req.params.ID },
                { email: req.params.ID }
            ]
        });
        if (!data) {
            return api_formatter(req, res, 404, "notFound", "data not found", null, null, null);
        }
        let buffer = {
            "username": data.username,
            "email": data.email,
            "role": data.role,
            "creationIp": data.creationIp,
            "lastConnection": data.lastConnection,
            "unique_id": data.unique_id
        };
        return api_formatter(req, res, 200, "success", "successfully received data", buffer, null, null);
    } catch (error) {
        return api_formatter(req, res, 500, "errorOccured", "Error occured when trying to get data", null, error, null);
    }
}

exports.internal_api_get_me = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);

    let data = {
        "username": req.user.username,
        "email": req.user.email,
        "role": req.user.role,
        "creationIp": req.user.creationIp,
        "lastConnection": req.user.lastConnection,
        "unique_id": req.user.unique_id
    };
    return api_formatter(req, res, 200, "success", "successfully received data", data, null, null);
}

exports.internal_api_assign = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    try {
        const assign_data = {
            "coachId": Number(req.body.coachId),
            "customerId": JSON.parse(req.body.customerId)
        };

        if (!assign_data.coachId || !assign_data.customerId)
            return api_formatter(req, res, 400, "badRequest", "missing data", null, null, null);

        const coach = await soulConnection.collection("employee").findOne({ id: assign_data.coachId});
        if (!coach)
            return api_formatter(req, res, 404, "notFound", "coach not found", null, null, null);

        if (coach.work.toLowerCase() != "coach")
            return api_formatter(req, res, 400, "badRequest", "the given employee is not a coach", null, null, null);

        if (typeof assign_data.customerId == "object") {
            let status = {"success": 0, "notFound": 0, "badRequest": 0};
            for (let i = 0; i < assign_data.customerId.length; i++) {
                const customer = await soulConnection.collection("customer").findOne({ customer_id: `${assign_data.customerId[i]}`});
                if (!customer) {
                    status["notFound"]++;
                    continue;
                }
                const assignation = await assign_coach_customers(coach, customer);
                if (assignation === true)
                    status["success"]++;
                else {
                    status["badRequest"]++;
                    console.error(assignation);
                }
            }
            return api_formatter(req, res, 200, "success", "successfully assigned a coach with a customers", status, null, null);
        } else {
            const customer = await soulConnection.collection("customer").findOne({ customer_id: `${assign_data.customerId}` });
            if (!customer)
                return api_formatter(req, res, 404, "notFound", "customer not found", null, null, null);

            
            const assignation = await assign_coach_customers(coach, customer);
            if (assignation === true)
                return api_formatter(req, res, 200, "success", "successfully assigned a coach with a customers", null, null, null);
            else
                return api_formatter(req, res, 400, "badRequest", "error occured when trying to assign a coach with a customers", null, assignation, null);
        }
    } catch (error) {
        return api_formatter(req, res, 500, "errorOccured", "Error occured when trying to assign a coach with a customers", null, error, null);
    }
}

async function assign_coach_customers(coach, customer) {
    try {
        const coachAssigned = customer.assigned_coach
        const customerAssigned = coach.assigned_customers

        if (!coachAssigned)
            soulConnection.collection("customer").updateOne({ customer_id: customer.customer_id }, { $addToSet: { "assigned_coach": coach.employee_id } });

        if (!customerAssigned)
            soulConnection.collection("employee").updateOne({ employee_id: coach.employee_id }, { $addToSet: { "assigned_customers": customer.customer_id } });

        return true;
    } catch (error) {
        return error;
    }
}

exports.internal_api_unassign = async (req, res) => {
    if (!req.user || req.user == null)
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    try {
        const unassign_data = {
            "coachId": Number(req.body.coachId),
            "customerId": JSON.parse(req.body.customerId)
        };

        if (!unassign_data.coachId || !unassign_data.customerId)
            return api_formatter(req, res, 400, "badRequest", "missing data", null, null, null);

        const coach = await soulConnection.collection("employee").findOne({ id: unassign_data.coachId});
        if (!coach)
            return api_formatter(req, res, 404, "notFound", "coach not found", null, null, null);

        if (coach.work.toLowerCase() != "coach")
            return api_formatter(req, res, 400, "badRequest", "the given employee is not a coach", null, null, null);

        if (typeof unassign_data.customerId == "object") {
            let status = {"success": 0, "notFound": 0, "badRequest": 0};
            for (let i = 0; i < unassign_data.customerId.length; i++) {
                const customer = await soulConnection.collection("customer").findOne({ customer_id: `${unassign_data.customerId[i]}`});
                if (!customer) {
                    status["notFound"]++;
                    continue;
                }
                const unassignation = await unassign_coach_customers(coach, customer);
                if (unassignation === true)
                    status["success"]++;
                else {
                    status["badRequest"]++;
                    console.error(unassignation);
                }
            }
            return api_formatter(req, res, 200, "success", "successfully unassigned a coach with a list of customers", status, null, null);
        } else {
            const customer = await soulConnection.collection("customer").findOne({ customer_id: `${unassign_data.customerId}` });
            if (!customer)
                return api_formatter(req, res, 404, "notFound", "customer not found", null, null, null);

            
            const unassignation = await unassign_coach_customers(coach, customer);
            if (unassignation === true)
                return api_formatter(req, res, 200, "success", "successfully unassigned a coach with a customers", null, null, null);
            else
                return api_formatter(req, res, 400, "badRequest", "error occured when trying to unassign a coach with a customers", null, assignation, null);
        }
    } catch (error) {
        return api_formatter(req, res, 500, "errorOccured", "Error occured when trying to unassign a coach with a customers", null, error, null);
    }
}

async function unassign_coach_customers(coach, customer) {
    try {
        const coachAssigned = customer.assigned_coach
        const customerAssigned = coach.assigned_customers

        if (coachAssigned && coachAssigned.includes(coach.employee_id))
            soulConnection.collection("customer").updateOne({ customer_id: customer.customer_id }, { $pull : { "assigned_coach": coach.employee_id } });

        if (customerAssigned && customerAssigned.includes(customer.customer_id))
            soulConnection.collection("employee").updateOne({ employee_id: coach.employee_id }, { $pull: { "assigned_customers": customer.customer_id } });

        return true;
    } catch (error) {
        return error;
    }
}
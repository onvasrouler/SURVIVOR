const { mainDB, soulConnection } = require("../../database/mongo");
const api_formatter = require("../../middleware/api-formatter.js");

exports.get_all = async (req, res) => {
    if (!req.user || req.user == null) {
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    } else {
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
    }
};

exports.soul_connection_api = async (req, res) => {
    if (!req.user || req.user == null) {
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    } else {
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

    }
};

exports.internal_api_get_all = async (req, res) => {
    if (!req.user || req.user == null) {
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    }
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
    if (!req.user || req.user == null) {
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    }
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
    if (!req.user || req.user == null) {
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    }
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
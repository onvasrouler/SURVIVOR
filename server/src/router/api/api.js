const { soulConnection } = require("../../database/mongo");
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

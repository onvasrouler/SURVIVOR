const { soulConnection } = require("../../database/mongo");
const api_formatter = require("../../middleware/api-formatter.js");

exports.get_all = async (req, res) => {
    if (!req.user || req.user == null) {
        return api_formatter(req, res, 401, "noSession", "vous n'êtes pas connecté", null, null, null);
    } else {
        try {
            console.log(req.params.COLLECTIONNAME);
            const data = await soulConnection.collection(req.params.COLLECTIONNAME).find({}).toArray();
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
            const collectionQuery = { [`${req.params.COLLECTIONNAME}_id`]: Number(req.params.ID) };
            const soulData = await soulConnection.collection(req.params.COLLECTIONNAME).findOne(collectionQuery);
            return api_formatter(req, res, 200, "success", "données la db recup avec succès", soulData, null, null);
        } catch (error) {
            console.error(error);
            return api_formatter(req, res, 500, "errorOccured", "Erreur lors de la récupération des données", null, error, null);
        }

    }
};
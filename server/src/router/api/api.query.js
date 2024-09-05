const api_interactions = require("./api.js");
const get_user_from_session = require("../../middleware/auth.js");

module.exports = function (app) {
    app.get("/soul_connection_api/:COLLECTIONNAME", get_user_from_session, api_interactions.get_all);
    app.get("/soul_connection_api/:COLLECTIONNAME/:ID", get_user_from_session, api_interactions.soul_connection_api);

};
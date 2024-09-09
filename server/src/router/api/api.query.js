const api_interactions = require("./api.js");
const get_user_from_session = require("../../middleware/auth.js");

module.exports = function (app) {
    app.get("/soul_connection_api/:COLLECTIONNAME", get_user_from_session, api_interactions.get_all);
    app.get("/soul_connection_api/:COLLECTIONNAME/:ID", get_user_from_session, api_interactions.soul_connection_api);
    app.get("/api/users", get_user_from_session, api_interactions.internal_api_get_all);
    app.get("/api/users/:ID", get_user_from_session, api_interactions.internal_api_get_one);
    app.get("/api/me", get_user_from_session, api_interactions.internal_api_get_me);

};
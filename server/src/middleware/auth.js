const User = require('../database/models/users.js')
const jwt = require('jsonwebtoken');
const sendApiData = require("./api-formatter.js");

async function get_user_from_session(req, res, next, bloquant = true) {
    try {
        const session = req.headers.session;
        var decoded = null;
        const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;

        req.user = null;
        if (!session || session == null || session == undefined || session == "null")
            return sendApiData(req, res, 401, "noSession", "You don't appaears to have a valid session", null, null, null, null);

        try {
            decoded = jwt.verify(session, process.env.SECRET);
        } catch (err) {
            return sendApiData(req, res, 401, "invalidSession", "It appears that your session is invalid", null, null, null, null);
        }

        if (!decoded) return sendApiData(req, res, 401, "invalidSession", "It appears that your session is invalid", null, null, null, null);

        Session.findOne({ unique_session_id: decoded.session_id }).then(function (session) {
            if (!check_non_null_session(session))
                return sendApiData(req, res, 401, "invalidSession", "It appears that your session is invalid or expired", null, null, null, null);

            User.findOne({ link_session_id: session.signed_id }).then(function (user) {
                if (!verif_session_data(session, user, ip))
                    return sendApiData(req, res, 401, "invalidSession", "It appears that your session is invalid", null, null, null, null);
                req.user = user;
                return next();
            }).catch(function (err) {
                return sendApiData(req, res, 500, "errorOccured", "An error occured while trying to verify your session", null, err, null, null);

            });
        }).catch(function (err) {
            return sendApiData(req, res, 500, "errorOccured", "An error occured while trying to verify your session", null, err, null, null);
        });
    } catch (err) {
        return sendApiData(req, res, 500, "errorOccured", "An error occured while trying to verify your session", null, err, null, null);
    }
}


async function check_non_null_session(session) {
    return (session && session != null && session != undefined && session != "null" && session.expire > Date.now());
}

async function verif_session_data(session, user, ip) {
    return (session.expire < Date.now() || session.expire == null || session.expire == undefined ||
        session.signed_id == null || session.signed_id == undefined ||
        session.signed_id != user.link_session_id || session.connexionIp != ip ||
        session.user_signed_id != user.unique_id)
}

module.exports = get_user_from_session;
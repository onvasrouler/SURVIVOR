const UserModel = require('../database/models/users.js')
const SessionModel = require('../database/models/session.js')
const jwt = require('jsonwebtoken');
const sendApiData = require("./api-formatter.js");

async function checkAuthenticated(req, res, next) {
    try {
        const GivenSession = req.headers.session;
        var decodedSession = null;
        const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;

        req.user = null;
        if (!GivenSession) return sendApiData(req, res, 401, "noSession", "You didn't provide any session", null, null, null, null);

        try {
            decodedSession = await jwt.verify(GivenSession, process.env.SECRET);
        } catch (err) {
            decodedSession = null;
        }
        if (!decodedSession) return sendApiData(req, res, 401, "invalidSession", "It appears that your session is invalid", null, null, null, null);

        await SessionModel.findOne({
            unique_session_id: decodedSession.session_id
        }).then(async function (FoundSession) {
            if (!FoundSession) return invalid_session(req, res);

            await UserModel.findOne({
                link_session_id: FoundSession.signed_id
            }).then(async function (CorrespondingUser) {

                await verif_session_data(FoundSession, CorrespondingUser, ip)

                req.user = CorrespondingUser;
                req.session = FoundSession;
                return next();
            })
        })
    } catch (err) {
        console.log(err);
        return sendApiData(req, res, 500, "errorOccured", "An error occured while trying to verify your session", null, err, null, null);
    }
}


async function verif_session_data(session, user, ip) {
    if (session.expire == null || session.expire < Date.now() ||
        session.signed_id == null || !user.link_session_id.includes(session.signed_id) ||
        session.connexionIp == null || session.connexionIp != ip ||
        session.user_signed_id != user.unique_id)
        return invalid_session(req, res);
}

function invalid_session(req, res) {
    return sendApiData(req, res, 401, "invalidSession", "It appears that your session is invalid", null, null, null, null);
}

module.exports = checkAuthenticated;
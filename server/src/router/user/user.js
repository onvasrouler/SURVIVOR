const User = require('../../database/models/users')
const Session = require('../../database/models/session')
const checkAuthenticated = require("../../middleware/auth.js");
const redirects = require("../../middleware/redirect.js");

const jwt = require('jsonwebtoken');
const crypto = require('crypto');

var hour = 3600000;
var day = hour * 24; Session
var month = day * 30;

exports.register = async (req, res) => {
    try {
        const register_data = {
            "email": req.body.email,
            "password": req.body.password,
            "username": req.body.username,
            "ip": req.headers['x-forwarded-for'] || req.connection.remoteAddress,
        }


        if (await check_json_data(register_data)) return res.status(400).send({ "message": "missing informations" });
        if (await User.emailExists(register_data.email)) return res.status(400).send({ "message": "email already exist" });
        if (await User.usernameExists(register_data.username)) return res.status(400).send({ "message": "username already exist" });

        const newUser = new User({
            email: register_data.email,
            username: register_data.username,
            password: register_data.password,
            creationIp: register_data.ip,
        });
        newUser.save().then(function (User, err) {
            if (err) return error_occured(req, res, err);

            const newSession = new Session({
                unique_session_id: crypto.randomUUID(),
                signed_id: crypto.randomUUID(),
                user_signed_id: User.unique_id,
                connexionIp: register_data.ip,
                expire: Date.now() + month,
            });

            newSession.save().then(function (Session, err) {
                if (err) return error_occured(req, res, err);

                User.updateOne({
                    unique_id: User.unique_id
                }, {
                    $addToSet: {
                        link_session_id: Session.signed_id
                    }
                }).then(function (newuser, err) {
                    if (err) return error_occured(req, res, err);
                    if (!User.link_session_id.includes(Session.signed_id))
                        return error_occured(req, res);
                    return return_signed_cookies(req, res, newSession.unique_session_id, newuser);
                }).catch(function (err) {
                    return error_occured(req, res, err);
                });
            }).catch(function (err) {
                return error_occured(req, res, err);
            })
        }).catch(function (err) {
            return error_occured(req, res, err);
        });
    } catch (err) {
        return error_occured(req, res, err);
    }
}

exports.login = async (req, res) => {
    try {
        let login_data = {
            "emailOrUsername": req.body.emailOrUsername,
            "password": req.body.password,
            "ip": req.headers['x-forwarded-for'] || req.connection.remoteAddress,
        }
        if (await check_json_data(login_data))
            return res.status(400).send({ "message": "missing informations" });
        User.findOne({
            $or: [
                {
                    email: login_data.emailOrUsername
                }, {
                    username: login_data.emailOrUsername
                }]
        }).then(async function (user) {
            if (!user) return res.status(401).send({ "message": "incorrect email or username" });
            if (!user.comparePassword(login_data.password))
                return res.status(401).send({ "message": "incorrect password" });

            const newSession = new Session({
                unique_session_id: crypto.randomUUID(),
                signed_id: crypto.randomUUID(),
                user_signed_id: user.unique_id,
                connexionIp: login_data.ip,
                expire: Date.now() + month,
            });
            await newSession.save().then(async function (Session) {
                await user.updateOne({
                    $addToSet: {
                        link_session_id: Session.signed_id
                    }
                })
                return return_signed_cookies(req, res, newSession.unique_session_id, user);
            }).catch(async function (err) {
                console.log(err);
                return error_occured(req, res, err);
            });
        }).catch(function (err) {
            return error_occured(req, res, err);
        });
    } catch (err) {
        return error_occured(req, res, err);
    }
}

exports.profile = async (req, res) => {
    return res.status(200).send({ "status": "success", "username": req.user.username });
}

exports.logout = async (req, res) => {
    if (req.user && req.user != null && req.user != undefined) {
        Session.deleteOne({ signed_id: req.user.link_session_id }).then(function (session, err) {
            if (session) {
                return redirects.logout_success(req, res);
            } else {
                console.log(err);
                return redirects.logout_error_occured(req, res);
            }
        }).catch(function (err) {
            console.log(err);
        });
    } else {
        return redirects.logout_success(req, res);
    }
}

exports.deleteaccount = async (req, res) => {
    try {
        if (req.user.comparePassword(req.body.password)) {
            await User.deleteOne({ _id: req.user._id }).then(async function (user, err) {
                if (err)
                    return redirects.account_delete_error(req, res);
                await Session.deleteOne({ signed_id: req.user.link_session_id }).then(function (session, err) {
                    if (err)
                        return redirects.account_delete_error(req, res);

                    return redirects.account_deleted(req, res);
                })
            })
        } else {
            return redirects.incorrect_password(req, res);
        }
    } catch (error) {
        return redirects.account_delete_error(req, res);
    }
}




function return_signed_cookies(req, res, uuid_session_id, user) {
    return res.status(200).send({
        "message": "connecté avec success",
        "session": jwt.sign({ session_id: uuid_session_id }, process.env.SECRET),
        "username": user.username
    });
}

function error_occured(req, res, errorMsg) {
    return res.status(500).send({
        "message": "error occured while creating session!",
        "session": "",
        "username": "",
        "error": errorMsg
    });
}

async function check_json_data(json_data) {
    return (Object.values(json_data).includes(undefined) || Object.values(json_data).includes(""));
}

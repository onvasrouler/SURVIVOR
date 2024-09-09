const test = require('node:test');
const assert = require('node:assert');
require("dotenv").config();

test_session = null;
server_URL = `http://${process.env.SERVER_URL}:${process.env.PORT}`;

test('POST /register', async (t) => {
    console.log("registering in");
    test_body = JSON.stringify({
        "email": process.env.TEST_EMAIL,
        "username": process.env.TEST_USERNAME,
        "password": process.env.TEST_PASSWORD
    });
    const response = await fetch(`${server_URL}/register`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: test_body,
    });
    const responseBody = await response.json();
    if (response.status == 200)
        test_session = responseBody.session;
    else
        console.log(responseBody);
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be Success');
});

test('GET /profile', async (t) => {
    console.log("getting profile to check if the given session is valid");
    const response = await fetch(`${server_URL}/profile`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.status, "success", 'Expected success to be success');
    assert.strictEqual(responseBody.username, process.env.TEST_USERNAME, 'Expected username to be correct');
});

test('GET /logout', async (t) => {
    console.log("logging out");
    const response = await fetch(`${server_URL}/logout`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be success');
});

test('GET /profile', async (t) => {
    console.log("getting profile to verify the log out");
    const response = await fetch(`${server_URL}/profile`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 401, 'Expected status code to be 401');
    assert.strictEqual(responseBody.messageStatus, "invalidSession", 'Expected status to be invalidSession');
    assert.strictEqual(responseBody.message, "It appears that your session is invalid", 'Expected message to be It appears that your session is invalid');
})

test('POST /login', async (t) => {
    console.log("logging in and updating the token");
    test_body = JSON.stringify({
        "emailOrUsername": process.env.TEST_EMAIL,
        "password": process.env.TEST_PASSWORD,
    });
    const response = await fetch(`${server_URL}/login`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: test_body,
    });
    const responseBody = await response.json();
    if (response.status == 200)
        test_session = responseBody.session;
    else
        console.log(responseBody);
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be Success');
});

test('POST /login', async (t) => {
    console.log("logging in a second time to create a second session but don't update the token");
    test_body = JSON.stringify({
        "emailOrUsername": process.env.TEST_EMAIL,
        "password": process.env.TEST_PASSWORD,
    });
    const response = await fetch(`${server_URL}/login`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: test_body,
    });
    const responseBody = await response.json();
    if (response.status != 200)
        console.log(responseBody);
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be Success');
});


test('GET /profile', async (t) => {
    console.log("getting profile to check if the session is valid");
    const response = await fetch(`${server_URL}/profile`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.status, "success", 'Expected success to be success');
    assert.strictEqual(responseBody.username, process.env.TEST_USERNAME, 'Expected username to be correct');
});

test('GET /logouteverywhere', async (t) => {
    console.log("deleting every session");
    const response = await fetch(`${server_URL}/logouteverywhere`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be success');
});

test('GET /profile', async (t) => {
    console.log("getting profile to verify the log out");
    const response = await fetch(`${server_URL}/profile`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 401, 'Expected status code to be 401');
    assert.strictEqual(responseBody.messageStatus, "invalidSession", 'Expected status to be invalidSession');
    assert.strictEqual(responseBody.message, "It appears that your session is invalid", 'Expected message to be It appears that your session is invalid');
})

test('POST /login', async (t) => {
    console.log("logging in and updating the token");
    test_body = JSON.stringify({
        "emailOrUsername": process.env.TEST_EMAIL,
        "password": process.env.TEST_PASSWORD,
    });
    const response = await fetch(`${server_URL}/login`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: test_body,
    });
    const responseBody = await response.json();
    if (response.status == 200)
        test_session = responseBody.session;
    else
        console.log(responseBody);
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be Success');
});

test('DELETE /profile', async (t) => {
    console.log("deleting the account");
    const response = await fetch(`${server_URL}/profile`, {
        method: 'DELETE',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
        body: JSON.stringify({
            "password": process.env.TEST_PASSWORD,
        }),
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 200, 'Expected status code to be 200');
    assert.strictEqual(responseBody.messageStatus, "success", 'Expected success to be success');
});

test('GET /profile', async (t) => {
    console.log("getting profile to verify the log out and account deletion");
    const response = await fetch(`${server_URL}/profile`, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            'session': test_session
        },
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 401, 'Expected status code to be 401');
    assert.strictEqual(responseBody.messageStatus, "invalidSession", 'Expected status to be invalidSession');
    assert.strictEqual(responseBody.message, "It appears that your session is invalid", 'Expected message to be It appears that your session is invalid');
})

test('POST /login', async (t) => {
    console.log("logging in to ensure that the account is deleted");
    test_body = JSON.stringify({
        "emailOrUsername": process.env.TEST_EMAIL,
        "password": process.env.TEST_PASSWORD,
    });
    const response = await fetch(`${server_URL}/login`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: test_body,
    });
    const responseBody = await response.json();
    assert.strictEqual(response.status, 401, 'Expected status code to be 401');
    assert.strictEqual(responseBody.messageStatus, "user_not_found", 'Expected success to be user_not_found');
})


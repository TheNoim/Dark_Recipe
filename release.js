const fs = require('fs');
const rp = require('request-promise');
const jwt = require('jsonwebtoken');


const secret = process.env.SIGNSECRET;

const destination = process.env.REMOTE_PROTO + "://" + process.env.REMOTE_HOST + "/createRelease/";

const payload = {
    commit: process.env.TRAVIS_COMMIT,
    version: "v" + process.env.TRAVIS_JOB_NUMBER,
    repo_org: process.env.REPO_ORG,
    repo: process.env.REPO
};

console.log("Sign payload: " + JSON.stringify(payload));
console.log("Destination: " + destination);

const createToken = jwt.sign(payload, secret);


rp({
    method: "POST",
    uri: destination + createToken,
    formData: {
        files: [
            fs.createReadStream('./' + process.env.RELEASE_MD5),
            fs.createReadStream('./' + process.env.RELEASE_IPA)
        ]
    }
}).then(response => {
    console.log("Server response: " + JSON.stringify(response));
    process.exit(0);
}).catch(function (err) {
    console.error("Error: " + err);
    process.exit(1);
});

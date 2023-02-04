const https = require("https");
const exec = require("child_process").exec;

function checkConnectivity() {
  https
    .get("https://www.google.com", (res) => {
      console.log("Network connected");
    })
    .on("error", (err) => {
      console.log("Network is not connected");
      const time = new Date().valueOf();
      exec(`bash ${__dirname}/auto-login.sh ${time}`, (error, stdout, stderr) => {
        if (error) {
          console.error(`Exection error: ${error}`);
          return;
        }
        console.log(`stdout: ${stdout}`);
        console.log(`stderror: ${stderr}`)
      });
    });
}

setInterval(checkConnectivity, 5000);

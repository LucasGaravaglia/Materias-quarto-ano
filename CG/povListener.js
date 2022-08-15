const { exec } = require("child_process");
const fs = require("fs");

var file = process.argv[2];

fs.watch(file, function (event, filename) {
  if (event == "change") {
    exec(`povray ${file}`);
  }
});

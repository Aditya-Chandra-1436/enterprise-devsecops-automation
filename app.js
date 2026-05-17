const express = require("express");
const helmet = require("helmet");
const cookieParser = require("cookie-parser");
const csrf = require("csurf");

const app = express();

app.use(helmet());

app.use(cookieParser());

app.use(express.urlencoded({ extended: true }));

const csrfProtection = csrf({ cookie: true });

app.get("/", csrfProtection, (req, res) => {
  res.send("Enterprise DevSecOps Pipeline Running Successfully");
});

app.listen(3000, () => {
  console.log("Application running on port 3000");
});

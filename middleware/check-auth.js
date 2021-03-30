const { json } = require("body-parser");

const jwt = require("jsonwebtoken");

module.exports = (req, res, next) => {
  // get auth header value
  const bearerHeader = req.headers["authorization"];
  // check if bearer is undefined
  if (typeof bearerHeader !== "undefined") {
    const bearer = bearerHeader.split(" ");
    const bearerToken = bearer[1];
    req.token = bearerToken;

    jwt.verify(req.token, "Gustavo@125", (err, authData) => {
      if (err) return res.status(403).json({ status: 403, message: "Login is required" });
      
      next();
    });
  } else {
    // send forbiden
    res.status(401).json({ status: 401, message: "Unauthorized member" });
  }
};

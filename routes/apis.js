"use strict";
const express = require("express");
let routes = express.Router();
const Ibimina = require("../controllers/endpoints");
const checkAuth = require("../middleware/check-auth");
// Member login
routes.post("/login", Ibimina.member_login);

// Get all members
routes.get("/members", Ibimina.members_get_all);

// Find member of given id
routes.get("/members/:member_id",checkAuth,Ibimina.get_member_by_id);
  // Update member password
routes.put("/members/:member_id",checkAuth,Ibimina.edit_member_by_id);
    
routes.post("/members", Ibimina.insert_member);
    
    // delete member of given id
routes.delete("/members/:member_id",checkAuth,Ibimina.delete_member);
      

// For Ibimina
routes.get("/ibimina", Ibimina.ibimina_get_all);
routes.post("/ibimina", checkAuth ,Ibimina.insert_ikimina);
routes.post("/test" ,Ibimina.test);
routes.get("/confirm/:token" ,Ibimina.verifyUser);


// membership request
routes.post("/ikimina_request", checkAuth ,Ibimina.membershipRequest);
// Membership
routes.get("/membership", checkAuth ,Ibimina.membership);


routes.post("/deposit", checkAuth ,Ibimina.membershipDeposit);


module.exports = routes;
      
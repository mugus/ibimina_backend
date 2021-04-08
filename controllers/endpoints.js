const db = require("../config/db");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
let nodemailer = require('nodemailer');

// Login
exports.member_login = (req, res) => {
  let sql = "SELECT member_id, email, status, password FROM members WHERE email = ?";
  let email = req.body.email;
  let password = req.body.password;
  db.query(sql, [email], async (err, rows) => {
    if (err) throw err;
    // set jwt token
    const result = JSON.parse(JSON.stringify(rows));
    let member_id = rows[0].member_id;
    let status = rows[0].status;
    // Check user status
    if(status === 0){
      res.status(401).json({ status: 401, message: "account not verified" });
    }else if(status === 1){
      
      if (rows.length > 0) {
        const hashedPassword = rows[0].password;
        const isValid = await bcrypt.compare(password, hashedPassword);
  
        if (isValid) {
          jwt.sign({ result },"Gustavo@125",{ expiresIn: "1h" },(err, token) => {
              res.json({ status: 200,loggedin_user:member_id, message: "success", token });
            }
          );
          res.status(200).json({ message: "success", token });
        } else {
          console.log("Password is invalid");
          res.status(403).json({ status: 403, message: "password not match" });
        }
      } else {
        res.status(404).send("Email not found!");
        console.log("Email not found!");
      }

    }else if(status === 2){
      res.status(401).json({ status: 401, message: "account temporary unavailable" });
    }else if(status === 3){
      res.status(401).json({ status: 401, message: "account stopped by owner of the site" });
    }

    res.end();
  });
};

// For Members

exports.members_get_all = (req, res) => {
  db.query("SELECT * FROM members ORDER BY member_id DESC", (err, result) => {
    if (err) throw err;
    var string=JSON.stringify(result);
    let ans = JSON.parse(string);
    console.log(ans);
    res.send(ans);
  });
};

exports.get_member_by_id = (req, res) => {
  db.query("SELECT * FROM members", (err, members) => {
    if (err) throw err;
    let member = members.find(
      (m) => m.member_id === parseInt(req.params.member_id)
    );
    if (!member) res.status(404).json("The member with given id not found");
    var string=JSON.stringify(member);
    let ans = JSON.parse(string);
    res.status(200).json(ans);
    console.log(">>Member: ", ans);
  });
};

exports.edit_member_by_id = (req, res) => {
  // get member to edit
  db.query("SELECT * FROM members", (err, members) => {
    if (err) throw err;
    console.log(members);
    let member = members.find(
      (m) => m.member_id === parseInt(req.params.member_id)
    );
    if (!member) res.status(404).json({message:"The member with given id not found"});
  });
  // update member
  let sqli = `UPDATE members SET password = ? WHERE member_id = ${req.params.member_id}`;
  let value = [bcrypt.hashSync(req.body.password, 10)];
  db.query(sqli, [value], (er, result) => {
    if (er) throw er;
    console.log(result);
    res.status(200).json({ status: 200, message: "member updated" });
  });
};

exports.insert_member = (req, res) => {
  let sql =
    "INSERT INTO members (firstname, lastname, phone, address, email, password) VALUES ?";
  let values = [
    [
      req.body.firstname,
      req.body.lastname,
      req.body.phone,
      req.body.address,
      req.body.email,
      bcrypt.hashSync(req.body.password, 10),
    ],
  ];
  db.query("SELECT * FROM members WHERE email = ?",req.body.email , (err, result) => {
    if (err) throw err;
    var string=JSON.stringify(result);
    let ans = JSON.parse(string);
    if(ans.length === 0){
      // Email is not taken
      console.log("Email available");
      db.query(sql, [values], (err, result) => {
        if (!err) {
          
          let transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
              user: 'm.ibiminagroup@gmail.com',
              pass: 'ibimina2020'
            }
          });
          const emailToken = jwt.sign({email: `${req.body.email}`},"123456789",{expiresIn: '1h'});
            let url = `http://localhost:4000/api/confirm/${emailToken}`;
            let mailOptions = {
              from: 'm.ibiminagroup@gmail.com',
              to: req.body.email,
              subject: 'Sending Email using Node.js',
              html: `Please click this to confirm :<a href="${url}">${url}</a>`
            };
              transporter.sendMail(mailOptions, function(error, info){
                if (error) {
                  console.log(error);
                } else {
                  console.log('Email sent: ' + info.response);
                }
              });
          

          res.status(200).json({ status: 200, message: "member inserted" });
          console.log("Inserted" + result.affectedRows);
        } else {
          res.status(404).json({ err });
        }
      });
      // res.status(200).send(ans);
    }else{
      // email is taken
      res.status(403).json({
        status: 403,
        message: "This email address is not available, Try new email"
      });
      console.log("Email Not available");
    }
  });

};

exports.delete_member = (req, res) => {
  // get member to edit
  db.query("SELECT * FROM members", (err, members) => {
    if (err) throw err;
    console.log(members);
    let member = members.find(
      (m) => m.member_id === parseInt(req.params.member_id)
    );
    if (!member) res.status(404).json("The member with given id not found");
  });

  //delete
  // update member
  let sqli = `DELETE FROM members WHERE member_id = ${req.params.member_id}`;
  // let value = [];
  db.query(sqli, (er, result) => {
    if (er) throw er;
    res.status(200).json({ status: 200, message: "Member Deleted" });
    // console.log(result);
  });
};



// For Ibimina

exports.ibimina_get_all = (req, res) => {
  db.query("SELECT * FROM ibimina ORDER BY created_at DESC", (err, result) => {
    if (err) throw err;
    let string=JSON.stringify(result);
    let ans = JSON.parse(string);
    console.log(ans);
    res.status(200).send(ans);
  });
};



exports.insert_ikimina = (req, res) => {

  let access_token = req.headers['authorization'];
  if(!access_token) return res.status(401).send({
    auth: false, msg:"No Token"
  });
  const bearer = access_token.split(" ");
  const bearerToken = bearer[1];
  token = bearerToken;
  console.log(token);

  jwt.verify(token, "Gustavo@125", function(err, decoded){
    if(err) return res.status(500).send({auth: false,msg:"failed to auth"});
      let string=JSON.stringify(decoded);
      let ans = JSON.parse(string);
      // console.log(ans); 
      // res.status(200).send(ans)
      let user = ans.result[0].member_id;
      console.log("user == ",user);
      let sql =
      "INSERT INTO ibimina (member_id ,brand_name, phone, address, about) VALUES ?";
      let values = [
        [
          user,
          req.body.brand_name,
          req.body.phone,
          req.body.address,
          req.body.about
        ],
      ];
    
      db.query("SELECT * FROM ibimina WHERE brand_name = ?",req.body.brand_name , (err, result) => {
        if (err) throw err;
        var string=JSON.stringify(result);
        let ans = JSON.parse(string);
        if(ans.length === 0){
          // Brand_name is not taken
          console.log("brand_name available");
          
          db.query(sql, [values], (err, result) => {
            if (!err) {
              res.status(200).json({ status: 200, message: "ikimina inserted" });
              // Add loggedin member to rowsin table
              let sqli = "INSERT INTO rowsins (member_id , ikimina_id) VALUES ?";
              let datas = [
                [
                  user,
                  result.insertId
                ],
              ];
              db.query(sqli,[datas], (e , rows) => {
                if(e) return e;
              });
              // Add Membership
              let sq = "INSERT INTO membership (member_id , ikimina_id) VALUES ?";
              let info = [
                [
                  user,
                  result.insertId
                ],
              ];
              db.query(sq,[info], (e , inf) => {
                if(!e) return e;
              });

              console.log("Inserted" + result.affectedRows);
            } else {
              res.status(404).json({ err, user });
            }
          });
          // res.status(200).send(ans);
        }else{
          // brand_name is taken
          res.status(403).json({
            status: 403,
            message: "This brand_name is not available, Try new brand_name"
          });
          console.log("Brand_name Not available");
        }
      });
  });



};

exports.verifyUser = (req, res) => {
  console.log(req.params.token);
  try {
    const {email: email}  = jwt.verify(req.params.token, "123456789");
    console.log(email);
    db.query("UPDATE members SET status=1 WHERE email= ?",email, (e , inf) => {
      if(!e) return res.redirect('/api/login');
      res.redirect('/');
      console.log(e);
    });
  } catch (e) {
    console.log(e);
  }
};

// Send membership request into a specific ikimina
exports.membershipRequest = (req, res) => {
  let access_token = req.headers['authorization'];
  if(!access_token) return res.status(401).send({
    auth: false, msg:"No Token"
  });
  const bearer = access_token.split(" ");
  const bearerToken = bearer[1];
  token = bearerToken;
  jwt.verify(token, "Gustavo@125", function(err, decoded){
    if(err) return res.status(500).send({auth: false,msg:"failed to auth"});
      let string=JSON.stringify(decoded);
      let ans = JSON.parse(string);

      let user = ans.result[0].member_id;
      let quer = "SELECT * FROM membership_request WHERE member_id= "+user+" AND ikimina_id= "+req.body.ikimina_id;

      db.query(quer, (e , rows) => {
        if(e) return res.status(404).json(e);
        if(rows.length > 0){
          res.status(400).json({status: 400,msg:"membership request already exist"});
        }else{
          let sqli = "INSERT INTO membership_request (member_id , ikimina_id) VALUES ?";
          let datas = [
            [
              user,
              req.body.ikimina_id,
            ],
          ];
          db.query(sqli,[datas], (e , rows) => {
            if(e) return e;
            res.status(200).json({status: 200,msg:'membership request inserted'});
          });
        }

      });
  });
};

// Make deposit into specific ikimina
exports.membershipDeposit = (req, res) => {
  let access_token = req.headers['authorization'];
  if(!access_token) return res.status(401).send({
    auth: false, msg:"No Token"
  });
  const bearer = access_token.split(" ");
  const bearerToken = bearer[1];
  token = bearerToken;
  jwt.verify(token, "Gustavo@125", function(err, decoded){
    if(err) return res.status(500).send({auth: false,msg:"failed to auth"});
      let string=JSON.stringify(decoded);
      let ans = JSON.parse(string);

      let user = ans.result[0].member_id;
          let sqli = "INSERT INTO deposits (member_id , ikimina_id, amount) VALUES ?";
          let datas = [
            [
              user,
              req.body.ikimina_id,
              req.body.amount,
            ],
          ];
          db.query(sqli,[datas], (e , rows) => {
            if(e) return e;
            res.status(200).json({status: 200,msg:'Deposit accepted'});
          });

      });
  };


// Check membership
  exports.membership = (req, res) => {
    let access_token = req.headers['authorization'];
    if(!access_token) return res.status(401).send({
      auth: false, msg:"No Token"
    });
    const bearer = access_token.split(" ");
    const bearerToken = bearer[1];
    token = bearerToken;
    jwt.verify(token, "Gustavo@125", function(err, decoded){
      if(err) return res.status(500).send({auth: false,msg:"failed to auth"});
        let string=JSON.stringify(decoded);
        let ans = JSON.parse(string);
  
        let user = ans.result[0].member_id;
            let sqli = "SELECT * FROM membership WHERE member_id=?";
            let datas = [
              [
                user
              ],
            ];
            db.query(sqli,[datas], (err , rows) => {
              if (err) throw err;
              var string=JSON.stringify(rows);
              let ans = JSON.parse(string);
              for(let i = 0; i < ans.length; i++){
                db.query("SELECT * FROM ibimina WHERE ikimina_id =?",ans[i].ikimina_id, (e,result) => {
                  let str=JSON.stringify(result);
                  let ikimina = JSON.parse(str);
                  console.log(ikimina);
                  // res.json({ikimina: ikimina);
                });
              }
              res.send(ans);
            });
  
        });
    };
// exports.test = (req, res) => {
//   let access_token = req.headers['authorization'];
//   if(!access_token) return res.status(401).send({
//     auth: false, msg:"No Token"
//   });
//   const bearer = access_token.split(" ");
//   const bearerToken = bearer[1];
//   token = bearerToken;
//   console.log(token);

//   jwt.verify(token, "Gustavo@125", function(err, decoded){
//     if(err) return res.status(500).send({auth: false,msg:"failed to auth"});
//       let string=JSON.stringify(decoded);
//       let ans = JSON.parse(string);
//       console.log(ans); 
//       res.status(200).json(ans.result[0].member_id)
//   });

// };





  exports.test = (req, res) => {

  let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'm.ibiminagroup@gmail.com',
      pass: 'ibimina2020'
    }
  });
  
  let mailOptions = {
    from: 'm.ibiminagroup@gmail.com',
    to: 'muhozagustave1213@gmail.com',
    subject: 'Sending Email using Node.js',
    text: 'That was easy!'
  };
  
  transporter.sendMail(mailOptions, function(error, info){
    if (error) {
      console.log(error);
    } else {
      console.log('Email sent: ' + info.response);
    }
  });

};

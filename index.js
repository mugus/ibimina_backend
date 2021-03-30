const express = require("express");
const app = express();
const cors = require('cors');
app.use(cors())
// const env = require("./config/env");
const routes = express.Router();
const api = require("./routes/apis");
app.use(express.json());
app.use("/", routes);
app.use("/api", api);

app.get("/", (req, res) => {
  res.json(
    {
      Author:"Gustave MUHOZA",
      content: "Help rural area development through saving in local cooperatives known as Ibimina",
      message:"Welcome to M-Ibimina Backend System"
    }
  );
});

const port = process.env.PORT || 3000;
app.listen(port, () => console.log(`listening on ${port}.....`));

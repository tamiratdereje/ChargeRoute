

const app = require('express');


const cors = require("cors");


app.use(cors());


app.use(express.json());
app.use(express.urlencoded({ extended: false }));



// Handle URL which don't exist
app.use("*", (req, res, next) => {

    return res.status(200).json({
        statu: "Success",
        data : {
            hello : "hello world"
        }
    })
    
  });
  


  module.exports = app;
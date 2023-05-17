// A configuration file that reads from the environment variables

// Dotenv
const dotenv = require("dotenv");
dotenv.config({ path: ".env" });

// Export config variables
module.exports = {
  env: process.env.NODE_ENV,
  db: {
    remote: process.env.DB_REMOTE,
  },
  jwt: {
    secret: process.env.JWT_SECRET,
    expiresIn: process.env.JWT_EXPIRESIN,
  },
};

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
  sms: {
    api_key: process.env.SMS_API_KEY,
  },
  cloudinary: {
    cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
    api_key: process.env.CLOUDINARY_API_KEY,
    api_secret: process.env.CLOUDINARY_SECRET,
  },
  payment: {
    chapa: process.env.CHAPA,
  },
};

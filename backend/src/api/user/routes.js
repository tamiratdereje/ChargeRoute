
const express = require("express");
const router = express.Router();
const {protect, authorize} = require('../../middleware/auth.js')

const userController = require("./contoller.js");

router.route("/")
        .post(userController.register)
        .get(protect, userController.getMe)
        .delete(protect, userController.deleteUser);


router.route("/login")
        .post(userController.login);

router.route("/changePassword")
        .post(protect, userController.changePassword);
router.route("/all")
        .get(userController.getAllUsers);

module.exports = router;
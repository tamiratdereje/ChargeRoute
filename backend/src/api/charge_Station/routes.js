const express = require("express");

const chargeStationController = require("./contoller");
const router = express.Router();

const {protect, authorize} = require('../../middleware/auth.js')

router.route("/")
                .post(protect, chargeStationController.createChargeStation)
                .get(protect, chargeStationController.getMyChargeStations)


router.route("/:id")
                .get(protect, chargeStationController.getChargeStation)
                .delete(protect, chargeStationController.deleteChargeStation)
                .update(protect, chargeStationController.updateChargeStation)

router.route("/all")
                .get(protect, chargeStationController.getAllChargeStation)

router.route("/rate")
                .post(protect, chargeStationController.rateChargeStation)


module.exports = router;
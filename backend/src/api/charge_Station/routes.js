const express = require("express");

const chargeStationController = require("./contoller");
const router = express.Router();

const {protect, authorize} = require('../../middleware/auth.js')

router.route("/")
                .post(protect, authorize("provider"), chargeStationController.createChargeStation)
                .get(protect, chargeStationController.getMyChargeStations)


router.route("/:id")
                .get(protect, chargeStationController.getChargeStation)
                .delete(protect, chargeStationController.deleteChargeStation)
                .patch(protect, chargeStationController.updateChargeStation)

router.route("/all")
                .get(chargeStationController.getAllChargeStation)

router.route("/rate")
                .post(protect, chargeStationController.rateChargeStation)

router.route("/search")
                .post(protect, chargeStationController.getNearChargeStations)

module.exports = router;
const express = require("express");

const chargeStationController = require("./contoller");
const router = express.Router();

router.route("/")
                .post(chargeStationController.createChargeStation)
                .get(chargeStationController.getMyChargeStations)


router.route("/:id")
                .get(chargeStationController.getChargeStation)
                .delete(chargeStationController.deleteChargeStation)
                .update(chargeStationController.updateChargeStation)

router.route("/all")
                .get(chargeStationController.getAllChargeStation)

router.route("/rate")
                .post(chargeStationController.rateChargeStation)


module.exports = router;
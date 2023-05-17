const { ChargeStation, Rating } = require("./model.js");

const AppError = require("../../utils/apperror.js");


// create
exports.createChargeStation = async (req, res, next) => {
  req.body.user = req.user_id;
  if (!req.body) {
    return next(new AppError("Request body is missing", 400));
  }

  const chargeStation = await ChargeStation.findOne({ phone: req.body.phone });
  if (chargeStation) {
    return next(new AppError("chargeStation already exist", 400));
  }

  try {
    // create chargeStation_
    const chargeStation_ = await ChargeStation.create(req.body);

    return res.status(200).json({
      data: chargeStation_,
      success: true,
    });
  } catch (error) {
    next(new AppError("Server Error", 500));
  }
};

// update chargeStation_
exports.updateChargeStation = async (req, res, next) => {
  try {
    const getChargeStation = await ChargeStation.findById(req.params.id);

    if (!getChargeStation) {
      return next(
        new new AppError("There is no charge station with this id", 400)()
      );
    }

    const chargeStation = await ChargeStation.findByIdAndUpdate(
      req.params.id,
      req.body,
      {
        runValidators: true,
        new: true,
      }
    );

    return res.status(200).json({
      data: chargeStation,
      success: true,
    });
  } catch (error) {
    next(new AppError("Server Error", 500));
  }
};



// Delete chargeStation_
exports.deleteChargeStation = async (req, res, next) => {
    try {
      const getChargeStation = await ChargeStation.findById(req.params.id);
      if (!getChargeStation)
        return next(new AppError("There is no idea with the specified id", 400));
  
      await ChargeStation.findByIdAndDelete(req.params.id);
  
      return res.status(200).json({
        success: true,
      });

    } catch (error) {
      next(new AppError("server error", 500));
    }
  };


  
// get chargeStation_
exports.getChargeStation = async (req, res, next) => {
    try {
      const chargeStation = await ChargeStation.findById(req.params.id);
  
      // Respond
      return res.status(200).json({
        success: true,
        data: chargeStation,
      });

    } catch (error) {
      next(error);
    }
  };
  
  // get chargeStation_
  exports.getAllChargeStation = async (_, res, next) => {
    try {
     const chargeStations = await ChargeStation.find();
    
     // Respond
     return res.status(200).json({
        success: true,
        data: chargeStations,
      });
      
    } catch (error) {
      next(error);
    }
  };
  
  
  exports.getMyChargeStations = async (req, res, next) => {
    try {
      const chargeStations = await ChargeStation.find({ user: req.user_id });
       // Respond
     return res.status(200).json({
        success: true,
        data: chargeStations,
      });

    } catch (error) {
      next(error);
    }
  };

  
  exports.getNearChargeStations = async (req, res, next) => {
    try {
      const {address} = req.body

      if (!address){
        return next(new AppError("There is no address given", 400));
      }

      const chargeStations = await ChargeStation.find({ address: {$regex: address}});
    
       // Respond
     return res.status(200).json({
        success: true,
        data: chargeStations,
      });

    } catch (error) {
      next(error);
    }
  };

  



// create
exports.rateChargeStation = async (req, res, next) => {

  req.body.user = req.user_id;
  
  if (!req.body) {
    return next(new AppError("Request body is missing", 400));
  }


  try {
    // create rating
    const rating = await Rating.create(req.body);

    return res.status(200).json({
      data: rating,
      success: true,
    });
  } catch (error) {
    next(new AppError("Server Error", 500));
  }
};
const { ChargeStation, Rating, Comment } = require("./model.js");
const User = require("../user/model.js");
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
    console.log(error);
    next(new AppError("server error", 500));
  }
};

// get user by id
const getUserByid = async (id) => {
  return await User.findById(id)

}


const getChargeStationByIdFromDb = async (id, user_id) => {
  const chargeStation = await ChargeStation.findById(id).populate({
    path: 'comments'
  });


  var ratingSum = 0;

  const ratings = await Rating.find({ chargeStation: chargeStation._id })
  var ratingSum = 0;
  var voted = -1;
  for (var i = 0; i < ratings.length; i++) {
    ratingSum += ratings[i].rating
    if (ratings[i].user === user_id) {
      voted = ratings[i].rating
    }
  }

  console.log(ratingSum)

  var count = ratings.length
  if (count === 0) {
    count = 1;
  }
  var new_comments = []

  for (var i = 0; i < chargeStation.comments.length; i += 1) {
    var commentor = await getUserByid(chargeStation.comments[i].commentor)
    if (commentor) {

      var new_single_comments = {
        "name": commentor.name,
        "commentor": chargeStation.comments[i].commentor,
        "description": chargeStation.comments[i].description,
        "_id": chargeStation.comments[i]._id,
        "chargeStation": chargeStation.comments[i].chargeStation
      }

      new_comments.push(new_single_comments)
    }

  }


  console.log(chargeStation);
  return {
    _id: chargeStation._id,
    name: chargeStation.name,
    description: chargeStation.description,
    phone: chargeStation.phone,
    address: chargeStation.address,
    user: chargeStation.user,
    rating: ratingSum / count,
    voted: voted,
    comments: new_comments,
    wattage: chargeStation.wattage,
  };
};



// get chargeStation_
exports.getChargeStation = async (req, res, next) => {
  try {
    return res.status(200).json({
      success: true,
      data: await getChargeStationByIdFromDb(req.params.id, req.user_id),
    });

  } catch (error) {
    next(error);
  }
};

// get chargeStation_
exports.getAllChargeStation = async (_, res, next) => {

  try {
    const chargeStations = await ChargeStation.find();

    var output = []
    for (var chargeStation of chargeStations) {
      var voted = -1;
      const ratings = await Rating.find({ chargeStation: chargeStation._id })
      var ratingSum = 0;
      for (var i = 0; i < ratings.length; i++) {
        ratingSum += ratings[i].rating

        if (ratings[i].user === req.user_id) {
          voted = ratings[i].rating
        }
      }
      console.log(ratingSum)

      var count = ratings.length
      if (count === 0) {
        count = 1;
      }



      var newObect = {
        _id: chargeStation._id,
        name: chargeStation.name,
        description: chargeStation.description,
        phone: chargeStation.phone,
        address: chargeStation.address,
        user: chargeStation.user,
        rating: ratingSum / count,
        voted: voted
      }
      console.log(newObect)
      output.push(newObect);


    }


    return res.status(200).json({
      success: true,
      data: output,
    });

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

    var output = []
    for (var chargeStation of chargeStations) {

      const ratings = await Rating.find({ chargeStation: chargeStation._id })
      var ratingSum = 0;
      var voted = -1;
      for (var i = 0; i < ratings.length; i++) {
        ratingSum += ratings[i].rating
        if (ratings[i].user === req.user_id) {
          voted = ratings[i].rating
        }
      }
      console.log(ratingSum)

      var count = ratings.length
      if (count === 0) {
        count = 1;
      }



      var newObect = {
        _id: chargeStation._id,
        name: chargeStation.name,
        description: chargeStation.description,
        phone: chargeStation.phone,
        address: chargeStation.address,
        user: chargeStation.user,
        rating: ratingSum / count,
        voted: voted
      }
      console.log(newObect)
      output.push(newObect);


    }


    return res.status(200).json({
      success: true,
      data: output,
    });

  } catch (error) {
    next(error);
  }
};


exports.getNearChargeStations = async (req, res, next) => {
  try {
    const { address } = req.body

    if (!address) {
      return next(new AppError("There is no address given", 400));
    }

    const chargeStations = await ChargeStation.find({ address: { $regex: address } }).populate({
      path: 'comments'
    });

    var output = []
    for (var chargeStation of chargeStations) {

      const ratings = await Rating.find({ chargeStation: chargeStation._id })
      var ratingSum = 0;
      var voted = -1;
      for (var i = 0; i < ratings.length; i++) {
        ratingSum += ratings[i].rating
        if (ratings[i].user === req.user_id) {
          voted = ratings[i].rating
        }
      }
      console.log(ratingSum)

      var count = ratings.length
      if (count === 0) {
        count = 1;
      }

      var newObect = {
        _id: chargeStation._id,
        name: chargeStation.name,
        description: chargeStation.description,
        phone: chargeStation.phone,
        address: chargeStation.address,
        user: chargeStation.user,
        rating: ratingSum / count,
        voted: voted,
        comments: chargeStation.comments,
        wattage: chargeStation.wattage
      }
      console.log(newObect)
      output.push(newObect);


    }


    return res.status(200).json({
      success: true,
      data: output,
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

    const prevRating = await Rating.findOne({ chargeStation: req.body.chargeStation, user: req.body.user });

    if (prevRating) {
      // update rating
      const rating = await Rating.findByIdAndUpdate(
        prevRating._id,
        req.body,
        {
          runValidators: true,
          new: true,
        });

      return res.status(200).json({
        data: await getChargeStationByIdFromDb(req.body.chargeStation, req.user_id),
        success: true,
      });
    }
    // create rating
    const rating = await Rating.create(req.body);

    return res.status(200).json({
      data: await getChargeStationByIdFromDb(req.body.chargeStation, req.user_id),
      success: true,
    });
  } catch (error) {
    next(new AppError("Server Error", 500));
  }
};


// unrate
exports.unRateChargeStation = async (req, res, next) => {

  // const 
  const ratingId = req.body.ratingId;
  const chargeStationId = req.body.chargeStationId;

  if (!ratingId || chargeStationId) {
    return next(new AppError("Request body is missing", 400));
  }

  try {
    // create rating

    const rating = await Rating.findById(ratingId);
    if (!rating) {
      return next(new AppError("no rating with given id", 400));
    }

    prevRating = rating.rating;

    const chargeStation = await ChargeStation.findById(chargeStationId);
    if (!chargeStation) {
      return next(new AppError("no chargeStation with given id", 400));
    }

    chargeStation.rating


    return res.status(200).json({
      data: rating,
      success: true,
    });
  } catch (error) {
    next(new AppError("Server Error", 500));
  }
};

// create
exports.commentChargeStation = async (req, res, next) => {

  const comment = {
    "commentor": req.user_id,
    "description": req.body.description,
    "chargeStation": req.body.chargeStation
  }

  if (!req.body.chargeStation || !req.body.description) {
    return next(new AppError("Request body is missing", 400));
  }


  try {
    // create comment
    const createComment = await Comment.create(comment);
    return res.status(200).json({
      data: createComment,
      success: true,
    });
  } catch (error) {
    next(new AppError("Server Error", 500));
  }
};


// delete comment 
exports.deleteComment = async (req, res, next) => {

  const commentId = req.body.commentId;

  if (!commentId) {
    return next(new AppError("Request body is missing", 400));
  }

  try {
    // delete comment
    const comment = await Comment.findByIdAndDelete(commentId);

    return res.status(200).json({
      data: comment,
      success: true,
    });

  }
  catch (error) {
    next(new AppError("Server Error", 500));
  }
};

// update comment
exports.updateComment = async (req, res, next) => {
  const commentId = req.body.commentId;
  const description = req.body.description;

  if (!commentId || !description) {
    return next(new AppError("Request body is missing", 400));
  }

  try {
    // update comment
    const comment = await Comment.findByIdAndUpdate(
      commentId,
      req.body,
      {
        runValidators: true,
        new: true,
      });

    return res.status(200).json({
      data: comment,
      success: true,
    });

  } catch (error) {
    next(new AppError("Server Error", 500));
  }

}
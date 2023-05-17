
// ID: Unique identifier for each charging station
// Name: Charging station name
// Address: Charging station address
// Latitude: Latitude of the charging station location
// Longitude: Longitude of the charging station location
// Plug Types: Compatible plug types available at the charging station
// Rating: Average rating given by users for the charging station
const mongoose = require('mongoose');


const ChargeStationSchema = new mongoose.Schema({

    name: {
        type: String,
        required : [true, "Please add a name"],
        unique: true,
        trim: true,
        maxlength : [50, 'Name can not be more than 50 characters']
    },

    description:{
        type: String,
        required : [true, "Please add a description"],
        maxlength : [500, 'Name can not be more than 50 characters']
    },

    
    phone: {
      type: String,
      maxlength: [20, 'Phone number can not be longer than 20 characters'],
      unique: true
    },

    rating : {
      type: Number,
    },

    address: {
      type: String,
      required: [true, 'Please add an address']
    },
      
    user: {
      type: mongoose.Schema.ObjectId,
      ref: 'User',
      required: true
    }
});


const RatingSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  chargeStation: { type: mongoose.Schema.Types.ObjectId, ref: 'ChargeStation', required: true },
  rating: { type: Number, required: true, min: 1, max: 5 }
});


RatingSchema.pre('save', async function(next) {

  const Rating = mongoose.model('Rating');
  const ChargeStationMain = mongoose.model('ChargeStation');

  const rating = this;

  // Get all ratings for this item
  const ratings = await Rating.find({ chargeStation: rating.chargeStation });

  // Calculate the average rating
  const sum = ratings.reduce((total, rating) => total + rating.rating, 0);
  const avg = sum / ratings.length;

  // Update the average rating on the item object
  const chargeStationMain = await ChargeStationMain.findById(rating.chargeStation);
  chargeStationMain.averageRating = avg;
  await chargeStationMain.save();

  next();
});


const ChargeStation = mongoose.model('ChargeStation', ChargeStationSchema);
const Rating = mongoose.model('Rating', RatingSchema);


module.exports = {
  ChargeStation: ChargeStation,
  Rating: Rating
}
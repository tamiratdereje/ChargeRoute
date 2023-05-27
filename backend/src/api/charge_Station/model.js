
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
    required: [true, "Please add a name"],
    unique: true,
    trim: true,
    maxlength: [50, 'Name can not be more than 50 characters']
  },
  description: {
    type: String,
    required: [true, "Please add a description"],
    maxlength: [500, 'Name can not be more than 50 characters']
  },
  phone: {
    type: String,
    maxlength: [20, 'Phone number can not be longer than 20 characters'],
    unique: true
  },
  address: {
    type: String,
    required: [true, 'Please add an address']
  },
  wattage: {
    type: Number,
    required: true
  },
  user: {
    type: mongoose.Schema.ObjectId,
    ref: 'User',
    required: true
  }
},
  {
    toJSON: { virtuals: true },
    toObject: { virtuals: true }
  }
);

ChargeStationSchema.virtual('comments', {
  ref: 'Comment',
  localField: '_id',
  foreignField: 'chargeStation',
  justOne: false
});

const RatingSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  chargeStation: { type: mongoose.Schema.Types.ObjectId, ref: 'ChargeStation', required: true },
  rating: { type: Number, required: true, min: 1, max: 5 }
});

const CommentSchema = new mongoose.Schema({
  commentor: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  chargeStation: { type: mongoose.Schema.Types.ObjectId, ref: 'ChargeStation', required: true },
  description: {
    type: String,
    required: [true, "Please add a description"],
    maxlength: [500, 'Name can not be more than 50 characters']
  },
});

const ChargeStation = mongoose.model('ChargeStation', ChargeStationSchema);
const Rating = mongoose.model('Rating', RatingSchema);
const Comment = mongoose.model('Comment', CommentSchema);

module.exports = {
  ChargeStation: ChargeStation,
  Rating: Rating,
  Comment: Comment
}
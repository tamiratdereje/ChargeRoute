
const bcrypt = require('bcryptjs');

const User = require('./model')
const AppError = require('../../utils/apperror')



exports.register = async (req, res, next) => {

    try {
        const user = await User.create(req.body);

        return res.status(200).json({
            success: true,
            data: user,
          });
        
    } catch (error) {
        next(new AppError("Server error", 500));
    }
    
};


exports.login = async (req, res, next) => {
    

    try {
        const { email, password } = req.body;
  
        // Validate emil & password
        if (!email || !password) {
          return next(new AppError('Please provide an email and password', 400));
        }
    
         // Check for user
         const user = await User.findOne({ email: email }).select('+password');
      
         if (!user) {
           return next(new AppError('Invalid credentials', 401));
         }
    
         // Check if password matches
        const isMatch = await user.matchPassword(password);
      
        if (!isMatch) {
          return next(new AppError('Invalid credentials', 401));
        }
    
        const token = user.getSignedJwtToken();
    
        res.status(200).json({
            success: true,
            data: user,
            token: token
          });
        
    } catch (error) {
        next(new AppError("Server error", 500));
    }

};



//  get me
exports.getMe = async (req, res, next) => {

    // user is already available in req due to the protect middleware
    const user = await User.find().populate({
      path:'chargeStations'
    });

  
    res.status(200).json({
      success: true,
      data: user,
    });
  };


// delete user
exports.deleteUser = async (req, res, next) => {

    try {
      const user = await User.findById(req.user_id);
      if (!user)
        return next(new AppError("There is no user with the specified id", 400));
  
      await User.findByIdAndDelete(req.params.id);
  
      return res.status(200).json({
        success: true,
      });

    } catch (error) {
      next(new AppError("server error", 500));
    }

  };

  
// change password

exports.changePassword = async (req, res, next) => {
    
    try {

      const {oldPassword, currentPassword} = req.body;
      const user = await User.findById(req.params.id);

      if (!user)
        return next(new AppError("There is no user with the specified id", 400));
      
      const isMatch = await user.matchPassword(oldPassword);

      if (isMatch) {
        user.password = currentPassword;
        await user.save();
      }

        
      return res.status(200).json({
        success: true,
      });

    } catch (error) {
      next(new AppError("server error", 500));
    }

  };

const jwt = require('jsonwebtoken');
const AppError = require('../utils/apperror');
const User = require('../api/user/model.js');

// Protect routes
exports.protect = async (req, res, next) => {

  let token;

  if (
    req.headers.authorization &&
    req.headers.authorization.startsWith('Bearer')
  ) {
    // Set token from Bearer token in header
    token = req.headers.authorization.split(' ')[1];
    // Set token from cookie
  }

  // Make sure token exists
  if (!token) {
    return next(new AppError('Not authorized to access this route', 401));
  }

  try {
    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.user = await User.findById(decoded.id);
    req.user_id = req.user._id
    if (!req.user){
      return next(new AppError('Not authorized to accccess this route', 401));

    }
    next();
  } catch (err) {
    return next(new AppError('Not authorized to access this route', 401));
  }
};


// Grant access to specific roles
exports.authorize = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.user.role)) {
      return next(
        new AppError(
          `User role ${req.user.role} is not authorized to access this route`,
          403
        )
      );
    }
    next();
  };
};
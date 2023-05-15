const AppError = require('../../utils/apperror');


const errorHandler = (err, req, res, next) => {
    console.log(err);
    let error =  { ...err };
    error.message = err.message;
    console.log(err.message, "lalla")
    
    // mongoose bad object
    if (err.name === 'CastError'){
        error = new AppError(`BootCamp CastError with id of ${err.value}`, 404);
    }
    else if (err.name === 'ReferenceError'){
        error = new AppError(`BootCamp ReferenceError with id of ${err.value}`, 404);
    }    
    // mongoose duplicate 
    else if (err.code === 11000) {
        const message = 'duplicate field value entered';
        error = new AppError(message, 400);
    } 
    // mongoose validator error
    else if (err.name === "ValidationError") {
        const message = Object.values(err.errors).map(val => val.message);
        error = new AppError(message, 400);
    }

    res.status(error.statusCode || 500).json({
        success: false,
        error : error.message || 'Server Error'
    })
}

module.exports = errorHandler;

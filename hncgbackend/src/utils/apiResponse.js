/**
 * Utility for standardizing API responses
 */

/**
 * Success Response
 * @param {*} res - Express response object
 * @param {*} data - Data to return
 * @param {string} message - Optional success message
 * @param {number} statusCode - HTTP status code (default: 200)
 */
const successResponse = (res, data = null, message = 'Thành công', statusCode = 200) => {
    return res.status(statusCode).json({
      success: true,
      message,
      data,
      timestamp: new Date().toISOString()
    });
  };
  
  /**
   * Error Response
   * @param {*} res - Express response object
   * @param {string} message - Error message
   * @param {number} statusCode - HTTP status code (default: 400)
   * @param {*} errors - Additional error details
   */
  const errorResponse = (res, message = 'Đã xảy ra lỗi', statusCode = 400, errors = null) => {
    return res.status(statusCode).json({
      success: false,
      message,
      errors,
      timestamp: new Date().toISOString()
    });
  };
  
  /**
   * Validation Error Response (422 Unprocessable Entity)
   * @param {*} res - Express response object 
   * @param {*} errors - Validation errors (typically from express-validator)
   */
  const validationErrorResponse = (res, errors) => {
    return res.status(422).json({
      success: false,
      message: 'Xác thực không thành công',
      errors: errors.array ? errors.array() : errors,
      timestamp: new Date().toISOString()
    });
  };
  
  /**
   * Not Found Response (404)
   * @param {*} res - Express response object
   * @param {string} message - Optional custom message
   */
  const notFoundResponse = (res, message = 'Không tìm thấy tài nguyên') => {
    return res.status(404).json({
      success: false,
      message,
      timestamp: new Date().toISOString()
    });
  };
  
  /**
   * Unauthorized Response (401)
   * @param {*} res - Express response object
   * @param {string} message - Optional custom message
   */
  const unauthorizedResponse = (res, message = 'Không được phép') => {
    return res.status(401).json({
      success: false,
      message,
      timestamp: new Date().toISOString()
    });
  };
  
  module.exports = {
    successResponse,
    errorResponse,
    validationErrorResponse,
    notFoundResponse,
    unauthorizedResponse
  };
const express = require('express');
const { check } = require('express-validator');
const authController = require('../controllers/auth.controller');
const { authenticate } = require('../middlewares/auth.middleware');

const router = express.Router();

// Đăng nhập
router.post('/login', 
  [
    check('email').isEmail().withMessage('Invalid email format'),
    check('password').notEmpty().withMessage('Password is required')
  ],
  authController.login
);

// Đăng ký
router.post('/register',
  [
    check('username').notEmpty().withMessage('Username is required'),
    check('email').isEmail().withMessage('Invalid email format'),
    check('password')
      .isLength({ min: 6 })
      .withMessage('Password must be at least 6 characters')
  ],
  authController.register
);

// Lấy thông tin profile (yêu cầu xác thực)
router.get('/profile', authenticate, authController.getProfile);

module.exports = router;
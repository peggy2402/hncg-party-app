const express = require('express');
const router = express.Router();
const authController = require('../controllers/auth.controller');
const { check } = require('express-validator');

// 👇 Định nghĩa routes KHÔNG thêm tiền tố /api/v1/auth ở đây
router.post(
  '/register',
  [
    check('username')
      .notEmpty().withMessage('Vui lòng nhập username')
      .isLength({ min: 3 }).withMessage('Username phải có ít nhất 3 ký tự'),
    check('email')
      .notEmpty().withMessage('Vui lòng nhập email')
      .isEmail().withMessage('Email không hợp lệ'),
    check('password')
      .notEmpty().withMessage('Vui lòng nhập mật khẩu')
      .isLength({ min: 6 }).withMessage('Mật khẩu phải có ít nhất 6 ký tự')
  ],
  authController.register
);

router.post(
  '/login',
  [
    check('identifier').notEmpty().withMessage('Vui lòng nhập email hoặc username'),
    check('password').notEmpty().withMessage('Vui lòng nhập mật khẩu')
  ],
  authController.login
);

router.get('/profile', authController.getProfile);

module.exports = router;
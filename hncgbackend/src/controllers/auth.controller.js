const { successResponse, errorResponse, validationErrorResponse } = require('../utils/apiResponse');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const pool = require('../config/db');
const { validationResult } = require('express-validator');

// Helper: Tạo JWT token
const generateToken = (userId) => {
  return jwt.sign(
    { userId },
    process.env.JWT_SECRET,
    { expiresIn: '1h' }
  );
};

// Helper: Lấy user từ DB
const getUserByEmail = async (email) => {
  const query = 'SELECT * FROM users WHERE email = $1';
  const { rows } = await pool.query(query, [email]);
  return rows[0];
};

exports.login = async (req, res) => {
  try {
    // 1. Validate input
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return validationErrorResponse(res, errors);
    }

    const { email, password } = req.body;

    // 2. Kiểm tra user tồn tại
    const user = await getUserByEmail(email);
    if (!user) {
      return errorResponse(res, 'Thông tin đăng nhập không hợp lệ', 401);
    }

    // 3. Verify password
    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return errorResponse(res, 'Thông tin đăng nhập không hợp lệ', 401);
    }

    // 4. Tạo token
    const token = generateToken(user.id);

    // 5. Cập nhật last_login (tuỳ chọn)
    await pool.query(
      'UPDATE users SET last_login = NOW() WHERE id = $1',
      [user.id]
    );

    // 6. Trả về response
    return successResponse(res, {
      user: {
        id: user.id,
        username: user.username,
        email: user.email,
        avatar_url: user.avatar_url
      },
      token
    }, 'Đăng nhập thành công', 200);

  } catch (err) {
    console.error('Lỗi đăng nhập:', err);
    return errorResponse(res, 'Lỗi máy chủ nội bộ', 500);
  }
};

exports.register = async (req, res) => {
  try {
    // 1. Validate input
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return validationErrorResponse(res, errors);
    }

    const { username, email, password } = req.body;

    // 2. Kiểm tra email đã tồn tại
    const existingUser = await getUserByEmail(email);
    if (existingUser) {
      return errorResponse(res, 'Email already exists', 400);
    }

    // 3. Mã hoá password
    const hashedPassword = await bcrypt.hash(password, 10);

    // 4. Tạo user mới
    const { rows } = await pool.query(
      `INSERT INTO users 
       (username, email, password, created_at, updated_at) 
       VALUES ($1, $2, $3, NOW(), NOW()) 
       RETURNING id, username, email, avatar_url`,
      [username, email, hashedPassword]
    );

    const newUser = rows[0];

    // 5. Tạo token
    const token = generateToken(newUser.id);

    // 6. Trả về response
    return successResponse(
      res, 
      {
        user: newUser,
        token
      },
      'Registration successful',
      201 // Created status code
    );

  } catch (err) {
    console.error('Registration error:', err);
    return errorResponse(res, 'Registration failed', 500);
  }
};

exports.getProfile = async (req, res) => {
  try {
    // Lấy user ID từ JWT
    const userId = req.userId;

    const { rows } = await pool.query(
      `SELECT id, username, email, avatar_url, bio, 
       gender, birthday, is_verified 
       FROM users WHERE id = $1`,
      [userId]
    );

    if (!rows.length) {
      return notFoundResponse(res, 'User not found');
    }

    return successResponse(res, rows[0]);

  } catch (err) {
    console.error('Get profile error:', err);
    return errorResponse(res, 'Failed to fetch profile', 500);
  }
};
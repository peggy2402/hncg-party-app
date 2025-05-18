const { successResponse, errorResponse, validationErrorResponse } = require('../utils/apiResponse');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
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

// Helper: Kiểm tra email tồn tại
const getUserByEmail = async (email) => {
  const { rows } = await pool.query(
    'SELECT * FROM users WHERE email = $1',
    [email]
  );
  return rows[0];
};

// Helper: Kiểm tra username tồn tại
const getUserByUsername = async (username) => {
  const { rows } = await pool.query(
    'SELECT * FROM users WHERE username = $1',
    [username]
  );
  return rows[0];
};

// Helper: Lấy user bằng email hoặc username
const getUserByIdentifier = async (identifier) => {
  const { rows } = await pool.query(
    'SELECT * FROM users WHERE email = $1 OR username = $1',
    [identifier]
  );
  return rows[0];
};

exports.login = async (req, res) => {
  try {
    console.log('Request body:', req.body);
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      console.log('Validation errors:', errors.array()); // Log lỗi validation
      return validationErrorResponse(res, errors);
    }

    const { identifier, password } = req.body; // ✅ Dùng identifier thay email

    // Tìm user bằng email HOẶC username
    const user = await pool.query(
      'SELECT * FROM users WHERE email = $1 OR username = $1',
      [identifier]
    );

    if (!user.rows[0]) {
      return errorResponse(res, 'Thông tin đăng nhập không hợp lệ', 401);
    }

    // Xác thực mật khẩu
    const validPassword = await bcrypt.compare(password, user.rows[0].password);
    if (!validPassword) {
      return errorResponse(res, 'Thông tin đăng nhập không hợp lệ', 401);
    }

    // Tạo token
    const token = jwt.sign(
      { userId: user.rows[0].id },
      process.env.JWT_SECRET,
      { expiresIn: '1h' }
    );

    // Trả response
    return successResponse(res, {
      user: {
        id: user.rows[0].id,
        username: user.rows[0].username,
        email: user.rows[0].email,
        avatar_url: user.rows[0].avatar_url
      },
      token
    });

  } catch (err) {
    console.error('Login error:', err);
    return errorResponse(res, 'Lỗi server');
  }
};

exports.register = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return validationErrorResponse(res, errors);
    }

    const { username, email, password } = req.body;

    // 1. Kiểm tra trùng lặp
    const [existingEmail, existingUsername] = await Promise.all([
      getUserByEmail(email),
      getUserByUsername(username)
    ]);

    if (existingEmail || existingUsername) {
      return errorResponse(res, 'Email hoặc username đã tồn tại');
    }

    // 2. Mã hóa mật khẩu
    const hashedPassword = await bcrypt.hash(password, 10);

    // 3. Tạo user mới
    const { rows } = await pool.query(
      `INSERT INTO users (username, email, password) 
       VALUES ($1, $2, $3)
       RETURNING id, username, email, avatar_url`,
      [username, email, hashedPassword]
    );

    // 4. Tạo token
    const token = generateToken(rows[0].id);

    return successResponse(res, {
      user: rows[0],
      token
    }, 'Đăng ký thành công', 201);

  } catch (err) {
    console.error('Lỗi đăng ký:', err);
    return errorResponse(res, 'Lỗi server: ' + err.message);
  }
};

exports.getProfile = async (req, res) => {
  try {
    const { rows } = await pool.query(
      `SELECT id, username, email, avatar_url, bio, 
       gender, birthday, is_verified 
       FROM users WHERE id = $1`,
      [req.userId]
    );

    if (!rows.length) {
      return errorResponse(res, 'Người dùng không tồn tại', 404);
    }

    return successResponse(res, rows[0]);

  } catch (err) {
    console.error('Lỗi lấy thông tin:', err);
    return errorResponse(res, 'Lỗi server: ' + err.message);
  }
};
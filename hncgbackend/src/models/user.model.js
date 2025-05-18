const pool = require('../config/db');
const bcrypt = require('bcryptjs');

const login = async (email, password) => {
  const query = `
    SELECT id, username, email, password 
    FROM users 
    WHERE email = $1
  `;
  const { rows } = await pool.query(query, [email]);
  
  if (rows.length === 0) throw new Error('Không tìm thấy người dùng');
  
  const isValid = await bcrypt.compare(password, rows[0].password);
  if (!isValid) throw new Error('Mật khẩu không hợp lệ');

  return {
    id: rows[0].id,
    username: rows[0].username,
    email: rows[0].email
  };
};

module.exports = { login };

-- =========================
-- USERS
-- =========================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar_url TEXT,
    bio TEXT,
    gender VARCHAR(10),
    birthday DATE,
    is_verified BOOLEAN DEFAULT FALSE,
    role VARCHAR(20) DEFAULT 'user',
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- FRIENDS / FOLLOWERS
-- =========================
CREATE TABLE friends (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    target_id INT REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'pending', -- pending, accepted, blocked
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- POSTS
-- =========================
CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    content TEXT,
    media_url TEXT,
    type VARCHAR(20), -- text, image, video
    privacy VARCHAR(20) DEFAULT 'public',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- COMMENTS
-- =========================
CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INT REFERENCES posts(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- LIKES
-- =========================
CREATE TABLE likes (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    likeable_id INT NOT NULL,
    likeable_type VARCHAR(20) NOT NULL, -- post or comment
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CHAT ROOMS
-- =========================
CREATE TABLE chat_rooms (
    id SERIAL PRIMARY KEY,
    is_group BOOLEAN DEFAULT FALSE,
    room_name VARCHAR(100),
    created_by INT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CHAT PARTICIPANTS
-- =========================
CREATE TABLE chat_participants (
    id SERIAL PRIMARY KEY,
    chat_room_id INT REFERENCES chat_rooms(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id) ON DELETE CASCADE,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- CHAT MESSAGES
-- =========================
CREATE TABLE chat_messages (
    id SERIAL PRIMARY KEY,
    chat_room_id INT REFERENCES chat_rooms(id) ON DELETE CASCADE,
    sender_id INT REFERENCES users(id),
    message_type VARCHAR(20), -- text, image, video
    message_content TEXT,
    media_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    read_at TIMESTAMP
);

-- =========================
-- LIVESTREAMS
-- =========================
CREATE TABLE livestreams (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    title VARCHAR(100),
    thumbnail_url TEXT,
    stream_key VARCHAR(100) UNIQUE,
    is_live BOOLEAN DEFAULT TRUE,
    viewer_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ended_at TIMESTAMP
);

-- =========================
-- LIVESTREAM VIEWERS
-- =========================
CREATE TABLE livestream_viewers (
    id SERIAL PRIMARY KEY,
    livestream_id INT REFERENCES livestreams(id) ON DELETE CASCADE,
    user_id INT REFERENCES users(id),
    joined_at TIMESTAMP,
    left_at TIMESTAMP
);

-- =========================
-- NOTIFICATIONS
-- =========================
CREATE TABLE notifications (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    type VARCHAR(50),
    data JSONB,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- REPORTS
-- =========================
CREATE TABLE reports (
    id SERIAL PRIMARY KEY,
    reporter_id INT REFERENCES users(id),
    target_type VARCHAR(20), -- user or post
    target_id INT NOT NULL,
    reason TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- BLOCKS
-- =========================
CREATE TABLE blocks (
    id SERIAL PRIMARY KEY,
    blocker_id INT REFERENCES users(id),
    blocked_id INT REFERENCES users(id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- SETTINGS
-- =========================
CREATE TABLE settings (
    id SERIAL PRIMARY KEY,
    user_id INT UNIQUE REFERENCES users(id),
    dark_mode BOOLEAN DEFAULT FALSE,
    notifications_enabled BOOLEAN DEFAULT TRUE,
    language VARCHAR(10) DEFAULT 'en',
    custom_settings JSONB
);

-- =========================
-- PAYMENTS
-- =========================
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    amount DECIMAL(10, 2),
    currency VARCHAR(10) DEFAULT 'USD',
    payment_method VARCHAR(50),
    type VARCHAR(50), -- gift, donate, top-up
    status VARCHAR(20) DEFAULT 'completed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =========================
-- GIFTS
-- =========================
CREATE TABLE gifts (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    image_url TEXT,
    value DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Gift transactions
CREATE TABLE user_gifts (
    id SERIAL PRIMARY KEY,
    sender_id INT REFERENCES users(id),
    receiver_id INT REFERENCES users(id),
    gift_id INT REFERENCES gifts(id),
    livestream_id INT REFERENCES livestreams(id),
    quantity INT DEFAULT 1,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

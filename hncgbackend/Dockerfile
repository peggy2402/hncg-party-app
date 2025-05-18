# Sử dụng image Debian-based
FROM node:18-bullseye

# Cài đặt build tools
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy package.json và cài đặt dependencies
COPY package*.json ./

# Build native modules từ source
RUN npm install --build-from-source --include=dev
# Cài đặt nodemon
RUN npm install -g nodemon
# Copy mã nguồn
COPY . .

CMD ["npm", "run", "dev"]
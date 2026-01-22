
# 1️⃣ Use lightweight Node.js 18 image
FROM node:18-alpine

# 2️⃣ Set working directory inside container
WORKDIR /app

# 3️⃣ Copy dependency files first for caching
COPY package*.json ./

# 4️⃣ Install production dependencies
RUN npm ci --only=production

# 5️⃣ Copy rest of the application code
COPY . .

# 6️⃣ Document the port your app listens on
EXPOSE 3000

# 7️⃣ Start the Node.js app
CMD ["node", "app.js"]

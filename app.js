const express = require('express');
const app = express();

// Simple route
app.get('/', (req, res) => {
    res.send('Hello from AfterLearning CI/CD Pipeline!');
});

// Listen on port 3000
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`App running on port ${PORT}`);
});

module.exports = app; // Useful if you want to write tests later



// Test Jenkins webhook update   i add this for checking wast sentence 

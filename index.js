const express = require('express');
const path = require('path');
const app = express();
const PORT = process.env.PORT || 3000;

// Serve static files from the 'dist' folder
app.use(express.static(path.join(__dirname, 'dist')));

// Handle all other routes by sending back the React index.html file
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'dist', 'index.html'));
});

// Listen on all interfaces (0.0.0.0) so Kubernetes / Docker can route traffic
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ Server is listening on port ${PORT}`);
});

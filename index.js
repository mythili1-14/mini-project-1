const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('✅ Brain Tasks App is running on port 3000');
});

app.listen(PORT, () => {
  console.log(`✅ Server is listening on port ${PORT}`);
});

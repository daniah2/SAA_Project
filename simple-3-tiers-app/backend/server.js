const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();

const connection = mysql.createConnection({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'admin',
    password: process.env.DB_PASS || 'admin',
    database: process.env.DB_NAME || 'visits_count_app',
    port: process.env.DB_PORT || 3306
});

connection.connect((error) => {
    if (error) throw error;
    console.log(`Connected to database at ${process.env.DB_HOST || 'localhost'}:${process.env.DB_PORT || 3306}`);
});

app.use(cors({
    origin: '*',
    methods: ['GET', 'POST', 'OPTIONS', 'PUT', 'DELETE'],
    allowedHeaders: ['Content-Type', 'Authorization', 'X-Requested-With', 'Accept', 'Origin'], // Include common headers
    credentials: false
}));

app.use(express.json());

app.get('/health', (req, res) => {
    connection.ping((error) => {
        if (error) {
            console.error('DB health check failed:', error);
            return res.status(500).json({
                status: 'Failed',
                data: 'Database connection failed!'
            });
        }

        res.status(200).json({
            status: 'Success',
            data: 'Database connection is healthy!'
        });
    });
});

app.post('/app', (req, res) => {
    connection.query('UPDATE visits SET count = count + 1 WHERE id = 1', (error) => {
        if (error) return res.status(500).json({ status: 'Failed', data: 'Error updating visit count' });

        connection.query('SELECT count FROM visits WHERE id = 1', (error, results) => {
            if (error) return res.status(500).json({ status: 'Failed', data: 'Error fetching visit count' });

            const visitCount = results[0].count;
            res.json({ status: 'Success', data: `Total Visits: ${visitCount}` });
        });
    });
});

app.listen(process.env.PORT || 3000, () => {
    console.log(`Server running on port ${process.env.PORT || 3000}...`);
});

const createTableQuery = `
CREATE TABLE IF NOT EXISTS visits (
  id INT PRIMARY KEY,
  count INT DEFAULT 0
);
`;

connection.query(createTableQuery, (error) => {
    if (error) {
        console.error("Error creating visits table:", error);
        process.exit(1);
    }
    console.log("Visits table checked/created");

    const insertInitialRow = `
    INSERT INTO visits (id, count)
    VALUES (1, 0)
    ON DUPLICATE KEY UPDATE count = count;
  `;

    connection.query(insertInitialRow, (err) => {
        if (err) {
            console.error("Error inserting initial visits row:", err);
            process.exit(1);
        }
        console.log("Initial visits row inserted/exists");
    });
});
import pg from 'pg';

const { Pool } = pg;

const connection = new Pool({
  connectionString: process.env.d94lrfmug95qij,
  ssl: {
      rejectUnauthorized: false
  }
});

export default connection;
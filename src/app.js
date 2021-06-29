import express from 'express';
import Joi from 'joi';
import bcrypt from 'bcrypt';
import connection from './database/database.js';
import cors from 'cors';
import { v4 as uuid } from 'uuid';

const app = express();
app.use(express.json());
app.use(cors());

export default app;
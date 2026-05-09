import { pool } from "./pool.js";

export const createTable = async () => {
  await pool.query(`
      DO $$ BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'user_role') THEN
          CREATE TYPE user_role AS ENUM('admin', 'viewer');
        END IF;
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_type') THEN
          CREATE TYPE payment_type AS ENUM('salary', 'advance');
        END IF;
        IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'payment_mode') THEN
          CREATE TYPE payment_mode AS ENUM('online', 'cash');
        END IF;
      END $$;
    `);

  // 2. Users
  await pool.query(`
      CREATE TABLE IF NOT EXISTS users(
        "user_id" BIGSERIAL PRIMARY KEY,
        "user_name" TEXT UNIQUE NOT NULL,
        "email" TEXT UNIQUE NOT NULL,
        "role" user_role NOT NULL,
        "password" TEXT NOT NULL,
        "created_at" TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

  // 3. Workers
  await pool.query(`
      CREATE TABLE IF NOT EXISTS workers(
        "w_id" BIGSERIAL PRIMARY KEY,
        "u_id" BIGINT REFERENCES users(user_id) ON DELETE CASCADE,
        "w_name" TEXT NOT NULL,
        "w_phone" TEXT NOT NULL
      );
    `);

  // 4. Transactions
  await pool.query(`
      CREATE TABLE IF NOT EXISTS transactions(
        "t_id" BIGSERIAL PRIMARY KEY,
        "w_id" BIGINT REFERENCES workers(w_id) ON DELETE CASCADE,
        "amount" BIGINT NOT NULL,
        "type" payment_type NOT NULL,
        "date" TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        "mode" payment_mode NOT NULL
      );
    `);

  // 5. Attendance
  await pool.query(`
      CREATE TABLE IF NOT EXISTS attendance(
        "id" BIGSERIAL PRIMARY KEY,
        "w_id" BIGINT REFERENCES workers(w_id) ON DELETE CASCADE,
        "is_present" BOOLEAN NOT NULL,
        "is_overtime" BOOLEAN DEFAULT false,
        "overtime_timing" TIME,
        "date" DATE DEFAULT CURRENT_DATE
      );
    `);
};

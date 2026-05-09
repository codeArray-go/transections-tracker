import { pool } from "../lib/pool.js";

export const checkUserExists = async (email) => {
  const result = await pool.query(`SELECT * FROM users WHERE email=$1`, [
    email,
  ]);
  return result.rows.length > 0;
};

export const signUpUserRepo = async ({ role, user_name, email, password }) => {
  const result = await pool.query(
    `INSERT INTO users(role, user_name, email, password)
     VALUES ($1, $2, $3, $4)
     RETURNING user_id, role, user_name, email`,
    [role, user_name, email, password],
  );

  return result.rows[0];
};

export const loginServiceRepo = async ({ role, email }) => {
  const result = (
    await pool.query(
      `SELECT * FROM users WHERE email=$1 AND role=$2`,
      [email, role],
    )
  ).rows[0];

  return result;
};

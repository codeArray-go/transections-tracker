import { pool } from "../lib/pool.js";

export const graphDataRepo = async ({ user_id, user_name }) => {
  const response = await pool.query(
    `
        SELECT t.amount, t.date FROM transactions t 
        JOIN workers w ON t.w_id = w.w_id
        JOIN users u ON w.u_id = u.user_id
        WHERE user_id = $1 AND user_name = $2;
    `,
    [user_id, user_name],
  );

  return response.rows;
};

export const inputTransactionDataRepo = async ({
  user_id,
  w_name,
  w_phone,
  amount,
  type,
  date,
  mode,
}) => {
  const worker_Id = await pool.query(
    `
    INSERT INTO workers (u_id, w_name, w_phone) VALUES ($1, $2, $3) RETURNING w_id;
  `,
    [user_id, w_name, w_phone],
  );

  const response = await pool.query(
    `
    INSERT INTO transactions (w_id, amount, type, date, mode) VALUES($1, $2, $3, $4, $5) RETURNING *;
  `,
    [worker_Id.rows[0].w_id, amount, type, date, mode],
  );

  return response.rows[0];
};

export const historyDataRepo = async ({ user_id, user_name }) => {
  const response = await pool.query(
    `
    SELECT t.* FROM transactions t 
    JOIN workers w ON t.w_id = w.w_id
    JOIN users u ON w.u_id = u.user_id
    WHERE user_id = $1 AND user_name = $2;  
  `,
    [user_id, user_name],
  );

  return response.rows;
};

export const inputAttendenceRepo = async ({
  w_id,
  is_present,
  is_overtime,
  overtime_timing,
  user_id,
  date,
}) => {
  const response = await pool.query(
    `
    INSERT INTO attendance (w_id, is_present, is_overtime, overtime_timing, date)
      SELECT $1, $2, $3, $4, $5
      FROM workers w
      WHERE w.w_id = $1 AND w.u_id = $6
      RETURNING *;
  `,
    [w_id, is_present, is_overtime, overtime_timing, date, user_id],
  );

  return response.rows[0];
};

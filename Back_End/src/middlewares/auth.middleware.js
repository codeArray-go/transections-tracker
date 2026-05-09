import { ENV } from "../lib/env.js";
import { pool } from "../lib/pool.js";
import jwt from "jsonwebtoken";

export const protectedRoute = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith("Bearer ")) {
      return res
        .status(401)
        .json({ message: "UNAUTHORIZED - NO TOKEN FOUND OR INVALID FORMAT." });
    }
    const token = authHeader.split(" ")[1];

    const decode = jwt.verify(token, ENV.JWT_SECRET);

    const userResult = await pool.query(
      `SELECT user_id, email, role, user_name FROM users WHERE user_id=$1`,
      [decode.userId],
    );

    const user = userResult.rows[0];

    if (!user)
      return res.status(401).json({ message: "UNAUTHORIZED - USER NOT FOUND" });

    req.user = user;
    next();
  } catch (error) {
    console.error(error.message);
    res
      .status(500)
      .json({ message: "INTERNAL SERVER ERROR IN AUTH MIDDLEWARE." });
  }
};

import express from "express";
import { ENV } from "./lib/env.js";
import { createTable } from "./lib/schema.js";
import authRouter from "./routes/auth.route.js";
import dataRouter from "./routes/data.route.js";

const app = express();
app.use(express.json());

app.use("/api/auth", authRouter);
app.use("/api/data", dataRouter);

app.get("/api/ping", (req, res) => {
  res.status(200).json({ message: "Server is alive 👍🏻" });
});

const PORT = ENV.PORT || 5000;

const startServer = async () => {
  try {
    await createTable();
    console.log("CONNECTED TO DB");
    app.listen(PORT, () => {
      console.log("SERVER IS LIVE ON PORT:", PORT);
    });
  } catch (error) {
    console.log("INTERNAL SERVER ERROR: ", error);
  }
};

startServer();

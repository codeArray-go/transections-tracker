import express from "express";
import {
  graphDataController,
  historyDataController,
  inputTransectionController,
} from "../controllers/data.controller.js";
import { protectedRoute } from "../middlewares/auth.middleware.js";
import { roleGuard } from "../middlewares/roleGuard.middleware.js";

const router = express.Router();

router.use(protectedRoute);

router.post(
  "/inputTransection",
  roleGuard("admin"),
  inputTransectionController,
);
router.get("/graph", graphDataController);
router.get("/history", historyDataController);

export default router;

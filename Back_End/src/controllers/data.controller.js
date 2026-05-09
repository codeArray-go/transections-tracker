import {
  graphDataRepo,
  historyDataRepo,
} from "../repositories/data.repository.js";
import {
  inputAttendenceService,
  inputTransactionDataService,
} from "../services/data.service.js";

export const inputTransectionController = async (req, res) => {
  const { user_id } = req.user;

  try {
    const response = await inputTransactionDataService(req.body, user_id);
    res
      .status(200)
      .json({ message: "Transactions added successfully.", data: response });
  } catch (error) {
    console.error(error.message);
    res
      .status(500)
      .json({ message: "INTERNAL SERVER ERROR WHILE INPUTING TRANSECTIONS" });
  }
};

export const inputAttendenceController = async (req, res) => {
  const { user_id } = req.user;
  try {
    const response = await inputAttendenceService(req.body, user_id);
    res
      .status(200)
      .json({ message: "ATTENDENCE ADDED SUCCESSFULLY.", data: response });
  } catch (error) {
    console.error(error);
    res.status(500).json("INTERNAL SERVER ERROR WHILE ADDING ATTENDENCES");
  }
};

export const graphDataController = async (req, res) => {
  const { user_id, user_name } = req.user;
  try {
    const response = await graphDataRepo({ user_id, user_name });
    res
      .status(200)
      .json({ message: "data successfully retrieved.", data: response });
  } catch (error) {
    console.error(error);
    res.status(500).json("INTERNAL SERVER ERROR WHILE GETTING GRAPH DATA");
  }
};

export const historyDataController = async (req, res) => {
  const { user_id, user_name } = req.user;
  try {
    const response = await historyDataRepo({ user_id, user_name });
    res.status(200).json({ message: "FETCHED HISTORY", data: response });
  } catch (error) {
    console.error(error);
    res
      .status(500)
      .json({ message: "INTERNAL SERVER WHILE FETCHING HISTORY." });
  }
};

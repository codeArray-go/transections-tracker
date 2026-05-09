import { inputAttendenceRepo, inputTransactionDataRepo } from "../repositories/data.repository.js";
import {
  ValidateAttendence,
  ValidateInputTransactionData,
} from "../utils/validators.js";

export const inputTransactionDataService = async (
  { w_name, w_phone, amount, type, date, mode },
  user_id,
) => {
  const error = ValidateInputTransactionData({
    w_name,
    w_phone,
    amount,
    type,
    date,
    mode,
  });
  if (error) throw new Error(error);

  const response = await inputTransactionDataRepo({
    user_id,
    w_name,
    w_phone,
    amount,
    type,
    date,
    mode,
  });

  return response;
};

export const inputAttendenceService = async (
  { w_id, is_present, is_overtime, overtime_timing, date },
  user_id,
) => {
  const error = ValidateAttendence({
    w_id,
    is_present,
    is_overtime,
    overtime_timing,
  });
  if (error) throw new Error(error);

  const response = await inputAttendenceRepo({
    w_id,
    is_present,
    is_overtime,
    overtime_timing,
    user_id,
    date,
  });

  return response;
};

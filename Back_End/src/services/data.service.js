import { inputTransactionDataRepo } from "../repositories/data.repository.js";
import { ValidateInputTransactionData } from "../utils/validators.js";

export const inputTransactionDataService = async (
  { w_name, w_phone, amount, type, date, mode, is_overtime },
  user_id,
) => {
  const error = ValidateInputTransactionData({
    w_name,
    w_phone,
    amount,
    type,
    date,
    mode,
    is_overtime,
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
    is_overtime,
  });

  return response;
};

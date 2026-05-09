import { validateSignup, ValidateLogin } from "../utils/validators.js";
import {
  checkUserExists,
  loginServiceRepo,
  signUpUserRepo,
} from "../repositories/auth.repository.js";
import { hashPassword } from "../utils/hash.js";
import { generateToken } from "../utils/token.js";
import bcrypt from "bcryptjs";

export const signUpService = async (
  { role, user_name, email, password },
  res,
) => {
  const error = validateSignup({ user_name, email, password });
  if (error) throw new Error(error);

  const exists = await checkUserExists(email);
  if (exists) throw new Error("USER ALREADY EXISTS.");

  const hashedPass = await hashPassword(password);

  let response = await signUpUserRepo({
    role,
    user_name,
    email,
    password: hashedPass,
  });
  const token = generateToken(response.user_id, res);

  const user = { ...response, token };

  return user;
};

export const loginService = async ({ role, email, password }, res) => {
  const error = ValidateLogin({ role, email, password });
  if (error) throw new Error(error);

  const existingUserData = await loginServiceRepo({ role, email });
  if (!existingUserData) throw new Error("USER NOT FOUND");

  const isMatch = await bcrypt.compare(password, existingUserData.password);
  if (!isMatch) throw new Error("INVALID CREDENTIALS");

  const token = generateToken(existingUserData.user_id, res);

  const user = {
    id: existingUserData.user_id,
    role: existingUserData.role,
    email: existingUserData.email,
    user_name: existingUserData.user_name,
    token: token,
  };

  return user;
};

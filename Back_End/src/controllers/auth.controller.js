import { loginService, signUpService } from "../services/auth.service.js";

export const signUpController = async (req, res) => {
  try {
    const user = await signUpService(req.body, res);

    res.status(201).json(user);
  } catch (error) {
    console.error("INTERNAL SERVER ERROR WHILE SINGINGUP.");
    res.status(400).json({ message: error.message });
  }
};

export const loginController = async (req, res) => {
  try {
    const user = await loginService(req.body, res);
    res.status(200).json(user);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "INTERNAL SERVER ERROR WHILE LOGINGIN." });
  }
};

export const validateSignup = ({ user_name, email, password }) => {
  if (!user_name || !email || !password) {
    return "CREDENTIALS ARE MENDATORY.";
  }

  if (password.length < 6) {
    return "PASSWORD SHOULD BE ATLEAST 6 CHARECTER LONG.";
  }

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  if (!emailRegex.test(email)) {
    return "INVALID EMAIL FORMAT.";
  }

  return null;
};

export const ValidateLogin = ({ role, email, password }) => {
  if (!email || !password) return "CREDENTIALS ARE MENDATORY.";
  if (!role) return "ROLE IS MENDATORY.";

  return null;
};

export const ValidateInputTransactionData = ({
  w_name,
  w_phone,
  amount,
  type,
  date,
  mode,
}) => {
  const errorMessage = (dynamicText) => {
    return `${dynamicText} IS MENDATORY.`;
  };

  if (!w_name) return errorMessage("WORKER'S NAME");
  if (!w_phone) return errorMessage("WORKER'S PHONE NUMBER");
  if (!amount) return errorMessage("TRANSECTION AMOUNT");
  if (!type) return errorMessage("TRANSECTION TYPE");
  if (!date) return errorMessage("DATE OF TRANSECTION");
  if (!mode) return errorMessage("MODE OF TRANSECTION");

  return null;
};

export const ValidateAttendence = ({
  w_id,
  is_present,
  is_overtime,
  overtime_timing,
}) => {
  // if (is_overtime === undefined || is_overtime === null || !overtime_timing) {
  //   return errorMessage("OVERTIME AND IT'S TIMING IS MENDATORY");
  // }

  const errorMessage = (dynamicText) => {
    return `${dynamicText} IS MENDATORY.`;
  };

  if (!w_id) return errorMessage("WORKER'S ID");
  if (!is_present) return errorMessage("WORKER'S PRECENSE");
};

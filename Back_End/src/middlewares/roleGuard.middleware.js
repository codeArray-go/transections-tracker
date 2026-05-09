export const roleGuard = (...allowedRole) => {
  return (req, res, next) => {
    if (!allowedRole.includes(req.user.role)) {
      return res
        .status(403)
        .json({ message: "आपके पास उचित शक्तियां नहीं है!" });
    }
    next();
  };
};

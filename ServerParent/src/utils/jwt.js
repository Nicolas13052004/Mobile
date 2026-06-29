const jwt = require('jsonwebtoken');

const JWT_SECRET = 'parentconnect_secret_key';

const generateToken = (user) => {

  return jwt.sign(
    {
      id: user.id,

      emailUtilisateur:
        user.emailUtilisateur,

      roleUtilisateur:
        user.roleUtilisateur,

      nomUtilisateur:
        user.nomUtilisateur,

      prenomUtilisateur:
        user.prenomUtilisateur
    },

    JWT_SECRET,

    {
      expiresIn: '7d'
    }
  );

};

const verifyToken = (token) => {
  return jwt.verify(token, JWT_SECRET);
};

module.exports = {
  generateToken,
  verifyToken
};
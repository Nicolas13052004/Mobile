const bcrypt = require('bcrypt');

const SALT_ROUNDS = 10;

/**
 * Hasher un mot de passe
 */
const hashPassword = async (password) => {
  return await bcrypt.hash(password, SALT_ROUNDS);
};

/**
 * Vérifier un mot de passe
 */
const comparePassword = async (password, hashedPassword) => {
  return await bcrypt.compare(password, hashedPassword);
};

module.exports = {
  hashPassword,
  comparePassword,
};
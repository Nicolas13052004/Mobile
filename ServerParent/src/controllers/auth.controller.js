const authService = require('../services/auth.service');

const login = async (req, res) => {
  try {
    // Accepte les deux formats de propriétés envoyés par le client
    const email = req.body.emailUtilisateur || req.body.email;
    const password = req.body.motDePasse || req.body.password;

    if (!email || !password) {
      return res.status(400).json({
        success: false,
        message: "Veuillez fournir un email et un mot de passe."
      });
    }

    const result = await authService.login(email, password);

    res.json({
      success: true,
      ...result
    });

  } catch (error) {
    res.status(401).json({
      success: false,
      message: error.message
    });
  }
};

const register = async (req, res) => {
  try {
    const result = await authService.register(req.body);
    res.status(201).json({
      success: true,
      data: result
    });
  } catch (error) {
    res.status(500).json({
      success: false,
      message: error.message
    });
  }
};

module.exports = {
  login,
  register
};
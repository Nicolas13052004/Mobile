const roleMiddleware = (...roles) => {

  return (req, res, next) => {

    if (!req.user) {

      return res.status(401).json({
        success: false,
        message: 'Utilisateur non authentifié'
      });

    }

    if (
      !roles.includes(
        req.user.roleUtilisateur
      )
    ) {

      return res.status(403).json({
        success: false,
        message: 'Accès refusé'
      });

    }

    next();

  };

};

module.exports = roleMiddleware;
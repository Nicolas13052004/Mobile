const {
    Utilisateurs,
    Eleves,
    Classes,
    Matieres
  } = require("../models");
  
  const getStats = async () => {
  
    const utilisateurs =
      await Utilisateurs.count();
  
    const eleves =
      await Eleves.count();
  
    const classes =
      await Classes.count();
  
    const matieres =
      await Matieres.count();
  
    const parents =
      await Utilisateurs.count({
        where: {
          roleUtilisateur: "parent"
        }
      });
  
    return {
      utilisateurs,
      eleves,
      parents,
      classes,
      matieres
    };
  };
  
  module.exports = {
    getStats
  };
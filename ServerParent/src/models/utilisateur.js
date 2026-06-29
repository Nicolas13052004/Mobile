module.exports = (sequelize, DataTypes) => {
  const Utilisateurs = sequelize.define("Utilisateurs", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nomUtilisateur: {
      type: DataTypes.STRING,
      allowNull: false
    },
    prenomUtilisateur: {
      type: DataTypes.STRING,
      allowNull: false
    },
    emailUtilisateur: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    motDePasse: {
      type: DataTypes.STRING,
      allowNull: false
    },
    roleUtilisateur: {
      type: DataTypes.STRING, // Aligné sur la migration
      allowNull: false
    }
  }, {
    tableName: 'Utilisateurs' // Force Sequelize à utiliser exactement le nom de ta migration
  });

  return Utilisateurs;
};
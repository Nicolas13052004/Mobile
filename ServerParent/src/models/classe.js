module.exports = (sequelize, DataTypes) => {
  const Classes = sequelize.define("Classes", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nomClasse: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false
    },
    niveauClasse: {
      type: DataTypes.STRING,
      allowNull: true
    }
  }, {
    tableName: 'Classes' // Force Sequelize à utiliser la table de la migration
  });

  return Classes;
};
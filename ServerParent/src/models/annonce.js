module.exports = (sequelize, DataTypes) => {
  const Annonces = sequelize.define("Annonces", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    titreAnnonce: {
      type: DataTypes.STRING,
      allowNull: false
    },
    contenuAnnonce: {
      type: DataTypes.TEXT,
      allowNull: false
    }
  }, {
    tableName: 'Annonces'
  });

  return Annonces;
};
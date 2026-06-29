module.exports = (sequelize, DataTypes) => {
  const Matieres = sequelize.define("Matieres", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nomMatiere: {
      type: DataTypes.STRING,
      allowNull: false,
      unique: true
    },
    codeMatiere: {
      type: DataTypes.STRING,
      allowNull: true,
      unique: true
    }
  }, {
    tableName: 'Matieres' // Aligné sur le nom en Base de Données
  });

  return Matieres;
};
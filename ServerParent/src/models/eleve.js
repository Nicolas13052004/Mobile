module.exports = (sequelize, DataTypes) => {
  const Eleves = sequelize.define("Eleves", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    matriculeEleve: {
      type: DataTypes.STRING,
      unique: true,
      allowNull: false
    },
    nomEleve: {
      type: DataTypes.STRING,
      allowNull: false
    },
    prenomEleve: {
      type: DataTypes.STRING,
      allowNull: false
    },
    dateNaissanceEleve: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    classId: { // Rejoint exactement 'classId' de ta migration
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Classes',
        key: 'id'
      }
    },
    parentId: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'Utilisateurs',
        key: 'id'
      }
    }
  }, {
    tableName: 'Eleves'
  });

  // Liaison avec la table Classes
  Eleves.associate = (models) => {
    Eleves.belongsTo(models.Classes, { foreignKey: 'classId', as: 'classe' });
  };

  return Eleves;
};
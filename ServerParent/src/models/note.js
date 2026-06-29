module.exports = (sequelize, DataTypes) => {
  const Notes = sequelize.define("Notes", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    matriculeEleve: {
      type: DataTypes.STRING,
      allowNull: false
    },
    codeMatiere: {
      type: DataTypes.STRING,
      allowNull: false
    },
    valeurNote: {
      type: DataTypes.FLOAT,
      allowNull: false
    },
    coefficientNote: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    trimestreNote: {
      type: DataTypes.STRING,
      allowNull: true
    }
  }, {
    tableName: 'Notes'
  });

  return Notes;
};
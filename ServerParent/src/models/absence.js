module.exports = (sequelize, DataTypes) => {
  const Absences = sequelize.define("Absences", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    matriculeEleve: {
      type: DataTypes.STRING,
      allowNull: false
    },
    dateAbsence: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    motifAbsence: {
      type: DataTypes.STRING,
      allowNull: true
    }
  }, {
    tableName: 'Absences'
  });

  return Absences;
};
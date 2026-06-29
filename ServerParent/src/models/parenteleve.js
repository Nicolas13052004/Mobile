module.exports = (sequelize, DataTypes) => {
  const ParentEleves = sequelize.define("ParentEleves", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    emailParent: {
      type: DataTypes.STRING,
      allowNull: false
    },
    matriculeEleve: {
      type: DataTypes.STRING,
      allowNull: false
    }
  }, {
    tableName: 'ParentEleves'
  });

  return ParentEleves;
};
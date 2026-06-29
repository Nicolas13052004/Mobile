module.exports = (sequelize, DataTypes) => {
  const Messages = sequelize.define("Messages", {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    emailExpediteur: {
      type: DataTypes.STRING,
      allowNull: false
    },
    emailDestinataire: {
      type: DataTypes.STRING,
      allowNull: false
    },
    contenuMessage: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    luMessage: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    }
  }, {
    tableName: 'Messages'
  });

  return Messages;
};
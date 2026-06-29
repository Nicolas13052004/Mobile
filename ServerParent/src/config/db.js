const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(
  'Pconnect2_db',
  'postgres',
  '1305',
  {
    host: '127.0.0.1',
    port: 5432,
    dialect: 'postgres',
    logging: false,
  }
);

module.exports = sequelize;
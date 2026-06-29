'use strict';

module.exports = {

  async up(queryInterface, Sequelize) {

    await queryInterface.createTable(
      'Messages',
      {

        id: {
          type: Sequelize.INTEGER,
          autoIncrement: true,
          primaryKey: true
        },

        emailExpediteur: {
          type: Sequelize.STRING,
          allowNull: false
        },

        emailDestinataire: {
          type: Sequelize.STRING,
          allowNull: false
        },

        contenuMessage: {
          type: Sequelize.TEXT
        },

        luMessage: {
          type: Sequelize.BOOLEAN,
          defaultValue: false
        },

        createdAt: {
          type: Sequelize.DATE,
          allowNull: false,
          defaultValue:
            Sequelize.literal(
              'CURRENT_TIMESTAMP'
            )
        },

        updatedAt: {
          type: Sequelize.DATE,
          allowNull: false,
          defaultValue:
            Sequelize.literal(
              'CURRENT_TIMESTAMP'
            )
        }
      }
    );

  },

  async down(queryInterface) {

    await queryInterface.dropTable(
      'Messages'
    );

  }
};
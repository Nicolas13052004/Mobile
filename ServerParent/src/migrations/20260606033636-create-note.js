'use strict';

module.exports = {

  async up(queryInterface, Sequelize) {

    await queryInterface.createTable(
      'Notes',
      {

        id: {
          type: Sequelize.INTEGER,
          autoIncrement: true,
          primaryKey: true
        },

        matriculeEleve: {
          type: Sequelize.STRING,
          allowNull: false
        },

        codeMatiere: {
          type: Sequelize.STRING,
          allowNull: false
        },

        valeurNote: {
          type: Sequelize.FLOAT
        },

        coefficientNote: {
          type: Sequelize.INTEGER
        },

        trimestreNote: {
          type: Sequelize.STRING
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
      'Notes'
    );

  }
};
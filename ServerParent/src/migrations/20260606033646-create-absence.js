'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {

    await queryInterface.createTable(
      'Absences',
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

        dateAbsence: {
          type: Sequelize.DATEONLY,
          allowNull: false
        },

        motifAbsence: {
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
      'Absences'
    );
  }
};
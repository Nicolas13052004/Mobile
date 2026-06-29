'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {

    await queryInterface.createTable(
      'ParentEleves',
      {

        id: {
          type: Sequelize.INTEGER,
          autoIncrement: true,
          primaryKey: true
        },

        emailParent: {
          type: Sequelize.STRING,
          allowNull: false
        },

        matriculeEleve: {
          type: Sequelize.STRING,
          allowNull: false
        },

        createdAt: {
          type: Sequelize.DATE,
          allowNull: false,
          defaultValue:
              Sequelize.literal(
                  'CURRENT_TIMESTAMP')
        },

        updatedAt: {
          type: Sequelize.DATE,
          allowNull: false,
          defaultValue:
              Sequelize.literal(
                  'CURRENT_TIMESTAMP')
        }

      }
    );

  },

  async down(queryInterface) {
    await queryInterface.dropTable(
      'ParentEleves'
    );
  }
};
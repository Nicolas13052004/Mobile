'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {

    await queryInterface.createTable('Eleves', {

      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },

      matriculeEleve: {
        type: Sequelize.STRING,
        unique: true,
        allowNull: false
      },

      nomEleve: {
        type: Sequelize.STRING,
        allowNull: false
      },

      prenomEleve: {
        type: Sequelize.STRING,
        allowNull: false
      },

      dateNaissanceEleve: {
        type: Sequelize.DATEONLY
      },

      classId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'Classes',
          key: 'id'
        }
      },

      parentId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'Utilisateurs',
          key: 'id'
        }
      },

      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },

      updatedAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      }

    });

  },

  async down(queryInterface) {
    await queryInterface.dropTable('Eleves');
  }
};
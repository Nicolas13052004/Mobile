'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('Utilisateurs', {
      id: {
        type: Sequelize.INTEGER,
        primaryKey: true,
        autoIncrement: true
      },

      nomUtilisateur: {
        type: Sequelize.STRING,
        allowNull: false
      },

      prenomUtilisateur: {
        type: Sequelize.STRING,
        allowNull: false
      },

      emailUtilisateur: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true
      },

      motDePasse: {
        type: Sequelize.STRING,
        allowNull: false
      },

      roleUtilisateur: {
        type: Sequelize.STRING,
        allowNull: false
      },

      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      },

      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
      }
    });
  },

  async down(queryInterface) {
    await queryInterface.dropTable('Utilisateurs');
  }
};
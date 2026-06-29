const { Classes } = require('../models');

const getAll = async () => {
  return await Classes.findAll();
};

const getById = async (id) => {
  return await Classes.findByPk(id);
};

const create = async (data) => {
  if (!Classes) {
    throw new Error("Le modèle 'Classes' est introuvable. Vérifiez l'export dans src/models/index.js");
  }

  // Utilisation des colonnes exactes de la migration
  return await Classes.create({
    nomClasse: data.nomClasse,
    niveauClasse: data.niveauClasse || data.niveau // Accepte niveauClasse ou niveau
  });
};

const update = async (id, data) => {
  const classe = await Classes.findByPk(id);
  
  if (!classe) {
    throw new Error("Classe introuvable");
  }

  const updateData = {
    nomClasse: data.nomClasse || classe.nomClasse,
    niveauClasse: data.niveauClasse || data.niveau || classe.niveauClasse
  };

  return await classe.update(updateData);
};

const remove = async (id) => {
  const classe = await Classes.findByPk(id);
  
  if (!classe) {
    throw new Error("Classe introuvable");
  }

  return await classe.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
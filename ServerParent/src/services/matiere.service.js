const { Matieres } = require('../models');

const getAll = async () => {
  return await Matieres.findAll({
    order: [['nomMatiere', 'ASC']]
  });
};

const getById = async (id) => {
  return await Matieres.findByPk(id);
};

const create = async (data) => {
  if (!Matieres) {
    throw new Error("Le modèle 'Matieres' est introuvable.");
  }
  return await Matieres.create({
    nomMatiere: data.nomMatiere,
    codeMatiere: data.codeMatiere || data.code
  });
};

const update = async (id, data) => {
  const matiere = await Matieres.findByPk(id);
  
  if (!matiere) {
    throw new Error("Matière introuvable");
  }

  const updateData = {
    nomMatiere: data.nomMatiere || matiere.nomMatiere,
    codeMatiere: data.codeMatiere || data.code || matiere.codeMatiere
  };

  return await matiere.update(updateData);
};

const remove = async (id) => {
  const matiere = await Matieres.findByPk(id);
  
  if (!matiere) {
    throw new Error("Matière introuvable");
  }

  return await matiere.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
const { Annonces } = require('../models');

// Fonction utilitaire de formatage (simple ici, mais on garde la bonne habitude)
const formatAnnonceResponse = (annonce) => {
  if (!annonce) return null;
  const rawData = annonce.toJSON();
  return {
    id: rawData.id,
    titreAnnonce: rawData.titreAnnonce,
    contenuAnnonce: rawData.contenuAnnonce,
    datePublication: rawData.createdAt // On renomme joliment la date de création
  };
};

const getAll = async () => {
  // On trie par ID décroissant pour avoir les annonces les plus récentes en premier
  const list = await Annonces.findAll({ order: [['id', 'DESC']] });
  return list.map(annonce => formatAnnonceResponse(annonce));
};

const getById = async (id) => {
  const annonce = await Annonces.findByPk(id);
  return formatAnnonceResponse(annonce);
};

const create = async (data) => {
  if (!Annonces) {
    throw new Error("Le modèle 'Annonces' est introuvable.");
  }

  // Vérification stricte : Titre et Contenu obligatoires
  if (!data.titreAnnonce || !data.contenuAnnonce) {
    throw new Error("Le titre et le contenu de l'annonce sont obligatoires.");
  }

  const newAnnonce = await Annonces.create({
    titreAnnonce: data.titreAnnonce,
    contenuAnnonce: data.contenuAnnonce
  });

  return formatAnnonceResponse(newAnnonce);
};

const update = async (id, data) => {
  const annonce = await Annonces.findByPk(id);
  
  if (!annonce) {
    throw new Error("Annonce introuvable");
  }

  // Empêcher de remplacer par du vide lors d'une modification
  if (data.titreAnnonce === "" || data.contenuAnnonce === "") {
    throw new Error("Le titre et le contenu ne peuvent pas être vides.");
  }

  await annonce.update({
    titreAnnonce: data.titreAnnonce || annonce.titreAnnonce,
    contenuAnnonce: data.contenuAnnonce || annonce.contenuAnnonce
  });

  return formatAnnonceResponse(annonce);
};

const remove = async (id) => {
  const annonce = await Annonces.findByPk(id);
  
  if (!annonce) {
    throw new Error("Annonce introuvable");
  }

  return await annonce.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
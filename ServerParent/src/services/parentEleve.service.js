const { ParentEleves, Utilisateurs, Eleves } = require('../models');

// Fonction utilitaire pour formater la réponse proprement
const formatParentEleveResponse = async (liaison) => {
  if (!liaison) return null;

  const rawData = liaison.toJSON();

  // On récupère les détails du parent et de l'élève pour un affichage complet
  const parent = await Utilisateurs.findOne({ where: { emailUtilisateur: rawData.emailParent } });
  const eleve = await Eleves.findOne({ where: { matriculeEleve: rawData.matriculeEleve } });

  return {
    id: rawData.id,
    emailParent: rawData.emailParent,
    nomParent: parent ? `${parent.nomUtilisateur} ${parent.prenomUtilisateur}` : "Inconnu",
    matriculeEleve: rawData.matriculeEleve,
    nomEleve: eleve ? `${eleve.nomEleve} ${eleve.prenomEleve}` : "Inconnu"
  };
};

const getAll = async () => {
  const list = await ParentEleves.findAll();
  return await Promise.all(list.map(item => formatParentEleveResponse(item)));
};

const getById = async (id) => {
  const liaison = await ParentEleves.findByPk(id);
  return await formatParentEleveResponse(liaison);
};

const create = async (data) => {
  if (!ParentEleves) {
    throw new Error("Le modèle 'ParentEleves' est introuvable.");
  }

  if (!data.emailParent || !data.matriculeEleve) {
    throw new Error("L'email du parent et le matricule de l'élève sont obligatoires.");
  }

  // 1. Vérification stricte de l'existence du parent
  const parentExists = await Utilisateurs.findOne({ where: { emailUtilisateur: data.emailParent } });
  if (!parentExists) {
    throw new Error("Aucun utilisateur trouvé avec cet email de parent.");
  }

  // 2. Vérification stricte de l'existence de l'élève
  const eleveExists = await Eleves.findOne({ where: { matriculeEleve: data.matriculeEleve } });
  if (!eleveExists) {
    throw new Error("Élève introuvable avec ce matricule.");
  }

  // 3. Vérification si la liaison existe déjà pour éviter les doublons
  const linkExists = await ParentEleves.findOne({
    where: { emailParent: data.emailParent, matriculeEleve: data.matriculeEleve }
  });
  if (linkExists) {
    throw new Error("Cette liaison parent-élève existe déjà.");
  }

  const newLink = await ParentEleves.create({
    emailParent: data.emailParent,
    matriculeEleve: data.matriculeEleve
  });

  return await getById(newLink.id);
};

const update = async (id, data) => {
  const liaison = await ParentEleves.findByPk(id);
  if (!liaison) {
    throw new Error("Liaison introuvable");
  }

  // Si on modifie l'email du parent, on revérifie s'il existe
  if (data.emailParent) {
    const parentExists = await Utilisateurs.findOne({ where: { emailUtilisateur: data.emailParent } });
    if (!parentExists) throw new Error("Le nouvel email parent n'existe pas.");
  }

  // Si on modifie le matricule, on revérifie s'il existe
  if (data.matriculeEleve) {
    const eleveExists = await Eleves.findOne({ where: { matriculeEleve: data.matriculeEleve } });
    if (!eleveExists) throw new Error("Le nouveau matricule élève n'existe pas.");
  }

  await liaison.update({
    emailParent: data.emailParent || liaison.emailParent,
    matriculeEleve: data.matriculeEleve || liaison.matriculeEleve
  });

  return await getById(id);
};

const remove = async (id) => {
  const liaison = await ParentEleves.findByPk(id);
  if (!liaison) {
    throw new Error("Liaison introuvable");
  }
  return await liaison.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
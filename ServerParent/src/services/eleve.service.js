const { Eleves, Classes } = require('../models');

// Fonction utilitaire de formatage : chaque élève a désormais une classe garantie
const formatEleveResponse = (eleve) => {
  if (!eleve) return null;
  
  const rawData = eleve.toJSON();
  
  return {
    id: rawData.id,
    matriculeEleve: rawData.matriculeEleve,
    nomEleve: rawData.nomEleve,
    prenomEleve: rawData.prenomEleve,
    dateNaissanceEleve: rawData.dateNaissanceEleve,
    nomClasseEleve: rawData.classe.nomClasse // Plus besoin de vérification "Aucune classe", elle existe forcément
  };
};

const getAll = async () => {
  const list = await Eleves.findAll({
    include: [{ model: Classes, as: 'classe', attributes: ['nomClasse'], required: true }] // required: true force la jointure stricte
  });
  return list.map(eleve => formatEleveResponse(eleve));
};

const getById = async (id) => {
  const eleve = await Eleves.findByPk(id, {
    include: [{ model: Classes, as: 'classe', attributes: ['nomClasse'], required: true }]
  });
  return formatEleveResponse(eleve);
};

const create = async (data) => {
  if (!Eleves) {
    throw new Error("Le modèle 'Eleves' est introuvable.");
  }

  // Blocage si le nom de la classe est absent du JSON
  if (!data.nomClasseEleve) {
    throw new Error("La classe est obligatoire pour inscrire un élève.");
  }

  // Recherche de la classe correspondante
  const foundClass = await Classes.findOne({ where: { nomClasse: data.nomClasseEleve } });
  
  if (!foundClass) {
    throw new Error("Classe introuvable");
  }

  const newEleve = await Eleves.create({
    matriculeEleve: data.matriculeEleve,
    nomEleve: data.nomEleve,
    prenomEleve: data.prenomEleve,
    dateNaissanceEleve: data.dateNaissanceEleve,
    classId: foundClass.id, // ID associé de manière sécurisée
    parentId: data.parentId || null
  });

  return await getById(newEleve.id);
};

const update = async (id, data) => {
  const eleve = await Eleves.findByPk(id);
  
  if (!eleve) {
    throw new Error("Élève introuvable");
  }

  let targetClassId = eleve.classId;

  // Si l'utilisateur change la classe, on applique la même règle stricte
  if (data.nomClasseEleve) {
    const foundClass = await Classes.findOne({ where: { nomClasse: data.nomClasseEleve } });
    
    if (!foundClass) {
      throw new Error("Classe introuvable. Modification annulée.");
    }
    targetClassId = foundClass.id;
  }

  await eleve.update({
    matriculeEleve: data.matriculeEleve || eleve.matriculeEleve,
    nomEleve: data.nomEleve || eleve.nomEleve,
    prenomEleve: data.prenomEleve || eleve.prenomEleve,
    dateNaissanceEleve: data.dateNaissanceEleve || eleve.dateNaissanceEleve,
    classId: targetClassId,
    parentId: data.parentId || eleve.parentId
  });

  return await getById(id);
};

const remove = async (id) => {
  const eleve = await Eleves.findByPk(id);
  if (!eleve) {
    throw new Error("Élève introuvable");
  }
  return await eleve.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
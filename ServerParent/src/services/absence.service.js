const { Absences, Eleves, ParentEleves } = require('../models');

// Fonction utilitaire pour formater la réponse proprement
const formatAbsenceResponse = async (absence) => {
  if (!absence) return null;

  const rawData = absence.toJSON();

  // On recherche l'élève pour récupérer son nom complet
  const eleve = await Eleves.findOne({ where: { matriculeEleve: rawData.matriculeEleve } });

  return {
    id: rawData.id,
    matriculeEleve: rawData.matriculeEleve,
    nomCompletEleve: eleve ? `${eleve.nomEleve} ${eleve.prenomEleve}` : "Élève inconnu",
    dateAbsence: rawData.dateAbsence,
    motifAbsence: rawData.motifAbsence || "",
    // Détermination dynamique : si un motif est renseigné, l'absence est considérée comme justifiée
    estJustifie: rawData.motifAbsence ? true : false
  };
};

const getAll = async () => {
  const list = await Absences.findAll({ order: [['dateAbsence', 'DESC']] });
  return await Promise.all(list.map(absence => formatAbsenceResponse(absence)));
};

const getById = async (id) => {
  const absence = await Absences.findByPk(id);
  return await formatAbsenceResponse(absence);
};

const getAbsencesParent = async (emailParent) => {
  const liaison = await ParentEleves.findOne({
    where: { emailParent: emailParent }
  });

  if (!liaison) {
    return [];
  }

  const list = await Absences.findAll({
    where: { matriculeEleve: liaison.matriculeEleve },
    order: [['dateAbsence', 'DESC']]
  });

  return await Promise.all(list.map(absence => formatAbsenceResponse(absence)));
};

const create = async (data) => {
  if (!Absences) {
    throw new Error("Le modèle 'Absences' est introuvable.");
  }

  if (!data.matriculeEleve || !data.dateAbsence) {
    throw new Error("Le matricule de l'élève et la date de l'absence sont obligatoires.");
  }

  const eleveExists = await Eleves.findOne({ where: { matriculeEleve: data.matriculeEleve } });
  if (!eleveExists) {
    throw new Error("Impossible d'ajouter l'absence : Élève introuvable avec ce matricule.");
  }

  const absenceExistante = await Absences.findOne({
    where: {
      matriculeEleve: data.matriculeEleve,
      dateAbsence: data.dateAbsence
    }
  });

  if (absenceExistante) {
    throw new Error(`Cet élève est déjà marqué absent pour la date du ${data.dateAbsence}. Utilisez une modification (PUT) pour changer le motif.`);
  }

  const newAbsence = await Absences.create({
    matriculeEleve: data.matriculeEleve,
    dateAbsence: data.dateAbsence,
    motifAbsence: data.motifAbsence || null
  });

  return await getById(newAbsence.id);
};

const update = async (id, data) => {
  const absence = await Absences.findByPk(id);
  if (!absence) {
    throw new Error("Absence introuvable");
  }

  const newMatricule = data.matriculeEleve || absence.matriculeEleve;
  const newDate = data.dateAbsence || absence.dateAbsence;

  if (data.matriculeEleve) {
    const eleveExists = await Eleves.findOne({ where: { matriculeEleve: data.matriculeEleve } });
    if (!eleveExists) throw new Error("Le nouveau matricule élève n'existe pas.");
  }

  const absenceExistante = await Absences.findOne({
    where: { matriculeEleve: newMatricule, dateAbsence: newDate }
  });

  if (absenceExistante && absenceExistante.id !== absence.id) {
    throw new Error(`Conflit : Cet élève possède déjà une autre entrée d'absence pour le ${newDate}.`);
  }

  await absence.update({
    matriculeEleve: newMatricule,
    dateAbsence: newDate,
    motifAbsence: data.motifAbsence !== undefined ? data.motifAbsence : absence.motifAbsence
  });

  return await getById(id);
};

const remove = async (id) => {
  const absence = await Absences.findByPk(id);
  if (!absence) {
    throw new Error("Absence introuvable");
  }
  return await absence.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove,
  getAbsencesParent
};
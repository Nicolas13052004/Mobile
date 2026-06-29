const { Notes, Eleves, Matieres, ParentEleves } = require('../models');

// Fonction utilitaire pour formater la réponse avec des détails textuels complets
const formatNoteResponse = async (note) => {
  if (!note) return null;

  const rawData = note.toJSON();

  const eleve = await Eleves.findOne({
    where: { matriculeEleve: rawData.matriculeEleve }
  });

  const matiere = await Matieres.findOne({
    where: { codeMatiere: rawData.codeMatiere }
  });

  return {
    id: rawData.id,
    matriculeEleve: rawData.matriculeEleve,
    nomCompletEleve: eleve
      ? `${eleve.nomEleve} ${eleve.prenomEleve}`
      : "Élève inconnu",

    codeMatiere: rawData.codeMatiere,

    nomMatiere: matiere
      ? matiere.nomMatiere
      : "Matière inconnue",

    valeurNote: rawData.valeurNote,

    coefficientNote: rawData.coefficientNote,

    trimestreNote: rawData.trimestreNote
  };
};


const getAll = async () => {

  const list = await Notes.findAll({
    order: [["id", "DESC"]]
  });

  return await Promise.all(
    list.map(note => formatNoteResponse(note))
  );
};

const getNotesParent = async (emailParent) => {

  const liaison = await ParentEleves.findOne({
    where: {
      emailParent: emailParent
    }
  });

  if (!liaison) {
    return [];
  }

  const list = await Notes.findAll({

    where: {
      matriculeEleve: liaison.matriculeEleve
    },

    order: [
      ["trimestreNote", "ASC"]
    ]

  });

  return await Promise.all(
    list.map(note => formatNoteResponse(note))
  );

};

const getById = async (id) => {

  const note = await Notes.findByPk(id);

  return await formatNoteResponse(note);

};

const create = async (data) => {

  if (!data.matriculeEleve ||
      !data.codeMatiere ||
      data.valeurNote === undefined) {

    throw new Error(
      "Le matricule, la matière et la note sont obligatoires."
    );

  }

  const trimestre =
      data.trimestreNote || "Trimestre 1";

  const eleve =
      await Eleves.findOne({
        where:{
          matriculeEleve:data.matriculeEleve
        }
      });

  if(!eleve){
    throw new Error("Élève introuvable");
  }

  const matiere =
      await Matieres.findOne({
        where:{
          codeMatiere:data.codeMatiere
        }
      });

  if(!matiere){
    throw new Error("Matière introuvable");
  }

  const existe =
      await Notes.findOne({

        where:{

          matriculeEleve:data.matriculeEleve,

          codeMatiere:data.codeMatiere,

          trimestreNote:trimestre

        }

      });

  if(existe){

    throw new Error(
      "Cette note existe déjà."
    );

  }

  const note =
      await Notes.create({

        matriculeEleve:data.matriculeEleve,

        codeMatiere:data.codeMatiere,

        valeurNote:data.valeurNote,

        coefficientNote:
            data.coefficientNote || 1,

        trimestreNote:trimestre

      });

  return await getById(note.id);

};

// ===============================

const update = async(id,data)=>{

  const note =
      await Notes.findByPk(id);

  if(!note){

    throw new Error("Note introuvable");

  }

  await note.update({

    matriculeEleve:
        data.matriculeEleve ??
        note.matriculeEleve,

    codeMatiere:
        data.codeMatiere ??
        note.codeMatiere,

    valeurNote:
        data.valeurNote ??
        note.valeurNote,

    coefficientNote:
        data.coefficientNote ??
        note.coefficientNote,

    trimestreNote:
        data.trimestreNote ??
        note.trimestreNote

  });

  return await getById(id);

};

// ===============================

const remove = async(id)=>{

  const note =
      await Notes.findByPk(id);

  if(!note){

    throw new Error("Note introuvable");

  }

  await note.destroy();

};

// ===============================

module.exports={

  getAll,

  getNotesParent,

  getById,

  create,

  update,

  remove

};
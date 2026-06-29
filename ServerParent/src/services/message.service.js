const { Messages, Utilisateurs } = require('../models');
const { Op } = require('sequelize'); 

// Fonction utilitaire pour enrichir le message avec les noms des utilisateurs
const formatMessageResponse = async (message) => {
  if (!message) return null;

  const rawData = message.toJSON();

  const expediteur = await Utilisateurs.findOne({ where: { emailUtilisateur: rawData.emailExpediteur } });
  const destinataire = await Utilisateurs.findOne({ where: { emailUtilisateur: rawData.emailDestinataire } });

  return {
    id: rawData.id,
    emailExpediteur: rawData.emailExpediteur,
    nomExpediteur: expediteur ? `${expediteur.nomUtilisateur} ${expediteur.prenomUtilisateur}` : "Utilisateur supprimé",
    emailDestinataire: rawData.emailDestinataire,
    nomDestinataire: destinataire ? `${destinataire.nomUtilisateur} ${destinataire.prenomUtilisateur}` : "Utilisateur supprimé",
    contenuMessage: rawData.contenuMessage,
    luMessage: rawData.luMessage,
    dateEnvoi: rawData.createdAt
  };
};

const getAll = async () => {
  const list = await Messages.findAll({ order: [['createdAt', 'DESC']] });
  return await Promise.all(list.map(msg => formatMessageResponse(msg)));
};

const getById = async (id) => {
  const message = await Messages.findByPk(id);
  return await formatMessageResponse(message);
};

// CORRIGÉ : Récupère l'historique complet de l'utilisateur (Boîte de réception + Boîte d'envoi)
const getMessagesEnvoyes = async (emailUtilisateur) => {
  const list = await Messages.findAll({
    where: {
      [Op.or]: [
        { emailExpediteur: emailUtilisateur },
        { emailDestinataire: emailUtilisateur }
      ]
    },
    order: [['createdAt', 'DESC']]
  });
  return await Promise.all(list.map(msg => formatMessageResponse(msg)));
};

const create = async (data) => {
  if (!Messages) {
    throw new Error("Le modèle 'Messages' est introuvable.");
  }

  if (!data.emailExpediteur || !data.emailDestinataire || !data.contenuMessage) {
    throw new Error("L'expéditeur, le destinataire et le contenu du message sont obligatoires.");
  }

  const expediteurExists = await Utilisateurs.findOne({ where: { emailUtilisateur: data.emailExpediteur } });
  if (!expediteurExists) {
    throw new Error("Impossible d'envoyer : L'email de l'expéditeur n'existe pas.");
  }

  const destinataireExists = await Utilisateurs.findOne({ where: { emailUtilisateur: data.emailDestinataire } });
  if (!destinataireExists) {
    throw new Error("Impossible d'envoyer : L'email du destinataire n'existe pas.");
  }

  const newMessage = await Messages.create({
    emailExpediteur: data.emailExpediteur,
    emailDestinataire: data.emailDestinataire,
    contenuMessage: data.contenuMessage,
    luMessage: false
  });

  return await getById(newMessage.id);
};

const update = async (id, data) => {
  const message = await Messages.findByPk(id);
  if (!message) {
    throw new Error("Message introuvable");
  }

  await message.update({
    emailExpediteur: data.emailExpediteur || message.emailExpediteur,
    emailDestinataire: data.emailDestinataire || message.emailDestinataire,
    contenuMessage: data.contenuMessage || message.contenuMessage,
    luMessage: data.luMessage !== undefined ? data.luMessage : message.luMessage
  });

  return await getById(id);
};

const remove = async (id) => {
  const message = await Messages.findByPk(id);
  if (!message) {
    throw new Error("Message introuvable");
  }
  return await message.destroy();
};

module.exports = {
  getAll,
  getById,
  getMessagesEnvoyes,
  create,
  update,
  remove
};
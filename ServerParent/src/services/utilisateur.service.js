const { Utilisateurs } = require('../models');
const bcrypt = require('bcrypt');

// Regex de validation globales
const emailRegex = /^[a-zA-Z0-9._%+-]+@gmail\.com$/;
const nomRegex = /^[a-zA-ZÀ-ÿ\s'-]+$/; // Ajout de ' et - au cas où

const getAll = async () => {
  return await Utilisateurs.findAll({
    attributes: { exclude: ['motDePasse'] },
    order: [['createdAt', 'DESC']]
  });
};

const getById = async (id) => {
  return await Utilisateurs.findByPk(id, {
    attributes: { exclude: ['motDePasse'] }
  });
};

const create = async (data) => {
  const plainPassword = data.password || data.motDePasse;
  const email = data.email || data.emailUtilisateur;
  const nom = data.nom || data.nomUtilisateur;
  const prenom = data.prenom || data.prenomUtilisateur;

  if (!plainPassword || !email) {
    throw new Error("L'email et le mot de passe sont requis pour créer un utilisateur.");
  }

  // ---- VALIDATIONS DES ENTRÉES ----
  if (!emailRegex.test(email)) {
    throw new Error("Email invalide (Seuls les comptes @gmail.com sont acceptés).");
  }

  if (!nom || !nomRegex.test(nom)) {
    throw new Error("Nom invalide (Caractères spéciaux non autorisés).");
  }

  if (!prenom || !nomRegex.test(prenom)) {
    throw new Error("Prénom invalide (Caractères spéciaux non autorisés).");
  }
  // ---------------------------------

  const hashedPassword = await bcrypt.hash(plainPassword, 10);

  const user = await Utilisateurs.create({
    nomUtilisateur: nom,
    prenomUtilisateur: prenom,
    emailUtilisateur: email,
    motDePasse: hashedPassword,
    roleUtilisateur: data.role || data.roleUtilisateur || "enseignant"
  });

  const userSafe = user.toJSON();
  delete userSafe.motDePasse;
  return userSafe;
};

const update = async (id, data) => {
  const user = await Utilisateurs.findByPk(id);

  if (!user) {
    throw new Error("Utilisateur introuvable");
  }

  const nom = data.nom || data.nomUtilisateur || user.nomUtilisateur;
  const prenom = data.prenom || data.prenomUtilisateur || user.prenomUtilisateur;
  const email = data.email || data.emailUtilisateur || user.emailUtilisateur;

  // ---- VALIDATIONS DES ENTRÉES AVANT UPDATE ----
  if (!emailRegex.test(email)) {
    throw new Error("Email invalide (Seuls les comptes @gmail.com sont acceptés).");
  }

  if (!nomRegex.test(nom)) {
    throw new Error("Nom invalide.");
  }

  if (!nomRegex.test(prenom)) {
    throw new Error("Prénom invalide.");
  }
  // ----------------------------------------------

  const updateData = {
    nomUtilisateur: nom,
    prenomUtilisateur: prenom,
    emailUtilisateur: email,
    roleUtilisateur: data.role || data.roleUtilisateur || user.roleUtilisateur
  };

  const plainPassword = data.password || data.motDePasse;
  if (plainPassword) {
    updateData.motDePasse = await bcrypt.hash(plainPassword, 10);
  }

  await user.update(updateData);

  const userSafe = user.toJSON();
  delete userSafe.motDePasse;
  return userSafe;
};

const remove = async (id) => {
  const user = await Utilisateurs.findByPk(id);

  if (!user) {
    throw new Error("Utilisateur introuvable");
  }

  return await user.destroy();
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
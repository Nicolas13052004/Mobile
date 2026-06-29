const { Utilisateurs } = require('../models');
const bcrypt = require('bcrypt');
const { generateToken } = require('../utils/jwt');

const login = async (email, password) => {
  if (!Utilisateurs) {
    throw new Error("Le modèle 'Utilisateurs' est introuvable. Vérifiez l'export dans src/models/index.js");
  }

  // Recherche de l'utilisateur par email
  const user = await Utilisateurs.findOne({
    where: { emailUtilisateur: email }
  });

  if (!user) {
    throw new Error("Utilisateur introuvable");
  }

  // Comparaison avec le champ 'motDePasse' (provenant de la migration)
  const isValid = await bcrypt.compare(password, user.motDePasse);

  if (!isValid) {
    throw new Error("Mot de passe incorrect");
  }

  // Retirer le mot de passe de l'objet renvoyé pour la sécurité
  const userSafe = user.toJSON();
  delete userSafe.motDePasse;

  return {
    user: userSafe,
    token: generateToken(user)
  };
};

const register = async (data) => {
  if (!Utilisateurs) {
    throw new Error("Le modèle 'Utilisateurs' est introuvable.");
  }

  const plainPassword = data.password || data.motDePasse;
  const email = data.email || data.emailUtilisateur;

  if (!plainPassword || !email) {
    throw new Error("L'email et le mot de passe sont requis pour l'inscription.");
  }

  const hashedPassword = await bcrypt.hash(plainPassword, 10);

  const user = await Utilisateurs.create({
    nomUtilisateur: data.nom || data.nomUtilisateur,
    prenomUtilisateur: data.prenom || data.prenomUtilisateur,
    emailUtilisateur: email,
    motDePasse: hashedPassword, // Aligné sur la migration
    roleUtilisateur: data.role || data.roleUtilisateur || "enseignant"
  });

  const userSafe = user.toJSON();
  delete userSafe.motDePasse;

  return userSafe;
};

module.exports = {
  login,
  register
};
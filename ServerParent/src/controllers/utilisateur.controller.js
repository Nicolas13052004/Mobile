const utilisateurService = require('../services/utilisateur.service');

const getAll = async (req, res) => {
  try {
    const data = await utilisateurService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await utilisateurService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Utilisateur introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await utilisateurService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Utilisateur créé avec succès",
      data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await utilisateurService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Utilisateur mis à jour avec succès",
      data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await utilisateurService.remove(req.params.id);
    res.json({ success: true, message: "Utilisateur supprimé avec succès" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove
};
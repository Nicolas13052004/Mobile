const absenceService = require('../services/absence.service');

const getAll = async (req, res) => {
  try {
    const data = await absenceService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await absenceService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Absence introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await absenceService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Absence enregistrée avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await absenceService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Absence mise à jour avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await absenceService.remove(req.params.id);
    res.json({ success: true, message: "Absence supprimée avec succès" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getAbsencesParent = async (req, res) => {
  try {
    const email = req.user.emailUtilisateur || req.user.email;
    const data = await absenceService.getAbsencesParent(email);
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
  getAll,
  getById,
  create,
  update,
  remove,
  getAbsencesParent
};
const matiereService = require('../services/matiere.service');

const getAll = async (req, res) => {
  try {
    const data = await matiereService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await matiereService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Matière introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await matiereService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Matière créée avec succès",
      data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await matiereService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Matière mise à jour avec succès",
      data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await matiereService.remove(req.params.id);
    res.json({ success: true, message: "Matière supprimée avec succès" });
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
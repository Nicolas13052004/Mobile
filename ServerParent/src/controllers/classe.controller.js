const classeService = require('../services/classe.service');

const getAll = async (req, res) => {
  try {
    const data = await classeService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await classeService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Classe introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await classeService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Classe créée avec succès",
      data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await classeService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Classe mise à jour avec succès",
      data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await classeService.remove(req.params.id);
    res.json({ success: true, message: "Classe supprimée avec succès" });
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
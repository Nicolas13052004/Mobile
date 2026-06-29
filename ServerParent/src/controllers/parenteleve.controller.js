const parentEleveService = require('../services/parenteleve.service');

const getAll = async (req, res) => {
  try {
    const data = await parentEleveService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await parentEleveService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Liaison introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await parentEleveService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Liaison Parent-Élève créée avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await parentEleveService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Liaison mise à jour avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await parentEleveService.remove(req.params.id);
    res.json({ success: true, message: "Liaison supprimée avec succès" });
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
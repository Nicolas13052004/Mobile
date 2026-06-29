const annonceService = require('../services/annonce.service');

const getAll = async (req, res) => {
  try {
    const data = await annonceService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await annonceService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Annonce introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await annonceService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Annonce publiée avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await annonceService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Annonce modifiée avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await annonceService.remove(req.params.id);
    res.json({ success: true, message: "Annonce supprimée avec succès" });
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
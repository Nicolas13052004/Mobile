const eleveService = require('../services/eleve.service');

const getAll = async (req, res) => {
  try {
    const data = await eleveService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await eleveService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Élève introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await eleveService.create(req.body);
    res.status(201).json(data); // Renvoie directement la structure propre
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await eleveService.update(req.params.id, req.body);
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await eleveService.remove(req.params.id);
    res.json({ success: true, message: "Élève supprimé avec succès" });
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
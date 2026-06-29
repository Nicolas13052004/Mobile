const messageService = require('../services/message.service');

const getAll = async (req, res) => {
  try {
    const data = await messageService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await messageService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Message introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Récupère l'historique complet (Messages envoyés et reçus par l'email)
const getMessagesEnvoyes = async (req, res) => {
  try {
    const email = req.params.email;
    const data = await messageService.getMessagesEnvoyes(email);
    res.json({
      success: true,
      total: data.length,
      messages: data
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await messageService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Message envoyé avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await messageService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Message mis à jour avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await messageService.remove(req.params.id);
    res.json({ success: true, message: "Message supprimé avec succès" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

module.exports = {
  getAll,
  getById,
  getMessagesEnvoyes,
  create,
  update,
  remove
};
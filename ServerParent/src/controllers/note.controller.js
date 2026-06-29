const noteService = require('../services/note.service');

const getAll = async (req, res) => {
  try {
    const data = await noteService.getAll();
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getById = async (req, res) => {
  try {
    const data = await noteService.getById(req.params.id);
    if (!data) {
      return res.status(404).json({ success: false, message: "Note introuvable" });
    }
    res.json(data);
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const create = async (req, res) => {
  try {
    const data = await noteService.create(req.body);
    res.status(201).json({
      success: true,
      message: "Note enregistrée avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const update = async (req, res) => {
  try {
    const data = await noteService.update(req.params.id, req.body);
    res.json({
      success: true,
      message: "Note mise à jour avec succès",
      data
    });
  } catch (error) {
    res.status(400).json({ success: false, message: error.message });
  }
};

const remove = async (req, res) => {
  try {
    await noteService.remove(req.params.id);
    res.json({ success: true, message: "Note supprimée avec succès" });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

const getNotesParent = async (req,res)=>{

  try{

    const email =
      req.user.emailUtilisateur || req.user.email;

    const data =
      await noteService.getNotesParent(email);

    res.json(data);

  }catch(error){

    res.status(500).json({

      success:false,

      message:error.message

    });

  }

};

module.exports = {

  getAll,

  getNotesParent,

  getById,

  create,

  update,

  remove

};
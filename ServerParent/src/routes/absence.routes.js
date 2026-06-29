const express = require("express");
const router = express.Router();

const absenceController = require("../controllers/absence.controller");
const authMiddleware = require("../middlewares/auth.middleware");
const roleMiddleware = require("../middlewares/role.middleware");

//=============================================================================
// Parent connecté (Doit être placé AVANT les routes avec paramètres comme /:id)
//=============================================================================
router.get("/parent", authMiddleware, roleMiddleware("parent"), absenceController.getAbsencesParent);

//=============================================================================
// CRUD & Lecture globale
//=============================================================================
router.post("/", authMiddleware, roleMiddleware("admin", "enseignant"), absenceController.create);
router.put("/:id", authMiddleware, roleMiddleware("admin", "enseignant"), absenceController.update);
router.delete("/:id", authMiddleware, roleMiddleware("admin", "enseignant"), absenceController.remove);

router.get("/", authMiddleware, absenceController.getAll);
router.get("/:id", authMiddleware, absenceController.getById);

module.exports = router;
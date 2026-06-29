const express = require("express");
const router = express.Router();

const eleveController = require("../controllers/eleve.controller");
const authMiddleware = require("../middlewares/auth.middleware");
const roleMiddleware = require("../middlewares/role.middleware");

// Seul l'admin peut lier ou modifier un profil élève
router.post("/", authMiddleware, roleMiddleware("admin"), eleveController.create);
router.put("/:id", authMiddleware, roleMiddleware("admin"), eleveController.update);
router.delete("/:id", authMiddleware, roleMiddleware("admin"), eleveController.remove);

// Consultable par les utilisateurs connectés
router.get("/", authMiddleware, eleveController.getAll);
router.get("/:id", authMiddleware, eleveController.getById);

module.exports = router;
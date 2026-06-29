const express = require("express");
const router = express.Router();

const annonceController = require("../controllers/annonce.controller");
const authMiddleware = require("../middlewares/auth.middleware");
const roleMiddleware = require("../middlewares/role.middleware");

// Création, modification et suppression : Réservé aux admins
router.post("/", authMiddleware, roleMiddleware("admin"), annonceController.create);
router.put("/:id", authMiddleware, roleMiddleware("admin"), annonceController.update);
router.delete("/:id", authMiddleware, roleMiddleware("admin"), annonceController.remove);

// Lecture : Tous les utilisateurs connectés peuvent voir les annonces
router.get("/", authMiddleware, annonceController.getAll);
router.get("/:id", authMiddleware, annonceController.getById);

module.exports = router;
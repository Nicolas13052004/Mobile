const express = require("express");
const router = express.Router();

const matiereController = require("../controllers/matiere.controller");
const authMiddleware = require("../middlewares/auth.middleware");
const roleMiddleware = require("../middlewares/role.middleware");

// CREATE (admin ou enseignant selon tes besoins, ici mis en admin only)
router.post("/", authMiddleware, roleMiddleware("admin"), matiereController.create);

// READ
router.get("/", authMiddleware, matiereController.getAll);
router.get("/:id", authMiddleware, matiereController.getById);

// UPDATE
router.put("/:id", authMiddleware, roleMiddleware("admin"), matiereController.update);

// DELETE
router.delete("/:id", authMiddleware, roleMiddleware("admin"), matiereController.remove);

module.exports = router;
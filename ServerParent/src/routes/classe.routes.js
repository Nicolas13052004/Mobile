const express = require("express");
const router = express.Router();

const classeController = require("../controllers/classe.controller");
const authMiddleware = require("../middlewares/auth.middleware");
const roleMiddleware = require("../middlewares/role.middleware");

// CREATE (admin only)
router.post("/", authMiddleware, roleMiddleware("admin"), classeController.create);

// READ
router.get("/", authMiddleware, classeController.getAll);
router.get("/:id", authMiddleware, classeController.getById);

// UPDATE (admin)
router.put("/:id", authMiddleware, roleMiddleware("admin"), classeController.update);

// DELETE (admin)
router.delete("/:id", authMiddleware, roleMiddleware("admin"), classeController.remove);

module.exports = router;
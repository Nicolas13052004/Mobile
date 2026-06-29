const express = require("express");
const router = express.Router();

const messageController = require("../controllers/message.controller");
const authMiddleware = require("../middlewares/auth.middleware");

// Routes POST, PUT, DELETE
router.post("/", authMiddleware, messageController.create);
router.put("/:id", authMiddleware, messageController.update);
router.delete("/:id", authMiddleware, messageController.remove);

// Routes GET
router.get("/", authMiddleware, messageController.getAll);

// ATTENTION : Cette route DOIT être placée avant "/:id" pour qu'Express ne confonde pas "envoyes" avec un ID.
router.get("/envoyes/:email", authMiddleware, messageController.getMessagesEnvoyes);

router.get("/:id", authMiddleware, messageController.getById);

module.exports = router;
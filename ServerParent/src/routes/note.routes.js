const express = require("express");

const router = express.Router();

const noteController =
require("../controllers/note.controller");

const authMiddleware =
require("../middlewares/auth.middleware");

const roleMiddleware =
require("../middlewares/role.middleware");

//==========================
// CRUD
//==========================

router.post(
"/",
authMiddleware,
roleMiddleware("admin","enseignant"),
noteController.create
);

router.put(
"/:id",
authMiddleware,
roleMiddleware("admin","enseignant"),
noteController.update
);

router.delete(
"/:id",
authMiddleware,
roleMiddleware("admin","enseignant"),
noteController.remove
);

//==========================
// Parent connecté
//==========================

router.get(
"/parent",
authMiddleware,
roleMiddleware("parent"),
noteController.getNotesParent
);

//==========================
// Tous
//==========================

router.get(
"/",
authMiddleware,
noteController.getAll
);

router.get(
"/:id",
authMiddleware,
noteController.getById
);

module.exports = router;
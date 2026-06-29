const express = require("express");
const router = express.Router();

const parentEleveController = require("../controllers/parenteleve.controller");
const authMiddleware = require("../middlewares/auth.middleware");
const roleMiddleware = require("../middlewares/role.middleware");

router.post("/", authMiddleware, roleMiddleware("admin"), parentEleveController.create);
router.put("/:id", authMiddleware, roleMiddleware("admin"), parentEleveController.update);
router.delete("/:id", authMiddleware, roleMiddleware("admin"), parentEleveController.remove);

router.get("/", authMiddleware, parentEleveController.getAll);
router.get("/:id", authMiddleware, parentEleveController.getById);

module.exports = router;
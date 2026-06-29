const express = require("express");
const router = express.Router();

// import routes
const authRoutes = require("./auth.routes");
const userRoutes = require("./utilisateur.routes");
const eleveRoutes = require("./eleve.routes");
const noteRoutes = require("./note.routes");
const absenceRoutes = require("./absence.routes");
const messageRoutes = require("./message.routes");
const annonceRoutes = require("./annonce.routes");
const matiereRoutes = require("./matiere.routes");
const classeRoutes = require("./classe.routes");
const parentRoutes = require("./parent.routes");
const dashboardRoutes =
  require("./dashboard.routes");

// use routes
router.use("/auth", authRoutes);

router.use("/users", userRoutes);
router.use("/eleves", eleveRoutes);
router.use("/notes", noteRoutes);
router.use("/absences", absenceRoutes);
router.use("/messages", messageRoutes);
router.use("/annonces", annonceRoutes);
router.use("/matieres", matiereRoutes);
router.use("/classes", classeRoutes);
router.use("/parents", parentRoutes);
router.use(
    "/dashboard",
    dashboardRoutes
  );

module.exports = router;
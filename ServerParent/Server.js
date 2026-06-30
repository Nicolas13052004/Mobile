const express = require("express");
const cors = require("cors");

const { sequelize } = require("./src/models");
const routes = require("./src/routes");

const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Routes API
app.use("/api/v1", routes);

// Route de test
app.get("/", (req, res) => {
  res.status(200).json({
    success: true,
    message: "ParentConnect API running 🚀",
  });
});

// Gestion globale des erreurs
app.use((err, req, res, next) => {
  console.error("Erreur :", err);

  res.status(500).json({
    success: false,
    message: "Erreur interne du serveur",
  });
});

// Démarrage du serveur
async function startServer() {
  try {
    // Vérification de la connexion PostgreSQL
    await sequelize.authenticate();
    console.log("✅ PostgreSQL connecté");

    // Démarrage du serveur
    app.listen(PORT, "0.0.0.0", () => {
      console.log("====================================");
      console.log(`🚀 Serveur démarré`);
      console.log(`🌐 Local    : http://localhost:${PORT}`);
      console.log(`📱 Réseau   : http://192.168.10.132:${PORT}`);
      console.log("====================================");
    });

  } catch (error) {
    console.error("❌ Impossible de démarrer le serveur");
    console.error(error);
    process.exit(1);
  }
}

startServer();
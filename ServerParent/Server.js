const express = require("express");
const cors = require("cors");

const { sequelize } = require("./src/models");
const routes = require("./src/routes");

const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

// 🔥 API VERSIONING PROPRE
app.use("/api/v1", routes);

// test route
app.get("/", (req, res) => {
  res.json({
    message: "ParentConnect API running 🚀",
  });
});

// 🔥 GLOBAL ERROR HANDLER (IMPORTANT)
app.use((err, req, res, next) => {
  console.error(err);
  res.status(500).json({
    message: "Erreur serveur",
  });
});

async function startServer() {
  try {
    await sequelize.authenticate();
    console.log("✅ PostgreSQL connecté");

    app.listen(PORT, () => {
      console.log(`🚀 Server running on port ${PORT}`);
    });

  } catch (error) {
    console.error("❌ Erreur DB :", error);
  }
}

startServer();
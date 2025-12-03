# SWOT-Matrix-Grafik: S/4HANA Migration
# Laden der benötigten Bibliothek
library(ggplot2)

# Datenbasis erstellen
swot_data <- data.frame(
  Typ = c("STÄRKEN (S)", "SCHWÄCHEN (W)", "CHANCEN (O)", "RISIKEN (T)"),
  Inhalt = c(
    "- Technologisch notwendig\n- Cloud-Kompatibilität\n- Differenzierung",
    "- Hohe Implementierungskosten\n- Langer Support-Aufwand\n- Kundenverluste (Churn)",
    "- Marktanteile gewinnen\n- Höhere Cloud-Margen\n- KI-Integration möglich",
    "- Kundenflucht zu MSFT\n- Reputationsschaden\n- Mittelstand verliert SAP"
  ),
  Farbe = c("#4CAF50", "#FF9800", "#2196F3", "#F44336"),
  X = c(1, 2, 1, 2),
  Y = c(2, 2, 1, 1),
  stringsAsFactors = FALSE
)

# Grafik erstellen
p <- ggplot(swot_data, aes(x = X, y = Y)) +
  # Kacheln mit Farben und Transparenz
  geom_tile(aes(fill = Farbe), color = "white", linewidth = 3, alpha = 0.2) +

  # Farben manuell setzen
  scale_fill_identity() +

  # Titel des Quadranten (fett, oben)
  geom_text(
    aes(label = Typ),
    fontface = "bold",
    size = 5.5,
    vjust = -3.5,
    hjust = 0.5
  ) +

  # Inhalt (Bullet Points, linksbündig)
  geom_text(
    aes(label = Inhalt),
    size = 4,
    vjust = 0.5,
    hjust = 0.5,
    lineheight = 1.1
  ) +

  # Achsen-Konfiguration (2x2 Matrix)
  scale_x_continuous(limits = c(0.5, 2.5), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, 2.5), expand = c(0, 0)) +


  # Komplett leeres Theme (PowerPoint-optimiert)
  theme_void(base_family = "sans") +

  # Theme-Anpassungen
  theme(
    text = element_text(family = "sans"),
    plot.margin = margin(0, 0, 0, 0, "cm"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# Grafik anzeigen
print(p)

# Grafik speichern
# Sicherstellen, dass die Datei im gleichen Verzeichnis wie der Code gespeichert wird
script_dir <- dirname(sys.frame(1)$ofile)
if (is.null(script_dir) || script_dir == "") {
  # Fallback: Verwende das Verzeichnis des Skripts
  script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
}
ggsave(
  file.path(script_dir, "swot_s4hana.png"),
  plot = p,
  width = 10,
  height = 8,
  dpi = 300,
  bg = "white"
)

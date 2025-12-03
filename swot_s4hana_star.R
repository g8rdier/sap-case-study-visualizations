# SWOT-Matrix-Grafik: S/4HANA Zwangsmigration - Strategisch Richtig, Operativ Komplex
# Ziel: Visualisierung einer schwierigen, aber notwendigen Entscheidung
# Laden der benötigten Bibliothek
library(ggplot2)

# Datenbasis erstellen (Fokus: Notwendige, aber schwierige Transformation)
swot_data <- data.frame(
  Typ = c(
    "STÄRKEN (S)\nStrategische Notwendigkeit",
    "SCHWÄCHEN (W)\nOperative Belastung",
    "CHANCEN (O)\nRealisierte Chancen",
    "RISIKEN (T)\nTeilweise Realisierte Risiken"
  ),
  Inhalt = c(
    "- Cloud-Zukunft\n- Technologisch modern\n- Wettbewerbsfähigkeit sichern",
    "- Hohe Implementierungskosten\n- Langer Support-Aufwand\n- Kundenverluste (Churn) initiiert",
    "✓ Marktanteile in Cloud gewinnen\n✓ Höhere Cloud-Margen\n✓ KI-Integration möglich",
    "- Kundenflucht zu MSFT\n- Reputationsschaden (temporär)\n- Mittelstand versucht Abwanderung"
  ),
  Farbe = c("#4CAF50", "#FF9800", "#2196F3", "#FF9966"),  # Threats: zartes Orange statt intensiv rot
  Alpha = c(0.2, 0.2, 0.25, 0.2),  # Opportunities etwas kräftiger (realisiert), Threats nicht zu stark
  X = c(1, 2, 1, 2),
  Y = c(2, 2, 1, 1),
  stringsAsFactors = FALSE
)

# Grafik erstellen
p <- ggplot(swot_data, aes(x = X, y = Y)) +
  # Kacheln mit Farben und individuellen Alpha-Werten
  geom_tile(aes(fill = Farbe, alpha = Alpha), color = "white", linewidth = 3) +

  # Farben und Alpha manuell setzen
  scale_fill_identity() +
  scale_alpha_identity() +

  # Titel des Quadranten (fett, oben, zweizeilig)
  geom_text(
    aes(label = Typ),
    fontface = "bold",
    size = 4.5,
    vjust = -3.2,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Inhalt (Bullet Points, zentriert)
  geom_text(
    aes(label = Inhalt),
    size = 3.8,
    vjust = 0.5,
    hjust = 0.5,
    lineheight = 1.1
  ) +

  # Text-Box links mit Bewertung
  annotate(
    "rect",
    xmin = 0.52, xmax = 1.3, ymin = 0.52, ymax = 0.9,
    fill = "white",
    color = "#CCCCCC",
    linewidth = 0.8
  ) +
  annotate(
    "text",
    x = 0.91,
    y = 0.80,
    label = "Strategie: Richtig",
    fontface = "bold",
    size = 3.2,
    color = "#4CAF50",
    hjust = 0.5,
    family = "sans"
  ) +
  annotate(
    "text",
    x = 0.91,
    y = 0.71,
    label = "Cloud ist die Zukunft",
    size = 2.8,
    color = "#666666",
    hjust = 0.5,
    family = "sans"
  ) +
  annotate(
    "text",
    x = 0.91,
    y = 0.62,
    label = "Umsetzung: Zu aggressiv",
    fontface = "italic",
    size = 2.8,
    color = "#FF9800",
    hjust = 0.5,
    family = "sans"
  ) +

  # Bewertung (groß, unten rechts)
  annotate(
    "text",
    x = 2.35,
    y = 0.65,
    label = "Bewertung:\n6/10",
    fontface = "bold",
    size = 7,
    color = "#4CAF50",
    lineheight = 0.9,
    family = "sans"
  ) +

  # Achsen-Konfiguration (2x2 Matrix)
  scale_x_continuous(limits = c(0.5, 2.5), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, 2.5), expand = c(0, 0)) +

  # Titel hinzufügen
  labs(
    title = "Entscheidung 1: S/4HANA Zwangsmigration (2018-2025) – Strategisch Richtig, Operativ Komplex"
  ) +

  # Komplett leeres Theme (PowerPoint-optimiert)
  theme_void(base_family = "sans") +

  # Theme-Anpassungen
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(
      hjust = 0.5,
      size = 13,
      face = "bold",
      margin = margin(b = 15),
      family = "sans"
    ),
    plot.margin = margin(10, 10, 10, 10, "pt"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# Grafik anzeigen
print(p)

# Grafik speichern (PowerPoint-optimiert)
# Sicherstellen, dass die Datei im gleichen Verzeichnis wie der Code gespeichert wird
script_dir <- getwd()
if (interactive()) {
  # In RStudio: Verwende das Verzeichnis des aktiven Dokuments
  if (requireNamespace("rstudioapi", quietly = TRUE)) {
    script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
  }
}
ggsave(
  file.path(script_dir, "swot_s4hana_star.png"),
  plot = p,
  width = 10,
  height = 8,
  dpi = 300,
  bg = "white"
)

# SWOT-Matrix-Grafik: Qualtrics Übernahme - Theorie vs. Realität
# Laden der benötigten Bibliothek
library(ggplot2)

# Datenbasis erstellen (Aktualisiert: Fokus auf Scheitern der Strategie)
swot_data <- data.frame(
  Typ = c(
    "STÄRKEN (S)\nDas Potenzial (Damals)",
    "SCHWÄCHEN (W)\nDie Realität (Heute)",
    "CHANCEN (O)\nVerfehlte Hoffnungen",
    "RISIKEN (T)\nEingetretene Folgen"
  ),
  Inhalt = c(
    "- Marktführer CX-Analytics\n- Zugriff auf Experience-Data\n- Ergänzung zur ERP-Suite",
    "- Extremer Preis (8 Mrd $)\n- Keine technische Integration\n- Kultureller Clash",
    "(X) Neue Revenue-Streams\n(X) Markt-Differenzierung\nSynergien blieben aus",
    "- Kostenexplosion ohne ROI\n- Fokusverlust im Kern\n- Notverkauf (IPO 2021)"
  ),
  Farbe = c("#4CAF50", "#FF9800", "#AAAAAA", "#F44336"),  # Opportunities grau (nicht realisiert)
  Alpha = c(0.2, 0.2, 0.15, 0.4),  # Threats kräftiger, Opportunities ausgeblichen
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

  # Bewertung (groß, unten rechts)
  annotate(
    "text",
    x = 2.35,
    y = 0.65,
    label = "Bewertung:\n2/10",
    fontface = "bold",
    size = 7,
    color = "#F44336",
    lineheight = 0.9,
    family = "sans"
  ) +

  # Achsen-Konfiguration (2x2 Matrix)
  scale_x_continuous(limits = c(0.5, 2.5), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0.5, 2.5), expand = c(0, 0)) +

  # Titel hinzufügen
  labs(
    title = "Entscheidung 2: Qualtrics-Übernahme – Theorie vs. Realität"
  ) +

  # Komplett leeres Theme (PowerPoint-optimiert)
  theme_void(base_family = "sans") +

  # Theme-Anpassungen
  theme(
    text = element_text(family = "sans"),
    plot.title = element_text(
      hjust = 0.5,
      size = 14,
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
  file.path(script_dir, "../../output/swot/swot_qualtrics.png"),
  plot = p,
  width = 10,
  height = 8,
  dpi = 300,
  bg = "white"
)

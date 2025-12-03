# SAP vs. FI-TS Lessons-Learned Grafik (Fixed - Text nicht abgeschnitten)
# Laden der benötigten Bibliothek
library(ggplot2)

# Datenbasis - 3 Fehler und 3 Lösungen
lessons <- data.frame(
  id = 1:3,
  # Linke Spalte (SAP-Fehler) - bei x=1.5
  fehler = c(
    "Kundenzwang\nbei S/4HANA",
    "Qualtrics\nnicht integriert",
    "Alte Produkte\nbehalten"
  ),
  fehler_x = 1.5,
  fehler_y = c(8, 5, 2),

  # Rechte Spalte (FI-TS Lösung) - bei x=8 (vorher 9)
  loesung = c(
    "Change Management\nplanen",
    "Integration\nvor Akquisition",
    "Portfolio-Disziplin\nüben"
  ),
  loesung_x = 8,
  loesung_y = c(8, 5, 2),

  # Pfeile (Mitte)
  pfeil_x_start = 3.4,
  pfeil_x_end = 6.6,
  pfeil_y = c(8, 5, 2)
)

# Grafik erstellen
p <- ggplot() +
  # Linke Spalte: SAP-Fehler (Rote Boxen)
  geom_rect(
    data = lessons,
    aes(xmin = fehler_x - 1.2, xmax = fehler_x + 1.2,
        ymin = fehler_y - 0.8, ymax = fehler_y + 0.8),
    fill = "#F44336",
    color = "#C62828",
    linewidth = 1,
    alpha = 0.9
  ) +

  # Text in den roten Boxen
  geom_text(
    data = lessons,
    aes(x = fehler_x, y = fehler_y, label = fehler),
    color = "white",
    fontface = "bold",
    size = 4.5,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Rechte Spalte: FI-TS Lösungen (Grüne Boxen)
  geom_rect(
    data = lessons,
    aes(xmin = loesung_x - 1.2, xmax = loesung_x + 1.2,
        ymin = loesung_y - 0.8, ymax = loesung_y + 0.8),
    fill = "#4CAF50",
    color = "#2E7D32",
    linewidth = 1,
    alpha = 0.9
  ) +

  # Text in den grünen Boxen
  geom_text(
    data = lessons,
    aes(x = loesung_x, y = loesung_y, label = loesung),
    color = "white",
    fontface = "bold",
    size = 4.5,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Pfeile (Mitte) - von links nach rechts
  geom_segment(
    data = lessons,
    aes(x = pfeil_x_start, y = pfeil_y, xend = pfeil_x_end, yend = pfeil_y),
    arrow = arrow(length = unit(0.3, "cm"), type = "closed"),
    color = "#455A64",
    linewidth = 1.5
  ) +

  # Titel der linken Spalte
  annotate(
    "text",
    x = 1.5,
    y = 10.5,
    label = "SAP-Fehler",
    fontface = "bold",
    size = 6,
    hjust = 0.5,
    color = "#C62828"
  ) +

  # Titel der rechten Spalte
  annotate(
    "text",
    x = 8,
    y = 10.5,
    label = "FI-TS Empfehlung",
    fontface = "bold",
    size = 6,
    hjust = 0.5,
    color = "#2E7D32"
  ) +

  # Achsen-Konfiguration (erweitert für rechten Text)
  scale_x_continuous(limits = c(-0.5, 10.5), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 12), expand = c(0, 0)) +

  # Festes Seitenverhältnis
  coord_fixed(ratio = 0.7) +

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

# Grafik speichern (breiteres Format)
# Sicherstellen, dass die Datei im gleichen Verzeichnis wie der Code gespeichert wird
script_dir <- dirname(sys.frame(1)$ofile)
if (is.null(script_dir) || script_dir == "") {
  # Fallback: Verwende das Verzeichnis des Skripts
  script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
}
ggsave(
  file.path(script_dir, "../../output/analysis/lessons_learned_fixed.png"),
  plot = p,
  width = 14,  # Breiter (vorher 10)
  height = 8,
  dpi = 300,
  bg = "white"
)

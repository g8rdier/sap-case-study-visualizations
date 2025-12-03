# SAP Execution Gap - Dumbbell Plot (Hantel-Diagramm)
# Gap-Analyse: Strategisches Potenzial vs. Operative Realität
# Laden der benötigten Bibliotheken
library(ggplot2)
library(dplyr)

# Datenbasis erstellen (Gap-Analyse)
gap_data <- data.frame(
  Thema = c(
    "S/4HANA Migration",
    "Qualtrics Übernahme",
    "Cloud Only Strategie"
  ),
  Strategie = c(9, 7, 8),
  Umsetzung = c(5, 2, 4),
  # Erklärungen für die Scores
  Strategie_Text = c(
    "Cloud ist Zukunft",
    "CX Analytics",
    "Innovation"
  ),
  Umsetzung_Text = c(
    "Zwang & Komplexität",
    "Keine Synergien",
    "Kosten vs. Zeit"
  )
)

# Thema als Factor für richtige Reihenfolge (von oben nach unten)
gap_data$Thema <- factor(gap_data$Thema, levels = rev(gap_data$Thema))

# Grafik erstellen
p <- ggplot(gap_data) +
  # Verbindungslinien (Hanteln) - hellgrau
  geom_segment(
    aes(x = Umsetzung, xend = Strategie, y = Thema, yend = Thema),
    color = "#e0e0e0",
    linewidth = 3
  ) +

  # Punkte: Umsetzung (Orange)
  geom_point(
    aes(x = Umsetzung, y = Thema),
    color = "#FF9800",
    size = 12,
    alpha = 0.9
  ) +

  # Punkte: Strategie (Blau)
  geom_point(
    aes(x = Strategie, y = Thema),
    color = "#2196F3",
    size = 12,
    alpha = 0.9
  ) +

  # Scores IN den Punkten (weiß, fett) - Umsetzung
  geom_text(
    aes(x = Umsetzung, y = Thema, label = Umsetzung),
    color = "white",
    fontface = "bold",
    size = 5,
    family = "sans"
  ) +

  # Scores IN den Punkten (weiß, fett) - Strategie
  geom_text(
    aes(x = Strategie, y = Thema, label = Strategie),
    color = "white",
    fontface = "bold",
    size = 5,
    family = "sans"
  ) +

  # Erklärungen UNTER den Punkten - Umsetzung (Orange) - mehr Abstand!
  geom_text(
    aes(x = Umsetzung, y = as.numeric(Thema) - 0.35, label = Umsetzung_Text),
    color = "#FF9800",
    fontface = "italic",
    size = 3,
    family = "sans",
    hjust = 0.5,
    vjust = 1
  ) +

  # Erklärungen ÜBER den Punkten - Strategie (Blau) - mehr Abstand!
  geom_text(
    aes(x = Strategie, y = as.numeric(Thema) + 0.35, label = Strategie_Text),
    color = "#2196F3",
    fontface = "italic",
    size = 3,
    family = "sans",
    hjust = 0.5,
    vjust = 0
  ) +

  # Legende als Annotation (rechts oben)
  annotate(
    "rect",
    xmin = 7.5, xmax = 10.5, ymin = 2.7, ymax = 3.3,
    fill = "white",
    color = "#cccccc",
    linewidth = 0.5
  ) +
  annotate(
    "point",
    x = 7.8, y = 3.15,
    color = "#2196F3",
    size = 5
  ) +
  annotate(
    "text",
    x = 8.3, y = 3.15,
    label = "Strategie-Potenzial",
    hjust = 0,
    size = 3.5,
    family = "sans"
  ) +
  annotate(
    "point",
    x = 7.8, y = 2.85,
    color = "#FF9800",
    size = 5
  ) +
  annotate(
    "text",
    x = 8.3, y = 2.85,
    label = "Operative Realität",
    hjust = 0,
    size = 3.5,
    family = "sans"
  ) +

  # Achsen-Konfiguration
  scale_x_continuous(
    limits = c(0, 11),
    breaks = seq(0, 10, 2),
    expand = c(0.02, 0)
  ) +

  # Y-Achse: Mehr Abstand zwischen den Themen für bessere Lesbarkeit
  scale_y_discrete(
    expand = expansion(add = c(0.6, 0.6))
  ) +

  # Beschriftungen
  labs(
    title = "Das SAP-Dilemma: Strategisches Potenzial vs. Operative Realität",
    subtitle = "Gap-Analyse der wichtigsten Entscheidungen (2018-2024)",
    x = "\nScore (1 = niedrig, 10 = hoch)",
    y = NULL
  ) +

  # Minimalistisches Design (PowerPoint-optimiert)
  theme_minimal(base_size = 12, base_family = "sans") +
  theme(
    plot.title = element_text(
      hjust = 0.5,
      size = 16,
      face = "bold",
      margin = margin(b = 5),
      family = "sans"
    ),
    plot.subtitle = element_text(
      hjust = 0.5,
      size = 11,
      color = "#666666",
      margin = margin(b = 20),
      family = "sans"
    ),
    axis.title.x = element_text(
      size = 11,
      face = "bold",
      family = "sans"
    ),
    axis.text.y = element_text(
      size = 12,
      face = "bold",
      family = "sans"
    ),
    axis.text.x = element_text(
      size = 10,
      family = "sans"
    ),
    panel.grid.major.y = element_line(color = "#f0f0f0", linewidth = 0.5),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_line(color = "#f0f0f0", linewidth = 0.3),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(20, 20, 20, 20, "pt")
  )

# Grafik anzeigen
print(p)

# Grafik speichern (PowerPoint-optimiert)
# Sicherstellen, dass die Datei im gleichen Verzeichnis wie der Code gespeichert wird
script_dir <- dirname(sys.frame(1)$ofile)
if (is.null(script_dir) || script_dir == "") {
  # Fallback: Verwende das Verzeichnis des Skripts
  script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
}
ggsave(
  file.path(script_dir, "sap_execution_gap.png"),
  plot = p,
  width = 10,
  height = 6,
  dpi = 300,
  bg = "white"
)

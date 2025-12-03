# SAP Execution Gap - Dumbbell Plot (Hantel-Diagramm)
# Vergleich der zwei analysierten Entscheidungen: S/4HANA vs. Qualtrics
# Laden der benötigten Bibliotheken
library(ggplot2)
library(dplyr)

# Datenbasis erstellen (Nur analysierte Entscheidungen)
gap_data <- data.frame(
  Thema = c(
    "S/4HANA Migration",
    "Qualtrics Übernahme"
  ),
  Strategie = c(9, 7),
  Umsetzung = c(5, 2),
  # Erklärungen für die Scores
  Strategie_Text = c(
    "Alternativlos",
    "Theoretisch gut"
  ),
  Umsetzung_Text = c(
    "Schwierig",
    "Desaströs"
  )
)

# Thema als Factor für richtige Reihenfolge (von oben nach unten)
gap_data$Thema <- factor(gap_data$Thema, levels = rev(gap_data$Thema))

# Daten für Legende vorbereiten (Long-Format für Punkte)
legend_data <- data.frame(
  Thema = rep(gap_data$Thema, 2),
  Wert = c(gap_data$Umsetzung, gap_data$Strategie),
  Typ = factor(rep(c("Operative Umsetzung", "Strategische Absicht"), each = nrow(gap_data)),
               levels = c("Strategische Absicht", "Operative Umsetzung"))
)

# Grafik erstellen
p <- ggplot(gap_data) +
  # Verbindungslinien (Hanteln) - hellgrau
  geom_segment(
    aes(x = Umsetzung, xend = Strategie, y = Thema, yend = Thema),
    color = "#e0e0e0",
    linewidth = 3
  ) +

  # Punkte mit Legende
  geom_point(
    data = legend_data,
    aes(x = Wert, y = Thema, color = Typ),
    size = 12,
    alpha = 0.9
  ) +

  # Manuelle Farbskala
  scale_color_manual(
    name = "",
    values = c("Strategische Absicht" = "#2196F3", "Operative Umsetzung" = "#FF9800"),
    breaks = c("Strategische Absicht", "Operative Umsetzung")
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
    title = "Strategie vs. Realität: Die Analyse",
    x = "\nStrategie-Potenzial (1 = niedrig, 10 = hoch)",
    y = "Entscheidungen"
  ) +

  # Minimalistisches Design (PowerPoint-optimiert)
  theme_minimal(base_size = 12, base_family = "sans") +
  theme(
    plot.title = element_text(
      hjust = 0.5,
      size = 16,
      face = "bold",
      margin = margin(b = 15),
      family = "sans"
    ),
    axis.title.x = element_text(
      size = 11,
      face = "bold",
      family = "sans"
    ),
    axis.title.y = element_text(
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
    plot.margin = margin(20, 20, 20, 20, "pt"),
    # Legende unten positionieren
    legend.position = "bottom",
    legend.direction = "horizontal",
    legend.text = element_text(size = 11, family = "sans"),
    legend.spacing.x = unit(0.5, "cm"),
    legend.margin = margin(t = 10, b = 0)
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
  file.path(script_dir, "sap_execution_gap.png"),
  plot = p,
  width = 10,
  height = 5,
  dpi = 300,
  bg = "white"
)

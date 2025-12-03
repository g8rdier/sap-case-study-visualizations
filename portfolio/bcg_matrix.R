# BCG-Matrix Visualisierung (SAP Geschäftsbericht 2024 - Offizielle Daten)
# Laden der benötigten Bibliothek
library(ggplot2)

# Datenbasis erstellen mit offiziellen SAP-Produktnamen und -Daten
data <- data.frame(
  SGE = c("A", "B", "C", "D"),
  Produktname = factor(
    c("A", "B", "C", "D"),
    levels = c("A", "B", "C", "D"),
    labels = c(
      "Cloud ERP Suite (S/4HANA) - Star",
      "Software Support (Cash Cow)",
      "Extension Suite (BTP) - Question Mark",
      "IaaS Cloud Services (Poor Dog)"
    )
  ),
  Marktanteil_relativ = c(1.8, 1.5, 0.7, 0.3),
  Marktwachstum = c(33, -4, 6, -28),
  Umsatz = c(14.2, 12.7, 2.4, 0.5)
)

# Grafik erstellen
ggplot(data, aes(x = Marktanteil_relativ, y = Marktwachstum, size = Umsatz, color = Produktname)) +
  # Bubbles mit unterschiedlichen Farben
  geom_point(alpha = 0.6) +

  # Farbpalette für die 4 SGEs (SAP-inspirierte Farben)
  scale_color_manual(
    values = c(
      "Cloud ERP Suite (S/4HANA) - Star" = "#17B863",              # Grün (Star)
      "Software Support (Cash Cow)" = "#0070F2",                   # SAP Blau (Cash Cow)
      "Extension Suite (BTP) - Question Mark" = "#F0AB00",         # SAP Gold (Question Mark)
      "IaaS Cloud Services (Poor Dog)" = "#8B9198"                 # Grau (Poor Dog)
    ),
    name = "Produkte"
  ) +

  # Quadranten-Trennlinien
  geom_vline(xintercept = 1.0, linetype = "dashed", color = "gray40", linewidth = 0.8) +
  geom_hline(yintercept = 5, linetype = "dashed", color = "gray40", linewidth = 0.8) +

  # Achsen-Konfiguration
  scale_x_log10(
    breaks = c(0.1, 0.2, 0.5, 1, 2, 5),
    labels = c("0.1x", "0.2x", "0.5x", "1x", "2x", "5x"),
    limits = c(0.1, 5)
  ) +
  scale_x_reverse() +  # Invertiert die X-Achse (hohe Werte links)

  scale_y_continuous(
    breaks = seq(-30, 40, 10),
    labels = paste0(seq(-30, 40, 10), "%"),
    limits = c(-35, 45),
    expand = expansion(mult = 0.1)
  ) +

  # Blasengröße-Skala (mit Legende)
  scale_size_continuous(
    range = c(5, 20),
    name = "Umsatz in Mrd. €",
    breaks = c(0.5, 2.5, 5, 10, 14),
    labels = c("0.5", "2.5", "5", "10", "14")
  ) +

  # Verhindert Abschneiden der Bubbles am Rand
  coord_cartesian(clip = "off") +

  # Beschriftungen
  labs(
    x = "Relativer Marktanteil",
    y = "Reales Marktwachstum"
  ) +

  # Minimalistisches Design (PowerPoint-optimiert)
  theme_minimal(base_size = 12, base_family = "sans") +
  theme(
    plot.title = element_text(hjust = 0.5, size = 16, face = "bold", family = "sans"),
    axis.title = element_text(size = 12, face = "bold", family = "sans"),
    axis.text = element_text(size = 10, family = "sans"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(color = "gray90", linewidth = 0.5),
    legend.position = "right",
    legend.title = element_text(size = 10, face = "bold", family = "sans"),
    legend.text = element_text(size = 8, family = "sans"),
    legend.key.size = unit(0.8, "cm"),
    legend.spacing.y = unit(0.3, "cm"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    plot.margin = margin(10, 10, 10, 10, "mm")
  ) +
  # Legenden-Reihenfolge: Farbe zuerst, dann Größe
  guides(
    color = guide_legend(order = 1, override.aes = list(size = 5)),
    size = guide_legend(order = 2)
  )

# Grafik speichern (PowerPoint-optimiert)
# Sicherstellen, dass die Datei im gleichen Verzeichnis wie der Code gespeichert wird
script_dir <- dirname(sys.frame(1)$ofile)
if (is.null(script_dir) || script_dir == "") {
  # Fallback: Verwende das Verzeichnis des Skripts
  script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
}
ggsave(
  file.path(script_dir, "bcg_matrix.png"),
  width = 10,
  height = 7,
  dpi = 300,
  bg = "white"
)

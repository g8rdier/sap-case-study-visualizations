# SAP Umsatzaufspaltung 2024 - Donut Chart (Korrigiert)
# Benötigte Pakete installieren (falls nicht vorhanden)
if (!require("ggrepel", quietly = TRUE)) {
  install.packages("ggrepel")
}

# Laden der benötigten Bibliotheken
library(ggplot2)
library(ggrepel)
library(dplyr)

# Datenbasis erstellen (in Mrd. €)
umsatz_data <- data.frame(
  Kategorie = factor(
    c("Cloud-Erlöse", "Softwarelizenzen &\nSupport", "Services &\nSonstiges"),
    levels = c("Cloud-Erlöse", "Softwarelizenzen &\nSupport", "Services &\nSonstiges")
  ),
  Wert = c(17.14, 12.69, 4.35),
  Farbe = c("#0070C0", "#808080", "#D9D9D9")
)

# Prozentanteile berechnen
umsatz_data <- umsatz_data %>%
  mutate(
    Prozent = round(Wert / sum(Wert) * 100, 1),
    Label = paste0(Kategorie, "\n", Prozent, "%\n(", Wert, " Mrd. €)")
  )

# Position für Labels berechnen (Mittelpunkt jedes Segments)
umsatz_data <- umsatz_data %>%
  arrange(desc(Kategorie)) %>%
  mutate(
    ypos = cumsum(Wert) - 0.5 * Wert,
    xpos = 2.8  # Position außerhalb des Rings
  )

# Gesamtumsatz für Mitte
total_umsatz <- sum(umsatz_data$Wert)

# Donut Chart erstellen
p <- ggplot(umsatz_data, aes(x = 2, y = Wert, fill = Farbe)) +
  # Donut Ring
  geom_col(width = 1, color = "white", linewidth = 2) +

  # Farben manuell setzen
  scale_fill_identity() +

  # Labels mit ggrepel (außerhalb des Rings)
  geom_text_repel(
    aes(x = 2.5, y = ypos, label = Label),
    color = "#333333",
    fontface = "bold",
    size = 3.5,
    lineheight = 0.85,
    family = "sans",
    nudge_x = 0.8,
    segment.color = "#999999",
    segment.size = 0.5,
    min.segment.length = 0,
    box.padding = 0.5,
    point.padding = 0.3,
    direction = "both",
    force = 2,
    max.overlaps = 20
  ) +

  # Text in der Mitte (Total)
  annotate(
    "text",
    x = 0.5,
    y = 0,
    label = paste0("Total\n", round(total_umsatz, 1), " Mrd. €"),
    fontface = "bold",
    size = 6,
    color = "#333333",
    lineheight = 0.9,
    family = "sans"
  ) +

  # Loch in der Mitte (xlim erstellt Donut-Effekt)
  xlim(c(0.5, 3.5)) +

  # Polar Koordinaten für Kreisform
  coord_polar(theta = "y") +

  # Komplett leeres Theme (PowerPoint-optimiert)
  theme_void(base_family = "sans") +
  theme(
    text = element_text(family = "sans"),
    plot.margin = margin(0, 0, 0, 0, "cm"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA),
    legend.position = "none"
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
  file.path(script_dir, "donut_umsatz.png"),
  plot = p,
  width = 6,
  height = 6,
  dpi = 300,
  bg = "white"
)

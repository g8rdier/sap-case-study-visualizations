# Five Forces Grafik (Porter-Modell) - SAP Fallstudie (Klassisches Layout)
# Laden der benötigten Bibliothek
library(ggplot2)

# Zentrale Box - Rivalität unter Wettbewerbern (Mitte)
center_box <- data.frame(
  xmin = 3.5,
  xmax = 6.5,
  ymin = 4.5,
  ymax = 6.5,
  fill = "#F44336"  # Rot für HOCH
)

# Grafik erstellen
p <- ggplot() +
  # Zentrale Box - Rivalität (Rot, HOCH)
  geom_rect(
    data = center_box,
    aes(xmin = xmin, xmax = xmax, ymin = ymin, ymax = ymax),
    fill = "#F44336",
    color = "#C62828",
    linewidth = 2,
    alpha = 0.9
  ) +

  # Text in der zentralen Box
  annotate(
    "text",
    x = 5,
    y = 5.5,
    label = "Rivalität unter\nWettbewerbern\n(5/5 - HOCH)",
    fontface = "bold",
    size = 4.5,
    hjust = 0.5,
    lineheight = 0.9,
    color = "white"
  ) +

  # Pfeil: Neue Anbieter (OBEN) → Mitte
  geom_segment(
    aes(x = 5, y = 8.5, xend = 5, yend = 6.7),
    arrow = arrow(length = unit(0.4, "cm"), type = "closed"),
    color = "#FF9800",
    linewidth = 2,
    alpha = 0.8
  ) +

  # Pfeil: Substitute (UNTEN) → Mitte
  geom_segment(
    aes(x = 5, y = 2, xend = 5, yend = 4.3),
    arrow = arrow(length = unit(0.4, "cm"), type = "closed"),
    color = "#4CAF50",
    linewidth = 2,
    alpha = 0.8
  ) +

  # Pfeil: Lieferanten (LINKS) → Mitte
  geom_segment(
    aes(x = 1, y = 5.5, xend = 3.3, yend = 5.5),
    arrow = arrow(length = unit(0.4, "cm"), type = "closed"),
    color = "#4CAF50",
    linewidth = 2,
    alpha = 0.8
  ) +

  # Pfeil: Kunden (RECHTS) → Mitte
  geom_segment(
    aes(x = 9, y = 5.5, xend = 6.7, yend = 5.5),
    arrow = arrow(length = unit(0.4, "cm"), type = "closed"),
    color = "#FF9800",
    linewidth = 2,
    alpha = 0.8
  ) +

  # Label: Neue Anbieter (OBEN)
  annotate(
    "text",
    x = 5,
    y = 9.5,
    label = "Neue Anbieter\n(3/5 - MITTEL)",
    fontface = "bold",
    size = 4,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Label: Substitute (UNTEN)
  annotate(
    "text",
    x = 5,
    y = 1,
    label = "Substitute\n(1/5 - GERING)",
    fontface = "bold",
    size = 4,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Label: Lieferanten (LINKS)
  annotate(
    "text",
    x = 1,
    y = 6.8,
    label = "Verhandlungsstärke\nLieferanten\n(1/5 - GERING)",
    fontface = "bold",
    size = 4,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Label: Kunden (RECHTS)
  annotate(
    "text",
    x = 9,
    y = 6.8,
    label = "Verhandlungsstärke\nKunden\n(4/5 - MITTEL-HOCH)",
    fontface = "bold",
    size = 4,
    hjust = 0.5,
    lineheight = 0.9
  ) +

  # Achsen-Konfiguration
  scale_x_continuous(limits = c(0, 10), expand = c(0, 0)) +
  scale_y_continuous(limits = c(0, 11), expand = c(0, 0)) +

  # Festes Seitenverhältnis
  coord_fixed(ratio = 1) +

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
  file.path(script_dir, "five_forces.png"),
  plot = p,
  width = 10,
  height = 10,
  dpi = 300,
  bg = "white"
)

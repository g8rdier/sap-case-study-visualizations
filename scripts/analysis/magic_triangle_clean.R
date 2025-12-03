# Magisches Dreieck: Qualität-Zeit-Kosten (Clean Version)
# Laden der benötigten Bibliothek
library(ggplot2)

# Datenbasis erstellen - Koordinaten der Ecken
triangle_corners <- data.frame(
  x = c(0, -0.866, 0.866),
  y = c(1, -0.5, -0.5),
  Label_Main = c("QUALITÄT", "ZEIT", "KOSTEN"),
  Label_Sub = c(
    "[+] HOCH\n(KI, Innovation)",
    "[~] MITTEL\n(5+ Jahre Transition)",
    "[-] SEHR HOCH\n(Premium-Preise)"
  ),
  Farbe = c("#4CAF50", "#FF9800", "#F44336")
)

# Mittelpunkt
center <- data.frame(x = 0, y = 0)

# Grafik erstellen
p <- ggplot() +
  # Dreieck (Polygon) mit hellgrauer Füllung
  geom_polygon(
    data = triangle_corners,
    aes(x = x, y = y),
    fill = "gray95",
    color = "gray30",
    linewidth = 1.5
  ) +

  # Gestrichelte Linien von der Mitte zu den Ecken
  geom_segment(
    data = triangle_corners,
    aes(x = 0, y = 0, xend = x, yend = y),
    linetype = "dashed",
    color = "gray50",
    linewidth = 0.8
  ) +

  # Große Punkte an den Ecken (Ampel-Farben)
  geom_point(
    data = triangle_corners,
    aes(x = x, y = y, color = Farbe),
    size = 8,
    alpha = 0.9
  ) +

  # Farben manuell setzen
  scale_color_identity() +

  # Hauptbegriffe (QUALITÄT, ZEIT, KOSTEN) - fett und groß
  geom_text(
    data = data.frame(
      x = c(0, -0.866, 0.866),
      y = c(1.25, -0.75, -0.75),
      label = c("QUALITÄT", "ZEIT", "KOSTEN")
    ),
    aes(x = x, y = y, label = label),
    fontface = "bold",
    size = 6,
    hjust = 0.5
  ) +

  # Bewertungs-Texte (darunter)
  geom_text(
    data = data.frame(
      x = c(0, -0.866, 0.866),
      y = c(1.05, -0.95, -0.95),
      label = c(
        "[+] HOCH\n(KI, Innovation)",
        "[~] MITTEL\n(5+ Jahre Transition)",
        "[-] SEHR HOCH\n(Premium-Preise)"
      )
    ),
    aes(x = x, y = y, label = label),
    size = 3.5,
    hjust = 0.5,
    lineheight = 0.9,
    color = "gray20"
  ) +

  # Mittelpunkt (grauer Punkt)
  geom_point(
    data = center,
    aes(x = x, y = y),
    size = 6,
    color = "gray50",
    alpha = 0.8
  ) +

  # Text "Zielkonflikt" in der Mitte
  geom_text(
    data = center,
    aes(x = x, y = y, label = "Zielkonflikt"),
    fontface = "bold",
    size = 4,
    vjust = -1.5,
    color = "gray30"
  ) +

  # Achsen-Konfiguration
  coord_fixed(ratio = 1) +
  scale_x_continuous(limits = c(-1.3, 1.3)) +
  scale_y_continuous(limits = c(-1.3, 1.5)) +

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
  file.path(script_dir, "../../output/analysis/magic_triangle_clean.png"),
  plot = p,
  width = 8,
  height = 8,
  dpi = 300,
  bg = "white"
)

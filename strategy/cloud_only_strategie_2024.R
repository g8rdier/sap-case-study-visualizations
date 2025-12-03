# Cloud Only Strategie - Drei Säulen (SAP Geschäftsbericht 2024)
# Laden der benötigten Bibliotheken
library(ggplot2)
library(stringr)

# 1. Daten definieren (sauber getrennt)
# Basis: Geht von y=0 bis y=1.5
# Säulen: Gehen von y=1.6 bis y=10 (Lücke von 0.1 -> KEINE Überlappung)

# RISE breiter = wichtiger (Cloud ERP ist der Star mit +33% Wachstum!)
rects <- data.frame(
  id = c(1, 2, 3, 4),
  xmin = c(0, 1, 4.5, 7.5),
  xmax = c(10, 4, 7, 10),
  ymin = c(0, 1.6, 1.6, 1.6),
  ymax = c(1.5, 10, 10, 10),
  fill = c("#0070F2", "#2196F3", "#FF9800", "#4CAF50")  # Clean Core in SAP Blau
)

# 2. Text definieren (mit automatischem Umbruch) - AKTUALISIERT 2024
texts <- data.frame(
  label = c("Clean Core – Standardisierte Prozesse",
            "RISE with SAP",
            "Extension Suite (BTP)",
            "Ecosystem Partner",
            # Beschreibungen (aktualisiert)
            "Cloud ERP Migration (S/4HANA)",
            "Integration & Erweiterung",
            "Partner-Innovation",
            # Zeithorizonte (präzisiert)
            "KURZFRISTIG:\n2025-2027 Migration",
            "MITTELFRISTIG:\n2025+ Integration",
            "LANGFRISTIG:\n2027+ Innovation"),
  x = c(5, 2.5, 5.75, 8.75, 2.5, 5.75, 8.75, 2.5, 5.75, 8.75),  # X-Positionen angepasst
  y = c(0.75, 9, 9, 9, 6.5, 6.5, 6.5, 3.5, 3.5, 3.5), # Zeithorizonte bei y=3.5
  size = c(5, 5, 5, 5, 4, 4, 4, 3.5, 3.5, 3.5),
  fontface = c("bold", "bold", "bold", "bold", "italic", "italic", "italic", "bold", "bold", "bold"),
  color = c("white", "white", "white", "white", "white", "white", "white", "white", "white", "white")
)

# Text automatisch umbrechen (max 15 Zeichen Breite)
texts$label <- str_wrap(texts$label, width = 15)

# 3. Plotten
p <- ggplot() +
  # Rechtecke
  geom_rect(data = rects, aes(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax, fill=fill), color=NA) +
  scale_fill_identity() +

  # Text
  geom_text(data = texts, aes(x=x, y=y, label=label, fontface=fontface, size=size, color=color)) +
  scale_size_identity() +
  scale_color_identity() +

  # Layout (PowerPoint-optimiert)
  theme_void(base_family = "sans") +
  coord_fixed(ratio = 0.7) + # Verhältnis fixieren damit es nicht verzerrt
  theme(
    text = element_text(family = "sans"),
    plot.margin = margin(0, 0, 0, 0, "cm"),
    plot.background = element_rect(fill = "white", color = NA),
    panel.background = element_rect(fill = "white", color = NA)
  )

# Grafik anzeigen
print(p)

# Speichern (PowerPoint-optimiert)
# Sicherstellen, dass die Datei im gleichen Verzeichnis wie der Code gespeichert wird
script_dir <- dirname(sys.frame(1)$ofile)
if (is.null(script_dir) || script_dir == "") {
  # Fallback: Verwende das Verzeichnis des Skripts
  script_dir <- dirname(rstudioapi::getActiveDocumentContext()$path)
}
ggsave(
  file.path(script_dir, "cloud_only_strategie_2024.png"),
  plot = p,
  width = 10,
  height = 7,
  dpi = 300,
  bg = "white"
)

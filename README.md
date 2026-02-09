# IPA Documentation Framework

Ein vollständig automatisiertes Hugo-Framework für die Erstellung von IPA-Dokumentationen (Individuelle Praktische Arbeit) mit HTML-Website und PDF-Export.

## Features

- ✅ **Automatische Kapitelnummerierung** (mehrstufig)
- ✅ **Automatische Abbildungsnummerierung** (global)
- ✅ **Automatisches Inhaltsverzeichnis**
- ✅ **Glossar mit Tooltips** und automatischer Indexgenerierung
- ✅ **Arbeitsjournal** automatisch nach Datum sortiert
- ✅ **Mermaid-Diagramme** mit PDF-Unterstützung
- ✅ **Akademisches PDF-Layout** (Titelblatt, Kopf-/Fusszeilen, Seitenzahlen)
- ✅ **HTML-Website UND kompiliertes PDF**
- ✅ **Keine manuelle Sortierung** erforderlich
- ✅ **Erweiterbare Architektur** für technische Dokumentation

## Schnellstart

### Voraussetzungen

- [Hugo Extended](https://gohugo.io/getting-started/installing/) (v0.110+)
- [Pandoc](https://pandoc.org/) oder [WeasyPrint](https://weasyprint.org/) für PDF-Export
- Optional: [Node.js](https://nodejs.org/) + [mermaid-cli](https://github.com/mermaid-js/mermaid-cli) für Diagramm-Pre-Rendering

### Installation

```bash
# Repository klonen
git clone <repository-url>
cd ipa-template

# Entwicklungsserver starten
hugo server

# Oder mit Build-Script
./scripts/build.sh serve
```

### Vollständiger Build (HTML + PDF)

```bash
# Scripts ausführbar machen
chmod +x scripts/*.sh

# Vollständiger Build
./scripts/build.sh

# Nur HTML
./scripts/build.sh html

# Nur PDF
./scripts/build.sh pdf
```

## Projektstruktur

```
ipa-template/
├── hugo.toml                 # Hauptkonfiguration
├── content/                  # Dokumentationsinhalt
│   ├── _index.md             # Titelblatt
│   ├── part_1/               # Kapitel 1: Einleitung
│   │   ├── _index.md         # Kapitel-Titelseite
│   │   ├── 01_projektauftrag.md
│   │   ├── 02_projektumfeld.md
│   │   └── 03_zeitplanung.md
│   ├── part_2/               # Kapitel 2: Hauptteil
│   │   ├── _index.md
│   │   ├── 01_anforderungsanalyse.md
│   │   ├── 02_konzept.md
│   │   └── 03_implementation.md
│   ├── part_3/               # Kapitel 3: Schluss
│   │   ├── _index.md
│   │   ├── 01_testing.md
│   │   ├── 02_fazit.md
│   │   └── 03_anhang.md
│   ├── arbeitsjournal/       # Arbeitsjournal
│   │   ├── _index.md
│   │   └── YYYY-MM-DD.md     # Einträge nach Datum
│   ├── glossar/              # Glossar
│   │   └── _index.md
│   └── pdf/                  # PDF-Kompilation
│       └── _index.md
├── data/
│   └── glossary.yaml         # Glossardaten
├── layouts/
│   ├── _default/
│   │   ├── baseof.html       # Basis-Template
│   │   ├── home.html         # Titelblatt
│   │   ├── section.html      # Kapitel-Listen
│   │   └── single.html       # Einzelseiten
│   ├── arbeitsjournal/
│   │   └── list.html         # Journal-Timeline
│   ├── glossar/
│   │   └── list.html         # Glossar-Index
│   ├── pdf/
│   │   └── list.html         # PDF-Kompilation
│   ├── partials/
│   │   ├── head.html
│   │   ├── header.html
│   │   ├── footer.html
│   │   └── scripts.html
│   └── shortcodes/
│       ├── figure.html       # Abbildungen
│       ├── glossary.html     # Glossar-Referenzen
│       ├── diagram.html      # Mermaid-Diagramme
│       ├── term-list.html    # Glossar-Liste
│       ├── param.html        # Parameter-Zugriff
│       └── ref.html          # Querverweise
├── static/
│   ├── css/
│   │   ├── main.css          # Haupt-Stylesheet
│   │   └── pdf.css           # PDF/Print-Stylesheet
│   └── js/
│       └── main.js           # Client-JavaScript
└── scripts/
    ├── build.sh              # Haupt-Build-Script
    └── render-diagrams.sh    # Diagramm-Pre-Rendering
```

## Konfiguration

### Site-Metadaten (`hugo.toml`)

```toml
[params]
  author = 'Kandidat Name'
  supervisor = 'Fachvorgesetzte/r Name'
  expert = 'Expert/in Name'
  company = 'Firma AG'
  apprenticeship = 'Informatiker/in EFZ Applikationsentwicklung'
  ipaTitle = 'IPA Dokumentation Titel'
  ipaSubtitle = 'Untertitel der Arbeit'
  ipaYear = '2026'
  ipaStartDate = '2026-01-15'
  ipaEndDate = '2026-02-09'
```

## Shortcodes

### Abbildungen mit automatischer Nummerierung

```markdown
{{< figure src="/images/diagram.png" caption="Systemarchitektur" >}}
```

Ergebnis: "Abbildung 1: Systemarchitektur"

### Glossar-Referenzen

```markdown
Die {{< glossary "API" >}} ermöglicht die Kommunikation zwischen Systemen.
```

Zeigt Tooltip mit Definition und verlinkt zum Glossar.

### Mermaid-Diagramme

```markdown
{{< diagram caption="Sequenzdiagramm" >}}
sequenceDiagram
    User->>Server: Request
    Server-->>User: Response
{{< /diagram >}}
```

### Querverweise

```markdown
Siehe {{< ref "fig-1" "Abbildung 1" >}} für Details.
```

### Parameter-Zugriff

```markdown
Autor: {{< param "author" >}}
```

## Automatische Nummerierung

### Wie es funktioniert

1. **Kapitelnummerierung**: Basiert auf der Reihenfolge der Sections in `content/`
2. **Unterkapitelnummerierung**: Basiert auf `weight` in Front Matter oder Dateinamen-Präfix (01_, 02_, etc.)
3. **Abbildungsnummerierung**: Global via Hugo Scratch-Variablen
4. **Diagrammnummerierung**: Separat global nummeriert

### Beispiel

```
Kapitel 1: Einleitung
├── 1.1 Projektauftrag
├── 1.2 Projektumfeld
└── 1.3 Zeitplanung

Kapitel 2: Hauptteil
├── 2.1 Anforderungsanalyse
├── 2.2 Konzept
└── 2.3 Implementation
```

## Glossar-System

### Datenformat (`data/glossary.yaml`)

```yaml
- id: api
  term: API
  abbrev: Application Programming Interface
  definition: |
    Eine Programmierschnittstelle, die definiert, wie verschiedene 
    Softwarekomponenten miteinander interagieren können.
  link: https://de.wikipedia.org/wiki/Programmierschnittstelle
```

### Features

- Automatische alphabetische Sortierung
- Tooltips bei Hover
- Verlinkung zur Glossar-Seite
- Fehlende Begriffe werden markiert

## Arbeitsjournal

### Einträge erstellen

```markdown
---
title: "Tag 1: Projektstart"
date: 2026-01-15
arbeitszeit: "8h"
---

## Tätigkeiten
- Kickoff-Meeting
- Einrichtung Entwicklungsumgebung
```

Journal-Einträge werden automatisch nach Datum sortiert (neueste zuerst).

## PDF-Export

### Unterstützte Tools

1. **WeasyPrint** (empfohlen)
   ```bash
   pip install weasyprint
   ```

2. **wkhtmltopdf**
   ```bash
   brew install wkhtmltopdf
   ```

3. **Pandoc + LaTeX**
   ```bash
   brew install pandoc
   brew install basictex
   ```

### PDF generieren

```bash
./scripts/build.sh pdf
```

Das PDF enthält:
- Titelblatt mit allen Metadaten
- Inhaltsverzeichnis mit Seitenzahlen
- Alle Kapitel nummeriert
- Kopf-/Fusszeilen
- Seitennummerierung

## CSS Paged Media

Das Framework nutzt CSS Paged Media für professionelles PDF-Layout:

```css
@page {
  size: A4;
  margin: 2.5cm 2cm;
  
  @top-center { content: string(chapter-title); }
  @bottom-center { content: counter(page); }
}
```

## Entwicklung

### Neue Kapitel hinzufügen

1. Ordner erstellen: `content/part_X/`
2. `_index.md` mit `chapter: true` anlegen
3. Unterkapitel mit Präfix (01_, 02_) erstellen
4. Menü in `hugo.toml` aktualisieren

### Neue Glossar-Begriffe

1. Begriff in `data/glossary.yaml` hinzufügen
2. Im Text mit `{{< glossary "Begriff" >}}` referenzieren

### Layout anpassen

- Hauptlayout: `layouts/_default/baseof.html`
- Styles: `static/css/main.css` und `static/css/pdf.css`

## Troubleshooting

### Hugo-Fehler: "failed to unmarshal YAML"
→ YAML-Syntax in Front Matter prüfen (Einrückung, Anführungszeichen)

### Fehlende Mermaid-Diagramme
→ JavaScript-Console auf Fehler prüfen, Mermaid-Syntax validieren

### PDF-Generation schlägt fehl
→ Prüfen ob WeasyPrint/wkhtmltopdf korrekt installiert ist

### Glossar-Begriff wird nicht gefunden
→ ID in `glossary.yaml` muss mit Referenz übereinstimmen (case-insensitive)

## Lizenz

MIT License - Frei verwendbar für IPA-Dokumentationen.

---

Erstellt mit ❤️ für Schweizer Lernende

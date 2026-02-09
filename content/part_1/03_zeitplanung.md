---
title: "Zeitplanung"
description: "Detaillierte Zeitplanung der IPA"
weight: 3
---

## Übersicht

Die IPA wird in der Zeit vom {{< param "ipaStartDate" >}} bis {{< param "ipaEndDate" >}} durchgeführt.

## Meilensteine

| Meilenstein | Datum | Status |
|-------------|-------|--------|
| Projektstart | {{< param "ipaStartDate" >}} | ✓ |
| Konzept fertig | TBD | ☐ |
| Implementation fertig | TBD | ☐ |
| Test abgeschlossen | TBD | ☐ |
| Dokumentation fertig | TBD | ☐ |
| Projektende | {{< param "ipaEndDate" >}} | ☐ |

## Arbeitsaufteilung

{{< diagram >}}
gantt
    title IPA Zeitplanung
    dateFormat  YYYY-MM-DD
    section Vorbereitung
    Einarbeitung           :a1, 2026-01-15, 2d
    Konzeption             :a2, after a1, 3d
    section Implementation
    Grundstruktur          :b1, after a2, 5d
    Features               :b2, after b1, 10d
    section Abschluss
    Testing                :c1, after b2, 3d
    Dokumentation          :c2, after c1, 2d
{{< /diagram >}}

## Stundenschätzung

| Phase | Geschätzte Stunden |
|-------|-------------------|
| Analyse | 16h |
| Konzept | 24h |
| Implementation | 40h |
| Testing | 8h |
| Dokumentation | 12h |
| **Total** | **100h** |

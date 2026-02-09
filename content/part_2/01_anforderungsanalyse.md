---
title: "Anforderungsanalyse"
description: "Analyse der funktionalen und nicht-funktionalen Anforderungen"
weight: 1
---

## Einleitung

In diesem Kapitel werden die Anforderungen an das System analysiert und dokumentiert.

## Funktionale Anforderungen

### FA-001: Benutzeranmeldung

| Attribut | Wert |
|----------|------|
| ID | FA-001 |
| Priorität | Muss |
| Beschreibung | Das System muss eine sichere Benutzeranmeldung ermöglichen |
| Akzeptanzkriterien | Benutzer kann sich mit E-Mail und Passwort anmelden |

### FA-002: Datenverwaltung

| Attribut | Wert |
|----------|------|
| ID | FA-002 |
| Priorität | Muss |
| Beschreibung | CRUD-Operationen für Stammdaten |
| Akzeptanzkriterien | Alle Operationen funktionieren korrekt |

## Nicht-funktionale Anforderungen

### NFA-001: Performance

Das System muss folgende Performance-Anforderungen erfüllen:

- Antwortzeit < 2 Sekunden
- Unterstützung für 100 gleichzeitige Benutzer
- Verfügbarkeit von 99.5%

### NFA-002: Sicherheit

- Verschlüsselte Datenübertragung (TLS 1.3)
- Sichere Passwortspeicherung (bcrypt)
- OWASP Top 10 konform

## Use Case Diagramm

{{< diagram >}}
graph TB
    subgraph System
        UC1[Anmelden]
        UC2[Daten verwalten]
        UC3[Berichte erstellen]
    end
    
    Benutzer((Benutzer)) --> UC1
    Benutzer --> UC2
    Admin((Admin)) --> UC3
    Admin --> UC2
{{< /diagram >}}

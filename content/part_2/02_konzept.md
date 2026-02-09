---
title: "Konzept"
description: "Technisches Konzept und Architektur"
weight: 2
---

## Systemarchitektur

### Übersicht

{{< diagram >}}
flowchart TB
    subgraph Frontend
        UI[Web Interface]
        API_Client[API Client]
    end
    
    subgraph Backend
        API[REST API]
        Auth[Authentication]
        BL[Business Logic]
    end
    
    subgraph Data
        DB[(Datenbank)]
        Cache[(Cache)]
    end
    
    UI --> API_Client
    API_Client --> API
    API --> Auth
    API --> BL
    BL --> DB
    BL --> Cache
{{< /diagram >}}

{{< figure src="/images/architecture.png" caption="Systemarchitektur im Detail" >}}

## Technologieentscheide

### Programmiersprache

Die Wahl fiel auf **TypeScript** aufgrund folgender Vorteile:

- Typsicherheit
- Moderne Sprachfeatures
- Grosse Community
- Gute IDE-Unterstützung

### Framework

| Framework | Pro | Contra | Entscheid |
|-----------|-----|--------|-----------|
| React | Flexibel, grosse Community | Lernkurve | ✓ |
| Vue | Einfach zu lernen | Kleinere Community | |
| Angular | Enterprise-ready | Komplex | |

## Datenmodell

### Entity-Relationship-Diagramm

{{< diagram >}}
erDiagram
    USER ||--o{ ORDER : places
    USER {
        int id PK
        string email
        string name
        datetime created_at
    }
    ORDER ||--|{ ORDER_ITEM : contains
    ORDER {
        int id PK
        int user_id FK
        datetime order_date
        string status
    }
    ORDER_ITEM {
        int id PK
        int order_id FK
        int product_id FK
        int quantity
    }
    PRODUCT ||--o{ ORDER_ITEM : "ordered in"
    PRODUCT {
        int id PK
        string name
        decimal price
    }
{{< /diagram >}}

## Glossar-Beispiele

Im Projekt werden folgende Begriffe verwendet:

- {{< glossary "API" >}} - Die Schnittstelle für die Kommunikation
- {{< glossary "REST" >}} - Das Architekturmuster für die API
- {{< glossary "CRUD" >}} - Die grundlegenden Datenbankoperationen

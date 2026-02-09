---
title: "Testing"
description: "Testkonzept und Testergebnisse"
weight: 1
---

## Testkonzept

### Teststrategie

Die Teststrategie folgt der Testpyramide:

{{< diagram >}}
graph TB
    subgraph Testpyramide
        E2E[E2E Tests<br/>10%]
        Integration[Integration Tests<br/>30%]
        Unit[Unit Tests<br/>60%]
    end
    
    E2E --> Integration
    Integration --> Unit
    
    style E2E fill:#ff6b6b
    style Integration fill:#feca57
    style Unit fill:#48dbfb
{{< /diagram >}}

### Testarten

1. **Unit Tests:** Testen einzelner Komponenten isoliert
2. **Integration Tests:** Testen des Zusammenspiels
3. **E2E Tests:** Testen des Gesamtsystems

## Testfälle

### TC-001: Benutzeranmeldung

| Attribut | Wert |
|----------|------|
| Testfall-ID | TC-001 |
| Bezug zu | FA-001 |
| Vorbedingung | Benutzer existiert in Datenbank |
| Eingabe | gültige E-Mail und Passwort |
| Erwartetes Ergebnis | JWT Token wird zurückgegeben |
| Tatsächliches Ergebnis | ✓ Wie erwartet |
| Status | Bestanden |

### TC-002: Ungültige Anmeldung

| Attribut | Wert |
|----------|------|
| Testfall-ID | TC-002 |
| Bezug zu | FA-001 |
| Vorbedingung | - |
| Eingabe | ungültiges Passwort |
| Erwartetes Ergebnis | Fehlermeldung 401 |
| Tatsächliches Ergebnis | ✓ Wie erwartet |
| Status | Bestanden |

## Testabdeckung

```
-------------------------|---------|----------|---------|---------|
File                     | % Stmts | % Branch | % Funcs | % Lines |
-------------------------|---------|----------|---------|---------|
All files                |   85.4  |    78.2  |   82.1  |   85.4  |
 src/services            |   92.3  |    88.5  |   90.0  |   92.3  |
 src/controllers         |   78.6  |    65.4  |   75.0  |   78.6  |
 src/models              |   95.0  |    90.0  |   92.5  |   95.0  |
-------------------------|---------|----------|---------|---------|
```

## Fazit Testing

Alle kritischen Funktionen wurden erfolgreich getestet. Die Testabdeckung von 85.4% übertrifft das Minimalziel von 80%.

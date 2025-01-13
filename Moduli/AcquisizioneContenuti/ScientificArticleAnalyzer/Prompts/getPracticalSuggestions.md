# Prompt per Analisi Testuale e Generazione di Suggerimenti Pratici con Citazioni Verificabili

## Descrizione
Questo prompt guida l'utente nell'analisi di un testo scientifico o tecnico per:
1. Identificare almeno 3 suggerimenti pratici e attuabili che una persona comune può implementare.
2. Fornire spiegazioni concise sulla rilevanza di ciascun suggerimento.
3. Citare il testo originale in modo chiaro, consentendo un facile riscontro da parte del lettore.

## Obiettivo
Garantire che i suggerimenti siano chiari, basati su evidenze, e che le fonti citate siano direttamente verificabili nel testo analizzato.

## Struttura
### Formato dell'Output
L'output deve essere in formato JSON e rispettare la seguente struttura:

json
[
  {
    "PracticalSuggestion": "[Descrizione del suggerimento pratico]",
    "Reason": "[Spiegazione della rilevanza del suggerimento con riferimento all'articolo]",
    "Reference": "[Citazione diretta dal testo con riferimento esatto]",
    "ImplementationSteps": "[Istruzioni pratiche per implementare il suggerimento]"
  },
  {
    "PracticalSuggestion": "[Descrizione del suggerimento pratico]",
    "Reason": "[Spiegazione della rilevanza del suggerimento con riferimento all'articolo]",
    "Reference": "[Citazione diretta dal testo con riferimento esatto]",
    "ImplementationSteps": "[Istruzioni pratiche per implementare il suggerimento]"
  }
]

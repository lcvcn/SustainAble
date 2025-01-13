import os
import openai
import PyPDF2
import sys

openai.api_key = 'LA_TUA_API_KEY'

PROMPT_TEMPLATE = """
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

```json
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
"""

def estrai_testo_pdf(percorso_pdf):
    try:
        with open(percorso_pdf, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            testo_completo = ""
            for pagina in reader.pages:
                testo_completo += pagina.extract_text() + "\n"
            return testo_completo
    except Exception as e:
        print(f"Errore nell'estrazione del testo da {percorso_pdf}: {e}")
        return None

def analizza_testo_con_gpt(testo):
    try:
        risposta = openai.ChatCompletion.create(
            model="gpt-4",
            messages=[
                {"role": "system", "content": """
                    Sei un assistente esperto specializzato nell'analisi di articoli scientifici e tecnici. Il tuo compito è:
                    1. Estrarre informazioni chiave dal testo fornito.
                    2. Generare almeno 3 suggerimenti pratici e attuabili che una persona comune può implementare.
                    3. Fornire spiegazioni concise sulla rilevanza di ciascun suggerimento, basate sulle evidenze presenti nel testo.
                    4. Citare direttamente il testo originale in modo chiaro, includendo riferimenti esatti.
                    5. Strutturare le risposte seguendo il formato specificato nel prompt dell'utente.

                    ### Linee Guida:
                    - Mantieni un tono formale e professionale.
                    - Evita di includere opinioni personali o informazioni non presenti nel testo.
                    - Assicurati che le citazioni siano accurate e pertinenti.
                    - Organizza le informazioni in modo chiaro e logico, seguendo la struttura richiesta.
                    """},
                {"role": "user", "content": PROMPT_TEMPLATE + "\n\nTesto:\n" + testo}
            ],
            max_tokens=1500,
            temperature=0.2,
        )
        return risposta.choices[0].message['content'].strip()
    except Exception as e:
        print(f"Errore nell'analisi con ChatGPT: {e}")
        return None

def salva_output(nome_file, contenuto):
    try:
        with open(nome_file, 'w', encoding='utf-8') as file:
            file.write(contenuto)
    except Exception as e:
        print(f"Errore nel salvataggio del file {nome_file}: {e}")

def main(cartella_pdf, cartella_output):
    if not os.path.isdir(cartella_pdf):
        print(f"La cartella {cartella_pdf} non esiste.")
        sys.exit(1)
    
    if not os.path.exists(cartella_output):
        os.makedirs(cartella_output)
    
    pdf_files = [f for f in os.listdir(cartella_pdf) if f.lower().endswith('.pdf')]
    
    if not pdf_files:
        print("Nessun file PDF trovato nella cartella specificata.")
        sys.exit(0)
    
    for pdf in pdf_files:
        percorso_pdf = os.path.join(cartella_pdf, pdf)
        print(f"Elaborazione di: {pdf}")
        
        testo = estrai_testo_pdf(percorso_pdf)
        if not testo:
            continue
        
        analisi = analizza_testo_con_gpt(testo)
        if not analisi:
            continue
        
        nome_output = os.path.splitext(pdf)[0] + "_analisi.txt"
        percorso_output = os.path.join(cartella_output, nome_output)
        salva_output(percorso_output, analisi)
        
        print(f"Analisi salvata in: {percorso_output}\n")

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Analizza PDF in una cartella e genera suggerimenti pratici.")
    parser.add_argument("Pdfs", help="Percorso alla cartella contenente i file PDF da analizzare.")
    parser.add_argument("Output", help="Percorso alla cartella dove salvare i risultati dell'analisi.")

    args = parser.parse_args()
    main(args.cartella_pdf, args.cartella_output)

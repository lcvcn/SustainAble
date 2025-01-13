import json
from pytrends.request import TrendReq
from datetime import datetime
import os
import pandas as pd

def get_google_trends(keywords, timeframe='now 7-d', geo=''): 
    pytrends = TrendReq(hl='en-US', tz=360)
    all_data = pd.DataFrame()

    # Google Trends supporta massimo 5 keyword per richiesta
    for i in range(0, len(keywords), 5):
        chunk = keywords[i:i + 5]
        pytrends.build_payload(chunk, cat=0, timeframe=timeframe, geo=geo, gprop='')

           trends_data = pytrends.interest_over_time()
        if not trends_data.empty:
            trends_data = trends_data.drop(columns=['isPartial'], errors='ignore')
            all_data = pd.concat([all_data, trends_data], axis=1)
        else:
            print(f"Nessun dato disponibile per le keyword: {chunk}")

    return all_data

# Creazione del report Markdown
def create_markdown_report(data, output_file, config):
    keyword_counts = data.sum(axis=0).sort_values(ascending=False).to_dict()
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("# Report Google Trends\n\n")
        f.write("## Parametri di ricerca\n")
        for key, value in config.items():
            f.write(f"- **{key.capitalize()}**: {value}\n")
        f.write("\n## Dati sulle keyword\n")
        f.write("| Keyword | Occorrenze |\n")
        f.write("|---------|------------|\n")
        for keyword, count in keyword_counts.items():
            f.write(f"| {keyword} | {count} |\n")

# Creazione del report JSON
def create_json_report(data, output_file, config):
    keyword_counts = data.sum(axis=0).sort_values(ascending=False).to_dict()
    result = {
        "parameters": config,
        "data": keyword_counts
    }
    with open(output_file, 'w', encoding='utf-8') as f:
        json.dump(result, f, ensure_ascii=False, indent=4)

def process_configurations(config_folder, md_report_folder, json_report_folder):
    os.makedirs(md_report_folder, exist_ok=True)  # Creare la cartella report Markdown se non esiste
    os.makedirs(json_report_folder, exist_ok=True)  # Creare la cartella report JSON se non esiste
    
    for filename in os.listdir(config_folder):
        if filename.endswith('.json'):
            with open(os.path.join(config_folder, filename), 'r', encoding='utf-8') as f:
                config = json.load(f)

            keywords = config.get("keywords", [])
            geo = config.get("geo", '')
            timeframe = config.get("timeframe", 'now 7-d')

            trends_data = get_google_trends(keywords, timeframe=timeframe, geo=geo)
            if not trends_data.empty:
                timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
                md_file = os.path.join(md_report_folder, f"trends_{geo}_{timestamp}.md")
                json_file = os.path.join(json_report_folder, f"trends_{geo}_{timestamp}.json")
                
                # Creazione report Markdown
                create_markdown_report(trends_data, md_file, config)
                print(f"Report Markdown salvato in {md_file}")
                
                # Creazione report JSON
                create_json_report(trends_data, json_file, config)
                print(f"Report JSON salvato in {json_file}")

def main():
    reports_folder = "reports/"
    config_folder = "configurations"  
    md_report_folder = reports_folder + "markdown_reports"
    json_report_folder = reports_folder + "json_reports" 
    process_configurations(config_folder, md_report_folder, json_report_folder)

if __name__ == "__main__":
    main()

import sys
from lxml import etree

def validate_xml(xsd_path, xml_path):
    try:
        # Carica lo schema XSD
        with open(xsd_path, 'rb') as xsd_file:
            schema_root = etree.XML(xsd_file.read())
            schema = etree.XMLSchema(schema_root)
        
        # Carica il documento XML
        with open(xml_path, 'rb') as xml_file:
            xml_doc = etree.XML(xml_file.read())
        
        # Validazione
        if schema.validate(xml_doc):
            print("Il documento XML è valido rispetto allo schema XSD.")
        else:
            print("Il documento XML non è valido. Errori:")
            for error in schema.error_log:
                print(f"- Linea {error.line}: {error.message}")
    except Exception as e:
        print(f"Errore durante la validazione: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Uso: python validate.py <file.xsd> <file.xml>")
        sys.exit(1)
    
    xsd_path = sys.argv[1]
    xml_path = sys.argv[2]
    
    validate_xml(xsd_path, xml_path)

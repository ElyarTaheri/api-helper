# API Helper

Api Helper for Ontology Loopkup API Service 

This little module uses net/http library to access the Ontology API Service via http://www.ebi.ac.uk/ols/api/ontologies


There are three methods:

### `get_ontologies_id`
This method prints all ontology ID and titles currently on service 

### `get_ontologies_full`
Gets a full list of ontologies with all details and returns as Hash

### `get_ontology_by_id`

Input param: `ontology_id`

Gets Ontology properties by ID

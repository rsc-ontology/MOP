## Customize Makefile settings for mop
## 
## If you need to customize your Makefile, make
## changes here rather than in the main Makefile

## Module for ontology: chebi

$(IMPORTDIR)/chebi_import.owl: $(IMPORTDIR)/chebi_terms.txt $(IMPORTSEED) | all_robot_plugins
	if [ $(IMP) = true ] && [ $(IMP_LARGE) = true ]; then $(ROBOT) \
	annotate --input $(MIRRORDIR)/chebi.owl --remove-annotations \
		 odk:normalize --add-source true \
		 extract --term-file $(IMPORTDIR)/chebi_terms.txt $(T_IMPORTSEED) \
		         --force true --copy-ontology-annotations true \
		         --individuals exclude \
		         --method BOT \
		 remove -T $(IMPORTDIR)/chebi_remove_list.txt --select "self descendants instances" --signature true \
		 remove $(foreach p, $(ANNOTATION_PROPERTIES), --term $(p)) \
		        --term-file $(IMPORTDIR)/chebi_terms.txt $(T_IMPORTSEED) \
		        --select complement --select annotation-properties \
		 odk:normalize --base-iri http://purl.obolibrary.org/obo/chebi.owl \
                --subset-decls true --synonym-decls true \
         repair --merge-axiom-annotations true \
         $(ANNOTATE_CONVERT_FILE); fi 
--
-- Name: biodatabase_name_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY biodatabase
    ADD CONSTRAINT biodatabase_name_key UNIQUE (name);


--
-- Name: biodatabase_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY biodatabase
    ADD CONSTRAINT biodatabase_pkey PRIMARY KEY (biodatabase_id);


--
-- Name: bioentry_accession_biodatabase_id_version_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry
    ADD CONSTRAINT bioentry_accession_biodatabase_id_version_key UNIQUE (accession, biodatabase_id, version);


--
-- Name: bioentry_dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry_dbxref
    ADD CONSTRAINT bioentry_dbxref_pkey PRIMARY KEY (bioentry_id, dbxref_id);


--
-- Name: bioentry_identifier_biodatabase_id_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry
    ADD CONSTRAINT bioentry_identifier_biodatabase_id_key UNIQUE (identifier, biodatabase_id);


--
-- Name: bioentry_path_object_bioentry_id_subject_bioentry_id_term_i_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry_path
    ADD CONSTRAINT bioentry_path_object_bioentry_id_subject_bioentry_id_term_i_key UNIQUE (object_bioentry_id, subject_bioentry_id, term_id, distance);


--
-- Name: bioentry_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry
    ADD CONSTRAINT bioentry_pkey PRIMARY KEY (bioentry_id);


--
-- Name: bioentry_qualifier_value_bioentry_id_term_id_rank_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry_qualifier_value
    ADD CONSTRAINT bioentry_qualifier_value_bioentry_id_term_id_rank_key UNIQUE (bioentry_id, term_id, rank);


--
-- Name: bioentry_reference_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry_reference
    ADD CONSTRAINT bioentry_reference_pkey PRIMARY KEY (bioentry_id, reference_id, rank);


--
-- Name: bioentry_relationship_object_bioentry_id_subject_bioentry_i_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry_relationship
    ADD CONSTRAINT bioentry_relationship_object_bioentry_id_subject_bioentry_i_key UNIQUE (object_bioentry_id, subject_bioentry_id, term_id);


--
-- Name: bioentry_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY bioentry_relationship
    ADD CONSTRAINT bioentry_relationship_pkey PRIMARY KEY (bioentry_relationship_id);


--
-- Name: biosequence_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY biosequence
    ADD CONSTRAINT biosequence_pkey PRIMARY KEY (bioentry_id);


--
-- Name: comment_bioentry_id_rank_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_bioentry_id_rank_key UNIQUE (bioentry_id, rank);


--
-- Name: comment_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (comment_id);


--
-- Name: dbxref_accession_dbname_version_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY dbxref
    ADD CONSTRAINT dbxref_accession_dbname_version_key UNIQUE (accession, dbname, version);


--
-- Name: dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY dbxref
    ADD CONSTRAINT dbxref_pkey PRIMARY KEY (dbxref_id);


--
-- Name: dbxref_qualifier_value_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY dbxref_qualifier_value
    ADD CONSTRAINT dbxref_qualifier_value_pkey PRIMARY KEY (dbxref_id, term_id, rank);


--
-- Name: hmm_profile_hierarchies_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_profile_hierarchies
    ADD CONSTRAINT hmm_profile_hierarchies_pkey PRIMARY KEY (hmm_profile_id);


--
-- Name: hmm_profiles_name_version_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_profiles
    ADD CONSTRAINT hmm_profiles_name_version_key UNIQUE (name, version);


--
-- Name: hmm_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_profiles
    ADD CONSTRAINT hmm_profiles_pkey PRIMARY KEY (id);


--
-- Name: hmm_result_domains_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_result_domains
    ADD CONSTRAINT hmm_result_domains_pkey PRIMARY KEY (id);


--
-- Name: hmm_result_row_sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_result_row_sequences
    ADD CONSTRAINT hmm_result_row_sequences_pkey PRIMARY KEY (id);


--
-- Name: hmm_result_rows_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_result_rows
    ADD CONSTRAINT hmm_result_rows_pkey PRIMARY KEY (id);


--
-- Name: hmm_results_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY hmm_results
    ADD CONSTRAINT hmm_results_pkey PRIMARY KEY (id);


--
-- Name: location_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_pkey PRIMARY KEY (location_id);


--
-- Name: location_qualifier_value_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY location_qualifier_value
    ADD CONSTRAINT location_qualifier_value_pkey PRIMARY KEY (location_id, term_id);


--
-- Name: location_seqfeature_id_rank_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY location
    ADD CONSTRAINT location_seqfeature_id_rank_key UNIQUE (seqfeature_id, rank);


--
-- Name: ncbi_taxon_hierarchies_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY ncbi_taxon_hierarchies
    ADD CONSTRAINT ncbi_taxon_hierarchies_pkey PRIMARY KEY (ncbi_taxon_id);


--
-- Name: ontology_name_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY ontology
    ADD CONSTRAINT ontology_name_key UNIQUE (name);


--
-- Name: ontology_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY ontology
    ADD CONSTRAINT ontology_pkey PRIMARY KEY (ontology_id);


--
-- Name: reference_crc_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT reference_crc_key UNIQUE (crc);


--
-- Name: reference_dbxref_id_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT reference_dbxref_id_key UNIQUE (dbxref_id);


--
-- Name: reference_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT reference_pkey PRIMARY KEY (reference_id);


--
-- Name: seqfeature_bioentry_id_type_term_id_source_term_id_rank_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature
    ADD CONSTRAINT seqfeature_bioentry_id_type_term_id_source_term_id_rank_key UNIQUE (bioentry_id, type_term_id, source_term_id, rank);


--
-- Name: seqfeature_dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature_dbxref
    ADD CONSTRAINT seqfeature_dbxref_pkey PRIMARY KEY (seqfeature_id, dbxref_id);


--
-- Name: seqfeature_path_object_seqfeature_id_subject_seqfeature_id__key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature_path
    ADD CONSTRAINT seqfeature_path_object_seqfeature_id_subject_seqfeature_id__key UNIQUE (object_seqfeature_id, subject_seqfeature_id, term_id, distance);


--
-- Name: seqfeature_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature
    ADD CONSTRAINT seqfeature_pkey PRIMARY KEY (seqfeature_id);


--
-- Name: seqfeature_qualifier_value_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature_qualifier_value
    ADD CONSTRAINT seqfeature_qualifier_value_pkey PRIMARY KEY (seqfeature_id, term_id, rank);


--
-- Name: seqfeature_relationship_object_seqfeature_id_subject_seqfea_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature_relationship
    ADD CONSTRAINT seqfeature_relationship_object_seqfeature_id_subject_seqfea_key UNIQUE (object_seqfeature_id, subject_seqfeature_id, term_id);


--
-- Name: seqfeature_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY seqfeature_relationship
    ADD CONSTRAINT seqfeature_relationship_pkey PRIMARY KEY (seqfeature_relationship_id);


--
-- Name: sequence_sources_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY sequence_sources
    ADD CONSTRAINT sequence_sources_pkey PRIMARY KEY (id);


--
-- Name: sequence_sources_source_name_version_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY sequence_sources
    ADD CONSTRAINT sequence_sources_source_name_version_key UNIQUE (source, name, version);


--
-- Name: sequences_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY sequences
    ADD CONSTRAINT sequences_pkey PRIMARY KEY (id);


--
-- Name: taxon_name_name_name_class_taxon_id_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY taxon_name
    ADD CONSTRAINT taxon_name_name_name_class_taxon_id_key UNIQUE (name, name_class, taxon_id);


--
-- Name: taxon_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT taxon_pkey PRIMARY KEY (taxon_id);


--
-- Name: term_dbxref_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_dbxref
    ADD CONSTRAINT term_dbxref_pkey PRIMARY KEY (term_id, dbxref_id);


--
-- Name: term_identifier_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_identifier_key UNIQUE (identifier);


--
-- Name: term_name_ontology_id_is_obsolete_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_name_ontology_id_is_obsolete_key UNIQUE (name, ontology_id, is_obsolete);


--
-- Name: term_path_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_path
    ADD CONSTRAINT term_path_pkey PRIMARY KEY (term_path_id);


--
-- Name: term_path_subject_term_id_predicate_term_id_object_term_id__key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_path
    ADD CONSTRAINT term_path_subject_term_id_predicate_term_id_object_term_id__key UNIQUE (subject_term_id, predicate_term_id, object_term_id, ontology_id, distance);


--
-- Name: term_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term
    ADD CONSTRAINT term_pkey PRIMARY KEY (term_id);


--
-- Name: term_relationship_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_relationship
    ADD CONSTRAINT term_relationship_pkey PRIMARY KEY (term_relationship_id);


--
-- Name: term_relationship_subject_term_id_predicate_term_id_object__key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_relationship
    ADD CONSTRAINT term_relationship_subject_term_id_predicate_term_id_object__key UNIQUE (subject_term_id, predicate_term_id, object_term_id, ontology_id);


--
-- Name: term_relationship_term_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_relationship_term
    ADD CONSTRAINT term_relationship_term_pkey PRIMARY KEY (term_relationship_id);


--
-- Name: term_relationship_term_term_id_key; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_relationship_term
    ADD CONSTRAINT term_relationship_term_term_id_key UNIQUE (term_id);


--
-- Name: term_synonym_pkey; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY term_synonym
    ADD CONSTRAINT term_synonym_pkey PRIMARY KEY (term_id, synonym);


--
-- Name: xaktaxon_left_value; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT xaktaxon_left_value UNIQUE (left_value);


--
-- Name: xaktaxon_ncbi_taxon_id; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT xaktaxon_ncbi_taxon_id UNIQUE (ncbi_taxon_id);


--
-- Name: xaktaxon_right_value; Type: CONSTRAINT; Schema: public; Owner: dl; Tablespace: 
--

ALTER TABLE ONLY taxon
    ADD CONSTRAINT xaktaxon_right_value UNIQUE (right_value);


--
-- Name: bioentry_db; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentry_db ON bioentry USING btree (biodatabase_id);


--
-- Name: bioentry_name; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentry_name ON bioentry USING btree (name);


--
-- Name: bioentry_tax; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentry_tax ON bioentry USING btree (taxon_id);


--
-- Name: bioentrypath_child; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentrypath_child ON bioentry_path USING btree (subject_bioentry_id);


--
-- Name: bioentrypath_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentrypath_trm ON bioentry_path USING btree (term_id);


--
-- Name: bioentryqual_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentryqual_trm ON bioentry_qualifier_value USING btree (term_id);


--
-- Name: bioentryref_ref; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentryref_ref ON bioentry_reference USING btree (reference_id);


--
-- Name: bioentryrel_child; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentryrel_child ON bioentry_relationship USING btree (subject_bioentry_id);


--
-- Name: bioentryrel_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX bioentryrel_trm ON bioentry_relationship USING btree (term_id);


--
-- Name: db_auth; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX db_auth ON biodatabase USING btree (authority);


--
-- Name: dblink_dbx; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX dblink_dbx ON bioentry_dbxref USING btree (dbxref_id);


--
-- Name: dbxref_db; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX dbxref_db ON dbxref USING btree (dbname);


--
-- Name: dbxrefqual_dbx; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX dbxrefqual_dbx ON dbxref_qualifier_value USING btree (dbxref_id);


--
-- Name: dbxrefqual_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX dbxrefqual_trm ON dbxref_qualifier_value USING btree (term_id);


--
-- Name: feadblink_dbx; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX feadblink_dbx ON seqfeature_dbxref USING btree (dbxref_id);


--
-- Name: hmm_profiles_parent_id; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX hmm_profiles_parent_id ON hmm_profiles USING btree (parent_id);


--
-- Name: hmm_result_domains_i00; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE UNIQUE INDEX hmm_result_domains_i00 ON hmm_result_domains USING btree (hmm_result_row_id, i);


--
-- Name: hmm_result_row_sequences_hmm_result_rows; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX hmm_result_row_sequences_hmm_result_rows ON hmm_result_row_sequences USING btree (hmm_result_row_id, sequence_id);


--
-- Name: hmm_result_row_sequences_sequences; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX hmm_result_row_sequences_sequences ON hmm_result_row_sequences USING btree (sequence_id, hmm_result_row_id);


--
-- Name: hmm_result_rows_i00; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE UNIQUE INDEX hmm_result_rows_i00 ON hmm_result_rows USING btree (hmm_result_id, qname, tname);


--
-- Name: hmm_result_rows_tname; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE UNIQUE INDEX hmm_result_rows_tname ON hmm_result_rows USING btree (hmm_result_id, qname, tname);


--
-- Name: hmm_results_hmm_profile_id; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX hmm_results_hmm_profile_id ON hmm_results USING btree (hmm_profile_id);


--
-- Name: hmm_results_sequence_source_id; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX hmm_results_sequence_source_id ON hmm_results USING btree (sequence_source_id);


--
-- Name: locationqual_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX locationqual_trm ON location_qualifier_value USING btree (term_id);


--
-- Name: seqfeature_fsrc; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeature_fsrc ON seqfeature USING btree (source_term_id);


--
-- Name: seqfeature_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeature_trm ON seqfeature USING btree (type_term_id);


--
-- Name: seqfeatureloc_dbx; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeatureloc_dbx ON location USING btree (dbxref_id);


--
-- Name: seqfeatureloc_start; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeatureloc_start ON location USING btree (start_pos, end_pos);


--
-- Name: seqfeatureloc_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeatureloc_trm ON location USING btree (term_id);


--
-- Name: seqfeaturepath_child; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeaturepath_child ON seqfeature_path USING btree (subject_seqfeature_id);


--
-- Name: seqfeaturepath_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeaturepath_trm ON seqfeature_path USING btree (term_id);


--
-- Name: seqfeaturequal_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeaturequal_trm ON seqfeature_qualifier_value USING btree (term_id);


--
-- Name: seqfeaturerel_child; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeaturerel_child ON seqfeature_relationship USING btree (subject_seqfeature_id);


--
-- Name: seqfeaturerel_trm; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX seqfeaturerel_trm ON seqfeature_relationship USING btree (term_id);


--
-- Name: sequences_i00; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE UNIQUE INDEX sequences_i00 ON sequences USING btree (seq_src, accno);


--
-- Name: sequences_i01; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX sequences_i01 ON sequences USING btree (accno);


--
-- Name: taxnamename; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX taxnamename ON taxon_name USING btree (name);


--
-- Name: taxnametaxonid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX taxnametaxonid ON taxon_name USING btree (taxon_id);


--
-- Name: taxparent; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX taxparent ON taxon USING btree (parent_taxon_id);


--
-- Name: term_ont; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX term_ont ON term USING btree (ontology_id);


--
-- Name: trmdbxref_dbxrefid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmdbxref_dbxrefid ON term_dbxref USING btree (dbxref_id);


--
-- Name: trmpath_objectid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmpath_objectid ON term_path USING btree (object_term_id);


--
-- Name: trmpath_ontid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmpath_ontid ON term_path USING btree (ontology_id);


--
-- Name: trmpath_predicateid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmpath_predicateid ON term_path USING btree (predicate_term_id);


--
-- Name: trmrel_objectid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmrel_objectid ON term_relationship USING btree (object_term_id);


--
-- Name: trmrel_ontid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmrel_ontid ON term_relationship USING btree (ontology_id);


--
-- Name: trmrel_predicateid; Type: INDEX; Schema: public; Owner: dl; Tablespace: 
--

CREATE INDEX trmrel_predicateid ON term_relationship USING btree (predicate_term_id);


--
-- Name: rule_biodatabase_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_biodatabase_i AS
    ON INSERT TO biodatabase
   WHERE (( SELECT biodatabase.biodatabase_id
           FROM biodatabase
          WHERE ((biodatabase.name)::text = (new.name)::text)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_dbxref_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_dbxref_i AS
    ON INSERT TO bioentry_dbxref
   WHERE (( SELECT bioentry_dbxref.dbxref_id
           FROM bioentry_dbxref
          WHERE ((bioentry_dbxref.bioentry_id = new.bioentry_id) AND (bioentry_dbxref.dbxref_id = new.dbxref_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_i1; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_i1 AS
    ON INSERT TO bioentry
   WHERE (( SELECT bioentry.bioentry_id
           FROM bioentry
          WHERE (((bioentry.identifier)::text = (new.identifier)::text) AND (bioentry.biodatabase_id = new.biodatabase_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_i2; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_i2 AS
    ON INSERT TO bioentry
   WHERE (( SELECT bioentry.bioentry_id
           FROM bioentry
          WHERE ((((bioentry.accession)::text = (new.accession)::text) AND (bioentry.biodatabase_id = new.biodatabase_id)) AND (bioentry.version = new.version))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_path_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_path_i AS
    ON INSERT TO bioentry_path
   WHERE (( SELECT bioentry_relationship.bioentry_relationship_id
           FROM bioentry_relationship
          WHERE (((bioentry_relationship.object_bioentry_id = new.object_bioentry_id) AND (bioentry_relationship.subject_bioentry_id = new.subject_bioentry_id)) AND (bioentry_relationship.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_qualifier_value_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_qualifier_value_i AS
    ON INSERT TO bioentry_qualifier_value
   WHERE (( SELECT bioentry_qualifier_value.bioentry_id
           FROM bioentry_qualifier_value
          WHERE (((bioentry_qualifier_value.bioentry_id = new.bioentry_id) AND (bioentry_qualifier_value.term_id = new.term_id)) AND (bioentry_qualifier_value.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_reference_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_reference_i AS
    ON INSERT TO bioentry_reference
   WHERE (( SELECT bioentry_reference.bioentry_id
           FROM bioentry_reference
          WHERE (((bioentry_reference.bioentry_id = new.bioentry_id) AND (bioentry_reference.reference_id = new.reference_id)) AND (bioentry_reference.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_bioentry_relationship_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_bioentry_relationship_i AS
    ON INSERT TO bioentry_relationship
   WHERE (( SELECT bioentry_relationship.bioentry_relationship_id
           FROM bioentry_relationship
          WHERE (((bioentry_relationship.object_bioentry_id = new.object_bioentry_id) AND (bioentry_relationship.subject_bioentry_id = new.subject_bioentry_id)) AND (bioentry_relationship.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_biosequence_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_biosequence_i AS
    ON INSERT TO biosequence
   WHERE (( SELECT biosequence.bioentry_id
           FROM biosequence
          WHERE (biosequence.bioentry_id = new.bioentry_id)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_comment_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_comment_i AS
    ON INSERT TO comment
   WHERE (( SELECT comment.comment_id
           FROM comment
          WHERE ((comment.bioentry_id = new.bioentry_id) AND (comment.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_dbxref_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_dbxref_i AS
    ON INSERT TO dbxref
   WHERE (( SELECT dbxref.dbxref_id
           FROM dbxref
          WHERE ((((dbxref.accession)::text = (new.accession)::text) AND ((dbxref.dbname)::text = (new.dbname)::text)) AND (dbxref.version = new.version))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_dbxref_qualifier_value_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_dbxref_qualifier_value_i AS
    ON INSERT TO dbxref_qualifier_value
   WHERE (( SELECT dbxref_qualifier_value.dbxref_id
           FROM dbxref_qualifier_value
          WHERE (((dbxref_qualifier_value.dbxref_id = new.dbxref_id) AND (dbxref_qualifier_value.term_id = new.term_id)) AND (dbxref_qualifier_value.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_location_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_location_i AS
    ON INSERT TO location
   WHERE (( SELECT location.location_id
           FROM location
          WHERE ((location.seqfeature_id = new.seqfeature_id) AND (location.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_location_qualifier_value_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_location_qualifier_value_i AS
    ON INSERT TO location_qualifier_value
   WHERE (( SELECT location_qualifier_value.location_id
           FROM location_qualifier_value
          WHERE ((location_qualifier_value.location_id = new.location_id) AND (location_qualifier_value.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_ontology_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_ontology_i AS
    ON INSERT TO ontology
   WHERE (( SELECT ontology.ontology_id
           FROM ontology
          WHERE ((ontology.name)::text = (new.name)::text)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_reference_i1; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_reference_i1 AS
    ON INSERT TO reference
   WHERE (( SELECT reference.reference_id
           FROM reference
          WHERE ((reference.crc)::text = (new.crc)::text)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_reference_i2; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_reference_i2 AS
    ON INSERT TO reference
   WHERE (( SELECT reference.reference_id
           FROM reference
          WHERE (reference.dbxref_id = new.dbxref_id)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_seqfeature_dbxref_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_seqfeature_dbxref_i AS
    ON INSERT TO seqfeature_dbxref
   WHERE (( SELECT seqfeature_dbxref.seqfeature_id
           FROM seqfeature_dbxref
          WHERE ((seqfeature_dbxref.seqfeature_id = new.seqfeature_id) AND (seqfeature_dbxref.dbxref_id = new.dbxref_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_seqfeature_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_seqfeature_i AS
    ON INSERT TO seqfeature
   WHERE (( SELECT seqfeature.seqfeature_id
           FROM seqfeature
          WHERE ((((seqfeature.bioentry_id = new.bioentry_id) AND (seqfeature.type_term_id = new.type_term_id)) AND (seqfeature.source_term_id = new.source_term_id)) AND (seqfeature.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_seqfeature_path_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_seqfeature_path_i AS
    ON INSERT TO seqfeature_path
   WHERE (( SELECT seqfeature_path.subject_seqfeature_id
           FROM seqfeature_path
          WHERE (((seqfeature_path.object_seqfeature_id = new.object_seqfeature_id) AND (seqfeature_path.subject_seqfeature_id = new.subject_seqfeature_id)) AND (seqfeature_path.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_seqfeature_qualifier_value_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_seqfeature_qualifier_value_i AS
    ON INSERT TO seqfeature_qualifier_value
   WHERE (( SELECT seqfeature_qualifier_value.seqfeature_id
           FROM seqfeature_qualifier_value
          WHERE (((seqfeature_qualifier_value.seqfeature_id = new.seqfeature_id) AND (seqfeature_qualifier_value.term_id = new.term_id)) AND (seqfeature_qualifier_value.rank = new.rank))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_seqfeature_relationship_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_seqfeature_relationship_i AS
    ON INSERT TO seqfeature_relationship
   WHERE (( SELECT seqfeature_relationship.subject_seqfeature_id
           FROM seqfeature_relationship
          WHERE (((seqfeature_relationship.object_seqfeature_id = new.object_seqfeature_id) AND (seqfeature_relationship.subject_seqfeature_id = new.subject_seqfeature_id)) AND (seqfeature_relationship.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_taxon_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_taxon_i AS
    ON INSERT TO taxon
   WHERE (( SELECT taxon.taxon_id
           FROM taxon
          WHERE (taxon.ncbi_taxon_id = new.ncbi_taxon_id)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_taxon_name_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_taxon_name_i AS
    ON INSERT TO taxon_name
   WHERE (( SELECT taxon_name.taxon_id
           FROM taxon_name
          WHERE (((taxon_name.taxon_id = new.taxon_id) AND ((taxon_name.name)::text = (new.name)::text)) AND ((taxon_name.name_class)::text = (new.name_class)::text))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_dbxref_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_dbxref_i AS
    ON INSERT TO term_dbxref
   WHERE (( SELECT term_dbxref.dbxref_id
           FROM term_dbxref
          WHERE ((term_dbxref.dbxref_id = new.dbxref_id) AND (term_dbxref.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_i1; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_i1 AS
    ON INSERT TO term
   WHERE (( SELECT term.term_id
           FROM term
          WHERE ((term.identifier)::text = (new.identifier)::text)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_i2; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_i2 AS
    ON INSERT TO term
   WHERE (( SELECT term.term_id
           FROM term
          WHERE ((((term.name)::text = (new.name)::text) AND (term.ontology_id = new.ontology_id)) AND (term.is_obsolete = new.is_obsolete))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_path_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_path_i AS
    ON INSERT TO term_path
   WHERE (( SELECT term_path.subject_term_id
           FROM term_path
          WHERE (((((term_path.subject_term_id = new.subject_term_id) AND (term_path.predicate_term_id = new.predicate_term_id)) AND (term_path.object_term_id = new.object_term_id)) AND (term_path.ontology_id = new.ontology_id)) AND (term_path.distance = new.distance))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_relationship_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_relationship_i AS
    ON INSERT TO term_relationship
   WHERE (( SELECT term_relationship.term_relationship_id
           FROM term_relationship
          WHERE ((((term_relationship.subject_term_id = new.subject_term_id) AND (term_relationship.predicate_term_id = new.predicate_term_id)) AND (term_relationship.object_term_id = new.object_term_id)) AND (term_relationship.ontology_id = new.ontology_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_relationship_term_i1; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_relationship_term_i1 AS
    ON INSERT TO term_relationship_term
   WHERE (( SELECT term_relationship_term.term_relationship_id
           FROM term_relationship_term
          WHERE (term_relationship_term.term_relationship_id = new.term_relationship_id)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_relationship_term_i2; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_relationship_term_i2 AS
    ON INSERT TO term_relationship_term
   WHERE (( SELECT term_relationship_term.term_id
           FROM term_relationship_term
          WHERE (term_relationship_term.term_id = new.term_id)) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: rule_term_synonym_i; Type: RULE; Schema: public; Owner: dl
--

CREATE RULE rule_term_synonym_i AS
    ON INSERT TO term_synonym
   WHERE (( SELECT term_synonym.term_id
           FROM term_synonym
          WHERE (((term_synonym.synonym)::text = (new.synonym)::text) AND (term_synonym.term_id = new.term_id))) IS NOT NULL) DO INSTEAD NOTHING;


--
-- Name: fkbiodatabase_bioentry; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry
    ADD CONSTRAINT fkbiodatabase_bioentry FOREIGN KEY (biodatabase_id) REFERENCES biodatabase(biodatabase_id);


--
-- Name: fkbioentry_bioseq; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY biosequence
    ADD CONSTRAINT fkbioentry_bioseq FOREIGN KEY (bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkbioentry_comment; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY comment
    ADD CONSTRAINT fkbioentry_comment FOREIGN KEY (bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkbioentry_dblink; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_dbxref
    ADD CONSTRAINT fkbioentry_dblink FOREIGN KEY (bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkbioentry_entqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_qualifier_value
    ADD CONSTRAINT fkbioentry_entqual FOREIGN KEY (bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkbioentry_entryref; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_reference
    ADD CONSTRAINT fkbioentry_entryref FOREIGN KEY (bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkbioentry_seqfeature; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature
    ADD CONSTRAINT fkbioentry_seqfeature FOREIGN KEY (bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkchildent_bioentrypath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_path
    ADD CONSTRAINT fkchildent_bioentrypath FOREIGN KEY (subject_bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkchildent_bioentryrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_relationship
    ADD CONSTRAINT fkchildent_bioentryrel FOREIGN KEY (subject_bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkchildfeat_seqfeatpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_path
    ADD CONSTRAINT fkchildfeat_seqfeatpath FOREIGN KEY (subject_seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fkchildfeat_seqfeatrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_relationship
    ADD CONSTRAINT fkchildfeat_seqfeatrel FOREIGN KEY (subject_seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fkdbxref_dblink; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_dbxref
    ADD CONSTRAINT fkdbxref_dblink FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE;


--
-- Name: fkdbxref_dbxrefqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY dbxref_qualifier_value
    ADD CONSTRAINT fkdbxref_dbxrefqual FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE;


--
-- Name: fkdbxref_feadblink; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_dbxref
    ADD CONSTRAINT fkdbxref_feadblink FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE;


--
-- Name: fkdbxref_location; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY location
    ADD CONSTRAINT fkdbxref_location FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id);


--
-- Name: fkdbxref_reference; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY reference
    ADD CONSTRAINT fkdbxref_reference FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id);


--
-- Name: fkdbxref_trmdbxref; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_dbxref
    ADD CONSTRAINT fkdbxref_trmdbxref FOREIGN KEY (dbxref_id) REFERENCES dbxref(dbxref_id) ON DELETE CASCADE;


--
-- Name: fkfeatloc_locqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY location_qualifier_value
    ADD CONSTRAINT fkfeatloc_locqual FOREIGN KEY (location_id) REFERENCES location(location_id) ON DELETE CASCADE;


--
-- Name: fkont_term; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term
    ADD CONSTRAINT fkont_term FOREIGN KEY (ontology_id) REFERENCES ontology(ontology_id) ON DELETE CASCADE;


--
-- Name: fkontology_trmpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_path
    ADD CONSTRAINT fkontology_trmpath FOREIGN KEY (ontology_id) REFERENCES ontology(ontology_id) ON DELETE CASCADE;


--
-- Name: fkontology_trmrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_relationship
    ADD CONSTRAINT fkontology_trmrel FOREIGN KEY (ontology_id) REFERENCES ontology(ontology_id) ON DELETE CASCADE;


--
-- Name: fkparentent_bioentrypath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_path
    ADD CONSTRAINT fkparentent_bioentrypath FOREIGN KEY (object_bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkparentent_bioentryrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_relationship
    ADD CONSTRAINT fkparentent_bioentryrel FOREIGN KEY (object_bioentry_id) REFERENCES bioentry(bioentry_id) ON DELETE CASCADE;


--
-- Name: fkparentfeat_seqfeatpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_path
    ADD CONSTRAINT fkparentfeat_seqfeatpath FOREIGN KEY (object_seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fkparentfeat_seqfeatrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_relationship
    ADD CONSTRAINT fkparentfeat_seqfeatrel FOREIGN KEY (object_seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fkreference_entryref; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_reference
    ADD CONSTRAINT fkreference_entryref FOREIGN KEY (reference_id) REFERENCES reference(reference_id) ON DELETE CASCADE;


--
-- Name: fkseqfeature_feadblink; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_dbxref
    ADD CONSTRAINT fkseqfeature_feadblink FOREIGN KEY (seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fkseqfeature_featqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_qualifier_value
    ADD CONSTRAINT fkseqfeature_featqual FOREIGN KEY (seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fkseqfeature_location; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY location
    ADD CONSTRAINT fkseqfeature_location FOREIGN KEY (seqfeature_id) REFERENCES seqfeature(seqfeature_id) ON DELETE CASCADE;


--
-- Name: fksourceterm_seqfeature; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature
    ADD CONSTRAINT fksourceterm_seqfeature FOREIGN KEY (source_term_id) REFERENCES term(term_id);


--
-- Name: fktaxon_bioentry; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry
    ADD CONSTRAINT fktaxon_bioentry FOREIGN KEY (taxon_id) REFERENCES taxon(taxon_id);


--
-- Name: fktaxon_taxonname; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY taxon_name
    ADD CONSTRAINT fktaxon_taxonname FOREIGN KEY (taxon_id) REFERENCES taxon(taxon_id) ON DELETE CASCADE;


--
-- Name: fkterm_bioentrypath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_path
    ADD CONSTRAINT fkterm_bioentrypath FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_bioentryrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_relationship
    ADD CONSTRAINT fkterm_bioentryrel FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_entqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY bioentry_qualifier_value
    ADD CONSTRAINT fkterm_entqual FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_featloc; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY location
    ADD CONSTRAINT fkterm_featloc FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_featqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_qualifier_value
    ADD CONSTRAINT fkterm_featqual FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_locqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY location_qualifier_value
    ADD CONSTRAINT fkterm_locqual FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_seqfeatpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_path
    ADD CONSTRAINT fkterm_seqfeatpath FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_seqfeatrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature_relationship
    ADD CONSTRAINT fkterm_seqfeatrel FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fkterm_seqfeature; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY seqfeature
    ADD CONSTRAINT fkterm_seqfeature FOREIGN KEY (type_term_id) REFERENCES term(term_id);


--
-- Name: fkterm_syn; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_synonym
    ADD CONSTRAINT fkterm_syn FOREIGN KEY (term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fkterm_trmdbxref; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_dbxref
    ADD CONSTRAINT fkterm_trmdbxref FOREIGN KEY (term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrm_dbxrefqual; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY dbxref_qualifier_value
    ADD CONSTRAINT fktrm_dbxrefqual FOREIGN KEY (term_id) REFERENCES term(term_id);


--
-- Name: fktrm_trmreltrm; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_relationship_term
    ADD CONSTRAINT fktrm_trmreltrm FOREIGN KEY (term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrmobject_trmpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_path
    ADD CONSTRAINT fktrmobject_trmpath FOREIGN KEY (object_term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrmobject_trmrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_relationship
    ADD CONSTRAINT fktrmobject_trmrel FOREIGN KEY (object_term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrmpredicate_trmpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_path
    ADD CONSTRAINT fktrmpredicate_trmpath FOREIGN KEY (predicate_term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrmpredicate_trmrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_relationship
    ADD CONSTRAINT fktrmpredicate_trmrel FOREIGN KEY (predicate_term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrmrel_trmreltrm; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_relationship_term
    ADD CONSTRAINT fktrmrel_trmreltrm FOREIGN KEY (term_relationship_id) REFERENCES term_relationship(term_relationship_id) ON DELETE CASCADE;


--
-- Name: fktrmsubject_trmpath; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_path
    ADD CONSTRAINT fktrmsubject_trmpath FOREIGN KEY (subject_term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: fktrmsubject_trmrel; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY term_relationship
    ADD CONSTRAINT fktrmsubject_trmrel FOREIGN KEY (subject_term_id) REFERENCES term(term_id) ON DELETE CASCADE;


--
-- Name: hmm_profiles_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_profiles
    ADD CONSTRAINT hmm_profiles_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES hmm_profiles(id);


--
-- Name: hmm_result_domains_hmm_result_row_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_domains
    ADD CONSTRAINT hmm_result_domains_hmm_result_row_id_fkey FOREIGN KEY (hmm_result_row_id) REFERENCES hmm_result_rows(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hmm_result_row_sequences_hmm_result_row_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_row_sequences
    ADD CONSTRAINT hmm_result_row_sequences_hmm_result_row_id_fkey FOREIGN KEY (hmm_result_row_id) REFERENCES hmm_result_rows(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hmm_result_row_sequences_sequence_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_row_sequences
    ADD CONSTRAINT hmm_result_row_sequences_sequence_id_fkey FOREIGN KEY (sequence_id) REFERENCES sequences(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hmm_result_rows_hmm_result_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_result_rows
    ADD CONSTRAINT hmm_result_rows_hmm_result_id_fkey FOREIGN KEY (hmm_result_id) REFERENCES hmm_results(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: hmm_results_hmm_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_results
    ADD CONSTRAINT hmm_results_hmm_profile_id_fkey FOREIGN KEY (hmm_profile_id) REFERENCES hmm_profiles(id);


--
-- Name: hmm_results_sequence_source_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dl
--

ALTER TABLE ONLY hmm_results
    ADD CONSTRAINT hmm_results_sequence_source_id_fkey FOREIGN KEY (sequence_source_id) REFERENCES sequence_sources(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


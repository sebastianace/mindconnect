-- =====================================================================
-- V5 - Pacientes, sus contactos y alergias
-- Tablas: 3 (acumulado: 16)
-- =====================================================================

CREATE TABLE patients (
    id                  UUID          NOT NULL DEFAULT gen_random_uuid(),
    document_type_id    UUID          NOT NULL,
    document_number     VARCHAR(30)   NOT NULL,
    first_name          VARCHAR(50)   NOT NULL,
    middle_name         VARCHAR(50),
    last_name           VARCHAR(50)   NOT NULL,
    second_last_name    VARCHAR(50),
    birth_date          DATE          NOT NULL,
    biological_sex_id   UUID          NOT NULL,
    gender_identity_id  UUID          NOT NULL,
    email               VARCHAR(150)  NOT NULL,
    phone               VARCHAR(30)   NOT NULL,
    address             VARCHAR(250)  NOT NULL,
    active              BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMP     NOT NULL DEFAULT NOW(),
    created_by          UUID,
    updated_at          TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_by          UUID,
    city_id             UUID          NOT NULL,
    CONSTRAINT pk_patients PRIMARY KEY (id),
    CONSTRAINT fk_patients_document_type FOREIGN KEY (document_type_id) REFERENCES document_types (id),
    -- biological_sex e identidad de género apuntan al mismo catálogo
    CONSTRAINT fk_patients_biological_sex FOREIGN KEY (biological_sex_id) REFERENCES genders (id),
    CONSTRAINT fk_patients_gender_identity FOREIGN KEY (gender_identity_id) REFERENCES genders (id),
    CONSTRAINT fk_patients_created_by FOREIGN KEY (created_by) REFERENCES professionals (id),
    CONSTRAINT fk_patients_updated_by FOREIGN KEY (updated_by) REFERENCES professionals (id),
    CONSTRAINT fk_patients_city FOREIGN KEY (city_id) REFERENCES city_municipalities (id),
    CONSTRAINT uk_patients_document UNIQUE (document_type_id, document_number),
    CONSTRAINT uk_patients_email UNIQUE (email),
    CONSTRAINT ck_patients_birth_date CHECK (birth_date <= CURRENT_DATE)
);
CREATE INDEX idx_patients_city_id ON patients (city_id);

CREATE TABLE patient_contacts (
    id                    UUID     NOT NULL DEFAULT gen_random_uuid(),
    contact_id            UUID     NOT NULL,
    patient_id            UUID     NOT NULL,
    is_primary_contact    BOOLEAN  NOT NULL DEFAULT FALSE,
    is_emergency_contact  BOOLEAN  NOT NULL DEFAULT FALSE,
    relationship_type_id  UUID     NOT NULL,
    CONSTRAINT pk_patient_contacts PRIMARY KEY (id),
    CONSTRAINT fk_patient_contacts_contact FOREIGN KEY (contact_id) REFERENCES contacts (id),
    CONSTRAINT fk_patient_contacts_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_patient_contacts_relationship_type FOREIGN KEY (relationship_type_id) REFERENCES relationship_types (id),
    CONSTRAINT uk_patient_contacts_patient_contact UNIQUE (patient_id, contact_id)
);
CREATE INDEX idx_patient_contacts_contact_id ON patient_contacts (contact_id);

CREATE TABLE patient_allergies (
    id           UUID          NOT NULL DEFAULT gen_random_uuid(),
    patient_id   UUID          NOT NULL,
    substance    VARCHAR(200)  NOT NULL,
    reaction     TEXT,
    severity     VARCHAR(20)   NOT NULL,
    active       BOOLEAN       NOT NULL DEFAULT TRUE,
    recorded_at  TIMESTAMP     NOT NULL DEFAULT NOW(),
    recorded_by  UUID          NOT NULL,
    created_at   TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_patient_allergies PRIMARY KEY (id),
    CONSTRAINT fk_patient_allergies_patient FOREIGN KEY (patient_id) REFERENCES patients (id)
);
CREATE INDEX idx_patient_allergies_patient_id ON patient_allergies (patient_id);

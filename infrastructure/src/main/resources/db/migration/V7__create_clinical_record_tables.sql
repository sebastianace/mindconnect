-- =====================================================================
-- V7 - Historia clínica y atenciones (encounters)
-- Tablas: 5 (acumulado: 32)
-- =====================================================================

CREATE TABLE clinical_records (
    id             UUID          NOT NULL DEFAULT gen_random_uuid(),
    patient_id     UUID          NOT NULL,
    creation_date  TIMESTAMP     NOT NULL DEFAULT NOW(),
    record_number  VARCHAR(50)   NOT NULL,
    opened_at      TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    closed_at      TIMESTAMPTZ,
    status_id      UUID          NOT NULL,
    created_at     TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    created_by     UUID          NOT NULL,
    CONSTRAINT pk_clinical_records PRIMARY KEY (id),
    CONSTRAINT fk_clinical_records_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_clinical_records_status FOREIGN KEY (status_id) REFERENCES clinical_record_statuses (id),
    CONSTRAINT fk_clinical_records_created_by FOREIGN KEY (created_by) REFERENCES professionals (id),
    CONSTRAINT uk_clinical_records_record_number UNIQUE (record_number),
    CONSTRAINT ck_clinical_records_dates CHECK (closed_at IS NULL OR closed_at >= opened_at)
);
CREATE INDEX idx_clinical_records_patient_id ON clinical_records (patient_id);
CREATE INDEX idx_clinical_records_status_id ON clinical_records (status_id);

CREATE TABLE encounters (
    id                  UUID         NOT NULL DEFAULT gen_random_uuid(),
    clinical_record_id  UUID         NOT NULL,
    professional_id     UUID         NOT NULL,
    encounter_type_id   UUID         NOT NULL,
    started_at          TIMESTAMPTZ  NOT NULL,
    ended_at            TIMESTAMPTZ,
    reason_for_visit    TEXT         NOT NULL,
    current_condition   TEXT,
    modality_id         UUID         NOT NULL,
    status_id           UUID         NOT NULL,
    created_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by          UUID         NOT NULL,
    updated_at          TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_by          UUID,
    CONSTRAINT pk_encounters PRIMARY KEY (id),
    CONSTRAINT fk_encounters_clinical_record FOREIGN KEY (clinical_record_id) REFERENCES clinical_records (id),
    CONSTRAINT fk_encounters_professional FOREIGN KEY (professional_id) REFERENCES professionals (id),
    CONSTRAINT fk_encounters_encounter_type FOREIGN KEY (encounter_type_id) REFERENCES encounter_types (id),
    CONSTRAINT fk_encounters_modality FOREIGN KEY (modality_id) REFERENCES encounter_modalities (id),
    CONSTRAINT fk_encounters_status FOREIGN KEY (status_id) REFERENCES encounter_statuses (id),
    CONSTRAINT ck_encounters_dates CHECK (ended_at IS NULL OR ended_at >= started_at)
);
CREATE INDEX idx_encounters_clinical_record_id ON encounters (clinical_record_id);
CREATE INDEX idx_encounters_professional_id ON encounters (professional_id);
CREATE INDEX idx_encounters_status_id ON encounters (status_id);

-- Nota clínica en formato SOAP (Subjective, Objective, Assessment, Plan)
CREATE TABLE clinical_notes (
    id                UUID         NOT NULL DEFAULT gen_random_uuid(),
    encounter_id      UUID         NOT NULL,
    professional_id   UUID         NOT NULL,
    subjective        TEXT         NOT NULL,
    objective         TEXT         NOT NULL,
    assessment        TEXT         NOT NULL,
    plan              TEXT         NOT NULL,
    additional_notes  TEXT,
    signed_at         TIMESTAMPTZ,
    created_at        TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_clinical_notes PRIMARY KEY (id),
    CONSTRAINT fk_clinical_notes_encounter FOREIGN KEY (encounter_id) REFERENCES encounters (id),
    CONSTRAINT fk_clinical_notes_professional FOREIGN KEY (professional_id) REFERENCES professionals (id)
);
CREATE INDEX idx_clinical_notes_encounter_id ON clinical_notes (encounter_id);
CREATE INDEX idx_clinical_notes_professional_id ON clinical_notes (professional_id);

-- Examen mental: los campos son opcionales porque no siempre se evalúan todos
CREATE TABLE mental_status_exams (
    id                    UUID         NOT NULL DEFAULT gen_random_uuid(),
    encounter_id          UUID         NOT NULL,
    appearance            TEXT,
    behavior              TEXT,
    attitude              TEXT,
    consciousness         TEXT,
    orientation           TEXT,
    attention             TEXT,
    memory                TEXT,
    speech                TEXT,
    mood                  TEXT,
    affect                TEXT,
    thought_process       TEXT,
    thought_content       TEXT,
    perception            TEXT,
    judgment              TEXT,
    insight               TEXT,
    psychomotor_activity  TEXT,
    observations          TEXT,
    created_at            TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    created_by            UUID         NOT NULL,
    CONSTRAINT pk_mental_status_exams PRIMARY KEY (id),
    CONSTRAINT fk_mental_status_exams_encounter FOREIGN KEY (encounter_id) REFERENCES encounters (id),
    CONSTRAINT fk_mental_status_exams_created_by FOREIGN KEY (created_by) REFERENCES professionals (id)
);
CREATE INDEX idx_mental_status_exams_encounter_id ON mental_status_exams (encounter_id);

CREATE TABLE risk_assessments (
    id                  UUID         NOT NULL DEFAULT gen_random_uuid(),
    encounter_id        UUID         NOT NULL,
    risk_level_id       UUID         NOT NULL,
    suicidal_ideation   BOOLEAN      NOT NULL DEFAULT FALSE,
    suicide_plan        BOOLEAN      NOT NULL DEFAULT FALSE,
    suicide_intent      BOOLEAN      NOT NULL DEFAULT FALSE,
    self_harm           BOOLEAN      NOT NULL DEFAULT FALSE,
    harm_to_others      BOOLEAN      NOT NULL DEFAULT FALSE,
    risk_factors        TEXT,
    protective_factors  TEXT,
    clinical_actions    TEXT,
    observations        TEXT,
    assessed_at         TIMESTAMPTZ  NOT NULL DEFAULT NOW(),
    assessed_by         UUID         NOT NULL,
    CONSTRAINT pk_risk_assessments PRIMARY KEY (id),
    CONSTRAINT fk_risk_assessments_encounter FOREIGN KEY (encounter_id) REFERENCES encounters (id),
    CONSTRAINT fk_risk_assessments_risk_level FOREIGN KEY (risk_level_id) REFERENCES risk_levels (id),
    CONSTRAINT fk_risk_assessments_assessed_by FOREIGN KEY (assessed_by) REFERENCES professionals (id)
);
CREATE INDEX idx_risk_assessments_encounter_id ON risk_assessments (encounter_id);
CREATE INDEX idx_risk_assessments_risk_level_id ON risk_assessments (risk_level_id);

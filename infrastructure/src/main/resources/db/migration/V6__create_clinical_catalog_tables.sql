-- =====================================================================
-- V6 - Catálogos clínicos (code + name + active)
-- Tablas: 11 (acumulado: 27)
-- =====================================================================

CREATE TABLE clinical_record_statuses (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_clinical_record_statuses PRIMARY KEY (id),
    CONSTRAINT uk_clinical_record_statuses_code UNIQUE (code),
    CONSTRAINT uk_clinical_record_statuses_name UNIQUE (name)
);

CREATE TABLE encounter_types (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_encounter_types PRIMARY KEY (id),
    CONSTRAINT uk_encounter_types_code UNIQUE (code),
    CONSTRAINT uk_encounter_types_name UNIQUE (name)
);

CREATE TABLE encounter_modalities (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_encounter_modalities PRIMARY KEY (id),
    CONSTRAINT uk_encounter_modalities_code UNIQUE (code)
);

CREATE TABLE encounter_statuses (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_encounter_statuses PRIMARY KEY (id),
    CONSTRAINT uk_encounter_statuses_code UNIQUE (code),
    CONSTRAINT uk_encounter_statuses_name UNIQUE (name)
);

CREATE TABLE risk_levels (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    severity    INTEGER      NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_risk_levels PRIMARY KEY (id),
    CONSTRAINT uk_risk_levels_code UNIQUE (code),
    CONSTRAINT ck_risk_levels_severity CHECK (severity > 0)
);

CREATE TABLE treatment_statuses (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_treatment_statuses PRIMARY KEY (id),
    CONSTRAINT uk_treatment_statuses_code UNIQUE (code),
    CONSTRAINT uk_treatment_statuses_name UNIQUE (name)
);

CREATE TABLE treatment_goal_statuses (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_treatment_goal_statuses PRIMARY KEY (id),
    CONSTRAINT uk_treatment_goal_statuses_code UNIQUE (code),
    CONSTRAINT uk_treatment_goal_statuses_name UNIQUE (name)
);

CREATE TABLE medication_routes (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_medication_routes PRIMARY KEY (id),
    CONSTRAINT uk_medication_routes_code UNIQUE (code)
);

CREATE TABLE assessment_types (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    code         VARCHAR(20)  NOT NULL,
    name         VARCHAR(50)  NOT NULL,
    active       BOOLEAN      NOT NULL DEFAULT TRUE,
    description  TEXT,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_assessment_types PRIMARY KEY (id),
    CONSTRAINT uk_assessment_types_code UNIQUE (code)
);

CREATE TABLE consent_types (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    code         VARCHAR(20)  NOT NULL,
    name         VARCHAR(50)  NOT NULL,
    active       BOOLEAN      NOT NULL DEFAULT TRUE,
    description  TEXT,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_consent_types PRIMARY KEY (id),
    CONSTRAINT uk_consent_types_code UNIQUE (code)
);

CREATE TABLE diagnostic_systems (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    version     VARCHAR(20)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_diagnostic_systems PRIMARY KEY (id),
    CONSTRAINT uk_diagnostic_systems_code UNIQUE (code)
);

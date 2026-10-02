-- =====================================================================
-- V2 - Catálogos de identidad y perfil
-- Tablas: 5 (acumulado: 8)
-- =====================================================================

CREATE TABLE document_types (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    code        VARCHAR(20)  NOT NULL,
    name        VARCHAR(50)  NOT NULL,
    active      BOOLEAN      NOT NULL DEFAULT TRUE,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_document_types PRIMARY KEY (id),
    CONSTRAINT uk_document_types_code UNIQUE (code)
);

CREATE TABLE genders (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    description  VARCHAR(50)  NOT NULL,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_genders PRIMARY KEY (id),
    CONSTRAINT uk_genders_description UNIQUE (description)
);

CREATE TABLE relationship_types (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    description  VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_relationship_types PRIMARY KEY (id),
    CONSTRAINT uk_relationship_types_description UNIQUE (description)
);

CREATE TABLE professional_types (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    name        VARCHAR(40)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_professional_types PRIMARY KEY (id),
    CONSTRAINT uk_professional_types_name UNIQUE (name)
);

CREATE TABLE studies (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    name        VARCHAR(40)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_studies PRIMARY KEY (id)
);

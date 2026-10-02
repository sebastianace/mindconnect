-- =====================================================================
-- V3 - Profesionales y su formación
-- Tablas: 2 (acumulado: 10)
-- =====================================================================

CREATE TABLE professionals (
    id                    UUID          NOT NULL DEFAULT gen_random_uuid(),
    document_type_id      UUID          NOT NULL,
    document_number       VARCHAR(30)   NOT NULL,
    first_name            VARCHAR(60)   NOT NULL,
    last_name             VARCHAR(60)   NOT NULL,
    professional_type_id  UUID          NOT NULL,
    license_number        VARCHAR(100)  NOT NULL,
    active                BOOLEAN       NOT NULL DEFAULT TRUE,
    city_id               UUID          NOT NULL,
    created_at            TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at            TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_professionals PRIMARY KEY (id),
    CONSTRAINT fk_professionals_document_type FOREIGN KEY (document_type_id) REFERENCES document_types (id),
    CONSTRAINT fk_professionals_professional_type FOREIGN KEY (professional_type_id) REFERENCES professional_types (id),
    CONSTRAINT fk_professionals_city FOREIGN KEY (city_id) REFERENCES city_municipalities (id),
    -- Un documento es único por tipo (CC 123 y TI 123 pueden coexistir)
    CONSTRAINT uk_professionals_document UNIQUE (document_type_id, document_number),
    CONSTRAINT uk_professionals_license_number UNIQUE (license_number)
);
CREATE INDEX idx_professionals_professional_type_id ON professionals (professional_type_id);
CREATE INDEX idx_professionals_city_id ON professionals (city_id);

CREATE TABLE professional_studies (
    id                 UUID          NOT NULL DEFAULT gen_random_uuid(),
    study_id           UUID          NOT NULL,
    professional_id    UUID          NOT NULL,
    title              VARCHAR(100)  NOT NULL,
    university         VARCHAR(100)  NOT NULL,
    is_valid           BOOLEAN       NOT NULL DEFAULT FALSE,
    resolution_number  VARCHAR(60),
    country_id         UUID          NOT NULL,
    created_at         TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at         TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_professional_studies PRIMARY KEY (id),
    CONSTRAINT fk_professional_studies_study FOREIGN KEY (study_id) REFERENCES studies (id),
    CONSTRAINT fk_professional_studies_professional FOREIGN KEY (professional_id) REFERENCES professionals (id),
    CONSTRAINT fk_professional_studies_country FOREIGN KEY (country_id) REFERENCES countries (id)
);
CREATE INDEX idx_professional_studies_study_id ON professional_studies (study_id);
CREATE INDEX idx_professional_studies_professional_id ON professional_studies (professional_id);
CREATE INDEX idx_professional_studies_country_id ON professional_studies (country_id);

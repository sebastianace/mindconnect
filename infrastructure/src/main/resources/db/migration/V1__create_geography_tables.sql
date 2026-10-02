-- =====================================================================
-- V1 - Geografía: countries -> state_regions -> city_municipalities
-- Tablas: 3 (acumulado: 3)
-- =====================================================================

CREATE TABLE countries (
    id                UUID          NOT NULL DEFAULT gen_random_uuid(),
    name_country      VARCHAR(50)   NOT NULL,
    code_country      VARCHAR(10)   NOT NULL,
    description       VARCHAR(100),
    is_active         BOOLEAN       NOT NULL DEFAULT TRUE,
    telephone_prefix  VARCHAR(5),
    created_at        TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_countries PRIMARY KEY (id),
    CONSTRAINT uk_countries_code_country UNIQUE (code_country)
);

CREATE TABLE state_regions (
    id           UUID          NOT NULL DEFAULT gen_random_uuid(),
    name_region  VARCHAR(50)   NOT NULL,
    code_region  VARCHAR(10)   NOT NULL,
    description  VARCHAR(100),
    is_active    BOOLEAN       NOT NULL DEFAULT TRUE,
    country_id   UUID          NOT NULL,
    created_at   TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_state_regions PRIMARY KEY (id),
    CONSTRAINT fk_state_regions_country FOREIGN KEY (country_id) REFERENCES countries (id),
    CONSTRAINT uk_state_regions_country_code UNIQUE (country_id, code_region)
);
CREATE INDEX idx_state_regions_country_id ON state_regions (country_id);

CREATE TABLE city_municipalities (
    id           UUID          NOT NULL DEFAULT gen_random_uuid(),
    name_city    VARCHAR(50)   NOT NULL,
    code_city    VARCHAR(10)   NOT NULL,
    description  VARCHAR(100),
    is_active    BOOLEAN       NOT NULL DEFAULT TRUE,
    region_id    UUID          NOT NULL,
    created_at   TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_city_municipalities PRIMARY KEY (id),
    CONSTRAINT fk_city_municipalities_region FOREIGN KEY (region_id) REFERENCES state_regions (id),
    CONSTRAINT uk_city_municipalities_region_code UNIQUE (region_id, code_city)
);
CREATE INDEX idx_city_municipalities_region_id ON city_municipalities (region_id);

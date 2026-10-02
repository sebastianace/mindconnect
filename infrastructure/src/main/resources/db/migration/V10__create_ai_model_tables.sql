-- =====================================================================
-- V10 - Proveedores y modelos de IA
-- Tablas: 2 (acumulado: 42)
-- =====================================================================

CREATE TABLE provider_models_ai (
    id                UUID          NOT NULL DEFAULT gen_random_uuid(),
    name_provider_ai  VARCHAR(100)  NOT NULL,
    razon_social      VARCHAR(150),
    sitio_web         TEXT,
    is_active         BOOLEAN       NOT NULL DEFAULT TRUE,
    created_at        TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_provider_models_ai PRIMARY KEY (id),
    CONSTRAINT uk_provider_models_ai_name UNIQUE (name_provider_ai)
);

CREATE TABLE ai_models (
    id                  UUID           NOT NULL DEFAULT gen_random_uuid(),
    provider_model_id   UUID           NOT NULL,
    name_model          VARCHAR(100)   NOT NULL,
    model_key           VARCHAR(120)   NOT NULL,
    input_token_price   DECIMAL(12,8)  NOT NULL DEFAULT 0,
    output_token_price  DECIMAL(12,8)  NOT NULL DEFAULT 0,
    max_tokens          INTEGER,
    context_window      INTEGER,
    is_active           BOOLEAN        NOT NULL DEFAULT TRUE,
    created_at          TIMESTAMP      NOT NULL DEFAULT NOW(),
    updated_at          TIMESTAMP      NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_ai_models PRIMARY KEY (id),
    CONSTRAINT fk_ai_models_provider FOREIGN KEY (provider_model_id) REFERENCES provider_models_ai (id),
    CONSTRAINT uk_ai_models_model_key UNIQUE (model_key),
    CONSTRAINT ck_ai_models_prices CHECK (input_token_price >= 0 AND output_token_price >= 0),
    CONSTRAINT ck_ai_models_tokens CHECK ((max_tokens IS NULL OR max_tokens > 0)
                                      AND (context_window IS NULL OR context_window > 0))
);
CREATE INDEX idx_ai_models_provider_model_id ON ai_models (provider_model_id);

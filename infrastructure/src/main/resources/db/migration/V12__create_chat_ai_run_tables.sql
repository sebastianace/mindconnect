-- =====================================================================
-- V12 - Ejecuciones de IA (runs), métricas y errores
-- Tablas: 3 (acumulado: 49)
-- =====================================================================

CREATE TABLE chat_ai_runs (
    id                UUID       NOT NULL DEFAULT gen_random_uuid(),
    conversation_id   UUID       NOT NULL,
    message_id        UUID       NOT NULL,
    model_id          UUID       NOT NULL,
    ai_run_status_id  UUID       NOT NULL,
    created_at        TIMESTAMP  NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_ai_runs PRIMARY KEY (id),
    CONSTRAINT fk_chat_ai_runs_conversation FOREIGN KEY (conversation_id) REFERENCES chat_conversations (id),
    CONSTRAINT fk_chat_ai_runs_message FOREIGN KEY (message_id) REFERENCES chat_messages (id),
    CONSTRAINT fk_chat_ai_runs_model FOREIGN KEY (model_id) REFERENCES ai_models (id),
    CONSTRAINT fk_chat_ai_runs_status FOREIGN KEY (ai_run_status_id) REFERENCES ai_runs_statuses (id)
);
CREATE INDEX idx_chat_ai_runs_conversation_id ON chat_ai_runs (conversation_id);
CREATE INDEX idx_chat_ai_runs_message_id ON chat_ai_runs (message_id);

-- Métricas y errores dependen totalmente del run: se borran con él
CREATE TABLE chat_ai_run_metrics (
    id                 UUID           NOT NULL DEFAULT gen_random_uuid(),
    ai_run_id          UUID           NOT NULL,
    prompt_tokens      INTEGER        NOT NULL DEFAULT 0,
    completion_tokens  INTEGER        NOT NULL DEFAULT 0,
    total_tokens       INTEGER        NOT NULL DEFAULT 0,
    cost               DECIMAL(10,6)  NOT NULL DEFAULT 0,
    created_at         TIMESTAMP      NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_ai_run_metrics PRIMARY KEY (id),
    CONSTRAINT fk_chat_ai_run_metrics_run FOREIGN KEY (ai_run_id) REFERENCES chat_ai_runs (id) ON DELETE CASCADE,
    CONSTRAINT ck_chat_ai_run_metrics_non_negative CHECK (prompt_tokens >= 0 AND completion_tokens >= 0
                                                      AND total_tokens >= 0 AND cost >= 0)
);
CREATE INDEX idx_chat_ai_run_metrics_ai_run_id ON chat_ai_run_metrics (ai_run_id);

CREATE TABLE chat_ai_run_errors (
    id                 UUID          NOT NULL DEFAULT gen_random_uuid(),
    ai_run_id          UUID          NOT NULL,
    error_message      TEXT          NOT NULL,
    error_code         VARCHAR(80),
    provider_error_id  VARCHAR(120),
    created_at         TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_ai_run_errors PRIMARY KEY (id),
    CONSTRAINT fk_chat_ai_run_errors_run FOREIGN KEY (ai_run_id) REFERENCES chat_ai_runs (id) ON DELETE CASCADE
);
CREATE INDEX idx_chat_ai_run_errors_ai_run_id ON chat_ai_run_errors (ai_run_id);

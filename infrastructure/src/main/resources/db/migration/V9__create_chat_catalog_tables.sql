-- =====================================================================
-- V9 - Catálogos del módulo de chat e IA
-- Tablas: 6 (acumulado: 40)
-- =====================================================================

CREATE TABLE sender_types (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    name_type   VARCHAR(50)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_sender_types PRIMARY KEY (id),
    CONSTRAINT uk_sender_types_name_type UNIQUE (name_type)
);

CREATE TABLE priorities (
    id             UUID         NOT NULL DEFAULT gen_random_uuid(),
    name_priority  VARCHAR(50)  NOT NULL,
    created_at     TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at     TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_priorities PRIMARY KEY (id),
    CONSTRAINT uk_priorities_name_priority UNIQUE (name_priority)
);

CREATE TABLE conversations_statuses (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    name_status  VARCHAR(50)  NOT NULL,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_conversations_statuses PRIMARY KEY (id),
    CONSTRAINT uk_conversations_statuses_name_status UNIQUE (name_status)
);

CREATE TABLE message_types (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    name_type   VARCHAR(50)  NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_message_types PRIMARY KEY (id),
    CONSTRAINT uk_message_types_name_type UNIQUE (name_type)
);

CREATE TABLE ai_runs_statuses (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    name_status  VARCHAR(50)  NOT NULL,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_ai_runs_statuses PRIMARY KEY (id),
    CONSTRAINT uk_ai_runs_statuses_name_status UNIQUE (name_status)
);

CREATE TABLE escalations_statuses (
    id           UUID         NOT NULL DEFAULT gen_random_uuid(),
    name_status  VARCHAR(50)  NOT NULL,
    created_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at   TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_escalations_statuses PRIMARY KEY (id),
    CONSTRAINT uk_escalations_statuses_name_status UNIQUE (name_status)
);

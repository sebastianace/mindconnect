-- =====================================================================
-- V11 - Conversaciones, participantes, mensajes y configuración IA
-- Tablas: 4 (acumulado: 46)
-- =====================================================================

CREATE TABLE chat_conversations (
    id                      UUID       NOT NULL DEFAULT gen_random_uuid(),
    conversation_status_id  UUID       NOT NULL,
    priority_id             UUID       NOT NULL,
    last_message_at         TIMESTAMP,
    closed                  BOOLEAN    DEFAULT FALSE,
    closed_at               TIMESTAMP,
    closed_by               UUID,
    created_at              TIMESTAMP  NOT NULL DEFAULT NOW(),
    updated_at              TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_conversations PRIMARY KEY (id),
    CONSTRAINT fk_chat_conversations_status FOREIGN KEY (conversation_status_id) REFERENCES conversations_statuses (id),
    CONSTRAINT fk_chat_conversations_priority FOREIGN KEY (priority_id) REFERENCES priorities (id)
);
CREATE INDEX idx_chat_conversations_status_id ON chat_conversations (conversation_status_id);

-- Un participante es paciente, profesional o ninguno de los dos (ej. la IA o el sistema)
CREATE TABLE chat_participants (
    id                   UUID       NOT NULL DEFAULT gen_random_uuid(),
    conversation_id      UUID       NOT NULL,
    participant_type_id  UUID       NOT NULL,
    patient_id           UUID,
    professional_id      UUID,
    created_at           TIMESTAMP  NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_participants PRIMARY KEY (id),
    CONSTRAINT fk_chat_participants_conversation FOREIGN KEY (conversation_id) REFERENCES chat_conversations (id),
    CONSTRAINT fk_chat_participants_type FOREIGN KEY (participant_type_id) REFERENCES sender_types (id),
    CONSTRAINT fk_chat_participants_patient FOREIGN KEY (patient_id) REFERENCES patients (id),
    CONSTRAINT fk_chat_participants_professional FOREIGN KEY (professional_id) REFERENCES professionals (id),
    CONSTRAINT ck_chat_participants_single_owner CHECK (num_nonnulls(patient_id, professional_id) <= 1)
);
CREATE INDEX idx_chat_participants_conversation_id ON chat_participants (conversation_id);
CREATE INDEX idx_chat_participants_patient_id ON chat_participants (patient_id);
CREATE INDEX idx_chat_participants_professional_id ON chat_participants (professional_id);

CREATE TABLE chat_messages (
    id               UUID       NOT NULL DEFAULT gen_random_uuid(),
    conversation_id  UUID       NOT NULL,
    message_type_id  UUID       NOT NULL,
    participant_id   UUID       NOT NULL,
    content          JSONB      NOT NULL,
    metadata         JSONB,
    created_at       TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_messages PRIMARY KEY (id),
    CONSTRAINT fk_chat_messages_conversation FOREIGN KEY (conversation_id) REFERENCES chat_conversations (id),
    CONSTRAINT fk_chat_messages_message_type FOREIGN KEY (message_type_id) REFERENCES message_types (id),
    CONSTRAINT fk_chat_messages_participant FOREIGN KEY (participant_id) REFERENCES chat_participants (id)
);
-- Consulta típica: mensajes de una conversación en orden cronológico
CREATE INDEX idx_chat_messages_conversation_created ON chat_messages (conversation_id, created_at);
CREATE INDEX idx_chat_messages_participant_id ON chat_messages (participant_id);

CREATE TABLE chat_conversation_ai_settings (
    id                UUID       NOT NULL DEFAULT gen_random_uuid(),
    conversation_id   UUID       NOT NULL,
    ai_enabled        BOOLEAN    NOT NULL DEFAULT TRUE,
    default_model_id  UUID       NOT NULL,
    created_at        TIMESTAMP  NOT NULL DEFAULT NOW(),
    updated_at        TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_conversation_ai_settings PRIMARY KEY (id),
    CONSTRAINT fk_chat_conv_ai_settings_conversation FOREIGN KEY (conversation_id) REFERENCES chat_conversations (id),
    CONSTRAINT fk_chat_conv_ai_settings_model FOREIGN KEY (default_model_id) REFERENCES ai_models (id)
);
CREATE INDEX idx_chat_conv_ai_settings_conversation_id ON chat_conversation_ai_settings (conversation_id);

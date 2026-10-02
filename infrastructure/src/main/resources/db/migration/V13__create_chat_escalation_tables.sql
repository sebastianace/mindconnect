-- =====================================================================
-- V13 - Escalamientos de chat a un profesional humano
-- Tablas: 3 (acumulado: 52)
-- =====================================================================

CREATE TABLE chat_escalations (
    id               UUID       NOT NULL DEFAULT gen_random_uuid(),
    conversation_id  UUID       NOT NULL,
    status_id        UUID       NOT NULL,
    from_ai          BOOLEAN    NOT NULL DEFAULT FALSE,
    reason           TEXT       NOT NULL,
    created_at       TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_escalations PRIMARY KEY (id),
    CONSTRAINT fk_chat_escalations_conversation FOREIGN KEY (conversation_id) REFERENCES chat_conversations (id),
    CONSTRAINT fk_chat_escalations_status FOREIGN KEY (status_id) REFERENCES escalations_statuses (id)
);
CREATE INDEX idx_chat_escalations_conversation_id ON chat_escalations (conversation_id);
CREATE INDEX idx_chat_escalations_status_id ON chat_escalations (status_id);

CREATE TABLE chat_escalation_assignments (
    id               UUID       NOT NULL DEFAULT gen_random_uuid(),
    escalation_id    UUID       NOT NULL,
    professional_id  UUID       NOT NULL,
    assigned_at      TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_escalation_assignments PRIMARY KEY (id),
    CONSTRAINT fk_chat_esc_assignments_escalation FOREIGN KEY (escalation_id) REFERENCES chat_escalations (id),
    CONSTRAINT fk_chat_esc_assignments_professional FOREIGN KEY (professional_id) REFERENCES professionals (id)
);
CREATE INDEX idx_chat_esc_assignments_escalation_id ON chat_escalation_assignments (escalation_id);
CREATE INDEX idx_chat_esc_assignments_professional_id ON chat_escalation_assignments (professional_id);

-- Historial de cambios de estado (auditoría: solo se inserta, nunca se actualiza)
CREATE TABLE chat_escalation_status_history (
    id                    UUID       NOT NULL DEFAULT gen_random_uuid(),
    escalation_id         UUID       NOT NULL,
    escalation_status_id  UUID       NOT NULL,
    created_at            TIMESTAMP  NOT NULL DEFAULT NOW(),
    changed_at            TIMESTAMP  NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_chat_escalation_status_history PRIMARY KEY (id),
    CONSTRAINT fk_chat_esc_history_escalation FOREIGN KEY (escalation_id) REFERENCES chat_escalations (id),
    CONSTRAINT fk_chat_esc_history_status FOREIGN KEY (escalation_status_id) REFERENCES escalations_statuses (id)
);
CREATE INDEX idx_chat_esc_history_escalation_changed ON chat_escalation_status_history (escalation_id, changed_at);

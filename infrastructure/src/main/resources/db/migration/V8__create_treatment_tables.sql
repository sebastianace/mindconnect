-- =====================================================================
-- V8 - Planes de tratamiento y metas
-- Tablas: 2 (acumulado: 34)
-- =====================================================================

CREATE TABLE treatment_plans (
    id                   UUID          NOT NULL DEFAULT gen_random_uuid(),
    encounter_id         UUID          NOT NULL,
    professional_id      UUID          NOT NULL,
    title                VARCHAR(200)  NOT NULL,
    description          TEXT,
    start_date           DATE          NOT NULL,
    end_date             DATE,
    treatment_status_id  UUID          NOT NULL,
    created_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_at           TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_treatment_plans PRIMARY KEY (id),
    CONSTRAINT fk_treatment_plans_encounter FOREIGN KEY (encounter_id) REFERENCES encounters (id),
    CONSTRAINT fk_treatment_plans_professional FOREIGN KEY (professional_id) REFERENCES professionals (id),
    CONSTRAINT fk_treatment_plans_status FOREIGN KEY (treatment_status_id) REFERENCES treatment_statuses (id),
    CONSTRAINT ck_treatment_plans_dates CHECK (end_date IS NULL OR end_date >= start_date)
);
CREATE INDEX idx_treatment_plans_encounter_id ON treatment_plans (encounter_id);
CREATE INDEX idx_treatment_plans_professional_id ON treatment_plans (professional_id);

CREATE TABLE treatment_goals (
    id                        UUID         NOT NULL DEFAULT gen_random_uuid(),
    treatment_plan_id         UUID         NOT NULL,
    description               TEXT         NOT NULL,
    target_date               DATE,
    completed_at              TIMESTAMPTZ,
    notes                     TEXT,
    treatment_goal_status_id  UUID         NOT NULL,
    created_at                TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at                TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_treatment_goals PRIMARY KEY (id),
    CONSTRAINT fk_treatment_goals_plan FOREIGN KEY (treatment_plan_id) REFERENCES treatment_plans (id),
    CONSTRAINT fk_treatment_goals_status FOREIGN KEY (treatment_goal_status_id) REFERENCES treatment_goal_statuses (id)
);
CREATE INDEX idx_treatment_goals_treatment_plan_id ON treatment_goals (treatment_plan_id);

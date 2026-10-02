-- =====================================================================
-- V4 - Contactos (personas de apoyo de los pacientes)
-- Tablas: 3 (acumulado: 13)
-- =====================================================================

CREATE TABLE contacts (
    id          UUID          NOT NULL DEFAULT gen_random_uuid(),
    full_name   VARCHAR(200)  NOT NULL,
    email       VARCHAR(150),
    notes       TEXT,
    city_id     UUID          NOT NULL,
    created_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    created_by  UUID          NOT NULL,
    updated_at  TIMESTAMPTZ   NOT NULL DEFAULT NOW(),
    updated_by  UUID,
    CONSTRAINT pk_contacts PRIMARY KEY (id),
    CONSTRAINT fk_contacts_city FOREIGN KEY (city_id) REFERENCES city_municipalities (id),
    CONSTRAINT fk_contacts_created_by FOREIGN KEY (created_by) REFERENCES professionals (id),
    CONSTRAINT fk_contacts_updated_by FOREIGN KEY (updated_by) REFERENCES professionals (id)
);
CREATE INDEX idx_contacts_city_id ON contacts (city_id);

-- Teléfonos y correos son parte del contacto: si se borra el contacto, se borran con él
CREATE TABLE phone_contacts (
    id          UUID         NOT NULL DEFAULT gen_random_uuid(),
    contact_id  UUID         NOT NULL,
    phone       VARCHAR(30)  NOT NULL,
    notes       TEXT,
    created_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_phone_contacts PRIMARY KEY (id),
    CONSTRAINT fk_phone_contacts_contact FOREIGN KEY (contact_id) REFERENCES contacts (id) ON DELETE CASCADE
);
CREATE INDEX idx_phone_contacts_contact_id ON phone_contacts (contact_id);

CREATE TABLE email_contacts (
    id          UUID          NOT NULL DEFAULT gen_random_uuid(),
    contact_id  UUID          NOT NULL,
    email       VARCHAR(150)  NOT NULL,
    notes       TEXT,
    created_at  TIMESTAMP     NOT NULL DEFAULT NOW(),
    updated_at  TIMESTAMP     NOT NULL DEFAULT NOW(),
    CONSTRAINT pk_email_contacts PRIMARY KEY (id),
    CONSTRAINT fk_email_contacts_contact FOREIGN KEY (contact_id) REFERENCES contacts (id) ON DELETE CASCADE,
    CONSTRAINT uk_email_contacts_email UNIQUE (email)
);
CREATE INDEX idx_email_contacts_contact_id ON email_contacts (contact_id);

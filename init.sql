-- Tabla de usuarios
CREATE TABLE "users" (
    "user_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_name" VARCHAR(500) NOT NULL,
    "user_last_name" VARCHAR(500) NOT NULL,
    "user_email" VARCHAR(500) NOT NULL
);

-- Tabla de proveedores
CREATE TABLE "providers" (
    "provider_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "provider_name" VARCHAR(500) NOT NULL,
    "provider_email" VARCHAR(500) NOT NULL
);

-- Tabla de tipos de producto
CREATE TABLE "product_types" (
    "product_type_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "product_type_name" VARCHAR(500) NOT NULL
);

-- Tabla de secciones de producto
CREATE TABLE "product_sections" (
    "section_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "section_name" VARCHAR(500) NOT NULL
);

-- Tabla de productos
CREATE TABLE "products" (
    "product_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "provider_id" BIGINT NOT NULL,
    "product_type_id" BIGINT NOT NULL,
    "section_id" BIGINT NOT NULL,
    "product_name" VARCHAR(500) NOT NULL,
    "product_description" VARCHAR(500) NOT NULL,
    "product_price" BIGINT NOT NULL,
    FOREIGN KEY ("provider_id") REFERENCES "providers" ("provider_id"),
    FOREIGN KEY ("product_type_id") REFERENCES "product_types" ("product_type_id"),
    FOREIGN KEY ("section_id") REFERENCES "product_sections" ("section_id")
);

-- Tabla de proyectos
CREATE TABLE "projects" (
    "project_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "project_name" VARCHAR(500) NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users" ("user_id")
);

-- Tabla de relación entre proyectos y productos
CREATE TABLE "project_products" (
    "project_product_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "project_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL,
    "project_product_quantity" BIGINT NOT NULL,
    FOREIGN KEY ("project_id") REFERENCES "projects" ("project_id"),
    FOREIGN KEY ("product_id") REFERENCES "products" ("product_id")
);

-- Tabla de calificaciones
CREATE TABLE "ratings" (
    "rating_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_id" BIGINT NOT NULL,
    "provider_id" BIGINT,
    "product_id" BIGINT,
    "rating_quality" BIGINT,
    "rating_cost" BIGINT,
    "rating_shipment" BIGINT,
    FOREIGN KEY ("user_id") REFERENCES "users" ("user_id"),
    FOREIGN KEY ("provider_id") REFERENCES "providers" ("provider_id"),
    FOREIGN KEY ("product_id") REFERENCES "products" ("product_id")
);

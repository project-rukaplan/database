-- Tabla: users
CREATE TABLE "users" (
    "user_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_name" VARCHAR(500) NOT NULL,
    "user_last_name" VARCHAR(500) NOT NULL,
    "user_email" VARCHAR(500) NOT NULL
);

-- Tabla: providers
CREATE TABLE "providers" (
    "provider_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "provider_name" VARCHAR(500) NOT NULL,
    "provider_email" VARCHAR(500) NOT NULL
);

-- Tabla: product_types
CREATE TABLE "product_types" (
    "product_type_id" SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "product_type_name" VARCHAR(255) NOT NULL
);

-- Tabla: product_sections
CREATE TABLE "product_sections" (
    "section_id" SMALLINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "section_name" VARCHAR(255) NOT NULL
);

-- Tabla: products
CREATE TABLE "products" (
    "product_id" BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "provider_id" INT,
    "product_type_id" SMALLINT,
    "section_id" SMALLINT,
    "product_name" VARCHAR(500) NOT NULL,
    "product_description" TEXT,
    "product_price" DECIMAL,
    FOREIGN KEY ("provider_id") REFERENCES "providers"("provider_id"),
    FOREIGN KEY ("product_type_id") REFERENCES "product_types"("product_type_id"),
    FOREIGN KEY ("section_id") REFERENCES "product_sections"("section_id")
);

-- Tabla: projects
CREATE TABLE "projects" (
    "project_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_id" INT,
    "project_name" VARCHAR(500) NOT NULL,
    FOREIGN KEY ("user_id") REFERENCES "users"("user_id")
);

-- Tabla: project_products
CREATE TABLE "project_products" (
    "project_id" INT,
    "product_id" BIGINT,
    "project_product_quantity" INT NOT NULL,
    PRIMARY KEY ("project_id", "product_id"),
    FOREIGN KEY ("project_id") REFERENCES "projects"("project_id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("product_id")
);

-- Tabla: rating_categories
CREATE TABLE "rating_categories" (
    "category_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "category_name" VARCHAR(255) NOT NULL
);

-- Tabla: rating_values
CREATE TABLE "rating_values" (
    "rating_id" INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    "user_id" INT,
    "provider_id" INT,
    "product_id" BIGINT,
    "category_id" INT,
    "rating_value" SMALLINT,
    FOREIGN KEY ("user_id") REFERENCES "users"("user_id"),
    FOREIGN KEY ("provider_id") REFERENCES "providers"("provider_id"),
    FOREIGN KEY ("product_id") REFERENCES "products"("product_id"),
    FOREIGN KEY ("category_id") REFERENCES "rating_categories"("category_id"),
    UNIQUE ("user_id", "provider_id", "product_id", "category_id")
);

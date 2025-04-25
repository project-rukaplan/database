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

-- Insertar en la tabla users
INSERT INTO "users" ("user_name", "user_last_name", "user_email")
VALUES
('Juan', 'Pérez', 'juan.perez@example.com'),
('Ana', 'Gómez', 'ana.gomez@example.com'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@example.com');

-- Insertar en la tabla providers
INSERT INTO "providers" ("provider_name", "provider_email")
VALUES
('Proveedor A', 'contacto@proveedora.com'),
('Proveedor B', 'contacto@proveedorb.com'),
('Proveedor C', 'contacto@proveedorc.com');

-- Insertar en la tabla product_types
INSERT INTO "product_types" ("product_type_name")
VALUES
('Tipo A'),
('Tipo B'),
('Tipo C');

-- Insertar en la tabla product_sections
INSERT INTO "product_sections" ("section_name")
VALUES
('Sección A'),
('Sección B'),
('Sección C');

-- Insertar en la tabla products
INSERT INTO "products" ("provider_id", "product_type_id", "section_id", "product_name", "product_description", "product_price")
VALUES
(1, 1, 1, 'Producto A', 'Descripción del Producto A', 100.50),
(1,1, 2, 'Producto A2', 'Descripción del Producto A2', 200.00),
(2, 1, 3, 'Producto B', 'Descripción del Producto B', 150.75),
(3, 2, 1, 'Producto C', 'Descripción del Producto C', 80.25),
(1, 2, 1, 'Producto D', 'Descripción del Producto D', 120.00),
(2, 3, 2, 'Producto E', 'Descripción del Producto E', 90.00),
(3, 1, 3, 'Producto F', 'Descripción del Producto F', 60.50),
(1, 2, 1, 'Producto G', 'Descripción del Producto G', 110.00),
(2, 3, 2, 'Producto H', 'Descripción del Producto H', 95.25),
(3, 1, 3, 'Producto I', 'Descripción del Producto I', 70.00),
(1, 2, 1, 'Producto J', 'Descripción del Producto J', 130.00),
(2, 2, 2, 'Producto B', 'Descripción del Producto B', 150.75),
(3, 3, 3, 'Producto C', 'Descripción del Producto C', 80.25);

-- Insertar en la tabla projects
INSERT INTO "projects" ("user_id", "project_name")
VALUES
(1, 'Proyecto 1'),
(2, 'Proyecto 2'),
(3, 'Proyecto 3');

-- Insertar en la tabla project_products
INSERT INTO "project_products" ("project_id", "product_id", "project_product_quantity")
VALUES
(1, 1, 10),
(2, 2, 5),
(3, 3, 8);

-- Insertar en la tabla rating_categories
INSERT INTO "rating_categories" ("category_name")
VALUES
('Calificación de Calidad'),
('Calificación de Precio'),
('Calificación de Entrega');

-- Insertar en la tabla rating_values
INSERT INTO "rating_values" ("user_id", "provider_id", "product_id", "category_id", "rating_value")
VALUES
(1, 1, 1, 1, 4),
(2, 2, 2, 2, 5),
(3, 3, 3, 3, 3);

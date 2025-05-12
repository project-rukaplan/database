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
    "product__detailed_description" TEXT,
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

-- Insertar usuarios
INSERT INTO users (user_name, user_last_name, user_email) VALUES
('Daniel', 'Gaviria', 'daniel@example.com'),
('Laura', 'Martinez', 'laura@example.com'),
('Carlos', 'Ramirez', 'carlos@example.com');

-- Insertar proveedores
INSERT INTO providers (provider_name, provider_email) VALUES
('Proveedor A', 'proveedorA@example.com'),
('Proveedor B', 'proveedorB@example.com');

-- Insertar tipos de producto
INSERT INTO product_types (product_type_name) VALUES
('Electrónica'), ('Ferretería'), ('Oficina');

-- Insertar secciones de producto
INSERT INTO product_sections (section_name) VALUES
('Almacenamiento'), ('Herramientas'), ('Mobiliario');

-- Insertar productos
INSERT INTO products (provider_id, product_type_id, section_id, product_name, product_description, product__detailed_description, product_price) VALUES
(1, 1, 1, 'Disco Duro SSD', 'Almacenamiento rápido', 'SSD de 1TB con interfaz NVMe', 350.00),
(1, 2, 2, 'Taladro Inalámbrico', 'Herramienta eléctrica', 'Taladro recargable con brocas incluidas', 120.00),
(2, 3, 3, 'Silla Ergonómica', 'Silla de oficina', 'Silla con soporte lumbar y ajustable en altura', 210.00);

-- Insertar proyectos
INSERT INTO projects (user_id, project_name) VALUES
(1, 'Proyecto Alpha'),
(2, 'Proyecto Beta');

-- Insertar productos en proyectos
INSERT INTO project_products (project_id, product_id, project_product_quantity) VALUES
(1, 1, 10),
(1, 2, 5),
(2, 3, 2);

-- Insertar categorías de calificación
INSERT INTO rating_categories (category_name) VALUES
('quality'), ('cost'), ('shipment');

-- Insertar calificaciones
INSERT INTO rating_values (user_id, provider_id, product_id, category_id, rating_value) VALUES
(1, 1, 1, 1, 5),
(1, 1, 1, 2, 4),
(1, 1, 1, 3, 3),
(2, 1, 2, 1, 4),
(2, 1, 2, 2, 5),
(2, 1, 2, 3, 4),
(3, 2, 3, 1, 3),
(3, 2, 3, 2, 4),
(3, 2, 3, 3, 5);


CREATE VIEW product_quality_rating_view AS
SELECT
    p.product_id,
    p.product_name,
    AVG(rv.rating_value) AS product_quality_rating
FROM products p
JOIN rating_values rv ON p.product_id = rv.product_id
JOIN rating_categories rc ON rv.category_id = rc.category_id
WHERE rc.category_name = 'quality'
GROUP BY p.product_id, p.product_name;

CREATE VIEW product_cost_rating_view AS
SELECT
    p.product_id,
    p.product_name,
    AVG(rv.rating_value) AS product_cost_rating
FROM products p
JOIN rating_values rv ON p.product_id = rv.product_id
JOIN rating_categories rc ON rv.category_id = rc.category_id
WHERE rc.category_name = 'cost'
GROUP BY p.product_id, p.product_name;

CREATE VIEW product_shipment_rating_view AS
SELECT
    p.product_id,
    p.product_name,
    AVG(rv.rating_value) AS product_shipment_rating
FROM products p
JOIN rating_values rv ON p.product_id = rv.product_id
JOIN rating_categories rc ON rv.category_id = rc.category_id
WHERE rc.category_name = 'shipment'
GROUP BY p.product_id, p.product_name;

CREATE OR REPLACE VIEW provider_quality_rating_view AS
SELECT
    pr.provider_id,
    pr.provider_name,
    AVG(rv.rating_value) AS provider_quality_rating
FROM providers pr
JOIN rating_values rv ON pr.provider_id = rv.provider_id
JOIN rating_categories rc ON rv.category_id = rc.category_id
WHERE rc.category_name = 'quality'
GROUP BY pr.provider_id, pr.provider_name;

CREATE OR REPLACE VIEW provider_cost_rating_view AS
SELECT
    pr.provider_id,
    pr.provider_name,
    AVG(rv.rating_value) AS provider_cost_rating
FROM providers pr
JOIN rating_values rv ON pr.provider_id = rv.provider_id
JOIN rating_categories rc ON rv.category_id = rc.category_id
WHERE rc.category_name = 'cost'
GROUP BY pr.provider_id, pr.provider_name;

CREATE OR REPLACE VIEW provider_shipment_rating_view AS
SELECT
    pr.provider_id,
    pr.provider_name,
    AVG(rv.rating_value) AS provider_shipment_rating
FROM providers pr
JOIN rating_values rv ON pr.provider_id = rv.provider_id
JOIN rating_categories rc ON rv.category_id = rc.category_id
WHERE rc.category_name = 'shipment'
GROUP BY pr.provider_id, pr.provider_name;


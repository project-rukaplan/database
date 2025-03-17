CREATE TABLE "users"(
    "user_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''users_user_id_seq'' )',
    "user_name" VARCHAR(500) NOT NULL,
    "user_last_name" VARCHAR(500) NOT NULL,
    "user_email" VARCHAR(500) NOT NULL
);
ALTER TABLE
    "users" ADD PRIMARY KEY("user_id");
CREATE TABLE "products"(
    "provider_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''products_provider_id_seq'' )',
    "product_type_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''products_product_type_id_seq'' )',
    "section_id" BIGINT NOT NULL,
    "product_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''products_product_id_seq'' )',
    "product_name" VARCHAR(500) NOT NULL,
    "product_description" VARCHAR(500) NOT NULL,
    "product_price" BIGINT NOT NULL
);
ALTER TABLE
    "products" ADD PRIMARY KEY("provider_id");
ALTER TABLE
    "products" ADD PRIMARY KEY("product_type_id");
ALTER TABLE
    "products" ADD PRIMARY KEY("product_id");
CREATE TABLE "providers"(
    "provider_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''providers_provider_id_seq'' )',
    "provider_name" VARCHAR(500) NOT NULL,
    "provider_email" VARCHAR(500) NOT NULL
);
ALTER TABLE
    "providers" ADD PRIMARY KEY("provider_id");
CREATE TABLE "projects"(
    "project_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''projects_project_id_seq'' )',
    "user_id" BIGINT NOT NULL,
    "project_name" VARCHAR(500) NOT NULL
);
ALTER TABLE
    "projects" ADD PRIMARY KEY("project_id");
CREATE TABLE "product_sections"(
    "section_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''product_sections_section_id_seq'' )',
    "section_name" VARCHAR(500) NOT NULL
);
ALTER TABLE
    "product_sections" ADD PRIMARY KEY("section_id");
CREATE TABLE "project_products"(
    "project_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''project_products_project_id_seq'' )',
    "product_id" BIGINT NOT NULL,
    "project_product_quantity" BIGINT NOT NULL
);
ALTER TABLE
    "project_products" ADD PRIMARY KEY("project_id");
ALTER TABLE
    "project_products" ADD PRIMARY KEY("product_id");
CREATE TABLE "ratings"(
    "rating_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''ratings_rating_id_seq'' )',
    "user_id" BIGINT NOT NULL,
    "provider_id" BIGINT NULL,
    "product_id" BIGINT NULL,
    "rating_quality" BIGINT NULL,
    "rating_cost" BIGINT NULL,
    "rating_shipment" BIGINT NULL
);
ALTER TABLE
    "ratings" ADD PRIMARY KEY("rating_id");
CREATE TABLE "product_types"(
    "product_type_id" BIGINT NOT NULL DEFAULT 'DEFAULT NEXTVAL ( ''product_types_product_type_id_seq'' )',
    "product_type_name" VARCHAR(500) NOT NULL
);
ALTER TABLE
    "product_types" ADD PRIMARY KEY("product_type_id");
ALTER TABLE
    "ratings" ADD CONSTRAINT "ratings_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "products"("product_id");
ALTER TABLE
    "projects" ADD CONSTRAINT "projects_project_id_foreign" FOREIGN KEY("project_id") REFERENCES "users"("user_id");
ALTER TABLE
    "ratings" ADD CONSTRAINT "ratings_provider_id_foreign" FOREIGN KEY("provider_id") REFERENCES "providers"("provider_id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_provider_id_foreign" FOREIGN KEY("provider_id") REFERENCES "providers"("provider_id");
ALTER TABLE
    "ratings" ADD CONSTRAINT "ratings_user_id_foreign" FOREIGN KEY("user_id") REFERENCES "users"("user_id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_product_id_foreign" FOREIGN KEY("product_id") REFERENCES "project_products"("product_id");
ALTER TABLE
    "product_types" ADD CONSTRAINT "product_types_product_type_id_foreign" FOREIGN KEY("product_type_id") REFERENCES "products"("product_type_id");
ALTER TABLE
    "products" ADD CONSTRAINT "products_section_id_foreign" FOREIGN KEY("section_id") REFERENCES "product_sections"("section_id");
ALTER TABLE
    "project_products" ADD CONSTRAINT "project_products_project_id_foreign" FOREIGN KEY("project_id") REFERENCES "projects"("project_id");
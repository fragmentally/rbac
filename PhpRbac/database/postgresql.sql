/*
 * Create Tables
 */
CREATE SEQUENCE PREFIX_permissions_id_seq;
CREATE TABLE IF NOT EXISTS "PREFIX_permissions" (
  "ID" integer NOT NULL DEFAULT nextval('PREFIX_permissions_id_seq'),
  "Lft" integer NOT NULL,
  "Rght" integer NOT NULL,
  "Title" character varying(64) NOT NULL,
  "Description" text NOT NULL,
  CONSTRAINT pkey_rbac_permissions PRIMARY KEY ("ID")
);
ALTER SEQUENCE PREFIX_permissions_id_seq OWNED BY "PREFIX_permissions"."ID";

CREATE TABLE IF NOT EXISTS "PREFIX_rolepermissions" (
  "RoleID" integer NOT NULL,
  "PermissionID" integer NOT NULL,
  "AssignmentDate" integer NOT NULL,
  CONSTRAINT pkey_rbac_rolepermissions PRIMARY KEY ("RoleID", "PermissionID")
);

CREATE SEQUENCE PREFIX_roles_id_seq;
CREATE TABLE IF NOT EXISTS "PREFIX_roles" (
  "ID" integer NOT NULL DEFAULT nextval('PREFIX_roles_id_seq'),
  "Lft" integer NOT NULL,
  "Rght" integer NOT NULL,
  "Title" character varying(128) NOT NULL,
  "Description" text NOT NULL,
  CONSTRAINT pkey_rbac_roles PRIMARY KEY ("ID")
);
ALTER SEQUENCE PREFIX_roles_id_seq OWNED BY "PREFIX_roles"."ID";

CREATE TABLE IF NOT EXISTS "PREFIX_userroles" (
  "UserID" integer NOT NULL,
  "RoleID" integer NOT NULL,
  "AssignmentDate" integer NOT NULL,
  CONSTRAINT pkey_rbac_userroles PRIMARY KEY ("UserID", "RoleID")
);

CREATE INDEX ix_rbac_permissions_lft ON "PREFIX_permissions" ("Lft");
CREATE INDEX ix_rbac_permissions_rght ON "PREFIX_permissions" ("Rght");
CREATE INDEX ix_rbac_permissions_title ON "PREFIX_permissions" ("Title");
CREATE INDEX ix_rbac_roles_lft ON "PREFIX_roles" ("Lft");
CREATE INDEX ix_rbac_roles_rght ON "PREFIX_roles" ("Rght");
CREATE INDEX ix_rbac_roles_title ON "PREFIX_roles" ("Title");

/*
 * Insert Initial Table Data
 */

INSERT INTO "PREFIX_permissions" ("ID", "Lft", "Rght", "Title", "Description")
VALUES (1, 0, 1, 'root', 'root');

INSERT INTO "PREFIX_rolepermissions" ("RoleID", "PermissionID", "AssignmentDate")
VALUES (1, 1, EXTRACT(EPOCH FROM NOW())::integer);

INSERT INTO "PREFIX_roles" ("ID", "Lft", "Rght", "Title", "Description")
VALUES (1, 0, 1, 'root', 'root');

INSERT INTO "PREFIX_userroles" ("UserID", "RoleID", "AssignmentDate")
VALUES (1, 1, EXTRACT(EPOCH FROM NOW())::integer);

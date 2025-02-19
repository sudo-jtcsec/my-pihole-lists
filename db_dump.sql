PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
DROP TABLE IF EXISTS 'domainlist_by_group';
DROP TABLE IF EXISTS 'group';
DROP TABLE IF EXISTS 'domainlist';
DROP TABLE IF EXISTS 'adlist';
CREATE TABLE IF NOT EXISTS "group"
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    name TEXT UNIQUE NOT NULL,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    description TEXT
);
INSERT INTO "group" VALUES(0,1,'Default',1739916485,1739916485,'The default group');
CREATE TABLE domainlist
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type INTEGER NOT NULL DEFAULT 0,
    domain TEXT NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    comment TEXT,
    UNIQUE(domain, type)
);
CREATE TABLE adlist
(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    address TEXT NOT NULL,
    enabled BOOLEAN NOT NULL DEFAULT 1,
    date_added INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    date_modified INTEGER NOT NULL DEFAULT (cast(strftime('%s', 'now') as int)),
    comment TEXT,
    date_updated INTEGER,
    number INTEGER NOT NULL DEFAULT 0,
    invalid_domains INTEGER NOT NULL DEFAULT 0,
    status INTEGER NOT NULL DEFAULT 0,
    abp_entries INTEGER NOT NULL DEFAULT 0,
    type INTEGER NOT NULL DEFAULT 0,
    UNIQUE(address, type)
);
INSERT INTO adlist VALUES(1,'https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts',1,1739916485,1739916485,'Migrated from /etc/pihole/adlists.list',1739916486,125376,0,1,0,0);
CREATE TABLE domainlist_by_group
(
    domainlist_id INTEGER NOT NULL REFERENCES domainlist (id),
    group_id INTEGER NOT NULL REFERENCES "group" (id),
    PRIMARY KEY (domainlist_id, group_id)
);
COMMIT;

Begin;

-- Drop all sys tables
DROP TABLE IF EXISTS sys_dept;
DROP TABLE IF EXISTS sys_user_role;
DROP TABLE IF EXISTS sys_role_menu;
DROP TABLE IF EXISTS sys_role_dept;
DROP TABLE IF EXISTS sys_role;
DROP TABLE IF EXISTS sys_menu;
DROP TABLE IF EXISTS sys_user_post;
DROP TABLE IF EXISTS sys_post;
DROP TABLE IF EXISTS sys_oper_log;
DROP TABLE IF EXISTS sys_dict_type;
DROP TABLE IF EXISTS sys_dict_data;
DROP TABLE IF EXISTS sys_config;
DROP TABLE IF EXISTS sys_notice;
DROP TABLE IF EXISTS sys_logininfor;
DROP TABLE IF EXISTS sys_user;
DROP TABLE IF EXISTS sys_job;
DROP TABLE IF EXISTS sys_job_log;
-- 1. Department Table
CREATE TABLE sys_dept (
    dept_id           SERIAL      NOT NULL PRIMARY KEY,
    parent_id         BIGINT         DEFAULT 0,
    ancestors         VARCHAR(50)    DEFAULT '',
    dept_name         VARCHAR(30)    DEFAULT '',
    order_num         INT            DEFAULT 0,
    leader            VARCHAR(20),
    phone             VARCHAR(11),
    email             VARCHAR(50),
    status            CHAR(1)        DEFAULT '0',
    del_flag          CHAR(1)        DEFAULT '0',
    create_by         VARCHAR(64)    DEFAULT '',
    create_time       TIMESTAMP,
    update_by         VARCHAR(64)    DEFAULT '',
    update_time       TIMESTAMP
);

-- Initialize - Department Table Data
INSERT INTO sys_dept VALUES
(100,  0,   '0',          'RBAC Software',                0, 'CEO', '15888888888', 'info@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(101,  100, '0,100',      'Engineering',                  1, 'CTO', '15888888888', 'eng@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(102,  100, '0,100',      'Product',                      2, 'CPO', '15888888888', 'product@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(103,  101, '0,100,101',  'Platform Team',                1, 'Platform Lead', '15888888888', 'platform@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(104,  101, '0,100,101',  'Application Team',             2, 'App Lead', '15888888888', 'app@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(105,  101, '0,100,101',  'Quality Assurance',            3, 'QA Lead', '15888888888', 'qa@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(106,  101, '0,100,101',  'DevOps',                       4, 'DevOps Lead', '15888888888', 'devops@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(107,  102, '0,100,102',  'Design',                       5, 'Design Lead', '15888888888', 'design@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(108,  102, '0,100,102',  'Research',                     1, 'Research Lead', '15888888888', 'research@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null),
(109,  102, '0,100,102',  'Customer Success',             2, 'CS Lead', '15888888888', 'cs@rbac.dev', '0', '0', 'admin', CURRENT_TIMESTAMP, '', null);

-- This will make the table to generate auto dep_id of current max dep_id + 2
SELECT setval(pg_get_serial_sequence('sys_dept', 'dept_id'), (SELECT MAX(dept_id) FROM sys_dept));

-- 2. User Information Table
CREATE TABLE sys_user (
    user_id           SERIAL      NOT NULL PRIMARY KEY,
    dept_id           BIGINT         DEFAULT NULL,
    user_name         VARCHAR(30)    NOT NULL,
    nick_name         VARCHAR(30)    NOT NULL,
    user_type         VARCHAR(2)     DEFAULT '00',
    email             VARCHAR(50)    DEFAULT '',
    phonenumber       VARCHAR(11)    DEFAULT '',
    sex               CHAR(1)        DEFAULT '0',
    avatar            VARCHAR(100)   DEFAULT '',
    password          VARCHAR(100)   DEFAULT '',
    status            CHAR(1)        DEFAULT '0',
    del_flag          CHAR(1)        DEFAULT '0',
    login_ip          VARCHAR(128)   DEFAULT '',
    login_date        TIMESTAMP,
    create_by         VARCHAR(64)    DEFAULT '',
    create_time       TIMESTAMP,
    update_by         VARCHAR(64)    DEFAULT '',
    update_time       TIMESTAMP,
    remark            VARCHAR(500)
);

-- Initialize - User Information Table Data
INSERT INTO sys_user VALUES
(1,  103, 'admin', 'RBAC Admin', '00', 'admin@rbac.dev', '1234567890', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', CURRENT_TIMESTAMP, 'admin', CURRENT_TIMESTAMP, '', NULL, 'Administrator');

-- This will make the table to generate auto user_id of current max user_id + 2
SELECT setval(pg_get_serial_sequence('sys_user', 'user_id'), (SELECT MAX(user_id) FROM sys_user));

-- 3. Position Information Table
CREATE TABLE sys_post (
    post_id       SERIAL      NOT NULL PRIMARY KEY,
    post_code     VARCHAR(64)    NOT NULL,
    post_name     VARCHAR(50)    NOT NULL,
    post_sort     INT            NOT NULL,
    status        CHAR(1)        NOT NULL,
    create_by     VARCHAR(64)    DEFAULT '',
    create_time   TIMESTAMP,
    update_by     VARCHAR(64)    DEFAULT '',
    update_time   TIMESTAMP,
    remark        VARCHAR(500)
);

-- Initialize - Position Information Table Data
INSERT INTO sys_post VALUES
(1, 'ceo',  'Chairman',           1, '0', 'admin', CURRENT_TIMESTAMP, '', null, ''),
(2, 'se',   'Project Manager',    2, '0', 'admin', CURRENT_TIMESTAMP, '', null, ''),
(3, 'hr',   'Human Resources',    3, '0', 'admin', CURRENT_TIMESTAMP, '', null, ''),
(4, 'user', 'Ordinary Employee',  4, '0', 'admin', CURRENT_TIMESTAMP, '', null, '');

SELECT setval(pg_get_serial_sequence('sys_post', 'post_id'), (SELECT MAX(post_id) FROM sys_post));

-- 4. Role Information Table
CREATE TABLE sys_role (
    role_id              SERIAL      NOT NULL PRIMARY KEY,
    role_name            VARCHAR(30)    NOT NULL,
    role_key             VARCHAR(100)   NOT NULL,
    role_sort            INT            NOT NULL,
    data_scope           CHAR(1)        DEFAULT '1',
    menu_check_strictly  SMALLINT       DEFAULT 1,
    dept_check_strictly  SMALLINT       DEFAULT 1,
    status               CHAR(1)        NOT NULL,
    del_flag             CHAR(1)        DEFAULT '0',
    create_by            VARCHAR(64)    DEFAULT '',
    create_time          TIMESTAMP,
    update_by            VARCHAR(64)    DEFAULT '',
    update_time          TIMESTAMP,
    remark               VARCHAR(500)
);

-- Initialize - Role Information Table Data
INSERT INTO sys_role VALUES
(1, 'Super Administrator', 'admin',  1, '1', 1, 1, '0', '0', 'admin', CURRENT_TIMESTAMP, '', null, 'Super Administrator');

SELECT setval(pg_get_serial_sequence('sys_role', 'role_id'), (SELECT MAX(role_id) FROM sys_role));

-- 5. Menu Permissions Table
CREATE TABLE sys_menu (
    menu_id           SERIAL      NOT NULL PRIMARY KEY,
    menu_name         VARCHAR(50)    NOT NULL,
    parent_id         BIGINT         DEFAULT 0,
    order_num         INT            DEFAULT 0,
    path              VARCHAR(200)   DEFAULT '',
    component         VARCHAR(255),
    query             VARCHAR(255),
    route_name        VARCHAR(50)    DEFAULT '',
    is_frame          CHAR(1)        DEFAULT 1,
    is_cache          CHAR(1)        DEFAULT 0,
    menu_type         CHAR(1)        DEFAULT '',
    visible           CHAR(1)        DEFAULT '0',
    status            CHAR(1)        DEFAULT '0',
    perms             VARCHAR(100),
    icon              VARCHAR(100)   DEFAULT '#',
    create_by         VARCHAR(64)    DEFAULT '',
    create_time       TIMESTAMP,
    update_by         VARCHAR(64)    DEFAULT '',
    update_time       TIMESTAMP,
    remark            VARCHAR(500)   DEFAULT ''
);

INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
	 ('Dashboard',0,1,'/admin',NULL,NULL,'','1','0','C','0','0','admin:dashboard:list','Gauge','admin','2025-07-14 16:48:34.509985','admin','2025-07-14 16:53:37.272895',''),
     ('System Management',0,2,'/admin/system/user',NULL,NULL,'','1','0','M','0','0','system:management:list','Settings','admin','2025-07-14 16:50:21.274859','',NULL,''),
	 ('System Monitoring',0,3,'',NULL,NULL,'','1','0','M','0','0','system:monitoring:list','Monitor','admin','2025-07-14 16:51:19.500095','',NULL,''),
     ('Users',2,1,'/admin/system/user','layout/admin/system/user',NULL,'','1','1','C','0','0','system:user:list','User','admin','2025-07-14 17:00:18.436984','',NULL,''),
	 ('Roles',2,2,'',NULL,NULL,'','1','1','C','0','0','system:role:list','ShieldCheck','admin','2025-07-14 17:02:31.732709','',NULL,''),
	 ('Menus',2,3,'',NULL,NULL,'','1','1','C','0','0','system:menu:list','List','admin','2025-07-14 17:05:15.344897','',NULL,''),
	 ('Dictionary',2,4,'',NULL,NULL,'','1','1','C','0','0','system:dict:list','BookOpen','admin','2025-07-14 17:07:34.751692','',NULL,''),
	 ('Configuration',2,5,'',NULL,NULL,'','1','1','C','0','0','system:config:list','SlidersHorizontal','admin','2025-07-14 17:09:47.731522','',NULL,''),
	 ('Notification',2,6,'',NULL,NULL,'','1','1','C','0','0','system:notice:list','Bell','admin','2025-07-14 17:10:56.151561','',NULL,'');
INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
	 ('Position',2,7,'',NULL,NULL,'','1','1','C','0','0','system:post:list','Briefcase','admin','2025-07-14 17:12:59.258077','admin','2025-07-14 17:13:07.531706',''),
	 ('Department',2,8,'zcx','/admin/system/dept','zxc','','1','1','C','0','0','system:dept:list','#','admin','2025-07-14 17:17:27.527528','',NULL,''),
	 ('Online Users',3,1,'','bmv',NULL,'','1','1','C','0','0','monitor:online:list','Users','admin','2025-07-14 17:20:48.866794','',NULL,''),
	 ('Server',3,2,'',NULL,NULL,'','1','1','C','0','0','monitor:server:list','Server','admin','2025-07-14 17:22:25.737024','',NULL,''),
	 ('Operation Log',3,3,'',NULL,NULL,'','1','1','C','0','0','monitor:operlog:list','FileText','admin','2025-07-14 17:23:32.693074','',NULL,''),
	 ('Login Log',3,5,'',NULL,NULL,'','1','1','C','0','0','monitor:logininfor:list','Key','admin','2025-07-14 17:24:43.555407','',NULL,''),
	 ('Cache',3,6,'',NULL,NULL,'','1','1','C','0','0','monitor:cache:list','HardDrive','admin','2025-07-14 17:25:33.59434','',NULL,''),
	 ('Cache List',3,7,'',NULL,NULL,'','1','1','C','0','0','monitor:cache:list','Database','admin','2025-07-14 17:27:31.549262','',NULL,''),
     ('User Query',4,1,'',NULL,NULL,'','1','0','F','0','0','system:user:query','#','admin','2025-07-14 17:31:45.317934','',NULL,''),
     ('Add User',4,2,'',NULL,NULL,'','1','0','F','0','0','system:user:add','#','admin','2025-07-14 17:32:13.374191','',NULL,'');
INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
     ('Edit User',4,3,'',NULL,NULL,'','1','0','F','0','0','system:user:edit','#','admin','2025-07-14 18:03:41.834948','',NULL,''),
     ('Delete User',4,4,'',NULL,NULL,'','1','0','F','0','0','system:user:remove','#','admin','2025-07-14 18:04:20.418486','',NULL,''),
     ('Export User',4,5,'',NULL,NULL,'','1','0','F','0','0','system:user:export','#','admin','2025-07-14 18:05:01.810625','',NULL,''),
     ('Import User',4,6,'',NULL,NULL,'','1','0','F','0','0','system:user:import','#','admin','2025-07-14 18:05:25.18649','',NULL,''),
     ('Reset Password',4,7,'',NULL,NULL,'','1','0','F','0','0','system:user:resetPwd','#','admin','2025-07-14 18:05:58.020742','',NULL,''),
     ('Role Query',5,1,'',NULL,NULL,'','1','0','F','0','0','system:role:query','#','admin','2025-07-14 18:06:18.84077','',NULL,''),
     ('Add Role',5,2,'',NULL,NULL,'','1','0','F','0','0','system:role:add','#','admin','2025-07-14 18:06:49.059022','',NULL,''),
     ('Edit Role',5,3,'',NULL,NULL,'','1','0','F','0','0','system:role:edit','#','admin','2025-07-14 18:07:29.118628','',NULL,''),
     ('Delete Role',5,4,'',NULL,NULL,'','1','0','F','0','0','system:role:remove','#','admin','2025-07-14 18:08:11.582679','',NULL,''),
     ('Export Role',5,5,'',NULL,NULL,'','1','0','F','0','0','system:role:export','#','admin','2025-07-14 18:08:39.385475','',NULL,'');
INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
     ('Menu Query',6,1,'',NULL,NULL,'','1','0','F','0','0','system:menu:query','#','admin','2025-07-14 18:09:20.145307','',NULL,''),
     ('Add Menu',6,2,'',NULL,NULL,'','1','0','F','0','0','system:menu:add','#','admin','2025-07-14 18:09:46.788333','',NULL,''),
     ('Edit Menu',6,3,'',NULL,NULL,'','1','0','F','0','0','system:menu:edit','#','admin','2025-07-14 18:10:11.140718','',NULL,''),
     ('Delete Menu',6,4,'',NULL,NULL,'','1','0','F','0','0','system:menu:remove','#','admin','2025-07-14 18:10:38.641664','',NULL,''),
     ('Department Query',11,1,'',NULL,NULL,'','1','0','F','0','0','system:dept:query','#','admin','2025-07-14 18:11:16.062147','',NULL,''),
     ('Add Department',11,2,'',NULL,NULL,'','1','0','F','0','0','system:dept:add','#','admin','2025-07-14 18:11:38.055115','',NULL,''),
     ('Edit Department',11,3,'',NULL,NULL,'','1','0','F','0','0','system:dept:edit','#','admin','2025-07-14 18:12:07.314512','',NULL,''),
     ('Delete Department',11,4,'',NULL,NULL,'','1','0','F','0','0','system:dept:remove','#','admin','2025-07-14 18:12:36.536344','admin','2025-07-14 18:12:47.940895',''),
     ('Post Query',10,1,'',NULL,NULL,'','1','0','F','0','0','system:post:query','#','admin','2025-07-14 18:20:14.717474','',NULL,''),
     ('Add Post',10,2,'',NULL,NULL,'','1','0','F','0','0','system:post:add','#','admin','2025-07-14 18:21:01.186881','',NULL,'');
INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
     ('Edit Post',10,3,'',NULL,NULL,'','1','0','F','0','0','system:post:edit','#','admin','2025-07-14 18:21:33.518474','',NULL,''),
     ('Delete Post',10,4,'',NULL,NULL,'','1','0','F','0','0','system:post:remove','#','admin','2025-07-14 18:21:58.669386','',NULL,''),
     ('Export Post',10,5,'',NULL,NULL,'','1','0','F','0','0','system:post:export','#','admin','2025-07-14 18:22:33.249881','',NULL,''),
     ('Dictionary Query',7,1,'',NULL,NULL,'','1','0','F','0','0','system:dict:query','#','admin','2025-07-14 18:23:20.124619','',NULL,''),
     ('Add Dictionary',7,2,'',NULL,NULL,'','1','0','F','0','0','system:dict:add','#','admin','2025-07-14 18:23:46.619984','',NULL,''),
     ('Edit Dictionary',7,3,'',NULL,NULL,'','1','0','F','0','0','system:dict:edit','#','admin','2025-07-14 18:24:14.109289','',NULL,''),
     ('Delete Dictionary',7,4,'',NULL,NULL,'','1','0','F','0','0','system:dict:remove','#','admin','2025-07-14 18:24:57.807078','',NULL,''),
     ('Export Dictionary',7,5,'',NULL,NULL,'','1','0','F','0','0','system:dict:export','#','admin','2025-07-14 18:25:27.08423','',NULL,''),
     ('Configuration Query',8,1,'',NULL,NULL,'','1','0','F','0','0','system:config:query','#','admin','2025-07-14 18:26:14.836302','',NULL,''),
     ('Add Configuration',8,2,'',NULL,NULL,'','1','0','F','0','0','system:config:add','#','admin','2025-07-14 18:26:57.720209','',NULL,'');
INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
     ('Edit Configuration',8,3,'',NULL,NULL,'','1','0','F','0','0','system:config:edit','#','admin','2025-07-14 18:27:31.892471','',NULL,''),
     ('Delete Configuration',8,4,'',NULL,NULL,'','1','0','F','0','0','system:config:remove','#','admin','2025-07-14 18:28:11.710236','',NULL,''),
     ('Export Configuration',8,5,'',NULL,NULL,'','1','0','F','0','0','system:config:export','#','admin','2025-07-14 18:28:41.645554','',NULL,''),
     ('Notice Query',9,1,'',NULL,NULL,'','1','0','F','0','0','system:notice:query','#','admin','2025-07-14 18:29:25.165537','',NULL,''),
     ('Add Notice',9,2,'',NULL,NULL,'','1','0','F','0','0','system:notice:add','#','admin','2025-07-14 18:29:50.09361','',NULL,''),
     ('Edit Notice',9,3,'',NULL,NULL,'','1','0','F','0','0','system:notice:edit','#','admin','2025-07-14 18:30:14.905687','',NULL,''),
     ('Delete Notice',9,4,'',NULL,NULL,'','1','0','F','0','0','system:notice:remove','#','admin','2025-07-14 18:30:47.561858','',NULL,''),
     ('Operation Query',14,1,'',NULL,NULL,'','1','0','F','0','0','monitor:operlog:query','#','admin','2025-07-14 18:32:06.89538','',NULL,''),
     ('Delete Operation',14,2,'',NULL,NULL,'','1','0','F','0','0','monitor:operlog:remove','#','admin','2025-07-14 18:32:33.176259','',NULL,''),
     ('Export Log',14,3,'',NULL,NULL,'','1','0','F','0','0','monitor:operlog:export','#','admin','2025-07-14 18:33:00.234482','',NULL,'');
INSERT INTO sys_menu (menu_name,parent_id,order_num,"path",component,query,route_name,is_frame,is_cache,menu_type,visible,status,perms,icon,create_by,create_time,update_by,update_time,remark) VALUES
     ('Login Query',15,1,'',NULL,NULL,'','1','0','F','0','0','monitor:logininfor:query','#','admin','2025-07-14 18:34:01.539229','',NULL,''),
     ('Delete Login',15,2,'',NULL,NULL,'','1','0','F','0','0','monitor:logininfor:remove','#','admin','2025-07-14 18:35:08.102336','',NULL,''),
     ('Export Login',15,3,'',NULL,NULL,'','1','0','F','0','0','monitor:logininfor:export','#','admin','2025-07-14 18:35:44.50973','',NULL,''),
     ('Account Unlock',15,4,'',NULL,NULL,'','1','0','F','0','0','monitor:logininfor:unlock','#','admin','2025-07-14 18:36:50.758545','',NULL,''),
     ('Online Query',12,1,'',NULL,NULL,'','1','0','F','0','0','monitor:online:query','#','admin','2025-07-14 18:44:37.475271','',NULL,''),
     ('Batch Force Logout',12,2,'',NULL,NULL,'','1','0','F','0','0','monitor:online:batchLogout','#','admin','2025-07-14 18:44:55.52098','',NULL,''),
     ('Single Force Logout',12,3,'',NULL,NULL,'','1','0','F','0','0','monitor:online:forceLogout','#','admin','2025-07-14 18:45:24.995199','',NULL,'');


SELECT setval(pg_get_serial_sequence('sys_menu', 'menu_id'), (SELECT MAX(menu_id) FROM sys_menu));

-- User and Role Association Table (Users N-1 Roles)
CREATE TABLE sys_user_role (
    user_id   BIGINT    NOT NULL,
    role_id   BIGINT    NOT NULL,
    PRIMARY KEY (user_id, role_id)
);

-- Initialization - User and Role Association Table Data
INSERT INTO sys_user_role VALUES (1, 1);

-- Role and Menu Association Table (Role 1-N Menu)
CREATE TABLE sys_role_menu (
    role_id   BIGINT    NOT NULL,
    menu_id   BIGINT    NOT NULL,
    PRIMARY KEY (role_id, menu_id)
);

-- Role and Department Association Table
CREATE TABLE sys_role_dept (
    role_id   BIGINT    NOT NULL,
    dept_id   BIGINT    NOT NULL,
    PRIMARY KEY (role_id, dept_id)
);

-- User and Post Association Table
CREATE TABLE sys_user_post (
    user_id   BIGINT    NOT NULL,
    post_id   BIGINT    NOT NULL,
    PRIMARY KEY (user_id, post_id)
);
-- Operation Log Records Table
CREATE TABLE sys_oper_log (
    oper_id           SERIAL     NOT NULL PRIMARY KEY,
    title             VARCHAR(50)   DEFAULT '',
    business_type     SMALLINT      DEFAULT 0,
    method            VARCHAR(200)  DEFAULT '',
    request_method    VARCHAR(10)   DEFAULT '',
    operator_type     SMALLINT      DEFAULT 0,
    oper_name         VARCHAR(50)   DEFAULT '',
    dept_name         VARCHAR(50)   DEFAULT '',
    oper_url          VARCHAR(255)  DEFAULT '',
    oper_ip           VARCHAR(128)  DEFAULT '',
    oper_location     VARCHAR(255)  DEFAULT '',
    oper_param        VARCHAR(2000) DEFAULT '',
    json_result       VARCHAR(2000) DEFAULT '',
    status            SMALLINT      DEFAULT 0,
    error_msg         VARCHAR(2000) DEFAULT '',
    oper_time         TIMESTAMP                ,
    cost_time         BIGINT        DEFAULT 0  --,
--     CONSTRAINT idx_sys_oper_log_bt UNIQUE (business_type),
--     CONSTRAINT idx_sys_oper_log_s  UNIQUE (status),
--     CONSTRAINT idx_sys_oper_log_ot UNIQUE (oper_time)
);

SELECT setval(pg_get_serial_sequence('sys_oper_log', 'oper_id'), (SELECT MAX(oper_id) FROM sys_oper_log));

-- Dictionary Type Table
CREATE TABLE sys_dict_type (
    dict_id          SERIAL     NOT NULL PRIMARY KEY,
    dict_name        VARCHAR(100)  DEFAULT '',
    dict_type        VARCHAR(100)  DEFAULT '' UNIQUE,
    status           CHAR(1)       DEFAULT '0',
    create_by        VARCHAR(64)   DEFAULT '',
    create_time      TIMESTAMP               ,
    update_by        VARCHAR(64)   DEFAULT '',
    update_time      TIMESTAMP                  ,
    remark           VARCHAR(500)  DEFAULT NULL
);

-- Initialization - Dictionary Type Table Data
INSERT INTO sys_dict_type VALUES
(1,  'User Gender',    'sys_user_sex',           '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'User gender list'),
(2,  'Menu Status',    'sys_show_hide',          '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Menu status list'),
(3,  'System Switch',  'sys_normal_disable',     '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'System switch list'),
(4,  'Task Status',    'sys_job_status',         '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Task status list'),
(5,  'Task Group',     'sys_job_group',          '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Task group list'),
(6,  'System Yes/No',  'sys_yes_no',             '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'System yes/no list'),
(7,  'Notice Type',    'sys_notice_type',        '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Notice type list'),
(8,  'Notice Status',  'sys_notice_status',      '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Notice status list'),
(9,  'Operation Type', 'sys_oper_type',          '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Operation type list'),
(10, 'System Status',  'sys_common_status',      '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Login status list'),
(11, 'Field Type',     'field_type',             '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Geo-fence field type list');

SELECT setval(pg_get_serial_sequence('sys_dict_type', 'dict_id'), (SELECT MAX(dict_id) FROM sys_dict_type));

-- Dictionary Data Table
CREATE TABLE sys_dict_data (
    dict_code        SERIAL     NOT NULL PRIMARY KEY ,
    dict_sort        INT           DEFAULT 0 ,
    dict_label       VARCHAR(100)  DEFAULT '' ,
    dict_value       VARCHAR(100)  DEFAULT '' ,
    dict_type        VARCHAR(100)  DEFAULT '' ,
    css_class        VARCHAR(100)  DEFAULT NULL ,
    list_class       VARCHAR(100)  DEFAULT NULL ,
    is_default       CHAR(1)       DEFAULT 'N' ,
    status           CHAR(1)       DEFAULT '0' ,
    create_by        VARCHAR(64)   DEFAULT '' ,
    create_time      TIMESTAMP                  ,
    update_by        VARCHAR(64)   DEFAULT '' ,
    update_time      TIMESTAMP                 ,
    remark           VARCHAR(500)  DEFAULT NULL
);

-- Initialization - Dictionary Data Table
INSERT INTO sys_dict_data VALUES
(1,  1,  'Male',        '0',       'sys_user_sex',        '',   '',        'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Gender male'),
(2,  2,  'Female',      '1',       'sys_user_sex',        '',   '',        'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Gender female'),
(3,  3,  'Unknown',     '2',       'sys_user_sex',        '',   '',        'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Gender unknown'),
(4,  1,  'Show',        '0',       'sys_show_hide',       '',   'primary', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Show menu'),
(5,  2,  'Hide',        '1',       'sys_show_hide',       '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Hide menu'),
(6,  1,  'Normal',      '0',       'sys_normal_disable',  '',   'primary', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Normal status'),
(7,  2,  'Disabled',    '1',       'sys_normal_disable',  '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Disabled status'),
(8,  1,  'Normal',      '0',       'sys_job_status',      '',   'primary', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Normal status'),
(9,  2,  'Paused',      '1',       'sys_job_status',      '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Disabled status'),
(10, 1,  'Default',     'DEFAULT', 'sys_job_group',       '',   '',        'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Default group'),
(11, 2,  'System',      'SYSTEM',  'sys_job_group',       '',   '',        'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'System group'),
(12, 1,  'Yes',         'Y',       'sys_yes_no',          '',   'primary', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'System default yes'),
(13, 2,  'No',          'N',       'sys_yes_no',          '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'System default no'),
(14, 1,  'Notice',      '1',       'sys_notice_type',     '',   'warning', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Notice'),
(15, 2,  'Announcement','2',       'sys_notice_type',     '',   'success', 'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Announcement'),
(16, 1,  'Normal',      '0',       'sys_notice_status',   '',   'primary', 'Y', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Normal status'),
(17, 2,  'Closed',      '1',       'sys_notice_status',   '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Closed status'),
(18, 99, 'Other',       '0',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Other operations'),
(19, 1,  'Add',         '1',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Add operation'),
(20, 2,  'Modify',      '2',       'sys_oper_type',       '',   'info',    'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Modify operation'),
(21, 3,  'Delete',      '3',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Delete operation'),
(22, 4,  'Authorize',   '4',       'sys_oper_type',       '',   'primary', 'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Authorize operation'),
(23, 5,  'Export',      '5',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Export operation'),
(24, 6,  'Import',      '6',       'sys_oper_type',       '',   'warning', 'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Import operation'),
(25, 7,  'Force Logout','7',       'sys_oper_type',       '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Force logout operation'),
(26, 1,  'Success',     '0',       'sys_common_status',   '',   'primary', 'N', '0', 'admin', CURRENT_TIMESTAMP, '', null, 'Normal status'),
(27, 2,  'Failure',     '1',       'sys_common_status',   '',   'danger',  'N', '0', 'admin', CURRENT_TIMESTAMP, '', null, 'Disabled status');

SELECT setval(pg_get_serial_sequence('sys_dict_data', 'dict_code'), (SELECT MAX(dict_code) FROM sys_dict_data));

-- Parameter Configuration Table
CREATE TABLE sys_config (
    config_id         SERIAL         NOT NULL PRIMARY KEY,
    config_name       VARCHAR(100)   DEFAULT '' ,
    config_key        VARCHAR(100)   DEFAULT '' ,
    config_value      VARCHAR(500)   DEFAULT '' ,
    config_type       CHAR(1)        DEFAULT 'N' ,
    create_by         VARCHAR(64)    DEFAULT '' ,
    create_time       TIMESTAMP                 ,
    update_by         VARCHAR(64)    DEFAULT '' ,
    update_time       TIMESTAMP                  ,
    remark            VARCHAR(500)   DEFAULT NULL
);

-- Initialization - Parameter Configuration Table Data
INSERT INTO sys_config VALUES
(1, 'Main Framework Page - Default Skin Style Name',  'sys.index.skinName',         'skin-blue', 'Y', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Blue skin-blue, Green skin-green, Purple skin-purple, Red skin-red, Yellow skin-yellow'),
(2, 'User Management - Initial Password',            'sys.user.initPassword',      '123456',    'Y', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Initial password 123456'),
(3, 'Main Framework Page - Sidebar Theme',           'sys.index.sideTheme',        'theme-dark','Y', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Dark theme theme-dark, Light theme theme-light'),
(4, 'Account Self-Service - CAPTCHA Switch',         'sys.account.captchaEnabled', 'true',      'Y', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Whether to enable CAPTCHA function (true to enable, false to disable)'),
(5, 'Account Self-Service - User Registration',      'sys.account.registerUser',   'false',     'Y', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Whether to enable user registration (true to enable, false to disable)'),
(6, 'User Login - Blacklist',                        'sys.login.blackIPList',      '',          'Y', 'admin', CURRENT_TIMESTAMP, '', NULL, 'Set login IP blacklist restriction; multiple entries are separated by ;, supports matching (* wildcard, subnet)');

SELECT setval(pg_get_serial_sequence('sys_config', 'config_id'), (SELECT MAX(config_id) FROM sys_config));

-- System Access Records Table
CREATE TABLE sys_logininfor (
    info_id          SERIAL      NOT NULL PRIMARY KEY ,
    user_name        VARCHAR(50)    DEFAULT '' ,
    ipaddr           VARCHAR(128)   DEFAULT '' ,
    login_location   VARCHAR(255)   DEFAULT '' ,
    browser          VARCHAR(50)    DEFAULT '' ,
    os               VARCHAR(50)    DEFAULT '' ,
    status           CHAR(1)        DEFAULT '0' ,
    msg              VARCHAR(255)   DEFAULT '' ,
    login_time       TIMESTAMP

);

CREATE INDEX idx_sys_logininfor_s ON sys_logininfor (status);
CREATE INDEX idx_sys_logininfor_lt ON sys_logininfor (login_time);

SELECT setval(pg_get_serial_sequence('sys_logininfor', 'info_id'), (SELECT MAX(info_id) FROM sys_logininfor));

-- Notification Announcement Table
CREATE TABLE sys_notice (
    notice_id        SERIAL         NOT NULL PRIMARY KEY,
    notice_title     VARCHAR(100)   NOT NULL ,
    notice_type      CHAR(1)        NOT NULL ,
    notice_content   text          DEFAULT NULL ,
    status           CHAR(1)        DEFAULT '0' ,
    create_by        VARCHAR(64)    DEFAULT ''  ,
    create_time      TIMESTAMP                  ,
    update_by        VARCHAR(64)    DEFAULT ''  ,
    update_time      TIMESTAMP                 ,
    remark           VARCHAR(255)   DEFAULT NULL
);

SELECT setval(pg_get_serial_sequence('sys_notice', 'notice_id'), (SELECT MAX(notice_id) FROM sys_notice));

-- ============================
-- Notice Seen Table
-- ============================
CREATE TABLE sys_notice_seen (
    notice_id INT NOT NULL REFERENCES sys_notice(notice_id) ON DELETE CASCADE,
    user_id   INT NOT NULL REFERENCES sys_user(user_id) ON DELETE CASCADE,

    seen      BOOLEAN DEFAULT FALSE,
    seen_at   TIMESTAMP,

    PRIMARY KEY (notice_id, user_id)
);

-- ============================
-- Notice Targets Table
-- ============================
CREATE TABLE sys_notice_target (
    target_id SERIAL PRIMARY KEY,

    notice_id INT NOT NULL REFERENCES sys_notice(notice_id) ON DELETE CASCADE,

    -- One of the following should be filled:
    target_user_id INT REFERENCES sys_user(user_id) ON DELETE CASCADE,
    target_dept_id INT REFERENCES sys_dept(dept_id) ON DELETE CASCADE,
    target_role_id INT REFERENCES sys_role(role_id) ON DELETE CASCADE,

    create_by         VARCHAR(64)    DEFAULT '',
    create_time       TIMESTAMP,
    update_by         VARCHAR(64)    DEFAULT '',
    update_time       TIMESTAMP,
    remark        VARCHAR(500),

    CONSTRAINT chk_at_least_one_target CHECK (
        target_user_id IS NOT NULL OR
        target_dept_id IS NOT NULL OR
        target_role_id IS NOT NULL
    )
);

CREATE INDEX idx_notice_target_notice ON sys_notice_target(notice_id);
CREATE INDEX idx_notice_seen_user ON sys_notice_seen(user_id);


COMMIT;
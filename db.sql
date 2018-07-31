SET foreign_key_checks = 0;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
  id        int           NOT NULL  AUTO_INCREMENT,
  privilege tinyint(4)    NOT NULL  DEFAULT 0,
  username  varchar(64)   NOT NULL  UNIQUE,
  password  varchar(255)  NOT NULL,
  tel       varchar(100)  NOT NULL  UNIQUE,
  email     varchar(255)  NOT NULL  UNIQUE,
  havecheckedemail  tinyint(1),
  baned     tinyint(1),
  created_at  timestamp   DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS user_info;
CREATE TABLE user_info
(
  id        int           NOT NULL  AUTO_INCREMENT,
  user_id   int           NOT NULL  UNIQUE,
  nickname  varchar(255),
  gender    tinyint(1),
  QQ        varchar(100),
  wechat    varchar(100),
  address   varchar(255),
  intro     text,
  created_at  timestamp   DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS goods;
CREATE TABLE goods
(
  id          int           NOT NULL  AUTO_INCREMENT,
  name        varchar(255)  NOT NULL,
  user_id     int           NOT NULL,
  price       double        NOT NULL,
  count       int           NOT NULL,
  description text          NOT NULL,
  deleted_at  timestamp     NULL DEFAULT NULL,
  created_at  timestamp     DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS tags;
CREATE TABLE tags
(
  id    int           NOT NULL AUTO_INCREMENT,
  name  varchar(100)  NOT NULL UNIQUE,
  created_at  timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id)
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS goods_tags;
CREATE TABLE goods_tags
(
  id      int NOT NULL AUTO_INCREMENT,
  good_id int NOT NULL,
  tag_id  int NOT NULL,
  created_at  timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (good_id) REFERENCES goods (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS favlists;
CREATE TABLE favlists
(
  id        int NOT NULL AUTO_INCREMENT,
  user_id   int NOT NULL,
  good_id   int,
  seller_id int,
  created_at  timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (good_id) REFERENCES goods (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (seller_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactions
(
  id        int         NOT NULL AUTO_INCREMENT,
  good_id   int         NOT NULL,
  buyer_id  int         NOT NULL,
  number    int         NOT NULL,
  status    smallint(6) NOT NULL,
  reason    text,
  created_at  timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (good_id) REFERENCES goods (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  FOREIGN KEY (buyer_id) REFERENCES users (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS comments;
CREATE TABLE comments
(
  id        int NOT NULL AUTO_INCREMENT,
  user_id   int NOT NULL,
  trans_id  int NOT NULL,
  content   text,
  created_at  timestamp DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (trans_id) REFERENCES transactions (id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
)
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

SET foreign_key_checks = 1;
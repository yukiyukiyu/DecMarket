SET foreign_key_checks = 0;

DROP TABLE IF EXISTS users;
CREATE TABLE users
{
  id        int           NOT NULL  AUTO_INCREMENT,
  privilege tinyint(4)    NOT NULL,
  username  varchar(64)   NOT NULL  UNIQUE,
  password  varchar(255)  NOT NULL,
  tel       varchar(100)  NOT NULL  UNIQUE,
  email     varchar(255)  NOT NULL  UNIQUE,
  havecheckedemail  tinyint(1),
  baned     tinyint(1),
  PRIMARY KEY (id)
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS user_info;
CREATE TABLE user_info
{
  id        int           NOT NULL  AUTO_INCREMENT,
  user_id   int           NOT NULL  UNIQUE,
  nickname  varchar(255),
  gender    tinyint(1),
  QQ        varchar(100),
  wechat    varchar(100),
  address   varchar(255),
  intro     text,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS goods;
CREATE TABLE goods
{
  id          int           NOT NULL  AUTO_INCREMENT,
  name        varchar(255)  NOT NULL,
  user_id     int           NOT NULL,
  price       double        NOT NULL,
  count       int           NOT NULL,
  description text          NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS tags;
CREATE TABLE tags
{
  id    int           NOT NULL AUTO_INCREMENT,
  name  varchar(100)  NOT NULL UNIQUE,
  PRIMARY KEY (id)
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS goods_tags;
CREATE TABLE goods_tags
{
  id      int NOT NULL AUTO_INCREMENT,
  good_id int NOT NULL,
  tag_id  int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (good_id) REFERENCES goods (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (tag_id) REFERENCES tags (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS favlists;
CREATE TABLE favlists
{
  id      int NOT NULL AUTO_INCREMENT,
  user_id int NOT NULL,
  good_id int NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (good_id) REFERENCES goods (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS transactions;
CREATE TABLE transactios
{
  id        int         NOT NULL AUTO_INCREMENT,
  good_id   int         NOT NULL,
  buyer_id  int         NOT NULL,
  number    int         NOT NULL,
  status    smallint(6) NOT NULL,
  reason    text,
  PRIMARY KEY (id),
  FOREIGN KEY (good_id) REFERENCES goods (id)
    ON UPDATE CASCADE,
  FOREIGN KEY (buyer_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

DROP TABLE IF EXISTS comments;
CREATE TABLE comments
{
  id        int NOT NULL AUTO_INCREMENT,
  user_id   int NOT NULL,
  trans_id  int NOT NULL,
  content   text,
  PRIMARY KEY (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (trans_id) REFERENCES transactions (id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
}
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

SET foreign_key_checks = 1;
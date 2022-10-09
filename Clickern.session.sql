UPDATE users_data
SET device_identifier = ""
WHERE user_Id = 1;
-- database alter queries
ALTER TABLE users_data DROP recent_login_datetime;
ALTER TABLE payment_info MODIFY datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;
-- Table creation quiries
CREATE TABLE clickern_config (
    Id INT AUTO_INCREMENT UNIQUE,
    config_name VARCHAR(50) NOT NULL,
    config_value VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);
CREATE TABLE users_data (
    user_Id int NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255),
    user_name VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    mob_no VARCHAR(15) NOT NULL UNIQUE,
    device_identifier VARCHAR(100),
    password VARCHAR(255),
    PRIMARY KEY (user_Id)
);
CREATE TABLE login_sessions (
    Id int NOT NULL AUTO_INCREMENT,
    session_Id VARCHAR(255) NOT NULL UNIQUE,
    user_Id int NOT NULL,
    device_name VARCHAR(255) NOT NULL,
    device_version VARCHAR(255) NOT NULL,
    device_identifier VARCHAR(255) NOT NULL,
    recent_login_datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (Id),
    FOREIGN KEY (user_Id) REFERENCES users_data(user_Id)
);
CREATE TABLE links_data (
    link_id int NOT NULL AUTO_INCREMENT,
    short_link VARCHAR(255) NOT NULL,
    target_link VARCHAR(255) NOT NULL,
    datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (link_id)
);
CREATE TABLE links_click_info (
    id int NOT NULL AUTO_INCREMENT,
    link_id int NOT NULL,
    user_Id int NOT NULL,
    click_count int NOT NULL,
    datetime DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_Id) REFERENCES users_data(user_Id),
    FOREIGN KEY (link_id) REFERENCES links_data(link_id)
);
CREATE TABLE payment_info (
    id INT AUTO_INCREMENT,
    user_Id int NOT NULL,
    paid DOUBLE DEFAULT 0,
    datetime DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (user_Id) REFERENCES users_data(user_Id)
);
-- Default config insertion
INSERT INTO clickern_config (config_name, config_value)
VALUES ("cost_per_click", ".15");
INSERT INTO clickern_config (config_name, config_value)
VALUES ("device_per_login_credential", "1");
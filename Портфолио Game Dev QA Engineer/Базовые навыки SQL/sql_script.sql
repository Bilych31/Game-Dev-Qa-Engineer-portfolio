CREATE TABLE devices
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    deviceName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    os INT DEFAULT 0,
    Price DECIMAL NOT NULL
);
CREATE TABLE users
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    nick VARCHAR(30) NOT NULL
);
CREATE TABLE purchases
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductId INT NOT NULL,
    CustomerId INT NOT NULL,
    CreatedAt DATE NOT NULL,
    os INT DEFAULT 1,
    Price DECIMAL NOT NULL,
    FOREIGN KEY (ProductId) REFERENCES devices(Id) ON DELETE CASCADE,
    FOREIGN KEY (CustomerId) REFERENCES users(Id) ON DELETE CASCADE
);

INSERT INTO devices (deviceName, Manufacturer, os, Price)
VALUES ('iPhone X', 'Apple', 2, 76000),
('iPhone 8', 'Apple', 2, 51000),
('iPhone 7', 'Apple', 5, 42000),
('Galaxy S9', 'Samsung', 2, 56000),
('Galaxy S8', 'Samsung', 1, 46000),
('Honor 10', 'Huawei', 2, 26000),
('Nokia 8', 'HMD Global', 6, 38000);
 
INSERT INTO users(nick) VALUES ('Tom'), ('Bob'),('Sam');
 
INSERT INTO purchases (ProductId, CustomerId, CreatedAt, os, Price)
VALUES
( 
    (SELECT Id FROM devices WHERE deviceName='Galaxy S8'),
    (SELECT Id FROM users WHERE nick='Tom'),
    '2018-05-21', 
    2, 
    (SELECT Price FROM devices WHERE deviceName='Galaxy S8')
),
( 
    (SELECT Id FROM devices WHERE deviceName='iPhone X'),
    (SELECT Id FROM users WHERE nick='Tom'),
    '2018-05-23',  
    1, 
    (SELECT Price FROM devices WHERE deviceName='iPhone X')
),
( 
    (SELECT Id FROM devices WHERE deviceName='iPhone X'),
    (SELECT Id FROM users WHERE nick='Bob'),
    '2018-05-21',  
    1, 
    (SELECT Price FROM devices WHERE deviceName='iPhone X')
);
SELECT * FROM devices;
SELECT * FROM devices WHERE Manufacturer = 'Apple';
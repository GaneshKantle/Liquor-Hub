create database liquorhub;

use liquorhub;

CREATE TABLE Customer (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    address VARCHAR(255)
);

CREATE TABLE Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    brand VARCHAR(50),
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    image VARCHAR(255),

    FOREIGN KEY (category_id)
    REFERENCES Category(category_id)
);

CREATE TABLE Cart (
    cart_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT UNIQUE,

    FOREIGN KEY (customer_id)
    REFERENCES Customer(customer_id)
);

CREATE TABLE CartItem (
    cart_item_id INT AUTO_INCREMENT PRIMARY KEY,
    cart_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,

    FOREIGN KEY (cart_id)
    REFERENCES Cart(cart_id),

    FOREIGN KEY (product_id)
    REFERENCES Product(product_id)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),

    FOREIGN KEY (customer_id)
    REFERENCES Customer(customer_id)
);

CREATE TABLE OrderItem (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id),

    FOREIGN KEY (product_id)
    REFERENCES Product(product_id)
);

CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT UNIQUE,
    payment_method VARCHAR(30),
    payment_status VARCHAR(20),

    FOREIGN KEY (order_id)
    REFERENCES Orders(order_id)
);

CREATE TABLE WishlistItem (
    wishlist_item_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    UNIQUE KEY uk_wishlist_customer_product (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);



INSERT INTO Category (category_name) VALUES
('Whisky'),
('Vodka'),
('Rum'),
('Gin'),
('Beer'),
('Wine'),
('Brandy'),
('Tequila');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(1,'Royal Stag','Royal Stag',850,100,'royal_stag.jpg'),
(1,'Royal Stag Barrel Select','Royal Stag',1050,80,'royal_stag_barrel.jpg'),
(1,'Blenders Pride','Blenders Pride',1250,90,'blenders_pride.jpg'),
(1,'Blenders Pride Reserve Collection','Blenders Pride',1700,60,'blenders_pride_reserve.jpg'),
(1,'Imperial Blue','Imperial Blue',780,120,'imperial_blue.jpg'),
(1,'Signature Rare Aged','Signature',1400,70,'signature.jpg'),
(1,'Oaksmith Gold','Oaksmith',1800,50,'oaksmith_gold.jpg'),
(1,'Rockford Reserve','Rockford',1700,40,'rockford.jpg'),
(1,'Teachers Highland Cream','Teachers',2600,35,'teachers.jpg'),
(1,'100 Pipers Deluxe','100 Pipers',2200,50,'100_pipers.jpg'),
(1,'Black Dog Triple Gold Reserve','Black Dog',3200,40,'black_dog.jpg'),
(1,'Black & White','Black & White',2500,35,'black_white.jpg'),
(1,'VAT 69','VAT 69',2800,30,'vat69.jpg'),
(1,'Ballantine''s Finest','Ballantine''s',3100,35,'ballantines.jpg'),
(1,'Johnnie Walker Red Label','Johnnie Walker',2900,45,'jw_red.jpg'),
(1,'Johnnie Walker Black Label','Johnnie Walker',4200,25,'jw_black.jpg'),
(1,'Johnnie Walker Double Black','Johnnie Walker',6200,15,'jw_double_black.jpg'),
(1,'Chivas Regal 12 Years','Chivas Regal',4500,25,'chivas12.jpg'),
(1,'Chivas Regal 18 Years','Chivas Regal',9800,10,'chivas18.jpg'),
(1,'Jameson Irish Whiskey','Jameson',3200,30,'jameson.jpg'),
(1,'Jack Daniel''s Old No.7','Jack Daniel''s',3800,30,'jack_daniels.jpg'),
(1,'Jack Daniel''s Honey','Jack Daniel''s',4200,20,'jd_honey.jpg'),
(1,'Glenfiddich 12 Years','Glenfiddich',6800,15,'glenfiddich12.jpg'),
(1,'The Glenlivet 12 Years','The Glenlivet',7200,12,'glenlivet12.jpg'),
(1,'Monkey Shoulder','Monkey Shoulder',4800,20,'monkey_shoulder.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(2,'Magic Moments','Magic Moments',700,120,'magic_moments.jpg'),
(2,'Magic Moments Remix Orange','Magic Moments',750,100,'magic_orange.jpg'),
(2,'Romanov','Romanov',650,100,'romanov.jpg'),
(2,'Romanov Lemon','Romanov',700,80,'romanov_lemon.jpg'),
(2,'White Mischief','White Mischief',720,90,'white_mischief.jpg'),
(2,'Smirnoff Red','Smirnoff',1400,60,'smirnoff_red.jpg'),
(2,'Smirnoff Green Apple','Smirnoff',1500,50,'smirnoff_apple.jpg'),
(2,'Absolut Blue','Absolut',2300,40,'absolut.jpg'),
(2,'Absolut Citron','Absolut',2400,30,'absolut_citron.jpg'),
(2,'Grey Goose','Grey Goose',5200,20,'grey_goose.jpg'),
(2,'Belvedere','Belvedere',4800,15,'belvedere.jpg'),
(2,'Ciroc','Ciroc',5600,15,'ciroc.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(3,'Old Monk XXX','Old Monk',650,150,'old_monk.jpg'),
(3,'Old Monk Gold Reserve','Old Monk',900,90,'old_monk_gold.jpg'),
(3,'Old Monk Supreme','Old Monk',1100,70,'old_monk_supreme.jpg'),
(3,'Bacardi Carta Blanca','Bacardi',1700,60,'bacardi_white.jpg'),
(3,'Bacardi Black','Bacardi',1800,50,'bacardi_black.jpg'),
(3,'Bacardi Limon','Bacardi',1850,45,'bacardi_limon.jpg'),
(3,'Captain Morgan Original','Captain Morgan',1300,70,'captain_morgan.jpg'),
(3,'Captain Morgan Spiced Gold','Captain Morgan',1600,50,'captain_spiced.jpg'),
(3,'Malibu Coconut Rum','Malibu',2500,35,'malibu.jpg'),
(3,'McDowell''s Celebration Rum','McDowell''s',600,100,'celebration.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(4,'Greater Than','Greater Than',1800,50,'greater_than.jpg'),
(4,'Stranger & Sons','Stranger & Sons',2500,40,'stranger_sons.jpg'),
(4,'Hapusa Himalayan Dry Gin','Hapusa',3600,20,'hapusa.jpg'),
(4,'Bombay Sapphire','Bombay Sapphire',2900,35,'bombay.jpg'),
(4,'Tanqueray London Dry','Tanqueray',3200,30,'tanqueray.jpg'),
(4,'Gordon''s London Dry','Gordon''s',2600,30,'gordons.jpg'),
(4,'Beefeater London Dry','Beefeater',3000,25,'beefeater.jpg'),
(4,'Hendrick''s Gin','Hendrick''s',6200,15,'hendricks.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(5,'Kingfisher Premium','Kingfisher',180,300,'kingfisher.jpg'),
(5,'Kingfisher Ultra','Kingfisher',220,250,'kingfisher_ultra.jpg'),
(5,'Kingfisher Strong','Kingfisher',170,300,'kingfisher_strong.jpg'),
(5,'Budweiser Premium','Budweiser',210,220,'budweiser.jpg'),
(5,'Budweiser Magnum','Budweiser',220,200,'bud_magnum.jpg'),
(5,'Heineken','Heineken',240,180,'heineken.jpg'),
(5,'Corona Extra','Corona',280,150,'corona.jpg'),
(5,'Hoegaarden','Hoegaarden',320,120,'hoegaarden.jpg'),
(5,'Bira 91 Blonde','Bira 91',210,200,'bira_blonde.jpg'),
(5,'Bira 91 White','Bira 91',240,180,'bira_white.jpg'),
(5,'Tuborg Green','Tuborg',160,250,'tuborg_green.jpg'),
(5,'Tuborg Strong','Tuborg',170,280,'tuborg_strong.jpg'),
(5,'Carlsberg Elephant','Carlsberg',210,180,'carlsberg_elephant.jpg'),
(5,'Carlsberg Smooth','Carlsberg',180,220,'carlsberg.jpg'),
(5,'Stella Artois','Stella Artois',320,120,'stella.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(6,'Sula Chenin Blanc','Sula',950,70,'sula_chenin.jpg'),
(6,'Sula Cabernet Shiraz','Sula',1100,60,'sula_cabernet.jpg'),
(6,'Sula Brut','Sula',1800,40,'sula_brut.jpg'),
(6,'Fratelli Classic Merlot','Fratelli',1300,45,'fratelli_merlot.jpg'),
(6,'Fratelli Sette','Fratelli',2200,20,'fratelli_sette.jpg'),
(6,'York Arros','York',1700,25,'york_arros.jpg'),
(6,'Grover La Reserve','Grover',1900,25,'grover.jpg'),
(6,'Jacob''s Creek Shiraz','Jacob''s Creek',1800,30,'jacobs_creek.jpg'),
(6,'Hardys Chardonnay','Hardys',1700,25,'hardys.jpg'),
(6,'Casillero del Diablo Cabernet','Casillero del Diablo',2400,20,'casillero.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(7,'Honey Bee','Honey Bee',800,90,'honey_bee.jpg'),
(7,'Morpheus XO','Morpheus',1200,60,'morpheus.jpg'),
(7,'Mansion House','Mansion House',900,80,'mansion_house.jpg'),
(7,'McDowell''s No.1 Brandy','McDowell''s',850,90,'mcdowells_brandy.jpg'),
(7,'Courrier Napoleon','Courrier Napoleon',1400,40,'courrier.jpg'),
(7,'St-Rémy VSOP','St-Rémy',3400,20,'st_remy.jpg'),
(7,'Hennessy VS','Hennessy',6200,15,'hennessy_vs.jpg');

INSERT INTO Product (category_id, product_name, brand, price, stock, image) VALUES
(8,'Jose Cuervo Especial','Jose Cuervo',3200,35,'jose_cuervo.jpg'),
(8,'Jose Cuervo Silver','Jose Cuervo',3500,30,'jose_cuervo_silver.jpg'),
(8,'Olmeca Blanco','Olmeca',3400,25,'olmeca_blanco.jpg'),
(8,'Olmeca Gold','Olmeca',3600,20,'olmeca_gold.jpg'),
(8,'Patron Silver','Patron',7800,10,'patron_silver.jpg'),
(8,'Patron Reposado','Patron',8600,8,'patron_reposado.jpg'),
(8,'Don Julio Blanco','Don Julio',9200,8,'don_julio.jpg');



-- BASE DE DONNÉES E-COMMERCE

-- Création de la BDD
CREATE DATABASE IF NOT EXISTS ecom;
-- IF NOT EXISTS permet de ne pas créer la BDD si elle existe déjà

-- Spécification de la BDD à utiliser
USE ecom;

-- Création des tables (entités)
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(30),
    lastname VARCHAR(30),
    email VARCHAR(100) NOT NULL,
    password VARCHAR(50) NOT NULL,
    phone VARCHAR(15),
    birthday DATE,
    role VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    image VARCHAR(255),
    description TEXT
);

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    price FLOAT NOT NULL,
    description TEXT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS reviews (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    content TEXT NOT NULL,
    note INT NOT NULL,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS products_tags (
    product_id INT NOT NULL,
    tag_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id)
);

CREATE TABLE IF NOT EXISTS product_images (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    link VARCHAR(255) NOT NULL,
    small VARCHAR(255) NOT NULL,
    medium VARCHAR(255),
    large VARCHAR(255),
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS stocks (
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE IF NOT EXISTS carts (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE IF NOT EXISTS product_carts (
    quantity INT NOT NULL,
    product_id INT NOT NULL,
    cart_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id),
    FOREIGN KEY (cart_id) REFERENCES carts(id)
);

CREATE TABLE IF NOT EXISTS payments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    status BOOLEAN NOT NULL DEFAULT 0,
    amount FLOAT NOT NULL,
    date datetime DEFAULT CURRENT_TIMESTAMP,
    transaction_id VARCHAR(255) NOT NULL,
    type VARCHAR(20) NOT NULL -- CB, Paypal, etc.
);

CREATE TABLE IF NOT EXISTS promos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    date DATETIME NOT NULL,
    discount FLOAT NOT NULL
);

CREATE TABLE IF NOT EXISTS deliveries ( 
    id INT PRIMARY KEY AUTO_INCREMENT,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip VARCHAR(10) NOT NULL,
    country VARCHAR(100) NOT NULL DEFAULT 'France',
    details TEXT,
    default_address BOOLEAN NOT NULL DEFAULT 0,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS orders (
    id INT PRIMARY KEY AUTO_INCREMENT,
    date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,
    cart_id INT NOT NULL,
    user_id INT NOT NULL,
    promo_id INT NOT NULL,
    delivery_id INT NOT NULL,
    payment_id INT NOT NULL,
    FOREIGN KEY (cart_id) REFERENCES carts(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (promo_id) REFERENCES promos(id),
    FOREIGN KEY (delivery_id) REFERENCES deliveries(id),
    FOREIGN KEY (payment_id) REFERENCES payments(id)
);

CREATE TABLE IF NOT EXISTS invoices (
    id INT PRIMARY KEY AUTO_INCREMENT,
    number INT NOT NULL,
    order_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);
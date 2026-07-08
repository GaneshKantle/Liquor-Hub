# LiquorHub

LiquorHub is a J2EE-based e-commerce web application for licensed liquor retailers.

## Tech Stack

- Java
- JSP
- Servlets
- JDBC
- MySQL
- Apache Tomcat

## Features

- User Registration/Login
- Product Catalogue
- Shopping Cart
- Order Management
- Payment Module

## Project Structure

- DTO
- DAO
- Servlets
- JSP
- Utility Classes

## Database Configuration

LiquorHub uses **MySQL** as its database.

### 1. Create the Database

Create a MySQL database named:

```sql
CREATE DATABASE liquorhub;
```

### 2. Import the SQL Script

Import the provided `liquor.sql` file into the `liquorhub` database.

### 3. Configure Database Credentials

A template configuration file named `db.properties.example` is included in the project.

Create a copy of this file and rename it to:

```
db.properties
```

Update it with your local MySQL credentials:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/liquorhub
db.username=your_username
db.password=your_password
```

> **Note:** `db.properties` is ignored by Git to prevent database credentials from being committed.

### 4. MySQL JDBC Driver

Ensure the MySQL Connector/J JAR is added to your project's build path.

### 5. Run the Project

Deploy the project on Apache Tomcat and access it through your browser.
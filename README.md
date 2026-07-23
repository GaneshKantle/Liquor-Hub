# LiquorHub

J2EE e-commerce web app for browsing, carting, and ordering spirits — Java Servlets, JSP, JDBC, and MySQL on Apache Tomcat.

> Intended for educational / demo use. Alcohol sales are regulated; this project does not replace licensing or age-verification requirements in your jurisdiction.

---

## Requirements

| Dependency | Version / notes |
|---|---|
| JDK | 17 |
| Servlet API | Jakarta EE 5 / Servlet 5.0 |
| Application server | Apache Tomcat 10+ (Jakarta) |
| Database | MySQL 8.x |
| IDE (recommended) | Eclipse IDE for Enterprise Java and Web Developers |
| JDBC driver | MySQL Connector/J 8.0.33 (shipped under `src/main/webapp/WEB-INF/lib/`) |

---

## Quick start

1. Clone the repository and open it as an Eclipse Dynamic Web Project (or import existing project).
2. Create and seed MySQL — see [Database configuration](#database-configuration).
3. Place `db.properties` on the classpath (see below).
4. Add Tomcat 10+ as a server runtime; ensure the project targets Java 17 and Servlet 5.0.
5. Deploy and open:

```
http://localhost:8080/LiqourHub/
```

Context path may differ if you rename the project in Eclipse. Welcome file forwards through `/home`.

---

## Features

- **Age gate + liquor quiz** — first-visit client-side gates (`js/gates.js`) before browsing
- **Accounts** — register, login, logout, profile/dashboard, password forget/reset, profile update
- **Catalogue** — categories (Whisky, Vodka, Rum, Gin, Beer, Wine, Brandy, Tequila), search/browse, curated home shelves
- **Wishlist** — save favourites (`/wishlist`, `/favourite`)
- **Cart & checkout** — add/update/remove items, buy-now, payment record per order
- **Orders** — order history and detail views
- **Rare collection** — curated collector bottles (`/rare`)
- **About / contact** — static informational pages
- **404 handling** — custom error page via `web.xml`

---

## Architecture

Layered package layout under `com.LiquorHub`:

```
Browser (JSP + CSS/JS)
        │
   HttpServlet (@WebServlet)
        │
   DAO interface  →  DAOImpl (JDBC)
        │
   MySQL (liquorhub)
```

| Layer | Package | Role |
|---|---|---|
| Presentation | `src/main/webapp/*.jsp`, `css/`, `js/` | Views and client behaviour |
| Controllers | `servlet` | Request handling, session, forwards |
| Contracts | `dao` | Persistence interfaces |
| Persistence | `daoImpl` | JDBC against MySQL |
| Models | `dto` | Transfer objects |
| Shared | `utility` | DB connector, validators, catalogue helpers, rare collection data |

`Connector` loads `db.properties` from the **classpath** at runtime.

---

## Project layout

```
LiqourHub/
├── liquor.sql                      # Schema + seed data
├── liquor_more_products.sql        # Optional extra products
├── lib/                            # Compile-time servlet/jsp APIs
├── src/
│   ├── resources/
│   │   └── db.properties.example   # Credential template (commit this)
│   └── main/
│       ├── java/com/LiquorHub/
│       │   ├── dao/
│       │   ├── daoImpl/
│       │   ├── dto/
│       │   ├── servlet/
│       │   ├── utility/
│       │   └── test/
│       ├── resources/
│       │   └── db.properties       # Local secrets (do not commit)
│       └── webapp/
│           ├── *.jsp
│           ├── assets/
│           ├── css/
│           ├── js/
│           └── WEB-INF/
│               ├── lib/            # mysql-connector-j, servlet-api
│               └── web.xml
└── README.md
```

---

## Key routes

| Path | Servlet | Purpose |
|---|---|---|
| `/`, `/home` | Home | Landing / catalogue shelves |
| `/catalog`, `/shop`, `/all-products` | Catalog | Full product list |
| `/login`, `/register`, `/logout` | Auth | Session |
| `/forgetPassword`, `/resetPassword` | forget / reset | Password recovery |
| `/dashboard`, `/profile` | Dashboard | Account |
| `/update` | update | Profile fields |
| `/cart`, `/add-to-cart` | Cart / AddToCart | Cart |
| `/buy`, `/buy-now` | Buy | Checkout + payment |
| `/order`, `/order-detail` | OrderDetail | Order view |
| `/wishlist`, `/favourite` | Wishlist | Favourites |
| `/rare`, `/collection` | Rare | Rare bottles |
| `/about`, `/team` | About | About |
| `/contact` | Contact | Contact |

---

## Database schema (overview)

| Table | Purpose |
|---|---|
| `Customer` | Accounts |
| `Category` | Product categories |
| `Product` | SKUs, price, stock, image key |
| `Cart` / `CartItem` | Per-customer cart |
| `Orders` / `OrderItem` | Placed orders |
| `Payment` | Payment method + status (1:1 with order) |
| `WishlistItem` | Favourites (unique per customer + product) |

ER reference asset: `src/main/webapp/assets/schema-er.svg`

Optional catalogue expansion: import `liquor_more_products.sql`, or rely on `CatalogSeeder` (runs from the home flow when needed).

---

## Database configuration

LiquorHub uses **MySQL** as its database.

### 1. Create the Database

Create a MySQL database named:

```sql
CREATE DATABASE liquorhub;
```

### 2. Import the SQL Script

Import the provided `liquor.sql` file into the `liquorhub` database.

```bash
mysql -u your_username -p liquorhub < liquor.sql
```

Optionally load extra SKUs:

```bash
mysql -u your_username -p liquorhub < liquor_more_products.sql
```

### 3. Configure Database Credentials

A template configuration file named `db.properties.example` is included in the project at:

```
src/resources/db.properties.example
```

Create a copy of this file and place it on the classpath as:

```
src/main/resources/db.properties
```

Update it with your local MySQL credentials:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/liquorhub
db.username=your_username
db.password=your_password
```

> **Note:** `db.properties` is ignored by Git to prevent database credentials from being committed. After changing it, refresh the project in Eclipse so the classpath picks up the new file.

### 4. MySQL JDBC Driver

Ensure the MySQL Connector/J JAR is on the webapp classpath. This repo already includes:

```
src/main/webapp/WEB-INF/lib/mysql-connector-j-8.0.33.jar
```

### 5. Run the Project

Deploy the project on Apache Tomcat and access it through your browser.

---

## Eclipse + Tomcat checklist

1. **Project facets:** Java 17, Dynamic Web Module 5.0 (Jakarta).
2. **Source folders:** `src/main/java` and `src/main/resources` (so `db.properties` is on the classpath).
3. **Target runtime:** Tomcat 10.1+ (not Tomcat 9 — that uses `javax.*`, this app uses `jakarta.*`).
4. **Deployment assembly:** `src/main/webapp` → `/`; Java build output → `/WEB-INF/classes`.
5. Start the server, open the context root, complete the age gate / quiz on first visit.

---

## Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `NullPointerException` / failed DB connect in `Connector` | Missing or wrong-path `db.properties` | Put file in `src/main/resources/`, refresh project |
| `ClassNotFoundException: com.mysql.cj.jdbc.Driver` | Driver not deployed | Confirm JAR under `WEB-INF/lib` |
| `javax.servlet` vs `jakarta.servlet` errors | Wrong Tomcat major version | Use Tomcat 10+ |
| Empty catalogue | Schema not imported / empty `Product` | Re-run `liquor.sql`; check MySQL `USE liquorhub` |
| 404 on `/home` | Context path or undeployed app | Confirm WAR/context name and that servlets deployed |

---

## Security notes

- Never commit real `db.properties` values.
- Passwords in the current schema/demo flow are educational — do not treat this stack as production-ready auth (no hashing/HTTPS assumptions documented here unless you add them).
- Age verification in the UI is client-side only; production systems need server-side policy and legal compliance.

---

## License

No license file is published in this repository. All rights reserved by the project authors unless otherwise stated.

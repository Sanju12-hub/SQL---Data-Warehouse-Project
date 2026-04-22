# 🏗️ Data Warehouse Project

## 📖 Overview
This project implements a **three‑layer data warehouse** using SQL Server, designed for scalable analytics and business intelligence.  
It integrates data from CRM and ERP systems through **Bronze**, **Silver**, and **Gold** layers — ensuring data quality, consistency, and usability.

---

## 🧱 Architecture

### Data Layers
| Layer | Description |
|-------|--------------|
| **Bronze** | Raw ingestion layer. Bulk‑loaded data from source systems. DDLs created and initial data inserted with minimal transformation. |
| **Silver** | Cleansed and standardized data. Handles data quality, joins, and basic enrichment from CRM and ERP sources. |
| **Gold** | Curated analytical layer. Contains dimension and fact views optimized for BI and reporting. |

---

## 🔄 Data Flow
1. **Bronze Layer**
   - Bulk load raw data from CRM and ERP sources.
   - Create DDLs for staging tables.
   - Insert data as‑is for traceability and audit.
2. **Silver Layer**
   - Apply transformations, data type corrections, and joins.
   - Standardize naming conventions and remove duplicates.
3. **Gold Layer**
   - Build star schema views (`dim_customers`, `dim_products`, `fact_sales`).
   - Provide clean, analytics‑ready data for visualization tools.

---

## 📊 Tables and Views

### `gold.dim_customers`
- **Purpose:** Customer master data with demographic and location details.  
- **Source:** `silver.crm_cust_info`, `silver.erp_cust_az12`, `silver.erp_loc_a101`
- **Grain:** One row per customer  
- **Key Columns:**  
  - `customer_key`, `customer_id`, `customer_number`, `first_name`, `last_name`, `country`, `gender`, `birthdate`, `create_date`

### `gold.dim_products`
- **Purpose:** Product master data with category and cost attributes.  
- **Source:** `silver.crm_prod_info`, `silver.erp_px_cat_g1v2`
- **Grain:** One row per active product (`prd_end_dt IS NULL`)  
- **Key Columns:**  
  - `product_key`, `product_id`, `product_number`, `product_name`, `category`, `sub_category`, `cost`, `product_line`, `start_date`

### `gold.fact_sales`
- **Purpose:** Transactional sales data linking customers and products.  
- **Source:** `silver.crm_sales_details`
- **Grain:** One row per sales order line  
- **Key Columns:**  
  - `order_num`, `product_key`, `customer_key`, `order_date`, `ship_date`, `due_date`, `sales`, `quantity`, `price`

---

## 🔗 Relationships
- `fact_sales.customer_key` → `dim_customers.customer_key`
- `fact_sales.product_key` → `dim_products.product_key`

---

## ⚙️ Setup Instructions
1. Create **Bronze** tables and bulk‑load raw data.
2. Run **Silver** layer scripts for cleansing and transformation.
3. Execute **Gold** layer scripts to create analytical views.
4. Validate joins and surrogate keys using sample queries.

---

## 📈 Usage
- Connect BI tools (Power BI, Tableau, Qlik Sense) to the **Gold** schema.
- Analyze:
  - Customer demographics
  - Product performance
  - Sales trends and profitability

---

## 🧩 Future Enhancements
- Add **dim_date** for time‑based analysis.
- Implement incremental ETL and audit logging.
- Introduce data quality dashboards and metadata tracking.

---

## 👥 Contributors
- **Data Engineer:** Sandhana  
- **Architect:** [Your Name or Team]  
- **Tools Used:** SQL Server, Power BI, Python (ETL), Excel (validation)

---

draw.ai - Integration model, data model, and hilgh level architecture
<img width="1051" height="653" alt="image" src="https://github.com/user-attachments/assets/ce17c639-a675-421a-adc2-fdbf2e34dcfe" />

<img width="1048" height="510" alt="image" src="https://github.com/user-attachments/assets/4af4a318-6bac-4adc-87c6-9e619d7afcde" />

<img width="919" height="853" alt="image" src="https://github.com/user-attachments/assets/c519e33d-ff22-46fd-a6ca-e6c6e669ccfe" />

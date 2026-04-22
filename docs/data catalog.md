# 📘 Data Catalog

## gold.dim_customers
**Type:** Dimension Table  
**Grain:** One row per customer  

### Description
Contains master data about customers, enriched with demographic and location details. Built from CRM and ERP sources.

### Columns
- **customer_key**: Surrogate key (row_number)
- **customer_id**: Natural key from CRM (`cst_id`)
- **customer_number**: Alternate identifier (`cst_key`)
- **first_name**: Customer first name
- **last_name**: Customer last name
- **country**: Country from ERP location table
- **marital_status**: Marital status from CRM
- **gender**: Gender from CRM or ERP (fallback logic applied)
- **birthdate**: Date of birth from ERP
- **create_date**: Customer creation date in CRM

---

## gold.dim_products
**Type:** Dimension Table  
**Grain:** One row per active product  

### Description
Contains product master data, including category and cost information. Historical products are filtered out (`prd_end_dt IS NULL`).

### Columns
- **product_key**: Surrogate key (row_number)
- **product_id**: Natural key from CRM (`prd_id`)
- **product_number**: Alternate identifier (`prd_key`)
- **product_name**: Product name
- **category_id**: Category identifier
- **category**: Product category from ERP
- **sub_category**: Product sub-category
- **maintenance**: Maintenance flag/attribute
- **cost**: Product cost
- **product_line**: Product line classification
- **start_date**: Product start date

---

## gold.fact_sales
**Type:** Fact Table  
**Grain:** One row per sales order line  

### Description
Captures transactional sales data, linking customers and products to sales metrics.

### Columns
- **order_num**: Sales order number
- **product_key**: Foreign key to `dim_products`
- **customer_key**: Foreign key to `dim_customers`
- **order_date**: Date of order
- **ship_date**: Date of shipment
- **due_date**: Due date for order
- **sales**: Sales amount
- **quantity**: Quantity sold
- **price**: Unit price

---

## Notes
- **Surrogate keys** (`customer_key`, `product_key`) are generated using `ROW_NUMBER()` for dimensional modeling.
- **Fact table joins**:  
  - `fact_sales.product_key` → `dim_products.product_key`  
  - `fact_sales.customer_key` → `dim_customers.customer_key`
- **Source systems**: CRM (`silver.crm_*`) and ERP (`silver.erp_*`) provide raw data, transformed into curated `gold` schema views.

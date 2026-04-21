-- normalizing cid col
select
case when cid like 'NAS%' then substring(cid, 4, len(cid))
else cid
end cid,
bdate,gen from silver.erp_cust_az12
-- identify out of range dates
select
bdate,gen from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()

-- data standardization and consistency
select distinct gen,
case when upper(trim(gen)) in ('M', 'Male') then 'Male'
when upper(trim(gen)) in ('F','Female') then 'Female'
else 'n/a'
end 
from silver.erp_cust_az12

-- 
select replace(cid,'-','') as cid, cntry from Bronze.erp_loc_a101
where replace(cid,'-','') not in (select cst_key from Silver.crm_cust_info) or cid is null or cntry is null

select cid, cntry, trim(cntry) from Bronze.erp_loc_a101
where cid is null or cntry is null or cntry != trim(cntry)

select * from Silver.crm_cust_info

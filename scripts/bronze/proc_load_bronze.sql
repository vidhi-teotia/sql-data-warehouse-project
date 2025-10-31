CREATE or alter PROCEDURE bronze.load_bronze as
begin

declare @start_time datetime,  @end_time datetime;
begin try
print 'Loading bronze layer'
print 'Loading CRM Table'
set @start_time=GETDATE(); 
truncate table bronze.crm_cust_info
bulk insert bronze.crm_cust_info 
from 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with(
firstrow=2,
fieldterminator =',',
tablock
);
set @end_time=GETDATE();
print 'Load Duration : ' + cast(datediff(second, @start_time, @end_time) as nvarchar) + 'seconds'
truncate table bronze.crm_prd_info 
bulk insert bronze.crm_prd_info 
from 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with(
firstrow=2,
fieldterminator =',',
tablock
);

truncate table bronze.crm_sales_details
bulk insert bronze.crm_sales_details
from 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with(
firstrow=2,
fieldterminator =',',
tablock
);

print 'Loading Erp Tables'
truncate table bronze.erp_cust_az12
bulk insert bronze.erp_cust_az12
from 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
with(
firstrow=2,
fieldterminator =',',
tablock
);

truncate table bronze.erp_loc_a101
bulk insert bronze.erp_loc_a101
from 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
with(
firstrow=2,
fieldterminator =',',
tablock
);

truncate table bronze.erp_px_cat_g1v2
bulk insert bronze.erp_px_cat_g1v2
from 'C:\Users\HP\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
with(
firstrow=2,
fieldterminator =',',
tablock
);
end try
begin catch
print 'Falied to load bronze layer'
end catch
end

exec bronze.load_bronze






with pott as
(
select
dp.parent_product_id
,dp.product_royalty_earner
,dp.product_key

from dim_product dp

where 1=1
and dp.product_royalty_earner like '%Pottermore%'
and dp.purchase_product_group = 'CONTENT'
and length(dp.product_id) in (14, 16)
and dp.product_status = 'Ready for Export'
)

select
pott.product_royalty_earner
,sum(fls.event_duration) seconds

from audible_dw.fct_listening_stats fls

join pott
on pott.product_key = fls.product_key

join audible_dw.dim_listening_device dld   
on fls.listening_device_key = dld.listening_device_key

join audible_dw.dim_marketplace dm 
on fls.marketplace_key = dm.marketplace_key

join dim_date dd                   
on fls.local_start_date_key = dd.date_key

where 1=1
and fls.local_start_date_key < 20171001 --time
and event_duration < 86400
and event_duration > 60
and fls.listening_event_ct = 1

Group by
pott.product_royalty_earner
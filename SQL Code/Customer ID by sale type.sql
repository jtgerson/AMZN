WITH CustomerInfo AS (


Select  DISTINCT Current_customer_id


FROM (

select

 case when (od.sale_type_desc = 'ALC' and mk.partner_id = 2) then 'ITUNES' else od.sale_type_desc end sale_type_desc , 
  
 Current_customer_id
,sum(oi.units) units
 
from fct_vw_unified_order_item oi
 
inner join dim_order_detail od
on od.order_detail_key = oi.order_detail_key
 
inner join dim_order_status os
on oi.order_status_key = os.order_status_key
 
inner join dim_marketplace mk
on mk.marketplace_key = oi.marketplace_key
 
inner join dim_date dd
on dd.date_key = oi.local_order_placed_date_key
 
inner join dim_merchant dm
on dm.merchant_key = oi.merchant_key
 
inner join dim_product dp
on oi.product_key = dp.product_key
 
inner join dim_customer dc
on dc.customer_key = oi.customer_key
 
where 1=1
and dd.date_value between'30-APR-2017' and '06-MAY-2017'
--and oi.ORDER_ITEM_TYPE = 'PURCHASE'
and od.sale_type_desc not in ('EXCLUDE')
and os.order_status_key = 7
and dc.active_flag = 'Y'
and dc.reg_marketplace_id = 91470
and dc.current_customer_id != -2
and mk.marketplace_id in (91470)
and mk.partner_id = 1
and dp.parent_product_id in ('BK_TANT_000260','BK_RECO_001637','BK_BLAK_001604','BK_RECO_001344','BK_RECO_000144','BK_RECO_001662','BK_BLAK_002556','BK_TANT_000048','BK_RECO_003597','BK_PNIX_000524','BK_BRLL_002153','BK_BRLL_003546','BK_OASI_001101','BK_RECO_006471','BK_ADBL_013464','BK_SCHC_000436','BK_BRLL_006956','BK_BLAK_007612','BK_BLAK_008850','BK_ADBL_026170','BK_LILI_000020','BK_BLAK_003117','BK_LILI_000246','BK_BLAK_000191','BK_LILI_000102','BK_PENG_001794','BK_PNIX_000523','BK_HACH_000953','BK_RECO_003730','BK_BRLL_002301','BK_SANS_005216','BK_BLAK_000191','BK_OASI_001120','BK_PENG_002128','BK_BLAK_005943','BK_TANT_003670','BK_LILI_001767','BK_BLAK_007639','BK_SCHC_000652','BK_LILI_001911','BK_BLAK_008618')
  

GROUP BY  case when (od.sale_type_desc = 'ALC' and mk.partner_id = 2) then 'ITUNES' else od.sale_type_desc end, Current_customer_id
 )

where units>0

)






SELECT CustomerInfo.current_customer_id, 

SUM(CASE WHEN od.sale_type_desc = 'ALC'  THEN units ELSE NULL END) ALC_UNITS,

SUM(CASE WHEN od.sale_type_desc = 'AL'  THEN units ELSE NULL END) AL_UNITS,

SUM(CASE WHEN od.sale_type_desc = 'ALOP'  THEN units ELSE NULL END) ALOP_UNITS,



SUM(CASE WHEN 
dp.parent_product_id in ('BK_TANT_000260','BK_RECO_001637','BK_BLAK_001604','BK_RECO_001344','BK_RECO_000144','BK_RECO_001662','BK_BLAK_002556','BK_TANT_000048','BK_RECO_003597','BK_PNIX_000524','BK_BRLL_002153','BK_BRLL_003546','BK_OASI_001101','BK_RECO_006471','BK_ADBL_013464','BK_SCHC_000436','BK_BRLL_006956','BK_BLAK_007612','BK_BLAK_008850','BK_ADBL_026170','BK_LILI_000020','BK_BLAK_003117','BK_LILI_000246','BK_BLAK_000191','BK_LILI_000102','BK_PENG_001794','BK_PNIX_000523','BK_HACH_000953','BK_RECO_003730','BK_BRLL_002301','BK_SANS_005216','BK_BLAK_000191','BK_OASI_001120','BK_PENG_002128','BK_BLAK_005943','BK_TANT_003670','BK_LILI_001767','BK_BLAK_007639','BK_SCHC_000652','BK_LILI_001911','BK_BLAK_008618')
 and dd.date_value between'30-APR-2017' and '06-MAY-2017' 

 THEN units ELSE NULL END) SaleProd_UNITS








from fct_vw_unified_order_item oi
 
inner join dim_order_detail od
on od.order_detail_key = oi.order_detail_key
 
inner join dim_order_status os
on oi.order_status_key = os.order_status_key
 
inner join dim_marketplace mk
on mk.marketplace_key = oi.marketplace_key
 
inner join dim_date dd
on dd.date_key = oi.local_order_placed_date_key
 
inner join dim_merchant dm
on dm.merchant_key = oi.merchant_key
 
inner join dim_product dp
on oi.product_key = dp.product_key
 
inner join dim_customer dc
on dc.customer_key = oi.customer_key
 
inner JOIN  CustomerInfo ON CustomerInfo.Current_customer_id=dc.current_customer_id

where 1=1
and dd.date_value between'01-APR-2017' and '20-MAY-2017'
--and oi.ORDER_ITEM_TYPE = 'PURCHASE'
and od.sale_type_desc not in ('EXCLUDE')
and os.order_status_key = 7
and dc.active_flag = 'Y'
and dc.reg_marketplace_id = 91470
and dc.current_customer_id != -2
and mk.marketplace_id in (91470)


GROUP BY CustomerInfo.current_customer_id

-- 1. Создаем представление, содержащее обменные курсы, 1 мин. изменения обменных курсов, std 1мин изменений обменных курсов (оцененные по первым 100 точкам) и предыдущие изменения обменных курсов.
-- Представление вспомогательное, на основе него будет рассчитано представление, где рассчитывается adjustment factor

CREATE OR REPLACE VIEW crypto_prices_add AS
(
WITH exchange_rates_data_1 AS
(SELECT timestamp, 
       btc_usd, eth_usd, usdt_usd, eurc_usd, btc_eur, btc_eth, btc_usdt, btc_eurc, eth_eur, 
       eth_btc, eth_usdt, eth_eurc, usdt_eur, usdt_btc, usdt_eth, usdt_eurc, eur_usdt, eur_eth, 
       eur_btc, eur_eurc, usd_usdt, usd_eth, usd_btc, usd_eurc, eurc_btc, eurc_eth, eurc_usdt, eurc_eur, 
       btc_usd_change, eth_usd_change, usdt_usd_change, btc_eur_change, btc_eth_change, btc_usdt_change, btc_eurc_change,
       eth_eur_change, eth_btc_change, eth_usdt_change, eth_eurc_change, usdt_eur_change, usdt_btc_change, usdt_eth_change, 
       usdt_eurc_change, eur_usdt_change, eur_eth_change, eur_btc_change, eur_eurc_change, usd_usdt_change, usd_eth_change, 
       usd_btc_change, usd_eurc_change, eurc_btc_change, eurc_eth_change, eurc_usdt_change, eurc_eur_change, eurc_usd_change
FROM public.crypto_prices
LIMIT 100),

exchange_rates_data_2 AS
(SELECT timestamp, 
       btc_usd, eth_usd, usdt_usd, eurc_usd, btc_eur, btc_eth, btc_usdt, btc_eurc, eth_eur, 
       eth_btc, eth_usdt, eth_eurc, usdt_eur, usdt_btc, usdt_eth, usdt_eurc, eur_usdt, eur_eth, 
       eur_btc, eur_eurc, usd_usdt, usd_eth, usd_btc, usd_eurc, eurc_btc, eurc_eth, eurc_usdt, eurc_eur, 
       btc_usd_change, eth_usd_change, usdt_usd_change, btc_eur_change, btc_eth_change, btc_usdt_change, btc_eurc_change,
       eth_eur_change, eth_btc_change, eth_usdt_change, eth_eurc_change, usdt_eur_change, usdt_btc_change, usdt_eth_change, 
       usdt_eurc_change, eur_usdt_change, eur_eth_change, eur_btc_change, eur_eurc_change, usd_usdt_change, usd_eth_change, 
       usd_btc_change, usd_eurc_change, eurc_btc_change, eurc_eth_change, eurc_usdt_change, eurc_eur_change, eurc_usd_change,
       stddev(btc_usd_change) OVER () AS  btc_usd_change_std,
       stddev(eth_usd_change) OVER () AS  eth_usd_change_std,
       stddev(usdt_usd_change) OVER () AS  usdt_usd_change_std,
       stddev(btc_eur_change) OVER () AS  btc_eur_change_std,
       stddev(btc_eth_change) OVER () AS  btc_eth_change_std,
       stddev(btc_usdt_change) OVER () AS  btc_usdt_change_std,
       stddev(btc_eurc_change) OVER () AS  btc_eurc_change_std,
       stddev(eth_eur_change) OVER () AS  eth_eur_change_std,
       stddev(eth_btc_change) OVER () AS  eth_btc_change_std,
       stddev(eth_usdt_change) OVER () AS  eth_usdt_change_std,
       stddev(eth_eurc_change) OVER () AS  eth_eurc_change_std,
       stddev(usdt_eur_change) OVER () AS  usdt_eur_change_std,
       stddev(usdt_btc_change) OVER () AS  usdt_btc_change_std,
       stddev(usdt_eth_change) OVER () AS  usdt_eth_change_std,
       stddev(usdt_eurc_change) OVER () AS  usdt_eurc_change_std,
       stddev(eur_usdt_change) OVER () AS  eur_usdt_change_std,
       stddev(eur_eth_change) OVER () AS  eur_eth_change_std,
       stddev(eur_btc_change) OVER () AS  eur_btc_change_std,
       stddev(eur_eurc_change) OVER () AS  eur_eurc_change_std,
       stddev(usd_usdt_change) OVER () AS  usd_usdt_change_std,
       stddev(usd_eth_change) OVER () AS  usd_eth_change_std,
       stddev(usd_btc_change) OVER () AS  usd_btc_change_std,
       stddev(usd_eurc_change) OVER () AS  usd_eurc_change_std,
       stddev(eurc_btc_change) OVER () AS  eurc_btc_change_std,
       stddev(eurc_eth_change) OVER () AS  eurc_eth_change_std,
       stddev(eurc_usdt_change) OVER () AS  eurc_usdt_change_std,
       stddev(eurc_eur_change) OVER () AS  eurc_eur_change_std,
       stddev(eurc_usd_change) OVER () AS  eurc_usd_change_std
FROM exchange_rates_data_1
LIMIT 100),

exchange_rates_data_3 AS 

(
(SELECT * FROM exchange_rates_data_2)

UNION ALL

(SELECT timestamp, 
       btc_usd, eth_usd, usdt_usd, eurc_usd, btc_eur, btc_eth, btc_usdt, btc_eurc, eth_eur, 
       eth_btc, eth_usdt, eth_eurc, usdt_eur, usdt_btc, usdt_eth, usdt_eurc, eur_usdt, eur_eth, 
       eur_btc, eur_eurc, usd_usdt, usd_eth, usd_btc, usd_eurc, eurc_btc, eurc_eth, eurc_usdt, eurc_eur, 
       btc_usd_change, eth_usd_change, usdt_usd_change, btc_eur_change, btc_eth_change, btc_usdt_change, btc_eurc_change, 
       eth_eur_change, eth_btc_change, eth_usdt_change, eth_eurc_change, usdt_eur_change, usdt_btc_change, usdt_eth_change, 
       usdt_eurc_change, eur_usdt_change, eur_eth_change, eur_btc_change, eur_eurc_change, usd_usdt_change, usd_eth_change, 
       usd_btc_change, usd_eurc_change, eurc_btc_change, eurc_eth_change, eurc_usdt_change, eurc_eur_change, eurc_usd_change,
       NULL AS  btc_usd_change_std,
       NULL AS  eth_usd_change_std,
       NULL AS  usdt_usd_change_std,
       NULL AS  btc_eur_change_std,
       NULL AS  btc_eth_change_std,
       NULL AS  btc_usdt_change_std,
       NULL AS  btc_eurc_change_std,
       NULL AS  eth_eur_change_std,
       NULL AS  eth_btc_change_std,
       NULL AS  eth_usdt_change_std,
       NULL AS  eth_eurc_change_std,
       NULL AS  usdt_eur_change_std,
       NULL AS  usdt_btc_change_std,
       NULL AS  usdt_eth_change_std,
       NULL AS  usdt_eurc_change_std,
       NULL AS  eur_usdt_change_std,
       NULL AS  eur_eth_change_std,
       NULL AS  eur_btc_change_std,
       NULL AS  eur_eurc_change_std,
       NULL AS  usd_usdt_change_std,
       NULL AS  usd_eth_change_std,
       NULL AS  usd_btc_change_std,
       NULL AS  usd_eurc_change_std,
       NULL AS  eurc_btc_change_std,
       NULL AS  eurc_eth_change_std,
       NULL AS  eurc_usdt_change_std,
       NULL AS  eurc_eur_change_std,
       NULL AS  eurc_usd_change_std
FROM public.crypto_prices
OFFSET 100)
)

SELECT *,
       lag(btc_usd_change) OVER (ORDER BY timestamp) AS  prev_btc_usd_change,
       lag(eth_usd_change) OVER (ORDER BY timestamp) AS  prev_eth_usd_change,
       lag(usdt_usd_change) OVER (ORDER BY timestamp) AS  prev_usdt_usd_change,
       lag(btc_eur_change) OVER (ORDER BY timestamp) AS  prev_btc_eur_change,
       lag(btc_eth_change) OVER (ORDER BY timestamp) AS  prev_btc_eth_change,
       lag(btc_usdt_change) OVER (ORDER BY timestamp) AS  prev_btc_usdt_change,
       lag(btc_eurc_change) OVER (ORDER BY timestamp) AS  prev_btc_eurc_change,
       lag(eth_eur_change) OVER (ORDER BY timestamp) AS  prev_eth_eur_change,
       lag(eth_btc_change) OVER (ORDER BY timestamp) AS  prev_eth_btc_change,
       lag(eth_usdt_change) OVER (ORDER BY timestamp) AS  prev_eth_usdt_change,
       lag(eth_eurc_change) OVER (ORDER BY timestamp) AS  prev_eth_eurc_change,
       lag(usdt_eur_change) OVER (ORDER BY timestamp) AS  prev_usdt_eur_change,
       lag(usdt_btc_change) OVER (ORDER BY timestamp) AS  prev_usdt_btc_change,
       lag(usdt_eth_change) OVER (ORDER BY timestamp) AS  prev_usdt_eth_change,
       lag(usdt_eurc_change) OVER (ORDER BY timestamp) AS  prev_usdt_eurc_change,
       lag(eur_usdt_change) OVER (ORDER BY timestamp) AS  prev_eur_usdt_change,
       lag(eur_eth_change) OVER (ORDER BY timestamp) AS  prev_eur_eth_change,
       lag(eur_btc_change) OVER (ORDER BY timestamp) AS  prev_eur_btc_change,
       lag(eur_eurc_change) OVER (ORDER BY timestamp) AS  prev_eur_eurc_change,
       lag(usd_usdt_change) OVER (ORDER BY timestamp) AS  prev_usd_usdt_change,
       lag(usd_eth_change) OVER (ORDER BY timestamp) AS  prev_usd_eth_change,
       lag(usd_btc_change) OVER (ORDER BY timestamp) AS  prev_usd_btc_change,
       lag(usd_eurc_change) OVER (ORDER BY timestamp) AS  prev_usd_eurc_change,
       lag(eurc_btc_change) OVER (ORDER BY timestamp) AS  prev_eurc_btc_change,
       lag(eurc_eth_change) OVER (ORDER BY timestamp) AS  prev_eurc_eth_change,
       lag(eurc_usdt_change) OVER (ORDER BY timestamp) AS  prev_eurc_usdt_change,
       lag(eurc_eur_change) OVER (ORDER BY timestamp) AS  prev_eurc_eur_change,
       lag(eurc_usd_change) OVER (ORDER BY timestamp) AS  prev_eurc_usd_change
FROM exchange_rates_data_3
OFFSET 99
--limit 110
)

-- Показать представление
--select * from crypto_prices_add_new
--limit 10

-- Удалить представление
--drop view crypto_prices_add_new

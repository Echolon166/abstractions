{{ config(tags=['dunesql'],
        alias = alias('trades')
        )
}}

{% set uniswap_polygon_models = [
'uniswap_v3_polygon_trades'
] %}


SELECT *
FROM (
    {% for dex_model in uniswap_polygon_models %}
    SELECT
        blockchain,
        project,
        version,
        block_date,
        block_time,
        token_bought_symbol,
        token_sold_symbol,
        token_pair,
        token_bought_amount,
        token_sold_amount,
        token_bought_amount_raw,
        token_sold_amount_raw,
        amount_usd,
        token_bought_address,
        token_sold_address,
        taker,
        maker,
        project_contract_address,
        tx_hash,
        tx_from,
        tx_to,
        
        evt_index
    FROM {{ ref(dex_model) }}
    {% if not loop.last %}
    UNION ALL
    {% endif %}
    {% endfor %}
)
import base64
import json
import os
from pathlib import Path

import polars as pl
from google.cloud import bigquery
from google.oauth2 import service_account

creds_json = base64.b64decode(
    os.environ["ENCODED_GOOGLE_APPLICATION_CREDENTIALS"]
).decode()

info = json.loads(creds_json)
creds = service_account.Credentials.from_service_account_info(info)
client = bigquery.Client(credentials=creds, project=info["project_id"])

sql = """
select
    datetime_trunc(timestamp_seconds(((height * 30) + 1598306400)), day) as date,
    avg(cast(total_raw_bytes_power as numeric) / (1024 * 1024 * 1024 * 1024 * 1024)) as rbp,
    avg(participating_miner_count) as participating_miner_count
from `lily-data.lily.chain_powers`
group by 1
order by 1 desc
limit 1000
"""

data = client.query(sql).to_arrow(create_bqstorage_client=True)

df = pl.DataFrame(data)

df.write_csv(f"data/{Path(__file__).stem}.csv")

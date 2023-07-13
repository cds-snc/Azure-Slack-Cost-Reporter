"""Reports on the azure spend to slack"""

import csv
import os
from decimal import Decimal
from slack_sdk.webhook import WebhookClient
from datetime import date

with open("report.csv", "r", encoding="utf-8") as csv_file:
    csv_reader = csv.DictReader(csv_file)
    daily_price = [Decimal(row["CostInBillingCurrency"]) for row in csv_reader]
    cost_to_date = sum(daily_price)

URL = os.getenv("SLACK_WEBHOOK_URL")

wh = WebhookClient(URL)
total = round(cost_to_date,2)

today = date.today()
resp = wh.send(
    blocks=[
        {
            "type": "header",
            "text": {
                "type": "plain_text",
                "text": f"Current Azure spend for {today.strftime('%m-%Y')}",
                "emoji": True
            }
        },{
            "type": "section",
            "fields": [{
                "type": "mrkdwn",
                "text": "*Sentinel*",
            },
            {
                "type": "plain_text",
                "text": f"${total} CAD",
            }]
        },{
            "type": "divider",
        },
        {
            "type": "section",
            "fields": [{
                "type": "mrkdwn",
                "text": "*Total*",
            },
            {
                "type": "plain_text",
                "text": f"${total} CAD",
            }]
        }
    ]
)

print(f"Response: {resp.status_code}")
print(f"Response: {resp.body}")

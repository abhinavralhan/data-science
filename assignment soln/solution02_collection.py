# https://finance.yahoo.com/quote/URTH/
# https://www.yahoofinanceapi.com/
# https://stackoverflow.com/questions/44030983/yahoo-finance-url-not-working

headers = {
    'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}

# My RQ:
# Did Covid-19 influence the global economy?

import requests
import pandas as pd
import matplotlib.pyplot as plt

symbol = "URTH"

url = "https://query1.finance.yahoo.com/v8/finance/chart/" + symbol + "?symbol=" + symbol + "&period1=0&period2=9999999999&interval=1d&includePrePost=true&events=div%7Csplit"

request = requests.get(url, headers=headers)

output = request.json()

timestamp = output["chart"]["result"][0]["timestamp"]
close = output['chart']['result'][0]["indicators"]["quote"][0]["close"]

df = pd.DataFrame({"timestamp": timestamp, "close": close})

df.to_csv("data.csv", index=False)

df.plot(x="timestamp", y="close")
plt.show()

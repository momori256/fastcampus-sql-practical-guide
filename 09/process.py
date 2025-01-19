import pandas as pd

input_file = "Online_Retail.csv"  # CSVファイルのパス
output_file = "Online_Retail_Processed.csv"  # 出力ファイルのパス

# エンコーディングを指定してCSVを読み込む
df = pd.read_csv(input_file, lineterminator='\r', encoding="ISO-8859-1")

# InvoiceDateの整形
def convert_date(date_str):
    dt = pd.to_datetime(date_str, format="%m/%d/%y %H:%M")
    return dt.strftime("%Y-%m-%d %H:%M:%S")

df["FormattedDate"] = df["InvoiceDate"].apply(convert_date)

# 既存の InvoiceDate カラムを削除し、FormattedDate を InvoiceDate にリネーム
df = df.drop(columns=["InvoiceDate"])
df.rename(columns={"FormattedDate": "InvoiceDate"}, inplace=True)

# 新しいCSVファイルに保存
df.to_csv(output_file, index=False)

print(f"Processed file saved as {output_file}")

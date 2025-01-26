import pandas as pd

def filter_rating(input_path, output_path):
    """
    rating.csv から rating = -1 の行を除外して新しい CSV ファイルを作成する。
    
    Parameters:
    - input_path (str): 元の CSV ファイルのパス。
    - output_path (str): フィルタリング後の CSV ファイルの保存先。
    """
    # CSV を読み込む
    df = pd.read_csv(input_path)

    # rating = -1 の行を除外
    filtered_df = df[df['rating'] != -1]

    # フィルタリング後のデータを新しい CSV ファイルとして保存
    filtered_df.to_csv(output_path, index=False)

    print(f"Filtered data saved to: {output_path}")

# スクリプトのエントリポイント
if __name__ == "__main__":
    input_file = "rating.csv"  # 元の CSV ファイル
    output_file = "filtered_rating.csv"  # 保存先のファイル名

    filter_rating(input_file, output_file)


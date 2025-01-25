import pandas as pd
import re

def normalize_genre_column(input_path, output_anime_path, output_genre_path):
    """
    anime.csv からジャンル列を分割し、
    - animeテーブル用: (元のカラム - genre列)  -> anime_normalized.csv
    - anime_genreテーブル用: (anime_id, genre) -> anime_genres.csv
    """

    # 1) CSV読み込み
    df = pd.read_csv(input_path)

    # 2) NaNを除外して genre が空の行を削除
    df_genre = df[['anime_id', 'genre']].copy()
    df_genre = df_genre.dropna(subset=['genre'])  # NaN を除外

    # 3) カンマ区切りを split → list化
    def clean_and_split(genres):
        return [
            re.sub(r'\s+', '', g)  # 全ての空白を削除
            for g in genres.split(',') if re.sub(r'\s+', '', g) != ''
        ]
    df_genre['genre_list'] = df_genre['genre'].apply(clean_and_split)

    # 4) explodeで1行に1ジャンルを展開
    df_genre = df_genre.explode('genre_list')

    # 5) カラムを整理
    df_genre = df_genre.rename(columns={'genre_list': 'genre_exploded'})
    df_genre = df_genre.drop(columns=['genre'])
    df_genre = df_genre.rename(columns={'genre_exploded': 'genre'})

    # 6) 空ジャンルを最終的に除外
    df_genre = df_genre[df_genre['genre'].str.strip() != '']

    # 7) anime テーブル用の DataFrame (genre 列だけ除去し、その他は残す)
    df_anime = df.drop(columns=['genre'])

    # 8) CSV に出力
    df_anime.to_csv(output_anime_path, index=False)
    df_genre.to_csv(output_genre_path, index=False)

    print("Done:")
    print(f"  - {output_anime_path}")
    print(f"  - {output_genre_path}")

if __name__ == "__main__":
    input_file = "anime.csv"
    output_anime_file = "anime_normalized.csv"
    output_genre_file = "anime_genres.csv"

    normalize_genre_column(input_file, output_anime_file, output_genre_file)

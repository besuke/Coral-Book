# Coral Book『金融工学の応用基礎』

金融工学の手法を実際の財務・市場データに適用し、価格評価やリスク計測を手元のRで再現する本である。第I部では財務・市場データの実証分析、ポートフォリオ最適化、市場・信用リスクの計測、トランシェ評価を、第II部では無裁定価格理論を基礎に、債券、金利カーブ、OIS、デリバティブの評価を扱う。本書のねらいと読み方は「[はじめに](index.qmd)」にまとめた。

## 関連するプロジェクト

- **[Carmine Studio『エンタープライズ金融モデル』](https://github.com/besuke/carmine-studio)**：Reactで条件を操作し、Rサーバー上のRiemannFinMathでモデルを評価するWebアプリ。計算エンジンと操作画面を分けた構成、並列計算、分散計算、自動微分を扱う。
- **[Crimson Proof『Leanから見た金融数学』](https://github.com/besuke/crimson-proof)**：金融モデルの仮定をLeanで定義し、どの仮定のもとで何が成り立つかを証明する本。

## 描画

```
quarto render          # HTML（_book/）
```

HTML と PDF をまとめて作るには `build_html_pdf.bat`（コミットと push はしない。ログは `build_logs/`）を使う。R の共通関数は `R/utility_LFL.R` にあり、プロジェクトのルートは `_quarto.yml` のあるフォルダとして探す。

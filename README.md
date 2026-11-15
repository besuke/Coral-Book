# Coral Book『金融工学の応用基礎』

金融モデルを「手元で計算する」「サーバーで動かす」「仮定から何が導けるかを証明する」の三つの入口から学ぶ三部作のうち、**理論を読み、手元の R で計算を再現する** Quarto の本です（旧名 LagrangeFinance）。第I部 均衡モデル（実証ファイナンス）、第II部 無裁定モデル、第III部 エンタープライゼーション（並列・分散・自動微分）からなります。

## 三部作

| | Coral Book『金融工学の応用基礎』 | Carmine Studio『エンタープライズ金融モデル』 | Crimson Proof『Leanから見た金融数学』 |
|---|---|---|---|
| 学び方 | **手元で計算する**：理論を読み、手元の R で計算を再現する Quarto の本 | **サーバーで動かす**：React で条件を操作し、R サーバー上の RiemannFinMath でモデルを評価する Web アプリ | **証明する**：金融モデルの仮定を Lean で定義し、どの仮定のもとで何が成り立つかを証明する本 |
| リポジトリ | <https://github.com/besuke/coral-book> | <https://github.com/besuke/carmine-studio> | <https://github.com/besuke/crimson-proof> |
| 始め方 | `quarto render`（または RStudio で各章を実行） | R API（`npm run api`、127.0.0.1:8787）と画面（`npm run dev`）を起動し、<http://127.0.0.1:8081/> を開く | `lean/` で `lake build`、本は `quarto render` |

## 同じテーマを三つの入口で

| テーマ | Coral Book（手元で計算する） | Carmine Studio（サーバーで動かす） | Crimson Proof（証明する） |
|---|---|---|---|
| 割引と無裁定 | 第II部 第1章 確定キャッシュフロー、第3章 OISスワップとマルチカーブ評価で、割引係数と複製を手で計算する | 「イールドカーブと円OIS」（`#/yield-curve-ois`）で OIS の気配を動かしてスワップの時価を確かめる。「OISアセットスワップ」（`#/asw`） | 第10章 有限市場における無裁定と価格の一意性、第11章 ニューメレール、第12章 資産価格の基本定理で、無裁定に必要な市場の仮定を定義して定理を証明する |
| 金利カーブ | 第II部 第2章 金利カーブ | 「金利カーブ」（`#/yield-curves`）、「国債先物・CTD」（`#/jgb-futures`） | 第11章 ニューメレール（割引による価格の正規化） |
| オプション | 第II部 第4章 ブラックモデル | 「ブラックモデル」（`#/black-model`） | — |
| 信用リスク | 第II部 第5章 信用リスクとCDS | 「信用リスクとCDS」（`#/credit-cds`） | — |
| 金利モデルと早期償還 | 第II部 第6〜8章 | `#/irs-calibration`、`#/rate-models`、`#/early-redemption` | — |
| PRDC | 第II部 第9章（第III部 第7章の本文は Carmine Studio へ移した） | 「PRDC」（`#/prdc`）、「PRDC のリスク計算」（`#/prdc-risk`） | PRDC のクーポンの分解（`lean/LagrangeAcademy/PrdcCoupon.lean`） |
| 並列・分散・自動微分 | 第III部の本文は Carmine Studio へ移した（原稿は `part3_enterprise_riemann/` に残す） | 「並列計算」（`#/parallel`）、「PRDC のリスク計算」（`#/prdc-risk`） | — |
| 計算の保証 | 各章の計算例 | 照合の記録（`reconciliation/`） | 第1章 計算と証明、第7章 実数と数値計算 |

Carmine Studio の画面は、Carmine Studio を起動したうえで <http://127.0.0.1:8081/> に続けて表のパスを開きます。

## 描画

```
quarto render          # HTML（_book/）
```

PDF と全体のビルドは `build_all_outputs.ps1`（`build_all_outputs.bat`）です。R の共通関数は `R/utility_LFL.R` にあり、プロジェクトのルートは `_quarto.yml` のあるフォルダとして探します。

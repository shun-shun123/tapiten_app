# tapiten_app

2020/09/12開催のOPEN HACK U 2020 Online vol.3で発表したスマホアプリ「神様と迷える仔羊たち」のプロジェクト
Flutterで開発

## プロジェクト規約
### ブランチの切り方
- master: リリースと同じバージョン
- version: リリースバージョンごとに作成するブランチ（リリース時にmasterにマージする）マージされたタイミングでビルドのCI/CD回す
- feature: 追加機能などの実装ごとに作成するブランチ（最終的には現行のversionブランチにマージする)versionへのPR時にtestのCIを回す
- fix: バグ修正などで作成するブランチ（最終的には現行のversionブランチにマージする）

### プルリクエストの運用
**Require two or more approvals**
「二人以上からLTGMもらえらマージOK」

以下のプルリクエスト作成時はCIを実行
- feature->version
- fix->version

### タスクの分け方
機能実装は一人で担当するが、今後その機能で修正等が必要になった場合は誰でもその修正に対してアサイン可能とする。
つまり「誰でもいじってね」って感じです。

### アーキテクチャ
MVVMを採用
**StatelessWidget + Provider + ChangeNotifierで開発する。**
- View: データを一切持たない。Provider経由でViewModelを取得して描画を行う。
- ViewModel: Viewのイベントを受け取って、適切なModelのビジネスロジックを呼び出し、ViewModelが保持している値を更新し、Viewに変更を通知する（notifyListeners()のこと）
- Model: データ構造とそれに対するビジネスロジックまでを定義。

### プロジェクトのディレクトリ構成
- Model
- Component(共通UIパーツ)
- Style(共通スタイル)
- Config(不変な値でハードコーディングしたくないものをまとめる)
- View
    - ui(画面名)
        - View
            - hoge_page_view.dart
        - ViewModel
            - hoge_page_view_model.dart


## 本番環境と開発環境の切り分け
### Firebase環境の分け方（暫定）
Firebaseのアプリを「本番用」と「開発用」に分けて開発を行う  
開発中は「開発用」のアプリに繋いで開発を行う。  
リリース時に「本番用」の設定に差し替えてビルドを行う。  


## その他のロジックメモ
### 神モード／仔羊モードの状態管理について
現在のモードを持っておくフラグをSharedPreference（端末領域に値を保存しておく機構）に持たせておいて、アプリ起動時にそれを読み出し、表示Widgetを判定する  
↓  
メッセージ画面など、共通UIの画面であっても別々のView, ViewModelを書く

### 詳細部分
<details>
<summary>DB 設計</summary>

```
{
  // ホーム画面（ランキング）-> "god_ranking", "sheep_ranking"でソートして取る
  "ranking": {
    "god_ranking": [{"id", "user_name", "image_url"}],
    "sheep_ranking": [{"id", "user_name", "image_url"}]
  },

  // マッチング画面
  "matching_state": {[
    id: {
      "is_login": true/false, // godもsheepもt/f取れる
      "is_waiting": true/false, // sheepのみtrueが取れる
      "is_searching": true/false, // godのみtrueが取れる
      "opponent_id": "相手のID"(String)
    }]
  },

  // 履歴画面
  // 神様モードの時はanswersを
  // 仔羊モードの時はquestionsを
  // 取得する
  "messages": {
    "answers": [
      id: {[
        "questioner_id": "質問者のログインID"(String),
        "question_content": "質問文"(String),
        "answer1": "選択肢1"(String),
        "answer2": "選択肢2"(String),
        "review_score": 3(int),
        "selected_anser_index": 0(int),
      ]
    }],
    "questions": [
      id: {[
        "answerer_id": "回答者のユーザーID"(String),
        "question_content": "質問文"(String),
        "answer1": "回答できる選択肢1"(String),
        "answer2": "回答できる選択肢2"(String),
        "god_message": "神様からの名言"(String),
        "selected_answer_index": 0(int),
      ]}
    ]
  }

  // プロフィール画面用コレクション -> 自己idで取ってくる
  "user_info": {
    "id": "ユーザID(UID)"(String),
    "login_id": "ユーザーID(英数字8文字以内)"(String),
    "name": "ユーザ名"(String),
    "password": "パスワード"(String),
    "god_score": 100(Int),
    "sheep_score": 100(Int),
    "isGod": true(Bool),
    "god_info": {
      "first_reward": "前半称号"(String),
      "last_reward": "後半称号"(String),
      "description": "自己紹介"(String),
    },
    "sheep_info": {
      "first_reward": "前半称号"(String),
      "last_reward": "後半称号"(String),
      "description": "自己紹介"(String)
    }
  }
}
```
</details>


<details>
<summary>投稿作成から回答までの流れ</summary>

```
1. 仔羊が投稿を作成

2. 仔羊が messages コレクションの questions->id に質問内容を書き込み

3. 仔羊側からマッチング処理
   3-0. isLogin = true && isSearching = true の神様がいる  
   3-1. 仔羊は自身の isWaiting を true にする  
   3-2. 神様は isLogin = true && isWaiting = true の仔羊を選ぶ
   3-3. 書き込み処理  
    3-3-1. 神様が仔羊の opponent_id に自身の id を書き込む  
    3-3-2. 仔羊は opponent_id の変更を検知。書き込まれた opponent_id の神様を探し、神様の opponent_id に自身の id を書き込む  
   3-4. 自身の opponent_id != "" && 相手の opponent_id != ""(or 自分の id)なら成功

4. 神様は matching コレクションの id->opponent_id から仔羊の id を取得して、messages コレクションから質問内容を取得する([questions->opponent_id].last)

5. 神様は取得した質問内容を View に表示して回答を作成する

6. 神様は回答内容を messages->questions->opponent_id と、messages->answers->id にそれぞれ書き込む

7. マッチングの破棄処理  
   7-1. 互いに opponent_id= ""にする
   7-2. 仔羊は isWaiting = false にする
   7-3. 神様は isSearching = false にする
```
</details>

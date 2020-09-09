# tapiten_app

2020/08/31 開催の HackU2020 で開発したスマホアプリのプロジェクト

## 開発概要
### 使用技術
- Flutter
- MVVM パターン with Provider, ChangeNotifier

### UIでの分割
**1.初回起動**→かるぼ

- 1-1. スタート画面
- 1-2. アカウント登録
- 1-3. 初回モード選択

**2.メッセージ**→マミー

- 2-1. メッセージ一覧
- 2-2. メッセージ詳細

**3.プロフィール**→レオ

- 3-1. 表示
- 3-2. 編集

**4.メイン（質問投稿／回答）**→ろば、マミー

#### 共通構造
**TabBar**→ ろばーと  
**Routing（画面遷移）**→ろばーと

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


## 開発進行ルール
### プロジェクト管理
- issueをPRで解消
- Github Projects
- マイルストーンで期限設定
- ラベルで進捗状態の共有（Slackでも）

#### ラベル
- Doing
- Help me

### 命名規則
#### issue
画面名とその画面に対するMVVMのどの部分の実装なのかを示す

【画面名】-【Model / View / ViewModel】- [日本語での説明]

#### branch
[関連するissue番号]-[画面名]-[実装内容の簡単な英語説明]

### 実装の流れ
1. 取り組むissueを決めて、Assigneesに自分を追加する
2. ブランチ命名に従って**masterから**ブランチを切る
3. 実装できたらPRを作る  
3-1. resolve #[issue番号]でissueを紐づける  
3-2. PRのReviewersに自分以外の3人を追加する  
3-2. Assigneesに自分を追加する
4. （Slackで連絡）
5. LGTM出たらマージ。リモートブランチはdeleteする。

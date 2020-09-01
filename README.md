# tapiten_app

2020/08/31 開催の HackU2020 で開発したスマホアプリのプロジェクト

# 使用技術

- Flutter
- MVVM パターン with Provider, ChangeNotifier

# 画面設計

### 1.トップ（共通）

→ カルボ

### 2.チュートリアル（共通）

省略

### 3.ログイン／サインイン画面（共通）

→ マミー

### 4.モード選択（共通）

→ レオ

### 5.ホーム（ランキング）（共通）

### 6.メッセージ（履歴）（共通）

### 7.プロフィール（神／仔羊）

→

### 8.通知（共通）

省略

### 9.投稿（仔羊）

### 10.受付（神）

### X.TabBar

→ ろばーと

# DB 設計

```json
{
  // ホーム画面（ランキング）-> "god_ranking", "sheep_ranking"でソートして取る
  "ranking": {
    "god_ranking": [{"id", "user_name", "image_url"}],
    "sheep_ranking": [{"id", "user_name", "image_url"}]
  },

  // マッチング画面
  "matching_state": {[
    id: {
      "isLogin": true/false, // godもsheepもt/f取れる
      "isWaiting": true/false, // sheepのみtrueが取れる
      "isSearching": true/false, // godのみtrueが取れる
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
        "answer_content": "回答された選択肢"(String)
      ]
    }],
    "questions": [
      id: {[
        "answerer_id": "回答者のログインID"(String),
        "question_content": "質問文"(String),
        "answer_content": "回答できる選択肢"(String)
      ]}
    ]
  }

  // プロフィール画面用コレクション -> 自己idで取ってくる
  "user_info": {
    "id": "ユーザ固有ID"(String),
    "login_id": "ログインID(英数字8文字以内)"(String),
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

# 投稿作成から回答までの流れ

1. 仔羊が投稿を作成

2. 仔羊側からマッチング処理
   2-0. isLogin = true && isSearching = true の神様がいる  
   2-1. 仔羊は自身の isWaiting を true にする  
   2-2. 神様は isLogin = true && isWaiting = true の仔羊を選ぶ **（ユーザーの View 操作有り）**  
   2-3. 書き込み処理  
    2-3-1. 神様が仔羊の opponent_id に自身の id を書き込む  
    2-3-2. 仔羊は opponent_id の変更を検知。書き込まれた opponent_id の神様を探し、神様の opponent_id に自身の id を書き込む  
   2-4. 自身の opponent_id != "" && 相手の opponent_id != ""(or 自分の id)なら成功

3. 仔羊が messages コレクションの questions->id に質問内容を書き込み

4. 神様は matching コレクションの id->opponent_id から仔羊の id を取得して、messages コレクションから質問内容を取得する([questions->opponent_id].last)

5. 神様は取得した質問内容を View に表示して回答を作成する

6. 神様は回答内容を messages->questions->opponent_id と、messages->answers->id にそれぞれ書き込む

7. マッチングの破棄処理  
   7-1. 互いに opponent_id= ""にする
   7-2. 仔羊は isWaiting = false にする
   7-3. 神様は isSearching = false にする

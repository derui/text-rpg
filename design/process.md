# Processについて #
Processとは、メッセージのやり取りを通じた処理を行うための簡単なフレームワークを指す。

## Processの仕組みについて ##
仕組みとしては、非常にシンプルなものとなる。Processは以下のいずれかの状態をとっている。

− End
 - そのProcessの終了状態となる
− Continue

## Processの状態遷移について ##
ProcessはEnd/Continueという状態でやり取りを行う。Processが送るメッセージには、常に **送信元** が付与されている。
Continueはこのメッセージと、送信先のActorを指定して、新しい送信先のハンドラを実行する。

実際の遷移図としては以下のようになる

```
Continue ---> End
          |
           -> Continue -> End (Continueは起動されたProcess中で一度しか行えない)
```


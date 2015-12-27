# ステータスについて #

ステータスと一言で言う場合、その中には複数の内容が含まれている。あるオブジェクト、キャラクタの状態をひとまとめに表した場合、

* オブジェクト、キャラクタ自体の生命（life）
* オブジェクト、キャラクタ自体の状態（status）
* オブジェクト、キャラクタが持つアビリティの影響（effect）
* オブジェクト、キャラクタが受けている追加効果（buff）

などが含まれる。これらを見た時に、ある種別、例えばStrengthなどのように、Statusを構成するある要素に対するEffect、と言ったような形で、 **ある項目に対する影響** という形で記述することができる。

基準となっているStatusも、全てが0の状態をデフォルトとした時に、状態の種別それぞれに対応する値の集合、という形で表すことが出来る。

# ステータスの最小単位 #
Statusを構成するそれぞれの要素を、 **element** と呼ぶ。 elementは、それぞれ **kind** という、そのelementの種別（strength、agilityなど）と、その種別に対する量（quantity）を保持している。
これら全ての種別を一つずつ持つのがStatusであり、一部だけ持ち加算・減算されるのがEffect、乃至buffである。

## Elementの構成要素 ##
elementには、 **kind** と、その種別に対する有効な量である **quantity** のみが構成要素となる。そのため、element自体には何か特殊なことがあるわけではなく、単純に値を示すものとして扱われる。

## kindの種類 ##
elementの種類であるkindは、大きく分けて以下のような種別を持つ。

* 各属性に対する攻撃力
* 各属性に対する防御力
* 強さの基準となる力
* 体力の基準となる生命力
* 素早さ
* 器用さ
* 運
* ・・・

全てのelementはこれらのkindをただひとつだけ保有している。

# lifeについて #
lifeはステータスとは異なる、そのキャラクタそのものの体力を表している。これをHealth pointとして、どれだけ健康状態が阻害されているかを示す。

このHealth Point、つまりHPもelementの一つであり、アビリティやbuffによって状態が変動するようになっている。ただし、HPは他のelementとは違い、 **最大値** と **現在値** という区別が存在する。buffなどは、全てこの最大についてのみ影響し、現在値には影響しない。

lifeとstatusを分ける最も大きなポイントは、保有するkindが異なることと、lifeは最高によい状態と、現在の状態との両方を持つ、Statefulなデータ構造であるということである。

## lifeのstatefulな状態の更新について ##
lifeのstatefulな状態も、基本的にはelementで表現されるものである。そのため、値の増減は、あくまで新しい値を持ったelementを現在値として再設定する、という処理となる。

# effectについて #
effect/buffは効果としてはよく似ているが、異なるのはその継続性と値の算出元である。

effectは **永続的** かつ、その各kindに対する値は、 **アビリティの情報** に起因する。effectは、elementとは違い、以下の要素から構成される。

* effectが対応するelement
* effectの影響力（weight）

effectの値が全て単純に加算されるわけではなく、ある条件下では影響力自体が増減する可能性もある、ということである。基本的には単純加算となる。

## effectとabilityの関係 ##
一つのeffectは、必ず一つのkindとのみ関連するが、一つのアビリティは複数のkindに影響する可能性がある。つまり、 effect:ability ＝ 1:n の関係となっている。

この関係を簡単に表したものとして、 abilityとkindの対応関係を表したデータが存在する（以後 relationship）。relationshipはある場所で定義され、あるabilityはその対応関係に従って、effectを構成する。

# buff/debuffについて #
effectとよく似ているが、違いは **一時的** かつ **効果が固定** されていることが最大の特徴となる。buff/debuffは基本的に一つ一つが定義されており、以下のような要素で構成される。

- 対象のkind
- buff/debuffの影響力
- buff/debuffが継続する期間

buff/debuffのeffectとの一番大きな違いは継続期間の有無であり、影響力などは事前に定義されたものがそのまま利用される。

## buff/debuffとabilityの関係 ##
前述の通り、buff/debuffは固定された効果を表すため、abilityなどには影響されない。
class CollectivePoint {
  CollectionNormalForm? mindIsland;
  CollectionNormalForm? orpheusStar;
  CollectionNormalForm? heartGiant;
  CollectionNormalForm? greatWorksArt;
  CollectionNormalForm? voyageItem;
  CollectionNormalForm? ignaeaToken;
  CollectionNormalForm? leafWorld;
  CollectionNormalForm? memoryBox;
  CollectionMococoForm? seedMococo;


  CollectivePoint({
    this.mindIsland,
    this.orpheusStar,
    this.heartGiant,
    this.greatWorksArt,
    this.seedMococo,
    this.voyageItem,
    this.ignaeaToken,
    this.leafWorld,
    this.memoryBox,
  });

  factory CollectivePoint.fromJson(Map<String, dynamic> json) {
    return CollectivePoint(
      mindIsland: json['mind_island'] != null ? CollectionNormalForm.fromJson(json['mind_island']) : null,
      orpheusStar: json['orpheus_star'] != null ? CollectionNormalForm.fromJson(json['orpheus_star']) : null,
      heartGiant: json['heart_giant'] != null ? CollectionNormalForm.fromJson(json['heart_giant']) : null,
      greatWorksArt: json['great_works_art'] != null ? CollectionNormalForm.fromJson(json['great_works_art']) : null,
      voyageItem: json['voyage_item'] != null ? CollectionNormalForm.fromJson(json['voyage_item']) : null,
      ignaeaToken: json['ignaea_token'] != null ? CollectionNormalForm.fromJson(json['ignaea_token']) : null,
      leafWorld: json['leaf_world'] != null ? CollectionNormalForm.fromJson(json['leaf_world']) : null,
      memoryBox: json['memory_box'] != null ? CollectionNormalForm.fromJson(json['memory_box']) : null,
      seedMococo: json['seed_mococo'] != null ? CollectionMococoForm.fromJson(json['seed_mococo']) : null,
    );
  }
}

class CollectionNormalForm {
  int? count;
  int? max;
  List<CollectionCheck>? list;

  CollectionNormalForm({this.count, this.max, this.list});

  factory CollectionNormalForm.fromJson(Map<String, dynamic> json) {
    List<CollectionCheck> list = [];
    if (json['list'] != null) {
      json['list'].forEach((v) {
        list.add(CollectionCheck.fromJson(v));
      });
    }
    return CollectionNormalForm(
      count: json['count'] != null ? int.parse(json['count']) : null,
      max: json['max'] != null ? int.parse(json['max']) : null,
      list: list,
    );
  }
}

class CollectionMococoForm {
  int? count;
  int? max;
  List<Mococo>? list;

  CollectionMococoForm({this.count, this.max, this.list});

  factory CollectionMococoForm.fromJson(Map<String, dynamic> json) {
    List<Mococo> list = [];
    if (json['list'] != null) {
      json['list'].forEach((v) {
        list.add(Mococo.fromJson(v));
      });
    }
    return CollectionMococoForm(
      count: json['count'] != null ? int.parse(json['count'].replaceAll(',','')) : null,
      max: json['count'] != null ? int.parse(json['max'].replaceAll(',','')): null,
      list: list,
    );
  }
}

// 모코코를 제외한 수집품 획득/미획득 Model
class CollectionCheck {
  String? name;
  String? check;

  CollectionCheck({this.name, this.check});

  factory CollectionCheck.fromJson(Map<String, dynamic> json) {
    return CollectionCheck(
      name: json['name'] != null ? json['name'] : null,
      check: json['check'] != null ? json['check'] : null,
    );
  }
}

// List<모코코> 에 사용되는 <모코코> Model
class Mococo {
  String? name;
  int? count;
  int? max;

  Mococo({this.name, this.count, this.max});

  factory Mococo.fromJson(Map<String, dynamic> json) {
    return Mococo(
      name: json['name'] != null ? json['name'] : null,
      count: json['count'] != null ? int.parse(json['count']) : null,
      max: json['max'] != null ? int.parse(json['max']) : null,
    );
  }
}

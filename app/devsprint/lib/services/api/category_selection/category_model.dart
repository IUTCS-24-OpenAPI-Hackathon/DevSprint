class CatagoryModel {
  List<ListItems>? listItems;
  String? attribution;
  String? version;

  CatagoryModel({this.listItems, this.attribution, this.version});

  CatagoryModel.fromJson(Map<String, dynamic> json) {
    if (json['listItems'] != null) {
      listItems = <ListItems>[];
      json['listItems'].forEach((v) {
        listItems!.add(new ListItems.fromJson(v));
      });
    }
    attribution = json['attribution'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listItems != null) {
      data['listItems'] = this.listItems!.map((v) => v.toJson()).toList();
    }
    data['attribution'] = this.attribution;
    data['version'] = this.version;
    return data;
  }
}

class ListItems {
  String? canonicalId;
  String? icon;
  String? name;
  String? version;
  String? uuid;

  ListItems({this.canonicalId, this.icon, this.name, this.version, this.uuid});

  ListItems.fromJson(Map<String, dynamic> json) {
    canonicalId = json['canonical_id'];
    icon = json['icon'];
    name = json['name'];
    version = json['version'];
    uuid = json['uuid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['canonical_id'] = this.canonicalId;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['version'] = this.version;
    data['uuid'] = this.uuid;
    return data;
  }
}
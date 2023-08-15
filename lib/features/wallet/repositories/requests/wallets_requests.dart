class RequestCreateWallet {
  int? type;
  int? currency;
  String? name;
  String? note;
  int? initialBalance;
  List<ExtraProperties>? extraProperties;

  RequestCreateWallet(
      {this.type,
      this.currency,
      this.name,
      this.note,
      this.initialBalance,
      this.extraProperties});

  RequestCreateWallet.fromJson(Map<String, dynamic> json) {
    type = json['Type'];
    currency = json['Currency'];
    name = json['Name'];
    note = json['Note'];
    initialBalance = json['InitialBalance'];
    if (json['ExtraProperties'] != null) {
      extraProperties = <ExtraProperties>[];
      json['ExtraProperties'].forEach((v) {
        extraProperties!.add(ExtraProperties.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Type'] = type;
    data['Currency'] = currency;
    data['Name'] = name;
    data['Note'] = note;
    data['InitialBalance'] = initialBalance;
    if (extraProperties != null) {
      data['ExtraProperties'] =
          extraProperties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExtraProperties {
  String? context;
  String? key;
  String? value;

  ExtraProperties({this.context, this.key, this.value});

  ExtraProperties.fromJson(Map<String, dynamic> json) {
    context = json['Context'];
    key = json['Key'];
    value = json['Value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Context'] = context;
    data['Key'] = key;
    data['Value'] = value;
    return data;
  }
}

class RequestUpdateWallet {
  String? id;
  RequestCreateWallet? requestUpdateWallet;

  RequestUpdateWallet({this.id, this.requestUpdateWallet});

  RequestUpdateWallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    requestUpdateWallet = json['data'] != null
        ? RequestCreateWallet.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (requestUpdateWallet != null) {
      data['data'] = requestUpdateWallet!.toJson();
    }
    return data;
  }
}

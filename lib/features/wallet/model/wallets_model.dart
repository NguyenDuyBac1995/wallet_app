class ResponseWallet {
  int? totalBalance;
  List<ResponseWalletById>? result;

  ResponseWallet({this.totalBalance, this.result});

  ResponseWallet.fromJson(Map<String, dynamic> json) {
    totalBalance = json['TotalBalance'];
    if (json['Result'] != null) {
      result = <ResponseWalletById>[];
      json['Result'].forEach((v) {
        result!.add(ResponseWalletById.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalBalance'] = totalBalance;
    if (result != null) {
      data['Result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResponseWalletById {
  String? id;
  int? type;
  int? currency;
  String? name;
  int? balance;
  String? note;
  String? profileId;
  List<dynamic>? extraProperties;

  ResponseWalletById(
      {this.id,
      this.type,
      this.currency,
      this.name,
      this.balance,
      this.note,
      this.profileId,
      this.extraProperties});

  ResponseWalletById.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    type = json['Type'];
    currency = json['Currency'];
    name = json['Name'];
    balance = json['Balance'];
    note = json['Note'];
    profileId = json['ProfileId'];
    if (json['ExtraProperties'] != null) {
      extraProperties = <dynamic>[];
      json['ExtraProperties'].forEach((v) {
        extraProperties!.add((v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Type'] = type;
    data['Currency'] = currency;
    data['Name'] = name;
    data['Balance'] = balance;
    data['Note'] = note;
    data['ProfileId'] = profileId;
    if (extraProperties != null) {
      data['ExtraProperties'] =
          extraProperties!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


    //  extraProperties:
    // List<dynamic>.from(json["ExtraProperties"].map((x) => x));
    //  data['ExtraProperties'] =
    //     List<dynamic>.from(extraProperties!.map((x) => x));
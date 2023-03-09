class ExchangeRatesModal {
  String? id;
  String? date;
  String? baseRate;
  String? syncedTime;
  dynamic? rates;

  ExchangeRatesModal({
    this.baseRate,
    this.id,
    this.date,
    this.syncedTime,
    this.rates,
  });

  ExchangeRatesModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    baseRate = json['Base'];
    date = json['Date'];
    syncedTime = json['SyncedTime'];
    rates = json['Rates'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Date'] = date;
    data['Base'] = baseRate;
    data['SyncedTime'] = syncedTime;
    data['Rates'] = rates;

    return data;
  }
}

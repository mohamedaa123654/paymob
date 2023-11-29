class MakeOrderModel {
  int? id;
  String? createdAt;
  bool? deliveryNeeded;
  Merchant? merchant;
  Null? collector;
  int? amountCents;
  Null? shippingData;
  String? currency;
  bool? isPaymentLocked;
  bool? isReturn;
  bool? isCancel;
  bool? isReturned;
  bool? isCanceled;
  Null? merchantOrderId;
  Null? walletNotification;
  int? paidAmountCents;
  bool? notifyUserWithEmail;
  List<Items>? items;

  MakeOrderModel(
      {this.id,
        this.createdAt,
        this.deliveryNeeded,
        this.merchant,
        this.collector,
        this.amountCents,
        this.shippingData,
        this.currency,
        this.isPaymentLocked,
        this.isReturn,
        this.isCancel,
        this.isReturned,
        this.isCanceled,
        this.merchantOrderId,
        this.walletNotification,
        this.paidAmountCents,
        this.notifyUserWithEmail,
        this.items});

  MakeOrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    deliveryNeeded = json['delivery_needed'];
    merchant = json['merchant'] != null
        ? Merchant.fromJson(json['merchant'])
        : null;
    collector = json['collector'];
    amountCents = json['amount_cents'];
    shippingData = json['shipping_data'];
    currency = json['currency'];
    isPaymentLocked = json['is_payment_locked'];
    isReturn = json['is_return'];
    isCancel = json['is_cancel'];
    isReturned = json['is_returned'];
    isCanceled = json['is_canceled'];
    merchantOrderId = json['merchant_order_id'];
    walletNotification = json['wallet_notification'];
    paidAmountCents = json['paid_amount_cents'];
    notifyUserWithEmail = json['notify_user_with_email'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['delivery_needed'] = deliveryNeeded;
    if (merchant != null) {
      data['merchant'] = merchant!.toJson();
    }
    data['collector'] = collector;
    data['amount_cents'] = amountCents;
    data['shipping_data'] = shippingData;
    data['currency'] = currency;
    data['is_payment_locked'] = isPaymentLocked;
    data['is_return'] = isReturn;
    data['is_cancel'] = isCancel;
    data['is_returned'] = isReturned;
    data['is_canceled'] = isCanceled;
    data['merchant_order_id'] = merchantOrderId;
    data['wallet_notification'] = walletNotification;
    data['paid_amount_cents'] = paidAmountCents;
    data['notify_user_with_email'] = notifyUserWithEmail;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Merchant {
  int? id;
  String? createdAt;
  List<String>? phones;
  List<String>? companyEmails;
  String? companyName;
  String? state;
  String? country;
  String? city;
  String? postalCode;
  String? street;

  Merchant(
      {this.id,
        this.createdAt,
        this.phones,
        this.companyEmails,
        this.companyName,
        this.state,
        this.country,
        this.city,
        this.postalCode,
        this.street});

  Merchant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    phones = json['phones'].cast<String>();
    companyEmails = json['company_emails'].cast<String>();
    companyName = json['company_name'];
    state = json['state'];
    country = json['country'];
    city = json['city'];
    postalCode = json['postal_code'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['phones'] = phones;
    data['company_emails'] = companyEmails;
    data['company_name'] = companyName;
    data['state'] = state;
    data['country'] = country;
    data['city'] = city;
    data['postal_code'] = postalCode;
    data['street'] = street;
    return data;
  }
}

class Items {
  String? name;
  String? description;
  int? amountCents;
  int? quantity;

  Items({this.name, this.description, this.amountCents, this.quantity});

  Items.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    amountCents = json['amount_cents'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['amount_cents'] = amountCents;
    data['quantity'] = quantity;
    return data;
  }
}
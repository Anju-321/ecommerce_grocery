class ProductResponse {
    int errorCode;
    List<Product> data;
    String message;

    ProductResponse({
        required this.errorCode,
        required this.data,
        required this.message,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        errorCode: json["error_code"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Product {
    int id;
    String name;
    String image;
    int price;
    DateTime createdDate;
    String createdTime;
    DateTime modifiedDate;
    String modifiedTime;
    bool flag;

    Product({
        required this.id,
        required this.name,
        required this.image,
        required this.price,
        required this.createdDate,
        required this.createdTime,
        required this.modifiedDate,
        required this.modifiedTime,
        required this.flag,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        createdDate: DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "price": price,
        "created_date": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date": "${modifiedDate.year.toString().padLeft(4, '0')}-${modifiedDate.month.toString().padLeft(2, '0')}-${modifiedDate.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
    };
}
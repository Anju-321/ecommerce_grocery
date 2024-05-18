class CustomerResponse {
    int errorCode;
    List<Customer> data;
    String message;

    CustomerResponse({
        required this.errorCode,
        required this.data,
        required this.message,
    });

    factory CustomerResponse.fromJson(Map<String, dynamic> json) => CustomerResponse(
        errorCode: json["error_code"],
        data: List<Customer>.from(json["data"].map((x) => Customer.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "error_code": errorCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
    };
}

class Customer {
    int id;
    String name;
    String? profilePic;
    String mobileNumber;
    String email;
    String street;
    String streetTwo;
    String city;
    int pincode;
    String? country;
    String state;
    DateTime createdDate;
    String createdTime;
    DateTime modifiedDate;
    String modifiedTime;
    bool flag;

   Customer({
        required this.id,
        required this.name,
        required this.profilePic,
        required this.mobileNumber,
        required this.email,
        required this.street,
        required this.streetTwo,
        required this.city,
        required this.pincode,
        required this.country,
        required this.state,
        required this.createdDate,
        required this.createdTime,
        required this.modifiedDate,
        required this.modifiedTime,
        required this.flag,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        name: json["name"],
        profilePic: json["profile_pic"],
        mobileNumber: json["mobile_number"],
        email: json["email"],
        street: json["street"],
        streetTwo: json["street_two"],
        city: json["city"],
        pincode: json["pincode"],
        country: json["country"],
        state: json["state"],
        createdDate: DateTime.parse(json["created_date"]),
        createdTime: json["created_time"],
        modifiedDate: DateTime.parse(json["modified_date"]),
        modifiedTime: json["modified_time"],
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile_pic": profilePic,
        "mobile_number": mobileNumber,
        "email": email,
        "street": street,
        "street_two": streetTwo,
        "city": city,
        "pincode": pincode,
        "country": country,
        "state": state,
        "created_date": "${createdDate.year.toString().padLeft(4, '0')}-${createdDate.month.toString().padLeft(2, '0')}-${createdDate.day.toString().padLeft(2, '0')}",
        "created_time": createdTime,
        "modified_date": "${modifiedDate.year.toString().padLeft(4, '0')}-${modifiedDate.month.toString().padLeft(2, '0')}-${modifiedDate.day.toString().padLeft(2, '0')}",
        "modified_time": modifiedTime,
        "flag": flag,
    };
}

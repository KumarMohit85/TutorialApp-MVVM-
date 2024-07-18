//to convert the response  to a non-nullable object
import 'package:_tut_app/app/extensions.dart';
import 'package:_tut_app/data/responses/responses.dart';
import 'package:_tut_app/domain/model/model.dart';

const EMPTY = "";
const ZERO = 0;

extension customerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(this?.id.orEmpty() ?? EMPTY, this?.name.orEmpty() ?? EMPTY,
        this?.numOfNotifications.orZero() ?? ZERO);
  }
}

extension contactResponseMapper on ContactResponse? {
  Contact toDomain() {
    return Contact(this?.email.orEmpty() ?? EMPTY,
        this?.phone.orEmpty() ?? EMPTY, this?.link.orEmpty() ?? EMPTY);
  }
}

extension authenticationResponseManager on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(this?.customer.toDomain(), this?.contact.toDomain());
  }
}

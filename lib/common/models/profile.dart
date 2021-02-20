import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Profile extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String personalImage;

  const Profile({
    @required this.firstName,
    @required this.middleName,
    @required this.lastName,
    @required this.personalImage,
  });

  String get fullName =>
      '$firstName ${middleName?.isNotEmpty == true ? middleName + ' ' : ''}$lastName';

  @override
  List<Object> get props => [firstName, middleName, lastName, personalImage];

  @override
  String toString() =>
      'Profile { firstName: $firstName, middleName: $middleName, lastName: $lastName, personalImage: $personalImage }';

  factory Profile.fromMap(Map<String, dynamic> map) => Profile(
        firstName: map['firstName'],
        middleName: map['middleName'],
        lastName: map['lastName'],
        personalImage: map['personalImage'],
      );

  Profile copyWith({
    String name,
    bool selected,
  }) {
    return Profile(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      personalImage: personalImage ?? this.personalImage,
    );
  }
}

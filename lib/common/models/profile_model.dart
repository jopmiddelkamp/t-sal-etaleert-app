import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Equatable {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String? personalImage;

  const ProfileModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.personalImage,
  });

  String get fullName =>
      '$firstName ${middleName?.isNotEmpty == true ? middleName! + ' ' : ''}$lastName';

  @override
  List<Object?> get props => [firstName, middleName, lastName, personalImage];

  @override
  String toString() =>
      'Profile { firstName: $firstName, middleName: $middleName, lastName: $lastName, personalImage: $personalImage }';

  factory ProfileModel.fromMap(Map<String, dynamic> map) => ProfileModel(
        firstName: map['firstName'],
        middleName: map['middleName'],
        lastName: map['lastName'],
        personalImage: map['personalImage'],
      );

  ProfileModel copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? personalImage,
  }) {
    return ProfileModel(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      personalImage: personalImage ?? this.personalImage,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}

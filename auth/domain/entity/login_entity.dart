import 'package:equatable/equatable.dart';
import 'package:smp/features/profile/domain/entity/user_entity.dart';

class LoginEntity extends Equatable{
  final String message,token;
  final UserEntity user;

  const LoginEntity({required this.message, required this.token, required this.user});

  @override
  List<Object?> get props => [message,user,token];
}

// "id": 8,
// "name": "hassan",
// "username": "hassan",
// "email": "hassan@gmail.com",
// "email_verified_at": "2024-06-11T11:04:48.000000Z",
// "profile_picture": null,
// "date_of_birth": null,
// "gender": null,
// "city": null,
// "state": null,
// "country": null,
// "bio": null,
// "phone_number": null,
// "website_url": null,
// "social_media_links": null,
// "visibility_settings": null,
// "privacy_settings": null,
// "hobbies": null,
// "favorite_books": null,
// "favorite_movies": null,
// "favorite_music": null,
// "languages_spoken": null,
// "favorite_quotes": null,
// "education_history": null,
// "employment_history": null,
// "relationship_status": "single",
// "activity_engagement": null,
// "notification_preferences": null,
// "location": null,
// "security_settings": null,
// "achievements": null,
// "badges": 0,
// "created_at": "2024-06-11T11:03:52.000000Z",
// "updated_at": "2024-06-11T11:17:15.000000Z",
// "active": true
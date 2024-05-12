import 'package:retrofit/dio.dart';

abstract class UseCase<Type,Params>{
  Future<HttpResponse<Type>> call({Params params});
}
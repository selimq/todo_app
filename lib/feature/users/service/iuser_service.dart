import '../model/reqres_model.dart';
import 'package:vexana/vexana.dart';

abstract class IUserService {
  final INetworkManager networkManager;
  IUserService({required this.networkManager});

  List<User> fetchUserData({int page = 0});
}

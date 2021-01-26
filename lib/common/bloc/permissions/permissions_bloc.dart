import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tsal_etaleert/common/utils/enum-utils.dart';

import '../../services/shared-preferences-service.dart';
import '../../utils/dialog-utils.dart';
import 'barrel.dart';
import 'permissions_event.dart';
import 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final SharedPreferencesService _sharedPreferencesService;

  PermissionsBloc(this._sharedPreferencesService)
      : assert(_sharedPreferencesService != null),
        super(PermissionsInitializing()) {
    add(PermissionsInitialize());
  }

  @override
  Stream<PermissionsState> mapEventToState(
    PermissionsEvent event,
  ) async* {
    if (event is PermissionsInitialize) {
      yield* _init();
    } else if (event is PermissionsAskUser) {
      yield* _askUser();
    } else if (event is PermissionsCheck) {
      yield* _check();
    } else {
      print('PermissionsBloc: unsupported event!');
    }
  }

  Stream<PermissionsState> _init() async* {
    var status = await Permission.locationWhenInUse.status;
    await _sharedPreferencesService.setLastLocationPermissionStatus(EnumUtils.getStringValue(status));
    yield status.isUndetermined ? PermissionsUndetermined() : PermissionsRejected();
  }

  Stream<PermissionsState> _askUser() async* {
    if (await _getLastLocationPermissionStatus().isUndetermined) {
      // You can can also directly ask the permission about its status.
      if (await Permission.locationWhenInUse.isRestricted) {
        // The OS restricts access, for example because of parental controls.
        await DialogUtils.showErrorDialog(
          title: 'Uw toegang wordt beperkt',
          message:
              'Het lijkt erop dat op uw toestel de toegang to de locatie wordt beperkt. Dit kan komen doordat er bijvoorbeeld ouderlijk toezicht is ingeschakeld. De app kan in deze staat niet worden gebruikt.',
        );
      }

      final result = await Permission.locationWhenInUse.request();
      await _sharedPreferencesService.setLastLocationPermissionStatus(EnumUtils.getStringValue(result));
      yield result.isGranted ? PermissionsGranted() : PermissionsRejected();
    } else {
      _check();
    }
  }

  Stream<PermissionsState> _check() async* {
    final lastLocationStatus = await _getLastLocationPermissionStatus();
    final locationStatus = await Permission.locationWhenInUse.status;
    await _sharedPreferencesService.setLastLocationPermissionStatus(EnumUtils.getStringValue(locationStatus));
    if (!lastLocationStatus.isUndetermined) {
      if (locationStatus.isGranted) {
        yield PermissionsGranted();
      } else {
        if (lastLocationStatus.isDenied) {
          await DialogUtils.showErrorDialog(
            title: 'Rechten geweigerd',
            message:
                'We hebben geconstateerd dat u ons verzoek voor de rechten tot het uitlezen van uw locatie gegeven heeft geweigerd. Om deze app te kunnen gebruiken zult u deze actie ongedaan moeten maken.',
          );
        } else {
          await DialogUtils.showErrorDialog(
            title: 'Rechten ontnomen',
            message:
                'We hebben geconstateerd dat u ons de rechten tot het uitlezen van uw locatie gegeven heeft ontnomen. Om deze app te kunnen gebruiken zult u deze actie ongedaan moeten maken.',
          );
        }
        if (Platform.isIOS) {
          await AppSettings.openLocationSettings();
        } else {
          _askUser();
        }
      }
    }
  }

  Future<PermissionStatus> _getLastLocationPermissionStatus() async {
    final status = EnumUtils.enumFromString(
      PermissionStatus.values,
      await _sharedPreferencesService.getLastLocationPermissionStatus(),
    );
    return status != null ? status : PermissionStatus.undetermined;
  }
}

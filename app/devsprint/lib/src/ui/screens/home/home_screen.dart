import 'package:devsprint/src/services/location/location_repo.dart';
import 'package:devsprint/src/services/location/models/locatin_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '/services/l10n/locale_extention.dart';
import '/services/router.dart';
import '/src/global/global.dart';
import '/src/ui/widgets/icons.dart';
import 'home_screen_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(countProvider);
    final colors = ref.watch(countColorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appName),
        actions: [
          IconButton(
            icon: const IIcon(
              FontAwesomeIcons.gear,
              fontAwesome: true,
            ),
            onPressed: () {
              context.pushNamed(AppRoutes.settings.name);
            },
          ),
        ],
      ),
        body: Center(
        child: ElevatedButton(
          onPressed: () async{
            LocationState _locationState = await  LocationRepository().getLocation();

            debugPrint(_locationState.toString());

          },
          child: Text("Get Location"),)
        
         ),
    );
  }
}

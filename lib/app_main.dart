library app_movie;

// IMPORTS
// UI library
import 'package:flutter/material.dart';

// Root Bundle Services
import 'package:flutter/services.dart' show rootBundle;

// Foundation
import 'package:flutter/foundation.dart';

// Url Intent library
import 'package:url_launcher/url_launcher.dart';

// Network library
import 'package:http/http.dart' as http;

// Async task and Converts
import 'dart:async';
import 'dart:convert';

// Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// - Persistence
import 'package:shared_preferences/shared_preferences.dart';

// PARTS
// - Screens
part 'package:flutter_app/ui/login.dart';
part 'package:flutter_app/ui/home.dart';
part 'package:flutter_app/ui/detail.dart';

// - List/Grid cell
part 'package:flutter_app/adapters/cells/item_cell.dart';
part 'package:flutter_app/adapters/cells/video_cell.dart';

// - Model
part 'package:flutter_app/models/movie.dart';
part 'package:flutter_app/models/video.dart';

// - Adapters
part 'package:flutter_app/adapters/list_adapter.dart';
part 'package:flutter_app/adapters/grid_adapter.dart';

// - Navigators
part 'package:flutter_app/navigators/grid_navigator.dart';
part 'package:flutter_app/navigators/login_navigator.dart';

// - Networking
part 'package:flutter_app/networking/network.dart';

// - Utils
part 'package:flutter_app/utils/utils.dart';
part 'package:flutter_app/utils/keys.dart';
part 'package:flutter_app/utils/material_button.dart';
part 'package:flutter_app/utils/progress_dialog.dart';

class AppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Trends',
      home: LoginPage(),
      theme: ThemeData(
        hintColor: Colors.white,
        primaryColor: Colors.black,
      ),
    );
  }
}

import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/supabase/supabase_provider.dart';

class LogoStorageService {
  final SupabaseClient _client;
  const LogoStorageService(this._client);

  Future<String> uploadLogo({
    required Uint8List bytes,
    required String providerId,
    required String fileName,
    required String contentType,
  }) async {
    final extension = path.extension(fileName).toLowerCase();
    final safeExtension = extension.isEmpty ? '.jpg' : extension;
    final objectPath = 'providers/$providerId/${DateTime.now().millisecondsSinceEpoch}$safeExtension';

    await _client.storage.from('provider-logos').uploadBinary(
      objectPath,
      bytes,
      fileOptions: FileOptions(contentType: contentType, upsert: true),
    );

    return _client.storage.from('provider-logos').getPublicUrl(objectPath);
  }
}

final logoStorageServiceProvider = Provider<LogoStorageService>((ref) {
  return LogoStorageService(ref.watch(supabaseClientProvider));
});

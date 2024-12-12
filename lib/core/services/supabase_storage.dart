import 'dart:io';
import 'package:fruit_hub_dashboard/core/services/storage_service.dart';
import 'package:fruit_hub_dashboard/core/utils/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path/path.dart' as b;

class SupabaseStorageService implements StorageService {
  static late Supabase _supaBase;

  static createBuckets(String bucketName) async {
    var buckets = await _supaBase.client.storage.listBuckets();
    bool isBucketExists = false;
    for (var bucket in buckets) {
      if (bucket.id == bucketName) {
        isBucketExists = true;
        break;
      }
    }
    if (!isBucketExists) {
      await _supaBase.client.storage.createBucket(bucketName);
    }
  }

  static initSupaBase() async {
    _supaBase = await Supabase.initialize(
      url: ConstantApp.kSupaBaseUrl,
      anonKey: ConstantApp.kSubaBaseAnonKey,
    );
  }

  @override
  Future<String> uploadFile(File file, String path) async {
    String fileName = b.basename(file.path);
    String extensionName = b.extension(file.path);
    var result = await _supaBase.client.storage
        .from('fruits_images')
        .upload('$path/$fileName.$extensionName', file);
    final String publicUrl = _supaBase.client.storage
        .from('fruits_images')
        .getPublicUrl('$path/$fileName.$extensionName');

    return result;
  }
}

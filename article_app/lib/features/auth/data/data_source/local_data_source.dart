abstract class AuthLocalDataSource {
  /// Caches a [token] in the local data source
  ///
  /// Throws a [CacheException] for cache errors
  Future<void> cacheToken(String token);

  Future<void> removeToken();

  /// Gets the cached token from the local data source
  ///
  /// Throws a [CacheException] for cache errors
  Future<String> getToken();

  /// Caches a [AuthenticatedUserInfoModel] in the local data source
  ///
  /// Throws a [CacheException] for cache errors

  /// Deletes the cached user  and it's data from the local data source
  ///
  /// Throws a [CacheException] for cache errors
  Future<void> deleteLoggedInUser();
}

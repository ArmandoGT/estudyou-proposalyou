// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeDashboardNotifier)
final homeDashboardProvider = HomeDashboardNotifierProvider._();

final class HomeDashboardNotifierProvider
    extends $AsyncNotifierProvider<HomeDashboardNotifier, HomeDashboardState> {
  HomeDashboardNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeDashboardProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeDashboardNotifierHash();

  @$internal
  @override
  HomeDashboardNotifier create() => HomeDashboardNotifier();
}

String _$homeDashboardNotifierHash() =>
    r'4b214feb692d376a55425d2f0434a1ac78c30679';

abstract class _$HomeDashboardNotifier
    extends $AsyncNotifier<HomeDashboardState> {
  FutureOr<HomeDashboardState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<HomeDashboardState>, HomeDashboardState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<HomeDashboardState>, HomeDashboardState>,
              AsyncValue<HomeDashboardState>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProviderListNotifier)
final providerListProvider = ProviderListNotifierProvider._();

final class ProviderListNotifierProvider
    extends $AsyncNotifierProvider<ProviderListNotifier, List<ProviderDto>> {
  ProviderListNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'providerListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$providerListNotifierHash();

  @$internal
  @override
  ProviderListNotifier create() => ProviderListNotifier();
}

String _$providerListNotifierHash() =>
    r'98fbab3be3cb5befc0b1007e4c9152df8d4a9b44';

abstract class _$ProviderListNotifier
    extends $AsyncNotifier<List<ProviderDto>> {
  FutureOr<List<ProviderDto>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProviderDto>>, List<ProviderDto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<ProviderDto>>, List<ProviderDto>>,
              AsyncValue<List<ProviderDto>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(ProviderEditNotifier)
final providerEditProvider = ProviderEditNotifierFamily._();

final class ProviderEditNotifierProvider
    extends $AsyncNotifierProvider<ProviderEditNotifier, ProviderDto> {
  ProviderEditNotifierProvider._({
    required ProviderEditNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'providerEditProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$providerEditNotifierHash();

  @override
  String toString() {
    return r'providerEditProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProviderEditNotifier create() => ProviderEditNotifier();

  @override
  bool operator ==(Object other) {
    return other is ProviderEditNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$providerEditNotifierHash() =>
    r'e7d87e9dfda05d3df59f7cebd68f4be8384537cf';

final class ProviderEditNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          ProviderEditNotifier,
          AsyncValue<ProviderDto>,
          ProviderDto,
          FutureOr<ProviderDto>,
          String
        > {
  ProviderEditNotifierFamily._()
    : super(
        retry: null,
        name: r'providerEditProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ProviderEditNotifierProvider call(String providerId) =>
      ProviderEditNotifierProvider._(argument: providerId, from: this);

  @override
  String toString() => r'providerEditProvider';
}

abstract class _$ProviderEditNotifier extends $AsyncNotifier<ProviderDto> {
  late final _$args = ref.$arg as String;
  String get providerId => _$args;

  FutureOr<ProviderDto> build(String providerId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProviderDto>, ProviderDto>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ProviderDto>, ProviderDto>,
              AsyncValue<ProviderDto>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}

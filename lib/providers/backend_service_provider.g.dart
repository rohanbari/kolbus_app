// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backend_service_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NormalizeStop)
final normalizeStopProvider = NormalizeStopFamily._();

final class NormalizeStopProvider
    extends $AsyncNotifierProvider<NormalizeStop, String> {
  NormalizeStopProvider._({
    required NormalizeStopFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'normalizeStopProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$normalizeStopHash();

  @override
  String toString() {
    return r'normalizeStopProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  NormalizeStop create() => NormalizeStop();

  @override
  bool operator ==(Object other) {
    return other is NormalizeStopProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$normalizeStopHash() => r'96e32533d39724e561680378347e75bdc9360879';

final class NormalizeStopFamily extends $Family
    with
        $ClassFamilyOverride<
          NormalizeStop,
          AsyncValue<String>,
          String,
          FutureOr<String>,
          String
        > {
  NormalizeStopFamily._()
    : super(
        retry: null,
        name: r'normalizeStopProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NormalizeStopProvider call(String input) =>
      NormalizeStopProvider._(argument: input, from: this);

  @override
  String toString() => r'normalizeStopProvider';
}

abstract class _$NormalizeStop extends $AsyncNotifier<String> {
  late final _$args = ref.$arg as String;
  String get input => _$args;

  FutureOr<String> build(String input);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(Suggestions)
final suggestionsProvider = SuggestionsFamily._();

final class SuggestionsProvider
    extends $AsyncNotifierProvider<Suggestions, List<String>> {
  SuggestionsProvider._({
    required SuggestionsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'suggestionsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$suggestionsHash();

  @override
  String toString() {
    return r'suggestionsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Suggestions create() => Suggestions();

  @override
  bool operator ==(Object other) {
    return other is SuggestionsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$suggestionsHash() => r'6e2936b217f4afa8d5b248060a216e1b49b8052c';

final class SuggestionsFamily extends $Family
    with
        $ClassFamilyOverride<
          Suggestions,
          AsyncValue<List<String>>,
          List<String>,
          FutureOr<List<String>>,
          String
        > {
  SuggestionsFamily._()
    : super(
        retry: null,
        name: r'suggestionsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SuggestionsProvider call(String query) =>
      SuggestionsProvider._(argument: query, from: this);

  @override
  String toString() => r'suggestionsProvider';
}

abstract class _$Suggestions extends $AsyncNotifier<List<String>> {
  late final _$args = ref.$arg as String;
  String get query => _$args;

  FutureOr<List<String>> build(String query);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<String>>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<String>>, List<String>>,
              AsyncValue<List<String>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}

@ProviderFor(SearchRoutes)
final searchRoutesProvider = SearchRoutesFamily._();

final class SearchRoutesProvider
    extends $AsyncNotifierProvider<SearchRoutes, List<RouteModel>> {
  SearchRoutesProvider._({
    required SearchRoutesFamily super.from,
    required ({String? source, String via, String? destination}) super.argument,
  }) : super(
         retry: null,
         name: r'searchRoutesProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$searchRoutesHash();

  @override
  String toString() {
    return r'searchRoutesProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  SearchRoutes create() => SearchRoutes();

  @override
  bool operator ==(Object other) {
    return other is SearchRoutesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$searchRoutesHash() => r'645c7e6e91eb303f0d55343cb84ce882a6876e50';

final class SearchRoutesFamily extends $Family
    with
        $ClassFamilyOverride<
          SearchRoutes,
          AsyncValue<List<RouteModel>>,
          List<RouteModel>,
          FutureOr<List<RouteModel>>,
          ({String? source, String via, String? destination})
        > {
  SearchRoutesFamily._()
    : super(
        retry: null,
        name: r'searchRoutesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  SearchRoutesProvider call({
    String? source,
    String via = '',
    String? destination,
  }) => SearchRoutesProvider._(
    argument: (source: source, via: via, destination: destination),
    from: this,
  );

  @override
  String toString() => r'searchRoutesProvider';
}

abstract class _$SearchRoutes extends $AsyncNotifier<List<RouteModel>> {
  late final _$args =
      ref.$arg as ({String? source, String via, String? destination});
  String? get source => _$args.source;
  String get via => _$args.via;
  String? get destination => _$args.destination;

  FutureOr<List<RouteModel>> build({
    String? source,
    String via = '',
    String? destination,
  });
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<RouteModel>>, List<RouteModel>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<RouteModel>>, List<RouteModel>>,
              AsyncValue<List<RouteModel>>,
              Object?,
              Object?
            >;
    return element.handleCreate(
      ref,
      () => build(
        source: _$args.source,
        via: _$args.via,
        destination: _$args.destination,
      ),
    );
  }
}

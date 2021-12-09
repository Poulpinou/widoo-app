import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widoo_app/exception/AppException.dart';
import 'package:widoo_app/exception/api/NotFoundException.dart';
import 'package:widoo_app/model/Activity.dart';
import 'package:widoo_app/model/dto/request/CreateActivityRequest.dart';
import 'package:widoo_app/repository/ActivityRepository.dart';
import 'package:widoo_app/utils/LocalStorageUtils.dart';
import 'package:widoo_app/utils/LoggingUtils.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  static const String CURRENT_ACTIVITY_KEY = "current_activity_id";

  final ActivityRepository activityRepository;

  ActivityBloc({required this.activityRepository}) : super(ActivityState());

  @override
  Stream<ActivityState> mapEventToState(ActivityEvent event) async* {
    if (event is _FetchCurrentActivity) {
      yield* _fetchCurrentActivity(event, state);
    } else if (event is _GetRandomActivity) {
      yield* _getRandomActivity(event, state);
    } else if (event is _CreateActivity) {
      yield* _createActivity(event, state);
    } else if (event is _CloseCurrentActivity) {
      yield* _closeCurrentActivity(event, state);
    } else if (event is _EndCurrentActivity) {
      yield* _endCurrentActivity(event, state);
    } else if (event is _FetchHistory) {
      yield* _fetchHistory(event, state);
    }
  }

  Stream<ActivityState> _fetchCurrentActivity(
      _FetchCurrentActivity event, ActivityState state) async* {
    yield state.copyWith(isLoading: true);

    final bool keyExists = await LocalStorageUtils.hasKey(CURRENT_ACTIVITY_KEY);
    if (keyExists) {
      final activityId = await LocalStorageUtils.getInt(CURRENT_ACTIVITY_KEY);
      try {
        final Activity activity =
            await activityRepository.getActivity(activityId!);
        yield state.copyWith(currentActivity: activity);
      } on NotFoundException catch (e) {
        Log.info("Could not found activity with id " +
            activityId.toString() +
            ", removing activity from local");

        await LocalStorageUtils.removeKey(CURRENT_ACTIVITY_KEY);

        yield state.copyWith(error: e, currentActivity: null);
      } on AppException catch (e) {
        yield state.copyWith(error: e);
      }
    } else {
      yield state.copyWith(currentActivity: null);
    }
  }

  Stream<ActivityState> _getRandomActivity(
      _GetRandomActivity event, ActivityState state) async* {
    yield state.copyWith(isLoading: true);

    try {
      final Activity activity = await activityRepository.getRandomActivity();

      await LocalStorageUtils.setInt(CURRENT_ACTIVITY_KEY, activity.id);
      Log.info("Current activity set to activity " + activity.id.toString());

      yield state.copyWith(currentActivity: activity);
    } on AppException catch (e) {
      Log.error("Failed to get random activity", e);
      yield state.copyWith(error: e);
    }
  }

  Stream<ActivityState> _createActivity(
      _CreateActivity event, ActivityState state) async* {
    yield state.copyWith(isLoading: true);

    try {
      await activityRepository.postActivity(event.request);

      yield state.copyWith();
      event.onSuccess?.call();
    } on AppException catch (e) {
      yield state.copyWith(error: e);
    }
  }

  Stream<ActivityState> _closeCurrentActivity(
      _CloseCurrentActivity event, ActivityState state) async* {
    yield state.copyWith(isLoading: true);

    await LocalStorageUtils.removeKey(CURRENT_ACTIVITY_KEY);

    yield state.clearCurrentActivity();
  }

  Stream<ActivityState> _endCurrentActivity(
      _EndCurrentActivity event, ActivityState state) async* {
    if (state.currentActivity == null) {
      throw Exception("No current activity!");
    }

    yield state.copyWith(isLoading: true);
    try {
      await activityRepository.endActivity(state.currentActivity!.id);
      await LocalStorageUtils.removeKey(CURRENT_ACTIVITY_KEY);

      yield state.clearCurrentActivity();
    } on AppException catch (e) {
      yield state.copyWith(error: e);
    }
  }

  Stream<ActivityState> _fetchHistory(
      _FetchHistory event, ActivityState state) async* {
    yield state.copyWith(isLoading: true);
    try {
      final List<Activity> history = await activityRepository.getHistory();

      yield state.copyWith(history: history);
    } on AppException catch (e) {
      yield state.copyWith(error: e);
    }
  }
}

// Events
abstract class ActivityEvent {}

abstract class ActivityEvents {
  static _FetchCurrentActivity fetchCurrent() => _FetchCurrentActivity();

  static _GetRandomActivity getRandom() => _GetRandomActivity();

  static _CreateActivity create(CreateActivityRequest request,
          {Function()? onSuccess}) =>
      _CreateActivity(
        request,
        onSuccess: onSuccess,
      );

  static _CloseCurrentActivity closeCurrent() => _CloseCurrentActivity();

  static _EndCurrentActivity endCurrent() => _EndCurrentActivity();

  static _FetchHistory fetchHistory() => _FetchHistory();
}

class _FetchCurrentActivity extends ActivityEvent {}

class _GetRandomActivity extends ActivityEvent {}

class _CreateActivity extends ActivityEvent {
  final CreateActivityRequest request;
  final Function()? onSuccess;

  _CreateActivity(this.request, {this.onSuccess});
}

class _CloseCurrentActivity extends ActivityEvent {}

class _EndCurrentActivity extends ActivityEvent {}

class _FetchHistory extends ActivityEvent {}

// State
class ActivityState {
  final bool isLoading;
  final AppException? error;
  final Activity? currentActivity;
  final List<Activity> history;

  get isErrored => error != null;

  ActivityState({
    this.isLoading = false,
    this.error,
    this.currentActivity,
    List<Activity>? history,
  }) : this.history = history ?? List.empty();

  ActivityState copyWith({
    bool? isLoading,
    AppException? error,
    Activity? currentActivity,
    List<Activity>? history,
  }) =>
      ActivityState(
        isLoading: isLoading ?? false,
        error: error,
        currentActivity: currentActivity ?? this.currentActivity,
        history: history ?? this.history,
      );

  ActivityState clearCurrentActivity() => ActivityState(
        isLoading: false,
        error: null,
        currentActivity: null,
        history: this.history,
      );
}

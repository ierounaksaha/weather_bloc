import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final _apiKey = 'f9539fe69b73a958d01cba6131660150';

  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
    emit(WeatherLoading());
    try{
      WeatherFactory wf = WeatherFactory(_apiKey, language: Language.ENGLISH);
      Position position = await Geolocator.getCurrentPosition();
      Weather weather = await wf.currentWeatherByLocation(position.latitude,position.longitude);
      emit(WeatherSuccess(weather));
     }catch(e){
      emit(WeatherFaliure());
     }
    });
  }
}

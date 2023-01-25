import 'package:api_call_city_name/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'cubit/weather_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherCubit>(
      create: (context) => WeatherCubit(LocalStorage()),
      child: const MaterialApp(
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 40.0,
            ),
            TextField(
              controller: _myController,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Insert city name',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<WeatherCubit, WeatherState>(
              bloc: BlocProvider.of<WeatherCubit>(context)..getLastValues(),
              listenWhen: (oldState, newState) => newState is WeatherError,
              listener: (context, state) {
                if (state is WeatherError) {
                  Fluttertoast.showToast(
                      msg: state.errorMessage.toString(),
                      gravity: ToastGravity.CENTER);
                }
              },
              buildWhen: (oldState, newState) =>
              newState is WeatherInitial ||
                  newState is WeatherLoading ||
                  newState is WeatherLoaded,
              builder: (context, state) {
                 if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  return _LoadedWidget(name: state.weather?.name,
                      temperature: state.weather?.temp,
                  lastTemp: state.lastTemp,
                  lastCity: state.lastCity,);
                }return Container();

                 }),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<WeatherCubit>(context)
                      .getWeather(_myController.text);
                },
                child: const Text('Get Weather')),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )),
    );
  }
}

class _LoadedWidget extends StatelessWidget {
  const _LoadedWidget({
    Key? key,
    this.name,
    this.temperature,
    this.lastCity,
    this.lastTemp
  }) : super(key: key);

  final String? name;
  final double? temperature;
  final String? lastCity;
  final String? lastTemp;

  @override
  Widget build(BuildContext context) {
       return Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Text(
               name ??
           'Insert your first city for today!',
             style: const TextStyle(fontSize: 60.0),
             textAlign: TextAlign.center,
           ),
           if(temperature != null)Text(
             temperature.toString(),
             style: const TextStyle(fontSize: 60.0),
           ),
           SizedBox(height: 40,),
           if(lastCity != null)Text(
             lastCity!,
             style: const TextStyle(fontSize: 40.0),
           ),
           if(lastTemp != null)Text(
             lastTemp!,
             style: const TextStyle(fontSize: 40.0),
           ),
         ],
       );
  }
}

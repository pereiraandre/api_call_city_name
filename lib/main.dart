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
      create: (context) => WeatherCubit(),
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
              listenWhen: (oldState, newState) => newState is WeatherError,
              listener: (context, state) {
                if (state is WeatherError) {
                  Fluttertoast.showToast(
                      msg: state.errorMessage.toString(),
                      gravity: ToastGravity.CENTER);
                }
              },
              buildWhen: (oldState, newState) =>
                  newState is WeatherLoading ||
                  newState is WeatherLoaded ||
                  newState is WeatherError,
              builder: (context, state) {
                String temperature = '0º';
                String city = '';
                if (state is WeatherLoading) {
                  return const CircularProgressIndicator();
                } else if (state is WeatherLoaded) {
                  temperature = state.weather.temp.toString();
                  city = state.weather.name.toString();
                }
                return Column(
                  children: [
                    Text(
                      city,
                      style: const TextStyle(fontSize: 60.0),
                    ),
                    Text(
                      temperature,
                      style: const TextStyle(fontSize: 60.0),
                    ),
                  ],
                );
              },
            ),
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

import 'package:flutter/material.dart';
//import 'package:pract_3/cubit/click_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pract_3/cubit/home/home_cubit.dart';
import 'package:pract_3/provider/themes.dart';

import 'cubit/theme/theme_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: context.read<ThemeCubit>().themeMode,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          home: MyHomePage(),
        );
      }),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                if (state is ClickState) {
                  return Text(
                    state.clickCount.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  '0',
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                context
                    .read<HomeCubit>()
                    .handleClick(context.read<ThemeCubit>().themeMode);
              },
              child: const Icon(Icons.add),
            ),
            SizedBox(width: 300, height: 300, child: Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Center(
                                child: Text(context
                                    .read<HomeCubit>()
                                    .messages[index]),
                              );
                            },
                            itemCount:
                                context.read<HomeCubit>().messages.length,
                          );
                        },
                      ),
                    ),)
          ],
        ),
      ),
      floatingActionButton: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return FloatingActionButton(
            onPressed: () {
              context.read<ThemeCubit>().changeTheme();
              context.read<HomeCubit>().themeSwitched(context);
            },
            child: Icon(state is LightThemeState
                ? Icons.dark_mode_outlined
                : Icons.light_mode_outlined),
          );
        },
      ),
    );
  }
}

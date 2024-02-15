import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../utils/api_service/api_url.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_validation_message.dart';
import '../../../../utils/navigator_key.dart';
import '../bloc/home_page_bloc/home_page_bloc.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomePageApiBloc>(context)
        .add(const HomePageApiUser(url: ApiUrl.baseUrl));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<HomePageApiBloc>(context)
                        .add(const HomePageApiUser(url: ApiUrl.baseUrl));
                  },
                  child: const Text("Refresh")),
            ],
          ),
          SvgPicture.asset(AppImages.demoImage),
          BlocBuilder<HomePageApiBloc, HomePageApiState>(
            builder: (context, state) {
              if (state is HomePageApiLoading) {
                return const CircularProgressIndicator();
              } else if (state is HomePageApiFailure) {
                return const Text(AppValidationMessage.validationSomethingWentWrong);
              } else if (state is HomePageApiResponse) {
                return (state.modelDemoApiData ?? []).isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.modelDemoApiData!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              NavigatorKey.navigatorKey.currentState!.pushNamed(
                                  AppRoutes.routesScreenDetails,
                                  arguments: state.modelDemoApiData![index]!.name ?? "");
                            },
                            title: Text(state.modelDemoApiData![index]!.name ?? ""),
                            subtitle: Text(state.modelDemoApiData![index]!.email ?? ""),
                          );
                        },
                      )
                    : const Text("No data found");
              }
              return const SizedBox();
            },
          )
        ],
      ),
    );
  }
}

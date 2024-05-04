import 'package:animate_do/animate_do.dart';
import 'package:number_trivia_app/core/app/app_assets.dart';
import 'package:number_trivia_app/core/app/app_colors.dart';
import 'package:number_trivia_app/core/app/text_styles.dart';
import 'package:number_trivia_app/core/presentation/app_scaffold.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/blocs/number_trivia_bloc.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/blocs/number_trivia_events.dart';
import 'package:number_trivia_app/features/number_trivia/presentation/blocs/number_trivia_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

enum TriviaType {
  concrete,
  random;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _numberController = TextEditingController();

  TriviaType selectedTrivia = TriviaType.concrete;

  void changeTiviaType(TriviaType newType) {
    selectedTrivia = newType;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      actions: [
        IconButton(
          onPressed: () {
            _numberController.clear();
            GetIt.I<NumberTriviaBloc>().add(GetRandomTriviaEvent());
          },
          icon: const Icon(Icons.refresh),
        )
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _numberController,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    hintText: 'Enter a number',
                    border: const OutlineInputBorder(),
                  ),
                ),
              ),
              10.horizontalSpace,
              IconButton.filled(
                onPressed: () {
                  GetIt.I<NumberTriviaBloc>().add(GetConcreteTriviaEvent(
                    number: int.parse(_numberController.text),
                  ));
                },
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                ),
                icon: Icon(
                  CupertinoIcons.arrow_down,
                  size: 30.h,
                ),
              )
            ],
          ),
          Expanded(
            child: BlocBuilder<NumberTriviaBloc, NumberTriviaStates>(
              builder: (context, state) {
                final intNumber = int.tryParse(_numberController.text);
                if (_numberController.text.isNotEmpty && intNumber == null) {
                  return Center(
                    child: Text(
                      'Are you seriasly want to know a trivia about number? Then enter a valid number above.',
                      style: textStyle16,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is TriviaLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is TriviaError) {
                  return Center(
                    child: Text(
                      'Something went wrong. Please try again later.',
                      style: textStyle16,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                if (state is TriviaSuccess) {
                  return FadeInUp(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   state.triviaModel.number.toString(),
                        //   style: textStyle40Bold,
                        // ),
                        Text(
                          state.triviaModel.text,
                          style: textStyle20.copyWith(fontSize: 25.sp),
                          textAlign: TextAlign.center,
                        ),
                        20.verticalSpace,
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.white,
                          ),
                          child: const Text('Save'),
                        ),
                      ],
                    ),
                  );
                }

                return Center(
                  child: Text(
                    'Some Interesting facts are waiting for you, enter some number above or get random trivia by pressing top right icon.',
                    style: textStyle18,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

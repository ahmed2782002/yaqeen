
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yaqeen/Islami/modules/Radio/radio_controls.dart';
import '../../../data/repository/radio_repository.dart';
import '../../../view_model/radio/radio_cubit.dart';
import '../../../view_model/radio/radio_state.dart';



class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  State<RadioView> createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> {
  // هنستخدم ValueNotifier عشان نتابع تغيير المحطة الحالية من الـ Controls
  final ValueNotifier<int> currentIndexNotifier = ValueNotifier<int>(0);

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return BlocProvider(
      create: (context) => RadioCubit(RadioRepository())..getRadios(),
      child: BlocBuilder<RadioCubit, RadioState>(
        builder: (context, state) {
          if (state is RadioLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RadioError) {
            return Center(child: Text(state.message));
          } else if (state is RadioSuccess) {
            final radios = state.radios;

            if (radios.isEmpty) {
              return const Center(child: Text("لا توجد محطات راديو"));
            }

            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/Background_qraun.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),

                  Image.asset(
                    "assets/images/radio.png",
                    width: mediaQuery.width * .75,
                  ),

                  SizedBox(height: mediaQuery.height * .05),

                  // اسم المحطة الحالية - يتحدث تلقائيًا
                  ValueListenableBuilder<int>(
                    valueListenable: currentIndexNotifier,
                    builder: (context, currentIndex, _) {
                      final currentRadio = radios[currentIndex];
                      return Text(
                        currentRadio.name ?? "Unknown Radio",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              blurRadius: 4,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),

                  SizedBox(height: mediaQuery.height * .05),
                  const Spacer(),

                  // أزرار التحكم - الكلاس المنفصل
                  SizedBox(
                    height: mediaQuery.height * .3,
                    child: RadioControls(
                      radios: radios,
                      initialIndex: 0,
                      // نرسل الـ notifier عشان الـ Controls يحدثه لما يتغير المؤشر
                      onIndexChanged: (newIndex) {
                        currentIndexNotifier.value = newIndex;
                      },
                    ),
                  ),

                  const Spacer(),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}


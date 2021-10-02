import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter_1/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit() : super(CounterInitialState());

static CounterCubit get(context) => BlocProvider.of(context);
var counter=0;

void minus()
{
  counter--;
  emit(CounterMinusState());
}

void plus()
{
  counter++;
  emit(CounterPlusState());
}

}
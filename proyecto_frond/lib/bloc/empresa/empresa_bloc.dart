import 'package:asistencia_app/modelo/EmpresaModelo.dart';
import 'package:asistencia_app/repository/EmpresaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'empresa_event.dart';
part 'empresa_state.dart';

class EmpresaBloc extends Bloc<EmpresaEvent, EmpresaState> {
  late final EmpresaRepository empresaRepository;
  EmpresaBloc(this.empresaRepository) : super(EmpresaInitialState()) {
    on<EmpresaEvent>((event, emit) async {
      if (event is ListarEmpresaEvent) {
        emit(EmpresaLoadingState());
        try {
          List<EmpresaModelo> empresaList =
              await empresaRepository.getEmpresa();
          emit(EmpresaLoadedState(empresaList));
        } catch (e) {
          emit(EmpresaError(e as Error));
        }
      } else if (event is DeleteEmpresaEvent) {
        try {
          await empresaRepository.deleteEmpresa(event.empresa!.id);
          Future.delayed(Duration(seconds: 1));
          emit(EmpresaLoadingState());

          List<EmpresaModelo> empresaList =
              await empresaRepository.getEmpresa();

          emit(EmpresaLoadedState(empresaList));
        } catch (e) {
          emit(EmpresaError(e as Error));
        }
      } else if (event is CreateEmpresaEvent) {
        try {
          await empresaRepository.createEmpresa(event.empresa);
          emit(EmpresaLoadingState());
          List<EmpresaModelo> empresaList =
              await empresaRepository.getEmpresa();
          emit(EmpresaLoadedState(empresaList));
        } catch (e) {
          emit(EmpresaError(e as Error));
        }
      } else if (event is UpdateEmpresaEvent) {
        try {
          await empresaRepository.updateEmpresa(
              event.empresa.id, event.empresa);
          emit(EmpresaLoadingState());
          List<EmpresaModelo> empresaList =
              await empresaRepository.getEmpresa();
          emit(EmpresaLoadedState(empresaList));
        } catch (e) {
          emit(EmpresaError(e as Error));
        }
      }
    });
  }
}

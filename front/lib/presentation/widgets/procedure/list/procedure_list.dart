import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_bloc/procedure_bloc.dart';
import 'package:front/presentation/widgets/procedure/list/procedure_card.dart';
import 'package:front/presentation/widgets/loading_widget.dart';
import 'package:front/theme.dart';

class ProcedureList extends StatefulWidget {
  const ProcedureList({super.key});

  @override
  State<ProcedureList> createState() => _ProcedureListState();
}

class _ProcedureListState extends State<ProcedureList> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<ProcedureBloc>(context).add(const FetchProcedures());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProcedureBloc, ProcedureState>(
        builder: (context, state) {
      if (state is ProceduresSuccess) {
        if (state.procedures.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.done_all,
                  color: seedColor,
                  size: 80,
                ),
                Text(
                  "Nemate aktuelnih operacija",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }
        return SafeArea(
          child: ListView.separated(
            itemCount: state.procedures.length,
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (context, index) {
              final procedure = state.procedures[index];
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ProcedureCard(
                    procedure: procedure,
                  ));
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        );
      } else if (state is ProcedureError) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                color: seedColor,
                size: 80,
              ),
              Text(
                "Došlo je do greške prilikom učitavanja operacija..",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        );
      }

      return const LoadingWidget();
    });
  }
}

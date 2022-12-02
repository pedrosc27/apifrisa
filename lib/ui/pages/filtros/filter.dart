import 'package:api/domain/models/attribute_filter.dart';
import 'package:api/domain/models/attribute_terms.dart';
import 'package:api/domain/models/filtro_model.dart';
import 'package:api/ui/global_controllers/attribute_terms_controller.dart';
import 'package:api/ui/pages/filtros/filter_result_page.dart';
import 'package:api/ui/pages/filtros/filtros_provider.dart';
import 'package:api/ui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FiltrosPage extends StatefulWidget {
  const FiltrosPage({Key? key}) : super(key: key);

  @override
  State<FiltrosPage> createState() => _FiltrosPageState();
}

class _FiltrosPageState extends State<FiltrosPage> {
  List<AttributeFilter> atributos = AttributeFilter.attributeList;
  List<AttributeTermsFilter>? terms;
  List<FiltroModel>? seleccionados;
  List<int>? numeros;
  @override
  void initState() {
    final termsProvider = context.read<AttributeTermsProvider>();
    termsProvider.readJson();
    numeros = List<int>.filled(atributos.length, -1, growable: true);
    seleccionados = List<FiltroModel>.generate(atributos.length,
        (index) => FiltroModel(id: atributos[index].id!, nombre: "nombre"));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    terms = context.watch<AttributeTermsProvider>().attributeTerms;
    final filtros = context.watch<FiltrosProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: amarilloFrisa,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            color: negroFrisa,
          ),
        ),
        title: const Text(
          "Filtros",
          style: TextStyle(
              fontSize: 18,
              color: negroFrisa,
              fontFamily: 'NeoMedium',
              fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: terms!.isEmpty
                    ? const Text("No hay info")
                    : Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const ScrollPhysics(),
                          itemCount: atributos.length,
                          itemBuilder: ((context, index) {
                            final atributo = atributos[index];
                            final termsAttribute = terms
                                ?.where((term) => term.parent == atributo.id)
                                .toList();
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text('${atributo.name}',
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'NeoMedium',
                                        color: negroFrisa,
                                        fontWeight: FontWeight.w400)),
                                const SizedBox(height: 20),
                                Wrap(
                                  runSpacing: 10,
                                  spacing: 10,
                                  runAlignment: WrapAlignment.center,
                                  children: List.generate(
                                      termsAttribute!.length, (indexOpciones) {
                                    final opciones = termsAttribute;
                                    final opcion = opciones[indexOpciones];
                                    return Container(
                                      margin: const EdgeInsets.only(right: 5),
                                      child: ChoiceChip(
                                        label: Text(
                                          opcion.name!,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 15,
                                        ),
                                        selected:
                                            numeros![index] == indexOpciones,
                                        selectedColor: negroFrisa,
                                        onSelected: (bool selected) {
                                          setState(() {
                                            seleccionados?[index].nombre =
                                                opcion.name;
                                                print("opcion name:  ${opcion.name}");
                                            numeros![index] =
                                                selected ? indexOpciones : 0;
                                          });
                                        },
                                        shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                color: grisVazel, width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        backgroundColor: Colors.white,
                                        labelStyle: TextStyle(
                                            fontSize: 14,
                                            color:
                                                numeros![index] == indexOpciones
                                                    ? Colors.white
                                                    : Colors.black,
                                            fontFamily: 'NeoRegular',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    );
                                  }),
                                )
                              ],
                            );
                          }),
                        ),
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: (() {
                  print("seleccionado ${seleccionados![0].id }");
                  print("seleccionado ${seleccionados![0].nombre }");
                  //seleccionados!.removeWhere((element) => element.nombre == "nombre");
                  List<FiltroModel>? nuevos = [...seleccionados!];
                  nuevos.removeWhere((element) => element.nombre == "nombre");
                  filtros.setSeleccionados(nuevos);
                  filtros.resetCargado();
                   Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => const FiltrosResultados()));
                
                }),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: const BoxDecoration(
                      color: negroFrisa,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Aplicar Filtros',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'NeoMedium',
                            color: amarilloFrisa,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        )),
      ),
    );
  }
}

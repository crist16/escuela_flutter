import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Prosecucion extends StatefulWidget {
  const Prosecucion({Key? key}) : super(key: key);

  @override
  State<Prosecucion> createState() => _ProsecucionState();
}

class _ProsecucionState extends State<Prosecucion> {
  final _keyForm = GlobalKey<FormState>();
  var dio = Dio();
  List<String> nacionalidad = ["V", "E"];
  late String _fileFullPath;

  TextEditingController _texDateController = new TextEditingController();
  List<String> nivelPromovido = ["BÁSICA", "MEDIA"];
  List<String> _periodos = [
    "2022-2023",
    "2023-2024",
    "2024-2025",
    "2025-2026",
    "2026-2027",
    "2027-2028",
    "2028-2029",
    "2029-2030",
    "2030-2031",
    "2031-2032",
    "2032-2033",
    "2033-2034",
    "2034-2035",
    "2035-2036"
  ];
  List<String> _literal = ["A", "B", "C", "D"];
  List<String> prosecucion = [
    "PRIMER",
    "SEGUNDO",
    "TERCER",
    "CUARTO",
    "QUINTO",
    "SEXTO"
  ];
  List<String> gradoPromovido = [
    "PRIMER",
    "SEGUNDO",
    "TERCER",
    "CUARTO",
    "QUINTO",
    "SEXTO",
    "PRIMER AÑO"
  ];
  String _gradoPromovidoValue = "PRIMER";
  String _periodoDropdownValue = "2022-2023";
  String _opcionDelDropDown = "V";
  String _opcionDelGradoQueCursa = "PRIMER";
  String _fecha = "";
  String _literaldropDownValue = "A";
  String _nivelPromovidoValue = "BÁSICA";
  String nombreEstudiante = "";
  String apellidoEstudiante = "";
  String cedulaEstudiante = "";
  String ciudadNacimiento = "";
  String diaNacimiento = "";
  String mesNacimiento = "";
  String yearNacimiento = "";
  String correo = "";
  bool isReady = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Prosecucion")),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _keyForm,
            child: Column(children: [
              Divider(),
              _crearNombresInput(),
              Divider(),
              _crearApellidosInput(),
              Divider(),
              _nacionalidad(),
              Divider(),
              _cedulaInput(),
              Divider(),
              _lugarDeNacimiento(),
              Divider(),
              _fechaDeNacimiento(context),
              Divider(),
              _gradoQueCursaDropDown(),
              Divider(),
              _literalDropDown(),
              Divider(),
              _periodoEscolar(),
              Divider(),
              _gradoPromovido(),
              Divider(),
              _nivelPromovido(),
              Divider(),
              _crearCorreoInput(),
              Divider(),
              TextButton(
                  onPressed: () {
                    if (_keyForm.currentState!.validate()) {
                      _mostraPopup(context);
                    } else {
                      print("Fallo la validacion");
                    }
                  },
                  child: const Text("Enviar")),
              isReady ? _downloadButton() : SizedBox.shrink()
            ]),
          ),
        ),
      ),
    );
  }

  _downloadButton() {
    return TextButton(
        onPressed: () {
          // _downloadAndSaveFileToStorage();
        },
        child: Text("Descargar"));
  }

  _crearNombresInput() {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "Este campo no puede estar vacio";
        }

        return null;
      },
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: "Jose Luis",
          labelText: "Nombres",
          suffixIcon: Icon(Icons.perm_identity),
          icon: Icon(Icons.account_circle)),
      onChanged: (value) => nombreEstudiante = value,
    );
  }

  _crearApellidosInput() {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "Este campo no puede estar vacio";
        }

        return null;
      },
      textCapitalization: TextCapitalization.characters,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: "Castro Fuentes",
          labelText: "Apellidos",
          suffixIcon: Icon(Icons.perm_identity),
          icon: Icon(Icons.account_circle)),
      onChanged: (value) => apellidoEstudiante = value,
    );
  }

  _cedulaInput() {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "Este campo no puede estar vacio";
        }

        return null;
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: "19762932",
          labelText: "Cédula",
          suffixIcon: Icon(Icons.document_scanner),
          icon: Icon(Icons.pause_presentation)),
      onChanged: (value) => cedulaEstudiante = value,
    );
  }

  _nacionalidad() {
    return Row(
      children: [
        Text("Nacionalidad"),
        Icon(Icons.select_all),
        SizedBox(width: 30.0), // Para separar vertical
        Expanded(
          child: DropdownButton(
              items: getOpcionesDropDown(),
              value: _opcionDelDropDown,
              onChanged: (opt) {
                setState(() {
                  _opcionDelDropDown = opt.toString();
                });
              }),
        ),
      ],
    );
  }

  _lugarDeNacimiento() {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "Este campo no puede estar vacio";
        }

        return null;
      },
      textCapitalization: TextCapitalization.characters,
      onChanged: (value) => ciudadNacimiento = value,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: "Cumaná-Edo. Sucre",
          labelText: "Lugar de Nacimiento",
          suffixIcon: Icon(Icons.people),
          icon: Icon(Icons.account_circle)),
    );
  }

  _fechaDeNacimiento(BuildContext context) {
    return TextFormField(
        controller: _texDateController,
        enableInteractiveSelection: false,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            hintText: "Fecha de Nacimiento",
            suffixIcon: Icon(Icons.accessibility),
            icon: Icon(Icons.account_circle)),
        onTap: (() {
          FocusScope.of(context).requestFocus(new FocusNode());
          _selectDate(context);
        }));
  }

  _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
        context: context,
        locale: Locale('es', 'ES'),
        initialDate: new DateTime(2000),
        firstDate: new DateTime(1991),
        lastDate: new DateTime(2060));
    if (picked != null) {
      setState(() {
        String dateString = picked.toString();
        List<String> dateList = dateString.split("-");

        String dia = dateList[2];
        List<String> stringDia = dia.split(" ");
        _fecha = "${stringDia[0]}/${dateList[1]}/${dateList[0]}";
        diaNacimiento = stringDia[0];
        mesNacimiento = dateList[1];
        yearNacimiento = dateList[0];
        _texDateController.text = _fecha;
      });
    }
  }

  _gradoQueCursaDropDown() {
    return Row(
      children: [
        Text("Grado Que Cursó"),
        Icon(Icons.book),
        SizedBox(width: 30.0), // Para separar vertical
        Expanded(
          child: DropdownButton(
              items: gradoProsecucionMenu(),
              value: _opcionDelGradoQueCursa,
              onChanged: (opt) {
                setState(() {
                  _opcionDelGradoQueCursa = opt.toString();
                });
              }),
        ),
      ],
    );
  }

  _literalDropDown() {
    return Row(
      children: [
        Text("Literal"),
        Icon(Icons.note_add),
        SizedBox(width: 30.0), // Para separar vertical
        Expanded(
          child: DropdownButton(
              items: literalProsecucionMenu(),
              value: _literaldropDownValue,
              onChanged: (opt) {
                setState(() {
                  _literaldropDownValue = opt.toString();
                });
              }),
        ),
      ],
    );
  }

  _periodoEscolar() {
    return Row(
      children: [
        Text("Período escolar"),
        Icon(Icons.calendar_month),
        SizedBox(width: 30.0), // Para separar vertical
        Expanded(
          child: DropdownButton(
              items: periodoDropDownMenu(),
              value: _periodoDropdownValue,
              onChanged: (opt) {
                setState(() {
                  _periodoDropdownValue = opt.toString();
                });
              }),
        ),
      ],
    );
  }

  _gradoPromovido() {
    return Row(
      children: [
        Text("Grado de Promoción"),
        Icon(Icons.heat_pump),
        SizedBox(width: 30.0), // Para separar vertical
        Expanded(
          child: DropdownButton(
              items: gradoPromovidoDownMenu(),
              value: _gradoPromovidoValue,
              onChanged: (opt) {
                setState(() {
                  _gradoPromovidoValue = opt.toString();
                });
              }),
        ),
      ],
    );
  }

  _nivelPromovido() {
    return Row(
      children: [
        Text("Nivel de promoción"),
        Icon(Icons.book),
        SizedBox(width: 30.0), // Para separar vertical
        Expanded(
          child: DropdownButton(
              items: nivelPromovidoDownMenu(),
              value: _nivelPromovidoValue,
              onChanged: (opt) {
                setState(() {
                  _nivelPromovidoValue = opt.toString();
                });
              }),
        ),
      ],
    );
  }

  _crearCorreoInput() {
    return TextFormField(
      validator: (value) {
        if (value == "") {
          return "Este campo no puede estar vacio";
        }

        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: "micorreo@gmail.com",
          helperText: "Correo donde se enviara la constancia",
          labelText: "Correo",
          suffixIcon: Icon(Icons.mail),
          icon: Icon(Icons.account_circle)),
      onChanged: (value) => correo = value,
    );
  }

  List<DropdownMenuItem<String>> getOpcionesDropDown() {
    List<DropdownMenuItem<String>> lista = [];
    nacionalidad.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> gradoProsecucionMenu() {
    List<DropdownMenuItem<String>> lista = [];
    prosecucion.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> literalProsecucionMenu() {
    List<DropdownMenuItem<String>> lista = [];
    _literal.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> periodoDropDownMenu() {
    List<DropdownMenuItem<String>> lista = [];
    _periodos.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> gradoPromovidoDownMenu() {
    List<DropdownMenuItem<String>> lista = [];
    gradoPromovido.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  List<DropdownMenuItem<String>> nivelPromovidoDownMenu() {
    List<DropdownMenuItem<String>> lista = [];
    nivelPromovido.forEach((element) {
      lista.add(DropdownMenuItem(
        child: Text(element),
        value: element,
      ));
    });
    return lista;
  }

  void _mostraPopup(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text("Verifique los datos por favor"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/img/cintillo.png',
                  width: 50,
                  height: 70,
                ),
                Row(
                  children: [
                    Text("Nombres:"),
                    Text("${nombreEstudiante} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Apellido:"),
                    Text("${apellidoEstudiante} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Nacionalidad:"),
                    Text("${_opcionDelDropDown} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Cédula:"),
                    Text("${cedulaEstudiante} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Ciudad:"),
                    Text("${ciudadNacimiento} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Fecha:"),
                    Text("${_fecha}"),
                  ],
                ),
                Row(
                  children: [
                    Text("Grado aprobado:"),
                    Text("${_opcionDelGradoQueCursa} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Literal:"),
                    Text("${_literaldropDownValue} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Período escolar:"),
                    Text("${_periodoDropdownValue} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Grado promovido:"),
                    Text("${_gradoPromovidoValue} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Nivel promovido:"),
                    Text("${_nivelPromovidoValue} "),
                  ],
                ),
                Row(
                  children: [
                    Text("Correo:"),
                    Text("${correo} "),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    print("envio http");
                    // _envioPostHttp();
                    _envioDioPostHttp();
                    isReady = true;
                    Navigator.of(context).pop();
                  },
                  child: Text("Ok")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancelar"))
            ],
          );
        });
  }

  _envioPostHttp() async {
    print("Enviando http");
    //var url = Uri.https('localhost:5000', '/constancia/prosecucion');
    var url =
        Uri.https('laescuelaapp.herokuapp.com', '/constancia/prosecucion');
    var response = await http.post(url,
        body: json.encode(<String, String>{
          "nombreEstudiante": nombreEstudiante,
          "apellidoEstudiante": apellidoEstudiante,
          'nacionalidad': _opcionDelDropDown,
          "cedulaEstudiante": cedulaEstudiante,
          "ciudadNacimiento": ciudadNacimiento,
          "diaNacimiento": diaNacimiento,
          "mesNacimiento": mesNacimiento,
          'yearNacimiento': yearNacimiento,
          "gradoCurso": _opcionDelGradoQueCursa,
          "literal": _literaldropDownValue,
          "periodoEscolar": _periodoDropdownValue,
          "gradoPromovido": _gradoPromovidoValue,
          "nivelPromovido": _nivelPromovidoValue,
          "correo": correo
        }));

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

  _envioDioPostHttp() async {
    try {
      print("Enviando http");

      var response = await dio.post(
          "https://laescuelaapp.herokuapp.com/constancia/prosecucion",
          data: {
            "nombreEstudiante": nombreEstudiante,
            "apellidoEstudiante": apellidoEstudiante,
            'nacionalidad': _opcionDelDropDown,
            "cedulaEstudiante": cedulaEstudiante,
            "ciudadNacimiento": ciudadNacimiento,
            "diaNacimiento": diaNacimiento,
            "mesNacimiento": mesNacimiento,
            'yearNacimiento': yearNacimiento,
            "gradoCurso": yearNacimiento,
            "literal": _literaldropDownValue,
            "periodoEscolar": _periodoDropdownValue,
            "gradoPromovido": _gradoPromovidoValue,
            "nivelPromovido": _nivelPromovidoValue,
            "correo": correo
          });
      if (response.statusCode == 200) {
        isReady == true;
      }
    } catch (e) {
      print(e);
    }

    //print(await http.read(Uri.https('example.com', 'foobar.txt')));
  }

/*
  Future _downloadAndSaveFileToStorage() async {
    var urlPath =
        "https://laescuelaapp.herokuapp.com/download/${nombreEstudiante}.docx";
    try {
      final status = await Permission.storage.request();
      if (status.isGranted) {
        final externalDirectory = await getExternalStorageDirectories();
        final id = FlutterDownloader.enqueue(
            url: urlPath,
            savedDir: externalDirectory![0].path,
            fileName: "$nombreEstudiante.docx",
            showNotification: true,
            openFileFromNotification: true);
      }
    } catch (e) {
      print(e);
    }
  }


*/
}

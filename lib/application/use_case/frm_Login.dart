import 'package:flutter/material.dart';
import '../use_case/widgets/main_admin/input_decoration.dart';
import 'package:system_delivery/controladores/c_login.dart';
import 'package:provider/provider.dart';

class frmLogin extends StatefulWidget {
  frmLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<frmLogin> createState() => _frmLoginState();
}

class _frmLoginState extends State<frmLogin> {
  final txtuser = TextEditingController();
  final txtpass = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    txtpass.addListener(() {});
    txtuser.addListener(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    txtpass.dispose();
    txtuser.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    final controller = context.read<LoginController>();
    final bool isOk = controller.formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
      child: Builder(
        builder: (context) => Scaffold(
          body: SafeArea(
              child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [cajapurpura(size), icono(), loginform(context)],
            ),
          )),
        ),
      ),
    );
  }

  SingleChildScrollView loginform(BuildContext context) {
    final LoginController controller = Provider.of<LoginController>(context);

    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          height: 250,
        ),
        Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            //height: size*,
            //color: Colors.green,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 15,
                      offset: Offset(0, 5))
                ]),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Text('Login', style: Theme.of(context).textTheme.headline4),
                const SizedBox(height: 30),
                Container(
                    child: Form(
                        key: controller.formKey,
                        child: Column(children: [
                          TextFormField(
                            autocorrect: false,
                            // ignore: prefer_const_constructors
                            decoration: InputDecorations.inputDecoration(
                                hintext: 'frank@gmail.com',
                                labeltext: 'Ingrese correo',
                                icono: const Icon(Icons.email_rounded)),
                            validator: (text) {
                              if (text!.contains("@")) return null;
                              return 'Correo invalido';
                            },
                            onChanged: controller.onEmailChanged,
                            controller: txtuser,
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: txtpass,
                            obscureText: true,
                            autocorrect: false,
                            // ignore: prefer_const_constructors
                            decoration: InputDecorations.inputDecoration(
                                hintext: '*******',
                                labeltext: 'Ingrese password',
                                icono: const Icon(Icons.security_rounded)),
                            validator: (text) {
                              if (text!.trim().length > 5) return null;
                              return 'Password invalido';
                            },
                            onChanged: controller.onPasswordChanged,
                          ),
                          const SizedBox(height: 30),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            disabledColor: Colors.grey,
                            color: Color.fromARGB(255, 181, 25, 38),
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 15),
                                child: const Text(
                                  'Ingresar',
                                  style: TextStyle(color: Colors.white),
                                )),
                            onPressed: () async {
                              _submit(context);
                            },
                          ),
                        ])))
              ],
            )),
        const SizedBox(height: 30),
        const TextButton(
          child: Text(
            'Crear una cuenta nueva',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          onPressed: null,
        )
      ]),
    );
  }

  SafeArea icono() {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 30),
        width: double.infinity,
        child:
            const Icon(Icons.person_pin_circle, color: Colors.white, size: 100),
      ),
    );
  }

  Container cajapurpura(Size size) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 153, 25, 29),
        Color.fromARGB(255, 201, 80, 80)
      ])),
      width: double.infinity,
      height: size.height * 0.4,
      child: Stack(children: [
        Positioned(top: 90, left: 30, child: burbuja()),
        Positioned(top: -40, left: -30, child: burbuja()),
        Positioned(top: -50, right: -20, child: burbuja()),
        Positioned(top: 120, left: -20, child: burbuja()),
        Positioned(top: 50, right: -20, child: burbuja()),
        Positioned(top: 70, left: 100, child: burbuja()),
        Positioned(top: 80, left: 160, child: burbuja()),
      ]),
    );
  }

  Container burbuja() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );
  }
}

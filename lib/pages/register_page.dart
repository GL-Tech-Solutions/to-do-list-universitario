import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aula_1/pages/pdf_viewer_page_politica.dart';
import 'package:flutter_aula_1/pages/pdf_viewer_page_termos.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';
import '../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nome = TextEditingController();
  final email = TextEditingController();
  final senha = TextEditingController();
  final confirmaSenha = TextEditingController();
  bool loading = false;
  ValueNotifier<bool> isChecked = ValueNotifier(false);

  void openPDFTermos() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPageTermos(),
        ),
      );

  void openPDFPolitica() => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerPagePolitica(),
        ),
      );

  registrar() async {
    setState(() => loading = true);
    try {
      if (isChecked.value) {
        final navigator = Navigator.of(context);
        await context
            .read<AuthService>()
            .registrar(nome.text, email.text, senha.text);
        navigator.pop();
      }
    } on AuthException catch (e) {
      String errorMessage = '';
      switch (e.message) {
        case 'weak-password':
          errorMessage = AppLocalizations.of(context)!.senhaFraca;
          break;
        case 'email-already-in-use':
          errorMessage = AppLocalizations.of(context)!.emailEmUso;
          break;
        case 'invalid-email':
          errorMessage = AppLocalizations.of(context)!.emailInvalido;
          break;
        default:
          AppLocalizations.of(context)!.erroInesperado;
      }
      setState(() => loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
        ),
      );
    }
  }

  @override
  void dispose() {
    isChecked.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cadastro),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.crieConta,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: nome,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.nome,
                        ),
                        keyboardType: TextInputType.name,
                        validator: Validatorless.required(
                            AppLocalizations.of(context)!.informeNome),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.email,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: Validatorless.required(
                            AppLocalizations.of(context)!.informeCorretamente),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: senha,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.senha,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.informeSenha;
                          } else if (value.length < 6) {
                            return AppLocalizations.of(context)!.caracteres;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: confirmaSenha,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              AppLocalizations.of(context)!.confirmeSenha,
                        ),
                        validator: Validatorless.compare(senha,
                            AppLocalizations.of(context)!.senhasNaoConferem),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ValueListenableBuilder(
                              valueListenable: isChecked,
                              builder: (BuildContext context, bool value,
                                  Widget? child) {
                                return Checkbox(
                                  value: value,
                                  onChanged: (value) =>
                                      isChecked.value = value ?? false,
                                );
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: RichText(
                              text: TextSpan(
                                text: AppLocalizations.of(context)!.liEAceito,
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .termosDeUso,
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => openPDFTermos(),
                                  ),
                                  TextSpan(
                                      text: AppLocalizations.of(context)!.e),
                                  TextSpan(
                                    text: AppLocalizations.of(context)!
                                        .politicaDePrivacidade,
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => openPDFPolitica(),
                                  ),
                                  TextSpan(text: '.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 36,
                      ),
                      ValueListenableBuilder(
                        valueListenable: isChecked,
                        builder:
                            (BuildContext context, bool value, Widget? child) {
                          return ElevatedButton(
                            onPressed: !value
                                ? null
                                : () {
                                    if (formKey.currentState!.validate()) {
                                      registrar();
                                    }
                                  },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: (loading)
                                  ? [
                                      Padding(
                                        padding: EdgeInsets.all(16),
                                        child: SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ]
                                  : [
                                      Icon(Icons.check),
                                      Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .cadastrar,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

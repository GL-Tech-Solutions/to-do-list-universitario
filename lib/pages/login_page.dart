import 'package:flutter/material.dart';
import 'package:flutter_aula_1/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final senha = TextEditingController();

  bool isLogin = true;
  String titulo = '';
  String actionButton = '';
  String toggleButton = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setFormAction(true);
    });
  }

  setFormAction(bool acao) {
    setState(() {
      isLogin = acao;
      if (isLogin) {
        titulo = AppLocalizations.of(context)!.bemVindo;
        actionButton = AppLocalizations.of(context)!.login;
        toggleButton = AppLocalizations.of(context)!.cadastrese;
      } else {
        titulo = AppLocalizations.of(context)!.crieConta;
        actionButton = AppLocalizations.of(context)!.cadastrar;
        toggleButton = AppLocalizations.of(context)!.voltarAoLogin;
      }
    });
  }

  login() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().login(email.text, senha.text);
    } on AuthException catch (e) {
      String errorMessage = '';
      switch (e.message) {
        case 'user-not-found':
          errorMessage = AppLocalizations.of(context)!.usuarioNaoEncontrado;
          break;
        case 'wrong-password':
          errorMessage = AppLocalizations.of(context)!.senhaIncorreta;
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

  registrar() async {
    setState(() => loading = true);
    try {
      await context.read<AuthService>().registrar(email.text, senha.text);
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: EdgeInsets.only(top: 100),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset('images/logo-pi.png'),
            Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titulo,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1.5,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(24),
                    child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.login,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .informeCorretamente;
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    child: TextFormField(
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
                  ),
                  Padding(
                    padding: EdgeInsets.all(24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          if (isLogin) {
                            login();
                          } else {
                            registrar();
                          }
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
                                          color: Colors.white)),
                                ),
                              ]
                            : [
                                Icon(Icons.check),
                                Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Text(
                                    actionButton,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => setFormAction(!isLogin),
                    child: Text(toggleButton),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

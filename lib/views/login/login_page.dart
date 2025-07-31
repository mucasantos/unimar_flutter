import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:unimar_sab_19/globals.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool _obscureText = true;


  @override
  void dispose() {
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _changeObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _loginUsuario() async {
    final email = _emailController.text.trim();
    final senha = _senhaController.text;
    if (email.isEmpty || senha.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha todos os campos')),
      );
      return;
    }
    final url = Uri.parse('https://petadopt.onrender.com/user/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: '{"email": "$email", "password": "$senha"}',
      );
      if (response.statusCode == 200) {
        final body = response.body;
        final tokenMatch = RegExp(r'"token"\s*:\s*"([^"]+)"').firstMatch(body);
        if (tokenMatch != null) {
          jwtToken = tokenMatch.group(1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login realizado com sucesso!')),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/cadastro_pet', (route) => false);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Token não encontrado na resposta.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login: ' + response.body)),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro de conexão: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 228, 235, 238),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Image.asset("assets/images/logo.png", height: 100),
              Text(
                "Adote Me",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF87AB),
                ),
              ),
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF87AB),
                ),
              ),
              SizedBox(height: 24),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _senhaController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: "Senha",
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: _changeObscureText,
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _loginUsuario,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFF87AB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Não tem uma conta?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/cadastro');
                    },
                    child: Text("Cadastre-se"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

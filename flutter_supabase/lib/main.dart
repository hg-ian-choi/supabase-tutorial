import "package:flutter/material.dart";
import "package:flutter_supabase/Config.dart";
import "package:supabase_flutter/supabase_flutter.dart";

void main() async {
  await Supabase.initialize(
    url: Config.supabaseUrl,
    anonKey: Config.supabaseAnonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
  }

  void fetchData() async {
    final data = await supabase.from("countries").select("name");
    print(data);
  }

  void insertData() async {
    final data = await supabase.from("countries").insert({"name": "Japan"});
    print(data);
  }

  void updateData() async {
    final data =
        await supabase.from("countries").update({"name": "China"}).eq("id", 5);
    print(data);
  }

  void upsertData() async {
    final data = await supabase
        .from("countries")
        .upsert({"id": 1, "name": "Albania"}).select();
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: upsertData,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:led_dign_app/services/index.dart';

class CrudSentencesPage extends StatefulWidget {
  const CrudSentencesPage({super.key});

  @override
  State<CrudSentencesPage> createState() => _CrudSentencesPageState();
}

class _CrudSentencesPageState extends State<CrudSentencesPage> {
  final _focusNode = FocusNode();
  final _ss = SentencesStorageService();
  TextEditingController _controller = TextEditingController();
  List<String> sentences = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      handleGetSentences();
    });
  }

  Future handleGetSentences() async {
    final ssArr = await _ss.getAllSentences();
    setState(() {
      sentences = ssArr;
    });
  }

  Future<void> handleAddSentence() async {
    bool saved = await _ss.addSentence(_controller.text);

    if (!saved) return;

    _controller.text = '';
    handleGetSentences();
  }

  Future handleDeleteSentence(int position) async {
    bool deleted = await _ss.deleteSentence(position);

    if (!deleted) return;

    handleGetSentences();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          "LED Sing",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Center(
          child: Column(
            children: [
              TextField(
                focusNode: _focusNode,
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Enter sentence",
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () {
                    handleAddSentence();
                    // _ss.deleteBox();
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                  ),
                  child: Text("Agregar"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: sentences.length,
                  itemBuilder: (ctx, i) {
                    String currentSentence = sentences[i];

                    return Card(
                      child: ListTile(
                        title: Text(currentSentence),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                handleDeleteSentence(i);
                              },
                              icon: const Icon(
                                Icons.delete,
                              ),
                              color: Colors.redAccent,
                            ),
                            const SizedBox(width: 8),
                            IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  "/show-animate-sentence",
                                  arguments: currentSentence,
                                );
                              },
                              icon: const Icon(
                                Icons.aspect_ratio_sharp,
                              ),
                              color: Colors.indigoAccent,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

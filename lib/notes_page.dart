import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});
  @override
  State<NotesPage> createState() => _NotePageState();
}

class _NotePageState extends State<NotesPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<Map<String, dynamic>> notesList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Catatan Saya",
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.teal[700],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal[700],
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          _showAddNoteDialog();
        },
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.teal[700],
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            padding: EdgeInsets.all(16),
            child: Text(
              "Total Catatan : ${notesList.length}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: notesList.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_alt_outlined,
                          size: 80,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Belum ada catatan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: notesList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: ListTile(
                          title: Text(
                            notesList[index]['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: (notesList[index]['isDone'] ?? false)
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          leading: IconButton(
                            icon: Icon(
                              (notesList[index]['isDone'] ?? false)
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: (notesList[index]['isDone'] ?? false)
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                notesList[index]['isDone'] =
                                    !(notesList[index]['isDone'] ?? false);
                              });
                            },
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notesList[index]['content'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  decoration:
                                      (notesList[index]['isDone'] ?? false)
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                              ),

                              Text(
                                DateFormat(
                                  'dd MMM yyyy, HH:mm',
                                ).format(notesList[index]['date']),
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit_square,
                                  color: Colors.teal,
                                ),
                                onPressed: () {
                                  _showEditNoteDialog(index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _showAlertDelete(index);
                                },
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
    );
  }

  void _showAddNoteDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Catatan Baru"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Judul",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Isi Catatan",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  setState(() {
                    notesList.add({
                      'title': _titleController.text,
                      'content': _contentController.text,
                      'isDone': false,
                      'date': DateTime.now(),
                    });
                  });
                  _titleController.clear();
                  _contentController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(int index) {
    _titleController.text = notesList[index]['title'];
    _contentController.text = notesList[index]['content'];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text("Edit Catatan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: "Judul",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contentController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Isi Catatan",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                if (_titleController.text.isNotEmpty ||
                    _contentController.text.isNotEmpty) {
                  setState(() {
                    notesList[index]['title'] = _titleController.text;
                    notesList[index]['content'] = _contentController.text;
                  });
                  _titleController.clear();
                  _contentController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                "Simpan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDelete(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Hapus Catatan"),
          content: const Text("Yakin Ingin Menghapus Catatan Ini?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Batal", style: TextStyle(color: Colors.black)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                setState(() {
                  notesList.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text("Hapus", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}

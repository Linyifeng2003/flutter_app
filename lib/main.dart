import 'package:flutter/material.dart';

void main() {
  runApp(MyAutobiographyApp());
}

class MyAutobiographyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '自傳',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAutobiographyHomePage(),
    );
  }
}

class MyAutobiographyHomePage extends StatefulWidget {
  @override
  _MyAutobiographyHomePageState createState() => _MyAutobiographyHomePageState();
}

class _MyAutobiographyHomePageState extends State<MyAutobiographyHomePage> {
  List<EditableSectionCard> sections = [
    EditableSectionCard(title: '姓名：', content: '林逸峰'),
    EditableSectionCard(title: '目前學歷：', content: '國立高雄科技大學 資訊工程系'),
    EditableSectionCard(
      title: '專業能力：',
      content: '熟悉JAVA和PYTHON語言，能夠透過一些開源API來實現一些功能，像是爬蟲、資料庫讀取以及網頁設計',
    ),
    EditableSectionCard(
      title: '競賽經驗：',
      content: '高中時參加過全國高中技藝競賽-電腦軟體設計，獲得優勝22名',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('自傳'),
      ),
      body: ListView(
        children: [
          for (var section in sections)
            Dismissible(
              key: Key(section.title),
              onDismissed: (direction) {
                deleteSection(section);
              },
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: section,
            ),
          ElevatedButton(
            onPressed: () {
              _addSection(context);
            },
            child: Text('新增內容'),
          ),
        ],
      ),
    );
  }

  void _addSection(BuildContext context) {
    TextEditingController _titleController = TextEditingController();
    TextEditingController _contentController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('新增內容'),
          content: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(labelText: '標題'),
              ),
              TextField(
                controller: _contentController,
                decoration: InputDecoration(labelText: '內容'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                String newTitle = _titleController.text;
                String newContent = _contentController.text;

                if (newTitle.isNotEmpty) {
                  setState(() {
                    sections.add(EditableSectionCard(title: newTitle, content: newContent));
                  });
                }

                Navigator.of(context).pop();
              },
              child: Text('確定'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
          ],
        );
      },
    );
  }

  void deleteSection(EditableSectionCard section) {
    setState(() {
      sections.remove(section);
    });
  }
}

class EditableSectionCard extends StatefulWidget {
  final String title;
  String content;

  EditableSectionCard({required this.title, required this.content});

  @override
  _EditableSectionCardState createState() => _EditableSectionCardState();
}

class _EditableSectionCardState extends State<EditableSectionCard> {
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _showEditDialog(context);
                      },
                      child: Text('編輯'),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              widget.content,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    TextEditingController _editedContentController = TextEditingController(text: widget.content);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('編輯 ${widget.title} 內容'),
          content: TextField(
            controller: _editedContentController,
            maxLines: null,
            decoration: InputDecoration(labelText: '新內容'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.content = _editedContentController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('儲存'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  List<Map<String, dynamic>> comments = []; // List to store comments and user emails
  TextEditingController _commentController = TextEditingController();
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Fetch user email when  widget initializes
    _fetchComments(); // Fetch comments from Firestore
  }

  Future<void> _getUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userEmail = user.email;
      });
    }
  }

  Future<void> _fetchComments() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('comments').get();
    setState(() {
      comments = querySnapshot.docs
          .map<Map<String, dynamic>>((doc) => {
                'id': doc.id,
                'email': doc['email'] as String,
                'comment': doc['comment'] as String,
              })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 4.0,
                child: ListView.builder(
                  itemCount: comments.length,
                  itemBuilder: (context, index) {
                    final comment = comments[index];
                    final String commentEmail = comment['email'];

                    return ListTile(
                      title: Text(
                        '$commentEmail: ${comment['comment']}',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      trailing: _isCurrentUser(commentEmail)
                          ? IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteComment(comment['id']);
                              },
                            )
                          : null,
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: () {
                    _addComment();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addComment() async {
    String newComment = _commentController.text;
    if (newComment.isNotEmpty) {
      await FirebaseFirestore.instance.collection('comments').add({
        'email': userEmail ?? 'Anonymous',
        'comment': newComment,
        'timestamp': Timestamp.now(), // Optional: Add timestamp
      });
      _commentController.clear();
      _fetchComments(); // Fetch comments again to update the UI
    }
  }

  Future<void> _deleteComment(String commentId) async {
    // Delete comment from Firestore
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(commentId)
        .delete();

    // Remove comment from local list
    setState(() {
      comments.removeWhere((comment) => comment['id'] == commentId);
    });
  }

  bool _isCurrentUser(String commentEmail) {
    return userEmail != null && userEmail == commentEmail;
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

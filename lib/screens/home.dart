import 'package:flutter/material.dart';
import 'package:github_api/main.dart';
import 'package:github_api/models/repo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<All> futureRepo;
  @override
  void initState() {
    super.initState();
    futureRepo = fetchRepos();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHub API!'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Container(
          child: FutureBuilder<All>(
            future: futureRepo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Repo> repos = [];
                for (int i = 0; i < snapshot.data!.repos.length; i++) {
                  repos.add(
                    Repo(
                      name: snapshot.data!.repos[i].name,
                      htmlUrl: snapshot.data!.repos[i].htmlUrl,
                      starCount: snapshot.data!.repos[i].starCount,
                    ),
                  );
                }
                return ListView(
                  children: repos
                      .map(
                        (r) => Card(
                          color: Colors.blue[300],
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      r.name,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    Text(r.starCount.toString()),
                                  ],
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Text(r.htmlUrl),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error!'),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

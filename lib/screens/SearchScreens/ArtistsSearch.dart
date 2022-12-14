import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vibe_music/providers/SearchProvider.dart';

class ArtistsSearch extends StatefulWidget {
  const ArtistsSearch({required this.query, super.key});
  final String query;

  @override
  State<ArtistsSearch> createState() => _ArtistsSearchState();
}

class _ArtistsSearchState extends State<ArtistsSearch> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SearchProvider>().searchArtists(widget.query);
    return !context.watch<SearchProvider>().artistsLoaded
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
                children: context.watch<SearchProvider>().artists.map(
              (artist) {
                return ListTile(
                  contentPadding: const EdgeInsets.all(8),
                  onTap: () async {
                    Navigator.pushNamed(context, '/search/artist', arguments: {
                      'browseId': artist['browseId'],
                      'imageUrl': artist['thumbnails'].last['url'],
                      'name': artist['artist'],
                    });
                  },
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(artist['thumbnails'].last['url']),
                  ),
                  title: Text(
                    artist['artist'],
                    style: Theme.of(context)
                        .primaryTextTheme
                        .titleMedium
                        ?.copyWith(overflow: TextOverflow.ellipsis),
                  ),
                );
              },
            ).toList()),
          );
  }
}

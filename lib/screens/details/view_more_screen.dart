import 'package:CUDI/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../models/store.dart';
import '../../widgets/etc/cudi_widgets.dart';
import '../../widgets/store_card.dart';

class ViewMoreScreen extends StatefulWidget {
  final String title;

  const ViewMoreScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<ViewMoreScreen> createState() => _ViewMoreScreenState();
}

class _ViewMoreScreenState extends State<ViewMoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchData,
          child: FutureBuilder(
            future: _fetchData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                List<Store> stores = CudiProvider.of(context).stores;
                return CustomScrollView(
                  slivers: <Widget>[
                    _buildSliverAppBar(context),
                    _buildSliverList(stores),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return sliverAppBar(context, title: widget.title);
  }

  Widget _buildSliverList(List<Store> stores) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              var store = stores[index];
              bool isFavorite = CudiProvider.of(context).favorites
                  .any((favorite) => favorite.storeId == store.storeId);
              // String? favoriteId = CudiProvider.of(context).favorites
              //     .firstWhere((favorite) => favorite.storeId == store.storeId).favoriteId;
          return Padding(
            padding: EdgeInsets.fromLTRB(24.w,24.h,24.w,0),
            // child: StoreCard(store: store, isFavorite: isFavorite, favoriteId: favoriteId.toString()),
            child: StoreCard(store: store),
          );
        },
        childCount: stores.length,
      ),
    );
  }

  Future<void> _fetchData() async {
    CudiProvider.getAndSetStores(context, index: 0);
  }
}
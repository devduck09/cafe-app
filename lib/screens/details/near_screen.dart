import 'dart:async';
import 'dart:ui' as ui;
import 'package:CUDI/widgets/haert_icon.dart';
import 'package:CUDI/widgets/store_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/theme.dart';
import '../../models/store.dart';
import '../../utils/firebase_firestore.dart';
import '../../widgets/etc/cudi_util_widgets.dart';
import '../../widgets/etc/cudi_widgets.dart';

class NearScreen extends StatefulWidget {
  final String userEmailId;

  const NearScreen({Key? key, required this.userEmailId}) : super(key: key);

  @override
  State<NearScreen> createState() => _NearScreenState();
}

class _NearScreenState extends State<NearScreen> {
  // 기본 위치 설정
  final CameraPosition position =
      const CameraPosition(target: LatLng(35.186103, 129.081756), zoom: 14);

  // Position() 기본값 설정
  DateTime timestamp = DateTime.now();
  double accuracy = 10.0;
  double altitude = 0.0;
  double altitudeAccuracy = 5.0;
  double heading = 90.0;
  double headingAccuracy = 2.0;
  double speed = 5.0;
  double speedAccuracy = 1.0;

  // 위치 서비스가 활성화되어 있는지 확인하고 장치의 위치에 액세스할 수 있는 권한을 확인/요청하는 것을 포함하여 장치의 현재 위치를 얻는 방법
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  // 실행 1. 현재 위치 얻기
  Future<Position> _getCurrentLocation() async {
    bool isGeolocationAvailable = await Geolocator.isLocationServiceEnabled();

    Position _position = Position(
        longitude: position.target.longitude,
        latitude: position.target.latitude,
        timestamp: timestamp,
        accuracy: accuracy,
        altitude: altitude,
        altitudeAccuracy: altitudeAccuracy,
        heading: heading,
        headingAccuracy: headingAccuracy,
        speed: speed,
        speedAccuracy: speedAccuracy);
    if (isGeolocationAvailable) {
      try {
        _position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best);
      } catch (error) {
        cudiDialog(context,
            '에러: 현재위치를 가져오지 못했습니다. 기본 위치: ' + _position.toString(), '닫기');
        return _position;
      }
    }
    cudiDialog(context, '현위치: ' + _position.toString(), '닫기');
    return _position;
  }

  List<Marker> markers = [];

  Future<void> addMarker(Position? pos, String markerId,
      {String? markerTitle, String? address, Store? store}) async {
    final Uint8List currIcon =
        await getBytesFromAsset('assets/images/marker_current.png', 100);
    final Uint8List storeIcon =
        await getBytesFromAsset('assets/images/marker.png', 60);

    if (pos != null) {
      // 널 체크 후 로직 계속 수행
      final marker = Marker(
          onTap: () {
            _goToPosition(latitude: pos.latitude, longitude: pos.longitude);
            if (store != null) {
              _carouselController.animateToPage(stores.indexOf(store));
            }
          },
          markerId: MarkerId(markerId),
          position: LatLng(pos.latitude, pos.longitude),
          infoWindow: markerTitle == null
              ? InfoWindow.noText
              : InfoWindow(title: markerTitle, snippet: address),
          icon: (markerId == 'currpos')
              ? BitmapDescriptor.fromBytes(currIcon)
              : BitmapDescriptor.fromBytes(storeIcon));
      markers.add(marker);
      setState(() {
        markers = markers;
      });
    } else {
      print('Position is null!');
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, allowUpscaling: false);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // 실행 0.
    _determinePosition().then((position) {
      cudiDialog(context, '권한 요청 후: $position', '닫기');
      addMarker(position, 'currpos');
    });
    // // 실행 1. 현재 위치 얻기
    // _getCurrentLocation().then((pos) {
    //   // -> 현재 위치 마커 생성
    //   addMarker(pos, 'currpos');
    // }).catchError((err) => print('curr: ' + err.toString()));
    // 실행 2. 스토어 데이터 가져오기
    initializeData().then((stores) {
      stores = stores
          // -> 스토어 위치 정보가 있는 데이터만 리스트로 생성
          .where((store) => store.longitude != null && store.latitude != null)
          .toList();
      // -> 생성한 리스트로 마커 생성
      for (var store in stores) {
        addMarker(
          Position(
              longitude: store.longitude ?? position.target.longitude,
              latitude: store.latitude ?? position.target.latitude,
              timestamp: timestamp,
              accuracy: accuracy,
              altitude: altitude,
              altitudeAccuracy: altitudeAccuracy,
              heading: heading,
              headingAccuracy: headingAccuracy,
              speed: speed,
              speedAccuracy: speedAccuracy),
          store.storeId.toString(),
          markerTitle: store.storeName.toString(),
          address: store.storeAddress.toString(),
          store: store,
        );
      }
    }).catchError((err) => print('store: ' + err.toString()));
    super.initState();
  }

  // 구글맵 컨트롤러
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  // 캐러셀 컨트롤러
  final CarouselController _carouselController = CarouselController();

  // 스토어 리스트
  List<Store> stores = [];

  // 캐러셀 리스트
  List<Widget> carouselItems = [];

  // 위치 이동 하는 함수
  Future<void> _goToPosition({double? latitude, double? longitude}) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            // bearing: 192.8334901395799,
            target: LatLng(latitude ?? position.target.latitude,
                longitude ?? position.target.longitude),
            // tilt: 59.440717697143555,
            zoom: 16)));
  }

  // 스토어 데이터
  Future<List<Store>> initializeData() async {
    final data = await FireStore.getNearbyStores(position.target.latitude, position.target.longitude);
    setState(() {
      stores = data;
    });
    print(stores);

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            // 제일 아래 구글맵
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: position,
              markers: Set<Marker>.of(markers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMove: (_) {},
              myLocationButtonEnabled: false,
              // 현재 위치를 중심으로 이동하는 버튼 표시 활성화
              myLocationEnabled: false,
              // 내 위치 블루 도트 활성화
              zoomControlsEnabled: false,
              // 확대 축소 버튼 활성화
              trafficEnabled: true,
              // 교통 상황 표시 활성화
              indoorViewEnabled: false,
              // 실내 맵 활성화
              compassEnabled: false,
              // 지도에 나침반 표시 활성화
              liteModeEnabled: false,
              // 단순화된 지도 렌더링 옵션 // 아이폰 안되고 안드 확대 축소 안됨
              // padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height), // 구글 로고 등 없애기
              buildingsEnabled: false,
              // 빌딩 그림자
              fortyFiveDegreeImageryEnabled: false,
              //  지도의 특정 지역에서 건물과 지형을 45도의 각도로 회전
              mapToolbarEnabled: false,
              //  "길찾기(Directions)", "주변에서 검색(Nearby Search)" 등의 옵션
              // onCameraIdle: , // 카메라가 멈췄을 때 동작
              // cameraTargetBounds: CameraTargetBounds.unbounded,
            ),
            // 캐러셀
            carousel(),
            // 구글 로고 가림
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 25.0,
                color: Colors.black,
              ),
            ),
            // 앱 바
            Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(0, 0, 0, 0.42), // 연하게
                        Colors.transparent,
                      ],
                      stops: [0.0, 1.0], // 11/20 수정됨 // 짧게
                    ),
                  ),
                  child: Column(
                    children: [
                      cudiAppTopSpace(),
                      const SizedBox(
                        height: 34.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24.0, vertical: 16.0),
                        child: nearAppBar(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget nearAppBar() {
    return SizedBox(
      height: 56.0.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 20.0,
            height: 20.0,
            margin: EdgeInsets.only(right: 22.0),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded,
                  color: black,
                  shadows: [
                Shadow(
                  color: Colors.white, // 그림자 색상
                  offset: Offset(1.0, 1.0), // 그림자 위치 (가로, 세로)
                  blurRadius: 3.0, // 그림자 흐림 정도
                ),
              ]),
            ),
          ),
          // icon: SvgPicture.asset(
          //     'assets/icon/ico-line-arrow-back-white.svg'))),
          const Text('내주변',
              style: TextStyle(
                color: black,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
                shadows: [
                  Shadow(
                    color: Colors.white, // 그림자 색상
                    offset: Offset(1.0, 1.0), // 그림자 위치 (가로, 세로)
                    blurRadius: 3.0, // 그림자 흐림 정도
                  ),
                  // BoxShadow(
                  //   color: Colors.black,
                  //   offset: Offset(2.0, 2.0),
                  //   blurRadius: 2.0,
                  // ),
                ],
              )),
          // 현위치 재설정 버튼
          SizedBox(
            width: 42.0,
            height: 42.0,
            child: FloatingActionButton(
              onPressed: () => {
              _getCurrentLocation().then((pos) {
              // -> 현재 위치 마커 생성
              addMarker(pos, 'currpos');
              cudiDialog(context, '현위치로 마커 재생성 성공: $pos', '닫기');
              _goToPosition(latitude: pos.latitude, longitude: pos.longitude);
              initializeData();
              }).catchError((err) => print('curr: ' + err.toString()))
              },
              child: Icon(Icons.location_searching_outlined, size: 20.0,),
              shape: CircleBorder(),
              backgroundColor: white,
            ),
          ),
        ],
      ),
    );
  }

  Widget carousel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        height: 320.0.h,
        // height: 295.0.h,
        // color: Colors.blue,
        child: CarouselSlider(
          carouselController: _carouselController,
          items: stores.map((store) => carouselItem(store)).toList(),
          options: CarouselOptions(
            enlargeCenterPage: true,
            enlargeFactor: 0.23,
            // 중심의 확대 비율. 기본값 1.0
            // enlargeStrategy: , // 확대를 어떻게 적용할지. 기본적으로 viewportFraction을 기반으로 한 정책이 사용됨
            // padEnds: , // 슬라이더의 끝에 여백을 추가할지 여부
            viewportFraction: 0.45,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) async {
              _goToPosition(
                  latitude: stores[index].latitude,
                  longitude: stores[index].longitude);
              final GoogleMapController controller = await _controller.future;
              controller.showMarkerInfoWindow(
                  MarkerId(stores[index].storeId.toString()));
            },
          ),
        ),
      ),
    );
  }

  Widget carouselItem(Store store) {
    int index = stores.indexOf(store);
    // final favoriteStoresProvider = Provider.of<FavoriteStoresProvider>(context);
    // favoriteStoresProvider.fetchData(widget.userEmailId);
    // bool isFavorite =
    //     favoriteStoresProvider.favoriteStores.containsKey(store.storeId);
    return InkWell(
      onTap: () async {
        _goToPosition(latitude: store.latitude, longitude: store.longitude);
        _carouselController.animateToPage(index);
        final GoogleMapController controller = await _controller.future;
        controller.showMarkerInfoWindow(MarkerId(store.storeId.toString()));
      },
      child: Container(
        width: 165.0.w,
        height: 247.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.3),
          image: DecorationImage(
            image: NetworkImage(store.storeImageUrl.toString()),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
                top: 16,
                left: 16,
                child: Text('${store.storeName}', style: s16w600)),
            heartIcon(store.storeId.toString()),
            threeDIcon(store),
          ],
        ),
      ),
    );
  }

  Widget heartIcon(String storeId) {
    return Positioned(
      right: 8.0,
      bottom: 48.0,
      child: HeartIcon(storeId: storeId, isPlain: false, isColumn: true,),
    );
  }

  Widget threeDIcon(Store store) {
    return Positioned(
        bottom: 8.0,
        right: 8.0,
        child: ThreeDIcon(storeThreeDUrl: store.storeThreeDUrl));
  }
}

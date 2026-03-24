import 'dart:async';
import 'package:clothing_ecommerce/features/bag/view_models/shipping_locations_cubit/shipping_locations_cubit.dart';
import 'package:clothing_ecommerce/features/bag/view_models/detect_location_cubit/detect_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapPage extends StatefulWidget {
  const OpenStreetMapPage({super.key});

  @override
  State<OpenStreetMapPage> createState() => _OpenStreetMapPageState();
}

class _OpenStreetMapPageState extends State<OpenStreetMapPage> {
  LatLng _currentPosition = const LatLng(30.0444, 31.2357);
  final MapController _mapController = MapController();
  late final DetectLocationCubit locationCubit;
  late final ShippingLocationsCubit shippingLocationCubit;
  bool _isMoving = false;
  Timer? _movementTimer;
  String _currentAddress = "";
  @override
  void initState() {
    super.initState();
    locationCubit = context.read<DetectLocationCubit>();
    shippingLocationCubit = context.read<ShippingLocationsCubit>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        locationCubit.getCurrentLocation();
      }
    });
  }

  @override
  void dispose() {
    _movementTimer?.cancel();
    super.dispose();
  }

  //Geocoding
  Future<void> _getAddressFromLatLng(LatLng position) async {
    try {
      // نطلب من المكتبة تحويل الإحداثيات إلى عنوان
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (!mounted) return;
      Placemark place = placemarks[0];
      setState(() {
        // تجميع العنوان من أجزاء مختلفة (شارع، مدينة، دولة)
        _currentAddress =
            "${place.street}, ${place.locality}, ${place.country}";
        // تنظيف العنوان إذا كانت بعض الأجزاء null
        if (_currentAddress.contains("null")) {
          _currentAddress =
              "${place.name ?? ''} ${place.locality ?? ''} ${place.country ?? ''}"
                  .trim();
        }
        if (_currentAddress.isEmpty || _currentAddress == ", , ") {
          _currentAddress = "تم تحديد الموقع بنجاح";
        }
      });
      debugPrint("✅ Address Found: $_currentAddress");
    } catch (e) {
      debugPrint("❌ Error getting address: $e");
      if (mounted) {
        setState(() {
          _currentAddress = "تعذر جلب اسم الشارع (تحقق من الإنترنت)";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Choose Your Location",
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(color: colorScheme.primary),
        ),
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.my_location, color: colorScheme.primary),
            onPressed: () {
              locationCubit.getCurrentLocation();
            },
          ),
        ],
      ),
      backgroundColor: colorScheme.surfaceContainerHighest,
      body: BlocConsumer<DetectLocationCubit, DetectLocationState>(
        bloc: locationCubit,
        listener: (context, state) {
          if (state is DetectLocationSuccess) {
            _mapController.move(state.location, 16.0);
            setState(() {
              _currentPosition = state.location;
            });
          } else if (state is DetectLocationError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        buildWhen: (previous, current) =>
            current is DetectLocationLoading ||
            current is DetectLocationSuccess ||
            current is DetectLocationError,
        builder: (context, state) {
          if (state is DetectLocationLoading &&
              _currentPosition.latitude == 30.0444) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }
          return FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(30.0444, 31.2357),
              initialZoom: 13.0,
              interactionOptions: InteractionOptions(
                flags: InteractiveFlag.all,
              ),
              onPositionChanged: (position, hasGesture) {
                // 1. تحديث الموقع دائماً
                setState(() {
                  _currentPosition = position.center;
                  _currentAddress =
                      "Loading ..."; // عرض رسالة تحميل أثناء الحركة
                  _isMoving = true; // نفترض أننا نتحرك طالما الدالة تُستدعى
                });
                // 2. إلغاء المؤقت السابق (لأن هناك حركة جديدة)
                _movementTimer?.cancel();
                // 3. بدء مؤقت جديد: إذا لم تُستدعَ هذه الدالة خلال 500 مللي ثانية،  توقفنا
                _movementTimer = Timer(const Duration(milliseconds: 800), () {
                  if (mounted) {
                    setState(() {
                      _isMoving = false; // هنا نتأكد من التوقف الحقيقي
                    });
                    _getAddressFromLatLng(_currentPosition);
                  }
                });
              },
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                // to avoid CORS issues, you can set a user agent (not required for all tile providers)
                userAgentPackageName: 'com.example.clothing_ecommerce',
                maxNativeZoom: 19,
                tileDimension: 256,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _currentPosition,
                    width: 40,
                    height: 40,
                    child: Icon(
                      Icons.location_on,
                      color: colorScheme.primary,
                      size: 40,
                    ),
                  ),
                ],
              ),
              // ✅ الشريط السفلي الذكي
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: size.width,
                  height: size.height * 0.2,
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(size.width * 0.1),
                      topRight: Radius.circular(size.width * 0.1),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.secondary,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentAddress,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: colorScheme.onSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: size.height * 0.02),
                      AnimatedContainer(
                        width: size.width * 0.8,
                        height: size.height * 0.08,
                        duration: const Duration(milliseconds: 500),
                        decoration: BoxDecoration(
                          color: _isMoving
                              ? colorScheme.onSurface
                              : colorScheme.primary,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.secondary,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child:
                            BlocListener<
                              ShippingLocationsCubit,
                              ShippingLocationsState
                            >(
                              bloc: shippingLocationCubit,
                              listenWhen: (previous, current) =>
                                  current is AddNewLocationFailure ||
                                  current is AddNewLocationSuccess,
                              listener: (context, state) {
                                if (state is AddNewLocationSuccess) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else if (state is AddNewLocationFailure) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.errorMessage)),
                                  );
                                }
                              },
                              child: InkWell(
                                onTap: () {
                                  shippingLocationCubit.addNewLocation(
                                    _currentAddress,
                                  );
                                },
                                child:
                                    BlocBuilder<
                                      ShippingLocationsCubit,
                                      ShippingLocationsState
                                    >(
                                      bloc: shippingLocationCubit,
                                      buildWhen: (previous, current) =>
                                          current is AddNewLocationLoading ||
                                          current is AddNewLocationSuccess ||
                                          current is AddNewLocationFailure,
                                      builder: (context, state) {
                                        if (state is AddNewLocationLoading) {
                                          return Center(
                                            child: CircularProgressIndicator(
                                              color: colorScheme.surface,
                                            ),
                                          );
                                        } else if (state
                                            is AddNewLocationFailure) {
                                          return Text(
                                            "Failed to add location",
                                            style: TextStyle(
                                              color: colorScheme.error,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          );
                                        }
                                        return SizedBox(
                                          width: size.width * 0.8,
                                          height: size.height * 0.05,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (_isMoving)
                                                SizedBox(
                                                  width: 16,
                                                  height: 16,
                                                  child:
                                                      CircularProgressIndicator(
                                                        strokeWidth: 2,
                                                        color:
                                                            colorScheme.surface,
                                                      ),
                                                ),
                                              SizedBox(
                                                width: size.width * 0.02,
                                              ),
                                              Text(
                                                _isMoving
                                                    ? "loading ..."
                                                    : "Add Location",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(
                                                      color:
                                                          colorScheme.surface,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                              ),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

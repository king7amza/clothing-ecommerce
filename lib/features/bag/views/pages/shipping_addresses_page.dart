import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/bag/view_models/shipping_locations_cubit/shipping_locations_cubit.dart';
import 'package:clothing_ecommerce/features/bag/views/widgets/choose_address_method_widget.dart';
import 'package:clothing_ecommerce/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShippingAddressesPage extends StatefulWidget {
  const ShippingAddressesPage({super.key});

  @override
  State<ShippingAddressesPage> createState() => _ShippingAddressesPageState();
}

class _ShippingAddressesPageState extends State<ShippingAddressesPage>
    with RouteAware {
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  // final TextEditingController cityController = TextEditingController();
  // final TextEditingController stateController = TextEditingController();
  // final TextEditingController countryController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // اشترك في مراقبة الـ Route عشان تعرف متى ترجع الصفحة للظهور
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    // مهم جداً: افصل الاشتراك عشان متحصلش على Memory Leak
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  // الدالة دي بتشتغل لما الصفحة تظهر تاني (بعد ما تعمل Pop من صفحة الخريطة)
  @override
  void didPopNext() {
    debugPrint("👋 صفحة العناوين رجعت للظهور! هجيب البيانات الجديدة.");
    _loadData(); // استدعي دالة جلب البيانات هنا
  }

  @override
  void initState() {
    super.initState();
    _loadData(); // جلب البيانات أول مرة عند الفتح
  }

  void _loadData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ShippingLocationsCubit>().fetchShippingLocations();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ShippingLocationsCubit shippingLocationsCubit = context
        .read<ShippingLocationsCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shipping Address",
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: AppColors.lightGrey1,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width * 0.04,
            right: size.width * 0.04,
            top: size.height * 0.03,
            bottom: size.height * 0.03,
          ),
          child: Stack(
            children: [
              Text(
                "Your Shipping Address",
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              BlocBuilder<ShippingLocationsCubit, ShippingLocationsState>(
                bloc: shippingLocationsCubit,
                buildWhen: (previous, current) =>
                    current is ShippingLocationInitial ||
                    current is ShippingLocationsFetched ||
                    current is ShippingLocationsError ||
                    current is FetchingShippingLocations,
                builder: (context, state) {
                  if (state is FetchingShippingLocations) {
                    return Center(
                      child: const CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  } else if (state is ShippingLocationsError) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.red),
                      ),
                    );
                  } else if (state is ShippingLocationsFetched) {
                    final shippingLocations = state.shippingLocations;
                    if (shippingLocations.isEmpty) {
                      return Center(
                        child: Image.asset(
                          "assets/images/payments_images/empty_locations.png",
                          width: size.width * 0.5,
                          height: size.height * 0.5,
                          fit: BoxFit.contain,
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.only(top: size.height * 0.05),
                      child: ListView.builder(
                        itemCount: shippingLocations.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * 0.07,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(
                                  size.height * 0.02,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * 0.04,
                                      right: size.width * 0.04,
                                      top: size.height * 0.01,
                                      bottom: size.height * 0.02,
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/payments_images/location_icon2.png",
                                              width: size.width * 0.14,
                                              height: size.height * 0.14,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(width: size.width * 0.05),
                                            SizedBox(
                                              width: size.width * 0.6,
                                              child: Text(
                                                shippingLocations[index]
                                                    .address,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall!
                                                    .copyWith(
                                                      color: AppColors.black,
                                                    ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Row(
                                          children: [
                                            Container(
                                              width: size.width * 0.07,
                                              height: size.height * 0.04,
                                              decoration: BoxDecoration(
                                                color: AppColors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: size.width * 0.08),
                                            Text(
                                              "Use as Default Address",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall!
                                                  .copyWith(
                                                    color: AppColors.black,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                  return Image.asset(
                    "assets/images/payments_images/empty_locations.png",
                    width: size.width * 0.5,
                    height: size.height * 0.5,
                    fit: BoxFit.contain,
                  );
                },
              ),
              Positioned(
                bottom: 20,
                right: 0,
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColors.lightGrey1,
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.7,
                      ),
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.04,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: size.height * 0.02),
                                Container(
                                  width: size.width * 0.15,
                                  height: size.height * 0.008,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey,
                                    borderRadius: BorderRadius.circular(
                                      size.height * 0.004,
                                    ),
                                  ),
                                ),
                                SizedBox(height: size.height * 0.03),
                                Text(
                                  "Choose address method",
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineMedium,
                                ),
                                SizedBox(height: size.height * 0.1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ChooseAddressMethodWidget(
                                      imagePath:
                                          "assets/images/payments_images/write_icon.png",
                                      title: "write address",
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(context, "/map");
                                      },
                                      child: ChooseAddressMethodWidget(
                                        imagePath:
                                            "assets/images/payments_images/location_icon.png",
                                        title: "using map",
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(size.height * 0.025),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(size.height * 0.07),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: AppColors.white,
                        size: size.height * 0.04,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

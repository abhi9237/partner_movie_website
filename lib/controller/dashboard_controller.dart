import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:partner_dashboard_web_app/common/app_font/app_font.dart';
import 'package:partner_dashboard_web_app/common/common_widget/common_widget.dart';
import 'package:partner_dashboard_web_app/config/route_constant/route_constant.dart';
import 'package:partner_dashboard_web_app/model/common/result.dart';
import 'package:partner_dashboard_web_app/model/response/toke_invalid_response.dart';
import 'package:partner_dashboard_web_app/presentation/dashboard/repo/dasboard_repo.dart';
import '../common/common_methods/common_methods.dart';
import '../core/bar_data/bar_data.dart';
import '../model/response/partner_detail_response.dart';
import '../model/response/partner_movie_detail_reponse.dart';
import '../model/response/partner_movie_response.dart';

class DashBoardController extends GetxController {
  BuildContext context;
  DashBoardController({required this.context});
  Rx<TextEditingController> searchController = TextEditingController().obs;

  DashboardRepository dashboardRepository = DashboardRepository();
  Color backGroundColor = Colors.transparent;
  var hoverIndex = -1.obs;
  var selectedDateRange = Rxn<DateTimeRange>();
  var selectedDrawerIndex = 0.obs;
  RxBool isShowProductDetail = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingProductDetail = false.obs;
  RxList<Results> partnerMoviesList = <Results>[].obs;
  List<Results> dummyPartnerMoviesList = <Results>[];
  RxMap<String, dynamic> weeklyWatchTimeList = <String, dynamic>{}.obs;
  Rx<PartnerDetailResponse> partnerDetailData = PartnerDetailResponse().obs;
  Rx<PartnerMovieDetailResponse> partnerMovieDetailData =
      PartnerMovieDetailResponse().obs;
  RxBool isShowCloseButton = false.obs;
  RxString selectedProductId = '0'.obs;
  Rx<DateTime> initialFilterData = DateTime(2020).obs;
  RxString selectedStartDate = ''.obs;
  RxString selectedEndDate = ''.obs;

  List<BarData> earningsBarData = [];

  @override
  void onInit() {
    super.onInit();
    getDashBoardData();
    getPartnerDetail();
  }

  Future<void> getDashBoardData({String? startDate, String? endDate}) async {
    isLoading.value = true;
    dummyPartnerMoviesList.clear();
    try {
      var response = await dashboardRepository.getDashBoardData(
        startDate: startDate ?? '',
        endDate: endDate ?? '',
      );
      log("Response Data: $response");
      final PartnerMoviesResponse result = PartnerMoviesResponse.fromJson(
        response.data,
      );
      if (response.statusCode == 200) {
        partnerMoviesList.value = result.results ?? [];
        dummyPartnerMoviesList.assignAll(result.results ?? []);
      } else {
        if (response.statusCode == 401) {
          final TokenInvalidResponse result = TokenInvalidResponse.fromJson(
            response.data,
          );
          showToastMessage(context, result.detail ?? '');
          context.go(RouteConstant.login);
        }
      }
    } catch (e) {
      showToastMessage(context, 'Server Error');
      log(e.toString());
    } finally {
      isLoading.value = false;
    }

    update();
  }

  Future<void> getPartnerDetail() async {
    isLoading.value = true;
    try {
      var response = await dashboardRepository.getPartnerDetail();
      log("Response Data: $response");
      final PartnerDetailResponse result = PartnerDetailResponse.fromJson(
        response.data,
      );
      if (response.statusCode == 200) {
        partnerDetailData.value = result;

        log('   partnerDetailData.value-==>${partnerDetailData.value}');
      } else {
        if (response.statusCode == 401) {
          final TokenInvalidResponse result = TokenInvalidResponse.fromJson(
            response.data,
          );
          showToastMessage(context, result.detail ?? '');
          context.go(RouteConstant.login);
        }
      }
    } catch (e) {
      showToastMessage(context!, 'Server Error');
      log(e.toString());
    } finally {
      isLoading.value = false;
    }

    update();
  }

  List<BarData> buildWeeklyBarData(Map<String, dynamic> apiData) {
    final sortedEntries = apiData.entries.toList();

    return List.generate(apiData.length, (index) {
      final entry = sortedEntries[index];
      return BarData(x: index, y: entry.value.toDouble(), label: entry.key);
    });
  }

  Future<void> getProductDetail(
    String id, {
    String? startDate,
    String? endDate,
  }) async {
    isLoadingProductDetail.value = true;
    try {
      var response = await dashboardRepository.getProductDetail(
        id,
        startDate: startDate ?? '',
        endDate: endDate ?? '',
      );
      log("Response Data: $response");
      final PartnerMovieDetailResponse result =
          PartnerMovieDetailResponse.fromJson(response.data);
      if (response.statusCode == 200) {
        partnerMovieDetailData.value = result;
        initialFilterData.value = DateTime.parse(
          partnerMovieDetailData.value.created ?? '',
        );

        if (startDate == null && endDate == null) {
          getLast30DaysRangeFromYesterday();
        }
        if (result.watchMinutesGraph != null) {
          weeklyWatchTimeList.value = convertToWeekdayMap(
            result.watchMinutesGraph!.toJson(),
          );
        }
      } else {
        if (response.statusCode == 401) {
          final TokenInvalidResponse result = TokenInvalidResponse.fromJson(
            response.data,
          );
          showToastMessage(Get.context!, result.detail ?? '');
        }
      }
    } catch (e) {
      showToastMessage(Get.context!, 'Server Error');
      log(e.toString());
    } finally {
      isLoadingProductDetail.value = false;
    }

    update();
  }

  void onTapSelectDrawer(int index) {
    selectedDrawerIndex.value = index;

    update();
  }

  void getLast30DaysRangeFromYesterday() {
    final DateTime endDate = DateTime.now().subtract(const Duration(days: 1));

    final DateTime startDate = endDate.subtract(const Duration(days: 30));

    selectedStartDate.value = DateFormat('d/MMM/yyyy').format(startDate);
    selectedEndDate.value = DateFormat('d/MMM/yyyy').format(endDate);

    update();
  }

  void onEnter(PointerEnterEvent v, int index) {
    hoverIndex = index;
    backGroundColor = Colors.blueAccent.withOpacity(0.1);
    update();
  }

  void onExit(PointerExitEvent v, int index) {
    hoverIndex = index;
    backGroundColor = Colors.transparent;
    update();
  }

  void onTapItem(BuildContext context, String id) {
    isShowProductDetail.value = true;
    partnerMoviesList.value = List.from(dummyPartnerMoviesList);
    selectedProductId.value = id;
    selectedDateRange.value = null;
    getProductDetail(id);
    update();
  }

  void onTapProductBackButton() {
    isShowProductDetail.value = false;
    update();
  }

  void selectDateRange(BuildContext context, String? id) async {
    var picked = await showDateRangePicker(
      context: context,
      initialDateRange: selectedDateRange.value,
      firstDate: isShowProductDetail.value == true
          ? initialFilterData.value
          : DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 500.0,
                maxHeight: 500.0,
              ),
              child: Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.blueAccent,
                  colorScheme: const ColorScheme.light(
                    primary: Colors.blueAccent,
                  ),
                  buttonTheme: const ButtonThemeData(
                    textTheme: ButtonTextTheme.primary,
                  ),
                ),
                child: child!,
              ),
            ),
          ),
        );
      },
    );

    if (picked != null && picked != selectedDateRange.value) {
      selectedDateRange.value = picked;

      if (isShowProductDetail.value == true) {
        selectedStartDate.value = DateFormat(
          'd/MMM/yyyy',
        ).format(selectedDateRange.value!.start);
        selectedEndDate.value = DateFormat(
          'd/MMM/yyyy',
        ).format(selectedDateRange.value!.end);
        log('selectedStartDate.value===> ${selectedStartDate.value}');
        update();
      }
      getProductDetail(
        id ?? '0',
        startDate: DateFormat(
          'yyyy-MM-dd',
        ).format(selectedDateRange.value!.start),
        endDate: DateFormat('yyyy-MM-dd').format(selectedDateRange.value!.end),
      );

      log('  selectedDateRange.value==> ${selectedDateRange.value}');
      update();
    }
  }

  String get dateRangeText {
    if (selectedDateRange.value == null) {
      return "Select Date";
    } else {
      final start = DateFormat(
        'MMM/d/yyyy',
      ).format(selectedDateRange.value!.start);
      final end = DateFormat('MMM/d/yyyy').format(selectedDateRange.value!.end);
      return "$start - $end";
    }
  }

  void onChangedTextFilled(String query) {
    log('${query}');
    if (query.isEmpty) {
      partnerMoviesList.assignAll(dummyPartnerMoviesList);
      isShowCloseButton.value = false;
    } else {
      final filteredList = partnerMoviesList.where((movie) {
        final movieTitle = movie.title?.toLowerCase() ?? '';
        final searchQuery = query.toLowerCase();

        return movieTitle.contains(searchQuery);
      }).toList();
      isShowCloseButton.value = true;
      partnerMoviesList.assignAll(filteredList);
    }
    update();
  }

  void onTapCloseTextFilled() {
    searchController.value.clear();
    partnerMoviesList.value = List.from(dummyPartnerMoviesList);
    isShowCloseButton.value = false;

    update();
  }
}

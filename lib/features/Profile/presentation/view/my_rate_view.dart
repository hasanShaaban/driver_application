import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:driver_application/features/Profile/presentation/manager/ratings_cubit/ratings_cubit.dart';
import 'package:driver_application/features/Profile/presentation/manager/ratings_cubit/ratings_state.dart';
import 'package:driver_application/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class MyRateView extends StatelessWidget {
  const MyRateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
        title: Text(
          'تقييماتي',
          style: AppTextStyle.medium18.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<RatingsCubit, RatingsState>(
        builder: (context, state) {
          if (state is RatingsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RatingsFailure) {
            return Center(child: Text(state.errMessage));
          } else if (state is RatingsSuccess) {
            final ratingsData = state.ratingsResponse.data;
            final ratings = ratingsData?.ratings ?? [];
            final totalRatings = ratingsData?.pagination?.total ?? 0;
            
            String averageRatingStr = '0.0';
            if (ratings.isNotEmpty) {
              final avg = ratings.first.ratee?.driverProfile?.ratingInfo?.averageRating;
              if (avg != null) {
                final doubleAvg = double.tryParse(avg);
                if (doubleAvg != null) {
                  averageRatingStr = doubleAvg.toStringAsFixed(1);
                }
              }
            }

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(Assets.iconsFilledStar, width: 60, height: 60),
                      Text(
                        averageRatingStr,
                        style: AppTextStyle.bold20.copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    '$totalRatings تقييم',
                    style: AppTextStyle.medium14.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 47),
                  Expanded(
                    child: ListView.separated(
                      itemCount: ratings.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                      itemBuilder: (context, index) {
                        final rating = ratings[index];
                        final raterName = rating.rater?.fullName ?? 'عميل غير معروف';
                        
                        String dateStr = '';
                        if (rating.createdAt != null) {
                          try {
                            final date = DateTime.parse(rating.createdAt!);
                            dateStr = DateFormat('yyyy-MM-dd').format(date);
                          } catch (e) {
                            dateStr = rating.createdAt!;
                          }
                        }

                        final int rateValue = rating.rating ?? 0;

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$raterName  $dateStr',
                                    style: AppTextStyle.medium14,
                                  ),
                                  Spacer(),
                                  ...List.generate(rateValue, (index) {
                                    return Row(
                                      children: [
                                        SvgPicture.asset(
                                          Assets.iconsFilledStar,
                                          width: 14,
                                        ),
                                        SizedBox(width: 4),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                              SizedBox(height: 10),
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.centerRight,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withAlpha(128),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: Text(
                                  rating.comment ?? 'لا يوجد تعليق',
                                  style: AppTextStyle.medium14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

import 'package:driver_application/core/utils/app_colors.dart';
import 'package:driver_application/core/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:driver_application/features/Profile/presentation/manager/profits_cubit/profits_cubit.dart';
import 'package:driver_application/features/Profile/presentation/manager/profits_cubit/profits_state.dart';

class ProfitsView extends StatelessWidget {
  const ProfitsView({super.key});
  final Map<String, String> statusMapper = const {
    'delivered': 'تم التوصيل',
    'cancelled_by_driver': 'ألغيت من قبل السائق',
    'cancelled_by_merchant': 'ألغيت من قبل التاجر',
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الأرباح', style: AppTextStyle.medium18),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.appBarColor,
      ),
      body: SafeArea(
        child: BlocBuilder<ProfitsCubit, ProfitsState>(
          builder: (context, state) {
            if (state is ProfitsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProfitsFailure) {
              return Center(
                child: Text(
                  state.errMessage,
                  style: TextStyle(color: Colors.red),
                ),
              );
            } else if (state is ProfitsSuccess) {
              // Just keeping the UI structure for now, without filling data
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final profit = state.profitsModel.data?.profits?[index];
                  final marhant = profit?.merchant;
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: profit?.status == 'delivered'
                          ? AppColors.successColor
                          : AppColors.failedColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 15,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10),

                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                              color: Colors.white,
                            ),

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 46,
                                  height: 46,
                                  margin: EdgeInsets.only(left: 12),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade200,
                                    image:
                                        marhant?.profilePictureUrl != null &&
                                            marhant!
                                                .profilePictureUrl!
                                                .isNotEmpty
                                        ? DecorationImage(
                                            image: NetworkImage(
                                              marhant.profilePictureUrl!,
                                            ),
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'الاسم: ${marhant?.fullName ?? "-"}',
                                            style: AppTextStyle.bold15.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          Spacer(),
                                          Text(
                                            'رقم الطلب : ${profit?.shipmentId ?? "-"}',
                                            style: AppTextStyle.bold15.copyWith(
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                        ],
                                      ),

                                      SizedBox(height: 4),
                                      Text(
                                        'رقم العميل: ${marhant?.phoneNumber ?? "-"}',
                                        style: AppTextStyle.medium12,
                                      ),
                                      Divider(color: Colors.grey, thickness: 1),
                                      Text(
                                        'الكلفة الكاملة : ${profit?.totalPrice ?? "-"} ل.س',
                                        style: AppTextStyle.medium14,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'عمولة التطبيق : ${profit?.appShare ?? "-"} ل.س',
                                        style: AppTextStyle.medium14,
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        'صافي الربح : ${profit?.pureProfit ?? "-"} ل.س',
                                        style: AppTextStyle.bold14,
                                      ),
                                      SizedBox(height: 4),
                                      Divider(color: Colors.grey, thickness: 1),
                                      Row(
                                        children: [
                                          Text(
                                            'حالة الطلب:',
                                            style: AppTextStyle.bold15,
                                          ),
                                          Spacer(),
                                          Text(
                                            statusMapper[profit?.status] ?? "",
                                            style: AppTextStyle.bold15.copyWith(
                                              color:
                                                  profit?.status == "delivered"
                                                  ? AppColors.successColor
                                                  : AppColors.failedColor,
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
                        ),
                      ],
                    ),
                  );
                },
                itemCount: state.profitsModel.data?.profits?.length ?? 0,
              );
            }
            return Center(child: Text('Unexpected State'));
          },
        ),
      ),
    );
  }
}

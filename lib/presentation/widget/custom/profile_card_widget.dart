import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';

import '../../../constant/color_constant.dart';
import '../../../constant/service_api_constant.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({
    super.key,
    required this.name,
    required this.age,
    required this.sport,
    required this.hobbies,
    required this.userId,
  });

  final String? name;
  final int? age;
  final String? sport;
  final String? hobbies;
  final String? userId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (userId != null) {
          BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(userId!));
        }
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Age Row
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      if (name != null)
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          child: Text(
                            name!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: themeColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      const Spacer(),
                      if (age != null)
                        Text(
                          '$age Yrs',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: green,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                // Sport
                if (sport != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sports: ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: themeColorLight,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          sport!,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                // Hobbies
                if (hobbies != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hobbies: ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: themeColorLight,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          hobbies!,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                // Chevron icon
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      if (userId != null) {
                        BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(userId!));
                      }
                    },
                    icon: Icon(
                      Icons.chevron_right_sharp,
                      color: themeColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(8, 16, 8, 8),
            child: Divider(
              thickness: 0.4,
              color: themeColorLight,
            ),
          ),
        ],
      ),
    );
  }
}

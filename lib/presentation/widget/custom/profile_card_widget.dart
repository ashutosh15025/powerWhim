import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:powerwhim/presentation/bloc/profilebloc/profilebloc_bloc.dart';

import '../../../constant/color_constant.dart';
import '../../../constant/service_api_constant.dart';


class ProfileCardWidget extends StatefulWidget {
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
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  bool _isTapped = false;

  void _handleTap(BuildContext context) {
    if (_isTapped || widget.userId == null) return;

    setState(() {
      _isTapped = true;
    });

    BlocProvider.of<ProfileblocBloc>(context).add(getFullProfileEvent(widget.userId!));

    // Optional: re-enable tap after some delay (if necessary)
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isTapped = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isTapped ? null : () => _handleTap(context),
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
                      if (widget.name != null)
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.75,
                          ),
                          child: Text(
                            widget.name!,
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
                      const Spacer()
                    ],
                  ),
                ),
                // Sport
                if (widget.sport != null)
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
                          widget.sport!,
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
                if (widget.hobbies != null)
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
                          widget.hobbies!,
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
                    onPressed: () => _handleTap(context),
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

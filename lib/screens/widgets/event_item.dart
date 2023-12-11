import 'package:eventcircle/models/event.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EventItem extends StatelessWidget {
  const EventItem({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/eventDetails', arguments: event.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 21),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF575C8A).withOpacity(0.06),
              blurRadius: 35,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                event.bannerImage,
                width: 85,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.getFormattedDateTime(),
                      style: GoogleFonts.inter(
                        color: const Color(0xFF5669FF),
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      )),
                  const SizedBox(height: 4),
                  Text(
                    event.title,
                    style: GoogleFonts.inter(
                      color: const Color(0xFF120D26),
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Iconsax.location4,
                        color: Color(0xFF747688),
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          "${event.venueName} • ${event.venueCity}",
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.inter(
                            color: const Color(0xFF747688),
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

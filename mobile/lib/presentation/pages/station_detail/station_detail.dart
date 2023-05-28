import 'package:charge_station_finder/application/charger_detail/charger_detail_bloc.dart';
import 'package:charge_station_finder/domain/review/review.dart';
import 'package:charge_station_finder/presentation/pages/station_detail/widgets/rating_bar.dart';
import 'package:charge_station_finder/presentation/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../application/auth/auth_bloc.dart';
import '../../../domain/charger/charger_detail.dart';

class StationDetail extends StatefulWidget {
  final String id;

  const StationDetail({super.key, required this.id});

  @override
  _StationDetailState createState() => _StationDetailState();
}

class _StationDetailState extends State<StationDetail> {
  String? currentEditReviewId;
  bool isLoaded = false;
  ChargerDetail detail = const ChargerDetail(
    id: "",
    name: "",
    address: "",
    description: "",
    phone: "",
    rating: -1,
    wattage: -1,
    reviews: [],
    hasUserRated: false,
    user: "",
    userVote: -1,
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChargerDetailBloc(
        chargerRepository: context.read(),
        reviewRepository: context.read(),
      )..add(ChargerDetailEventLoad(widget.id)),
      child: BlocConsumer<ChargerDetailBloc, ChargerDetailState>(
        listener: (context, state) {
          isLoaded |= state is ChargerDetailStateLoaded;
          if (state is ChargerDetailStateLoaded) {
            detail = state.charger;
          } else if (state is ChargerDetailStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is ChargerDetailStateChargerDeleted) {
            context.go(AppRoutes.Home);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Station Detail'),
              actions: (isLoaded &&
                      detail.user ==
                          (context.read<AuthenticationBloc>().state
                                  as AuthenticationStateAuthenticated)
                              .userData!
                              .user
                              .id)
                  ? [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          context.pushNamed(AppRoutes.AddStation,
                              queryParameters: {
                                'id': detail.id,
                              });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<ChargerDetailBloc>()
                              .add(ChargerDetailEventDeleteCharger(detail.id));
                        },
                      ),
                    ]
                  : [],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is ChargerDetailStateLoading)
                    const LinearProgressIndicator(),
                  if (state is ChargerDetailStateLoaded || isLoaded)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            detail.name,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            detail.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 16.0),
                          Text(
                            'Address',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            detail.address,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Phone',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            detail.phone,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8.0),
                          RatingBar(
                            rating: detail.rating,
                            onRatingUpdate: (rating) {
                              context.read<ChargerDetailBloc>().add(
                                  ChargerDetailEventRateCharger(
                                      widget.id, rating));
                            },
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.bolt,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                "${detail.wattage.toStringAsFixed(0)}W",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          ReviewHeader(
                            onPost: (content) {
                              context.read<ChargerDetailBloc>().add(
                                  ChargerDetailEventPostReview(
                                      widget.id, content));
                            },
                          ),
                          const SizedBox(height: 16),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: detail.reviews.length,
                            itemBuilder: (context, idx) {
                              return ReviewCard(
                                review: detail.reviews[idx],
                                currentEditReviewId: currentEditReviewId,
                                setEditReviewId: (value) {
                                  setState(() {
                                    currentEditReviewId = value;
                                  });
                                },
                                onDeleteReview: () {
                                  context.read<ChargerDetailBloc>().add(
                                      ChargerDetailEventDeleteReview(
                                          detail.reviews[idx].id));
                                },
                                onUpdateReview: (String content) {
                                  context.read<ChargerDetailBloc>().add(
                                      ChargerDetailEventUpdateReview(
                                          detail.reviews[idx].id, content));
                                },
                              );
                            },
                          )
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
}

class ReviewCard extends StatefulWidget {
  final String? currentEditReviewId;
  final Function(String?) setEditReviewId;

  final Review review;

  final Function() onDeleteReview;

  final Function(String content) onUpdateReview;

  const ReviewCard({
    super.key,
    this.currentEditReviewId,
    required this.setEditReviewId,
    required this.review,
    required this.onDeleteReview,
    required this.onUpdateReview,
  });

  @override
  _ReviewCardState createState() => _ReviewCardState();
}

class _ReviewCardState extends State<ReviewCard> {
  final editReviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person_rounded,
                        size: 32,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.review.userName,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                  if ((context.read<AuthenticationBloc>().state
                              as AuthenticationStateAuthenticated)
                          .userData!
                          .user
                          .id ==
                      widget.review.userId)
                    PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          if (widget.currentEditReviewId == null)
                            const PopupMenuItem(
                              value: 1,
                              child: Text("Edit"),
                            ),
                          const PopupMenuItem(
                            value: 2,
                            child: Text("Delete"),
                          ),
                        ];
                      },
                      onSelected: (value) {
                        if (value == 1) {
                          editReviewController.text = widget.review.content;
                          widget.setEditReviewId(widget.review.id);
                        } else if (value == 2) {
                          widget.onDeleteReview();
                        }
                      },
                    )
                ],
              ),
              const SizedBox(height: 8),
              if (widget.currentEditReviewId != widget.review.id)
                Text(widget.review.content),
              if (widget.currentEditReviewId == widget.review.id)
                TextField(
                  controller: editReviewController,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              if (widget.currentEditReviewId == widget.review.id)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        editReviewController.clear();
                        widget.setEditReviewId(null);
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onUpdateReview(editReviewController.text);
                        editReviewController.clear();
                        widget.setEditReviewId(null);
                      },
                      child: const Text("Save"),
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

class ReviewHeader extends StatefulWidget {
  final Function onPost;

  const ReviewHeader({super.key, required this.onPost});

  @override
  State<ReviewHeader> createState() => _ReviewHeaderState();
}

class _ReviewHeaderState extends State<ReviewHeader> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var onPost = widget.onPost;

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: Theme.of(context).colorScheme.surfaceVariant,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            children: [
              TextFormField(
                controller: controller,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Write a review',
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedBuilder(
                    builder: (context, widget) {
                      return FilledButton(
                        onPressed: controller.text.isEmpty
                            ? null
                            : () {
                                onPost(controller.text);
                                controller.clear();
                              },
                        child: const Text('Post'),
                      );
                    },
                    animation: controller,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

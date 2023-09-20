import 'package:flutter/material.dart';
import 'package:flutter_application_2/constant/enums.dart';
import 'package:flutter_application_2/pages/add_person/add_person_page.dart';
import 'package:flutter_application_2/pages/edit_person/edit_person_page.dart';
import 'package:flutter_application_2/pages/edit_person/logic/bloc/edit_user_bloc.dart';
import 'package:flutter_application_2/pages/home/logic/bloc/home_bloc.dart';
import 'package:flutter_application_2/pages/home/model/home_model.dart';
import 'package:flutter_application_2/tools/loading_widget.dart';
import 'package:flutter_application_2/tools/media_query.dart';
import 'package:flutter_application_2/tools/responsive.dart';
import 'package:flutter_application_2/tools/style/shapes.dart';
import 'package:flutter_application_2/tools/theme/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    context.read<HomeBloc>().add(FetchDataHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var countPerson = 0;
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.homeEvent is CompletedHomeEvent) {
          final CompletedHomeEvent event =
              state.homeEvent as CompletedHomeEvent;
          countPerson = event.personModel.length;
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () =>
                Navigator.pushNamed(context, AddPersonPage.screenId),
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: Text(countPerson.toString()),
            actions: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.homeEvent is CompletedHomeEvent) {
                    final CompletedHomeEvent event =
                        state.homeEvent as CompletedHomeEvent;
                    return event.personModel.isEmpty
                        ? Container()
                        : TextButton.icon(
                            onPressed: () {
                              context.read<EditUserBloc>().add(DeleteAllUser());
                              context
                                  .read<HomeBloc>()
                                  .add(FetchDataHomeEvent());
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.redAccent,
                            ),
                            label: const Text("حذف دسته جمعی"),
                          );
                  }
                  return Container();
                },
              ),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: getShapeWidget(10),
                      backgroundColor: Colors.white,
                      useSafeArea: true,
                      builder: (context) {
                        return Container(
                          width: getAllWidth(context),
                          height: Responsive.isMobile(context) ? 250 : 320,
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 0.05),
                              vertical: getWidth(context, 0.02)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("مرتب سازی بر اساس نام",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                onTap: () {
                                  context.read<HomeBloc>().add(
                                      SortPersonEvent(sort: Sort.sortByName));
                                  Navigator.pop(context);
                                },
                              ),
                              ListTile(
                                title: Text(" مرتب سازی بر اساس نام خانوادگی",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                onTap: () {
                                  context.read<HomeBloc>().add(SortPersonEvent(
                                      sort: Sort.sortByLastName));
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.search_rounded)),
            ],
          ),
          body: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state.homeEvent is LoadingDataHomeEvent) {
                return const LoadingWidget();
              }
              if (state.homeEvent is CompletedHomeEvent) {
                final CompletedHomeEvent event =
                    state.homeEvent as CompletedHomeEvent;
                countPerson = event.personModel.length;
                List<PersonModel> personModel = event.personModel;
                return personModel.isEmpty
                    ? const Center(child: Text("لیست خالی می باشد"))
                    : ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: personModel.length,
                        itemBuilder: (context, index) {
                          var item = personModel[index];
                          return Dismissible(
                            key: ValueKey(item.id),
                            direction: DismissDirection.horizontal,
                            background: Container(
                              width: getAllWidth(context),
                              height: Responsive.isMobile(context) ? 45 : 75,
                              color: Colors.red,
                              child: IconButton(
                                alignment: Alignment.centerRight,
                                icon: Icon(Icons.delete_forever,
                                    size: getWidth(context, 0.07)),
                                padding: EdgeInsets.only(
                                    right: getWidth(context, 0.03)),
                                color: Colors.white,
                                onPressed: () {},
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                context
                                    .read<HomeBloc>()
                                    .add(DeleteByIndexEvent(index: index));
                              }
                            },
                            child: ListTile(
                              title:
                                  Text("${item.firstname}  ${item.lastname}"),
                              subtitle: Text(item.sex),
                              trailing: IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      EditPersonPage.screenId,
                                      arguments: [
                                        item.id,
                                        item.firstname,
                                        item.lastname,
                                        item.sex,
                                        index
                                      ],
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blueAccent,
                                  )),
                            ),
                          );
                        },
                      );
              }
              return Container();
            },
          ),
        );
      },
    );
  }
}

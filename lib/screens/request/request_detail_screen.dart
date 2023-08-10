import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/models/request.dart';
import 'package:demo_publicarea/widgets/custom_title.dart';
import 'package:demo_publicarea/l10n/app_localizations.dart';
import 'package:demo_publicarea/providers/user_providers.dart';
import 'package:demo_publicarea/providers/request_provider.dart';
import 'package:demo_publicarea/widgets/custom_listitem_big.dart';
import 'package:demo_publicarea/utils/date_amount_formatter.dart';

class RequestDetailScreen extends StatefulWidget {
  static String routeName = '/aRequest';

  const RequestDetailScreen({Key? key}) : super(key: key);

  @override
  State<RequestDetailScreen> createState() => _RequestDetailScreenState();
}

class _RequestDetailScreenState extends State<RequestDetailScreen> {
  String _currentRequestType = '';

  late String requestId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentRequestType;
    requestId = ModalRoute.of(context)!.settings.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    RequestProvider requestProvider =
        Provider.of<RequestProvider>(context, listen: false);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    var trnslt = AppLocalizations.of(context)!;

    return StreamBuilder<Request?>(
      stream: requestProvider.fetchARequest(requestId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(userProvider.currentUser.building),
              backgroundColor: mainBackgroundColor,
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(userProvider.currentUser.building),
              backgroundColor: mainBackgroundColor,
            ),
            body: Center(
              child:
                  Text('${trnslt.lcod_lbl_error_snapshot} ${snapshot.error}'),
            ),
          );
        } else {
          Request? request = snapshot.data;

          _currentRequestType = request!.requestType;
          if (_currentRequestType == 'lcod_lbl_request_malfunction') {
            _currentRequestType = trnslt.lcod_lbl_request_malfunction;
          }

          if (_currentRequestType == 'lcod_lbl_request_question') {
            _currentRequestType = trnslt.lcod_lbl_request_question;
          }
          if (_currentRequestType == 'lcod_lbl_request_suggestion') {
            _currentRequestType = trnslt.lcod_lbl_request_suggestion;
          }
          if (_currentRequestType == 'lcod_lbl_request_complaint') {
            _currentRequestType = trnslt.lcod_lbl_request_complaint;
          }

          if (request == null) {
            return Scaffold(
              appBar: AppBar(
                title: Text(userProvider.currentUser.building),
                backgroundColor: mainBackgroundColor,
              ),
              body: Center(
                child: Text(trnslt.lcod_lbl_no_request),
              ),
            );
          }

          String? subtitleText;

          if (request.status == true) {
            subtitleText =
                "${NoyaFormatter.generate(request.requestDate)} ${trnslt.lcod_lbl_request_continues} '${_currentRequestType}'";
          } else {
            subtitleText =
                "${NoyaFormatter.generate(request.requestDate)} ${trnslt.lcod_lbl_request_concluded} '${_currentRequestType}'";
          }
          return Container(
            color: mainBackgroundColor,
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(userProvider.currentUser.building),
                  backgroundColor: mainBackgroundColor,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTitle(
                        mainTitle: request.requestTitle,
                      ),
                      CustomBigListItem(
                        image: request.imageUrl, //request.imageUrl,
                        title: trnslt.lcod_lbl_request_title(
                            userProvider.currentUser.name,
                            userProvider.currentUser.surname,
                            request.apartmentNumber),

                        subtitle: subtitleText,

                        text: request.requestExplanation,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

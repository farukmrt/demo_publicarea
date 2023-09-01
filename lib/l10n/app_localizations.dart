import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('tr')
  ];

  /// No description provided for @changeLanguage.
  ///
  /// In tr, this message translates to:
  /// **'Dili değiştir'**
  String get changeLanguage;

  /// No description provided for @login.
  ///
  /// In tr, this message translates to:
  /// **'Asagida login sayfasi bulunmaktadir'**
  String get login;

  /// No description provided for @lcod_lbl_login.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get lcod_lbl_login;

  /// No description provided for @lcod_lbl_email.
  ///
  /// In tr, this message translates to:
  /// **'Email Adresinizi Girin'**
  String get lcod_lbl_email;

  /// No description provided for @lcod_lbl_password.
  ///
  /// In tr, this message translates to:
  /// **'Parolanızı girin'**
  String get lcod_lbl_password;

  /// No description provided for @lcod_lbl_welcome.
  ///
  /// In tr, this message translates to:
  /// **'PublicArea\'ya \nHoşgeldiniz'**
  String get lcod_lbl_welcome;

  /// No description provided for @lcod_lbl_signup.
  ///
  /// In tr, this message translates to:
  /// **'Üye Ol'**
  String get lcod_lbl_signup;

  /// No description provided for @lcod_lbl_profilphoto.
  ///
  /// In tr, this message translates to:
  /// **'Profil Resmi Ekleyiniz..'**
  String get lcod_lbl_profilphoto;

  /// No description provided for @lcod_lbl_upload_gallery.
  ///
  /// In tr, this message translates to:
  /// **'Galeriden Yükle'**
  String get lcod_lbl_upload_gallery;

  /// No description provided for @lcod_lbl_create_password.
  ///
  /// In tr, this message translates to:
  /// **'Parolanızı Oluşturun'**
  String get lcod_lbl_create_password;

  /// No description provided for @lcod_lbl_create_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı Adınızı Oluşturun'**
  String get lcod_lbl_create_username;

  /// No description provided for @lcod_lbl_enter_name.
  ///
  /// In tr, this message translates to:
  /// **'Adınızı Girin'**
  String get lcod_lbl_enter_name;

  /// No description provided for @lcod_lbl_enter_surname.
  ///
  /// In tr, this message translates to:
  /// **'Soyadınızı Girin'**
  String get lcod_lbl_enter_surname;

  /// No description provided for @lcod_lbl_enter_building.
  ///
  /// In tr, this message translates to:
  /// **'Bina Adını Girin'**
  String get lcod_lbl_enter_building;

  /// No description provided for @lcod_lbl_enter_phonenumber.
  ///
  /// In tr, this message translates to:
  /// **'Telefon Numaranızı Girin'**
  String get lcod_lbl_enter_phonenumber;

  /// No description provided for @main.
  ///
  /// In tr, this message translates to:
  /// **'asagida main sayfasi bulunmaktadir'**
  String get main;

  /// No description provided for @lcod_lbl_announcements.
  ///
  /// In tr, this message translates to:
  /// **'Duyurular'**
  String get lcod_lbl_announcements;

  /// No description provided for @lcod_lbl_error_snapshot.
  ///
  /// In tr, this message translates to:
  /// **'Hata: '**
  String get lcod_lbl_error_snapshot;

  /// No description provided for @lcod_lbl_announcement_not_found.
  ///
  /// In tr, this message translates to:
  /// **'Duyuru bulunamadı.'**
  String get lcod_lbl_announcement_not_found;

  /// No description provided for @lcod_lbl_dear_username_surname.
  ///
  /// In tr, this message translates to:
  /// **'Sayın {name} {surname}'**
  String lcod_lbl_dear_username_surname(String name, String surname);

  /// No description provided for @lcod_lbl_your_debt.
  ///
  /// In tr, this message translates to:
  /// **'Borcunuz'**
  String get lcod_lbl_your_debt;

  /// No description provided for @lcod_lbl_error_data_not_received.
  ///
  /// In tr, this message translates to:
  /// **'Hata: veriler alınamadı.'**
  String get lcod_lbl_error_data_not_received;

  /// No description provided for @lcod_lbl_data_not_received.
  ///
  /// In tr, this message translates to:
  /// **'Veri bulunamadı veya hata oluştu.'**
  String get lcod_lbl_data_not_received;

  /// No description provided for @lcod_lbl_to_pay.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme Yap'**
  String get lcod_lbl_to_pay;

  /// No description provided for @lcod_lbl_see_all.
  ///
  /// In tr, this message translates to:
  /// **'Tümünü Gör ->'**
  String get lcod_lbl_see_all;

  /// No description provided for @lcod_lbl_no_announcement_1.
  ///
  /// In tr, this message translates to:
  /// **'Yeni bir duyuru yapıldığında burada listelenecektir.'**
  String get lcod_lbl_no_announcement_1;

  /// No description provided for @lcod_lbl_no_announcement_2.
  ///
  /// In tr, this message translates to:
  /// **'Güncel duyurunuz bulunmamaktadır'**
  String get lcod_lbl_no_announcement_2;

  /// No description provided for @lcod_lbl_no_announcement_3.
  ///
  /// In tr, this message translates to:
  /// **'Eğer hala binaya dahil olmadıysanız yöneticiniz ile irtibata geçin.'**
  String get lcod_lbl_no_announcement_3;

  /// No description provided for @lcod_lbl_main_screen.
  ///
  /// In tr, this message translates to:
  /// **'Anasayfa'**
  String get lcod_lbl_main_screen;

  /// No description provided for @lcod_lbl_statement_screen.
  ///
  /// In tr, this message translates to:
  /// **'Hesap Özeti'**
  String get lcod_lbl_statement_screen;

  /// No description provided for @lcod_lbl_request_screen.
  ///
  /// In tr, this message translates to:
  /// **'Talepler'**
  String get lcod_lbl_request_screen;

  /// No description provided for @lcod_lbl_settings_screen.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get lcod_lbl_settings_screen;

  /// No description provided for @request.
  ///
  /// In tr, this message translates to:
  /// **'asagida request sayfasi bulunmaktadir'**
  String get request;

  /// No description provided for @lcod_lbl_no_request.
  ///
  /// In tr, this message translates to:
  /// **'Talep bulunamadı.'**
  String get lcod_lbl_no_request;

  /// No description provided for @lcod_lbl_request_continues.
  ///
  /// In tr, this message translates to:
  /// **' tarihinde yapmış olduğunuz talebiniz hala devam etmektedir, \nTalep Tipi: '**
  String get lcod_lbl_request_continues;

  /// No description provided for @lcod_lbl_request_concluded.
  ///
  /// In tr, this message translates to:
  /// **' tarihinde yapmış olduğunuz talebiniz sonuçlanmıştır, \nTalep Tipi: '**
  String get lcod_lbl_request_concluded;

  /// No description provided for @lcod_lbl_request_title.
  ///
  /// In tr, this message translates to:
  /// **'Sayın {name} {surname}; \n {apartmentNumber} no\'lu daireniz için'**
  String lcod_lbl_request_title(String name, String surname, String apartmentNumber);

  /// No description provided for @lcod_lbl_create_request.
  ///
  /// In tr, this message translates to:
  /// **'Talep Oluştur'**
  String get lcod_lbl_create_request;

  /// No description provided for @lcod_lbl_subject.
  ///
  /// In tr, this message translates to:
  /// **'Konu'**
  String get lcod_lbl_subject;

  /// No description provided for @lcod_lbl_apartment.
  ///
  /// In tr, this message translates to:
  /// **'Daire'**
  String get lcod_lbl_apartment;

  /// No description provided for @lcod_lbl_request_type.
  ///
  /// In tr, this message translates to:
  /// **'Talep Tipi'**
  String get lcod_lbl_request_type;

  /// No description provided for @lcod_lbl_request_list.
  ///
  /// In tr, this message translates to:
  /// **'\'Arıza\', \'Soru\', \'Öneri\', \'Şikayet\''**
  String get lcod_lbl_request_list;

  /// No description provided for @lcod_lbl_request_malfunction.
  ///
  /// In tr, this message translates to:
  /// **'Arıza'**
  String get lcod_lbl_request_malfunction;

  /// No description provided for @lcod_lbl_request_question.
  ///
  /// In tr, this message translates to:
  /// **'Soru'**
  String get lcod_lbl_request_question;

  /// No description provided for @lcod_lbl_request_suggestion.
  ///
  /// In tr, this message translates to:
  /// **'Öneri'**
  String get lcod_lbl_request_suggestion;

  /// No description provided for @lcod_lbl_request_complaint.
  ///
  /// In tr, this message translates to:
  /// **'Şikayet'**
  String get lcod_lbl_request_complaint;

  /// No description provided for @lcod_lbl_explanation.
  ///
  /// In tr, this message translates to:
  /// **'Açıklama'**
  String get lcod_lbl_explanation;

  /// No description provided for @lcod_lbl_add_image.
  ///
  /// In tr, this message translates to:
  /// **'Resim Ekle'**
  String get lcod_lbl_add_image;

  /// No description provided for @lcod_lbl_shooting.
  ///
  /// In tr, this message translates to:
  /// **'Çekim Yap'**
  String get lcod_lbl_shooting;

  /// No description provided for @lcod_lbl_upload_from_gallery.
  ///
  /// In tr, this message translates to:
  /// **'Galeriden Yükle'**
  String get lcod_lbl_upload_from_gallery;

  /// No description provided for @lcod_lbl_send_request.
  ///
  /// In tr, this message translates to:
  /// **'Talebi Gönder'**
  String get lcod_lbl_send_request;

  /// No description provided for @lcod_lbl_new_request.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Talep'**
  String get lcod_lbl_new_request;

  /// No description provided for @lcod_lbl_current_request.
  ///
  /// In tr, this message translates to:
  /// **'Güncel'**
  String get lcod_lbl_current_request;

  /// No description provided for @lcod_lbl_complete_request.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlanmış'**
  String get lcod_lbl_complete_request;

  /// No description provided for @lcod_lbl_no_current_request.
  ///
  /// In tr, this message translates to:
  /// **'Güncel talebiniz bulunmuyor'**
  String get lcod_lbl_no_current_request;

  /// No description provided for @lcod_lbl_new_request_article.
  ///
  /// In tr, this message translates to:
  /// **'Öneri, talep ve şikayetlerinizi yönetiminize “yeni talep” oluşturarak iletebilirsiniz.'**
  String get lcod_lbl_new_request_article;

  /// No description provided for @lcod_lbl_no_complete_request.
  ///
  /// In tr, this message translates to:
  /// **'Tamamlanmış talebiniz bulunmuyor'**
  String get lcod_lbl_no_complete_request;

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Asagida settings sayfasi bulunmaktadir'**
  String get settings;

  /// No description provided for @lcod_lbl_profile_screen.
  ///
  /// In tr, this message translates to:
  /// **'Profil Ekranı'**
  String get lcod_lbl_profile_screen;

  /// No description provided for @lcod_lbl_update_profile_screen.
  ///
  /// In tr, this message translates to:
  /// **'Profil Resmini Güncelle'**
  String get lcod_lbl_update_profile_screen;

  /// No description provided for @lcod_lbl_name_surname.
  ///
  /// In tr, this message translates to:
  /// **'İsim Soyisim'**
  String get lcod_lbl_name_surname;

  /// No description provided for @lcod_lbl_email_text.
  ///
  /// In tr, this message translates to:
  /// **'E-Mail'**
  String get lcod_lbl_email_text;

  /// No description provided for @lcod_lbl_new_email.
  ///
  /// In tr, this message translates to:
  /// **'Yeni e-mail Adresini Girin'**
  String get lcod_lbl_new_email;

  /// No description provided for @lcod_lbl_password_2.
  ///
  /// In tr, this message translates to:
  /// **'Şifrenizi Girin'**
  String get lcod_lbl_password_2;

  /// No description provided for @lcod_lbl_updated_email.
  ///
  /// In tr, this message translates to:
  /// **'E-mail adresiniz güncellendi...'**
  String get lcod_lbl_updated_email;

  /// No description provided for @lcod_lbl_wrong_password.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli şifre yanlış.'**
  String get lcod_lbl_wrong_password;

  /// No description provided for @lcod_lbl_update.
  ///
  /// In tr, this message translates to:
  /// **'Güncelle'**
  String get lcod_lbl_update;

  /// No description provided for @lcod_lbl_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı Adı'**
  String get lcod_lbl_username;

  /// No description provided for @lcod_lbl_new_username.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Kullanıcı Adını Girin'**
  String get lcod_lbl_new_username;

  /// No description provided for @lcod_lbl_phone_number.
  ///
  /// In tr, this message translates to:
  /// **'Telefon Numarası'**
  String get lcod_lbl_phone_number;

  /// No description provided for @lcod_lbl_phone_text.
  ///
  /// In tr, this message translates to:
  /// **'Telefon'**
  String get lcod_lbl_phone_text;

  /// No description provided for @lcod_lbl_updated_phone_number.
  ///
  /// In tr, this message translates to:
  /// **'Telefon numaranız güncellendi...'**
  String get lcod_lbl_updated_phone_number;

  /// No description provided for @lcod_lbl_updated_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı adınız güncellendi...'**
  String get lcod_lbl_updated_username;

  /// No description provided for @lcod_lbl_building.
  ///
  /// In tr, this message translates to:
  /// **'Bina'**
  String get lcod_lbl_building;

  /// No description provided for @lcod_lbl_current_password.
  ///
  /// In tr, this message translates to:
  /// **'Güncel Şifrenizi Giriniz'**
  String get lcod_lbl_current_password;

  /// No description provided for @lcod_lbl_new_password.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Şifrenizi Oluşturun'**
  String get lcod_lbl_new_password;

  /// No description provided for @lcod_lbl_new_password_again.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Şifrenizi Tekrar Girin'**
  String get lcod_lbl_new_password_again;

  /// No description provided for @lcod_lbl_wrong_password_long.
  ///
  /// In tr, this message translates to:
  /// **'Şifreler uyuşmuyor, kontrol ederek tekrar girin..'**
  String get lcod_lbl_wrong_password_long;

  /// No description provided for @lcod_lbl_update_password.
  ///
  /// In tr, this message translates to:
  /// **'Şifreyi Güncelle'**
  String get lcod_lbl_update_password;

  /// No description provided for @lcod_lbl_logout.
  ///
  /// In tr, this message translates to:
  /// **'Hesaptan Çıkış Yap'**
  String get lcod_lbl_logout;

  /// No description provided for @statement.
  ///
  /// In tr, this message translates to:
  /// **'Asagida statement sayfasi bulunmaktadir'**
  String get statement;

  /// No description provided for @lcod_lbl_card_screen.
  ///
  /// In tr, this message translates to:
  /// **'Kart Ekranı'**
  String get lcod_lbl_card_screen;

  /// No description provided for @lcod_lbl_selected_amount.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen Tutar'**
  String get lcod_lbl_selected_amount;

  /// No description provided for @lcod_lbl_card_number.
  ///
  /// In tr, this message translates to:
  /// **'Kart Numarası'**
  String get lcod_lbl_card_number;

  /// No description provided for @lcod_lbl_expiration.
  ///
  /// In tr, this message translates to:
  /// **'Son Kullanma Tarihi'**
  String get lcod_lbl_expiration;

  /// No description provided for @lcod_lbl_card_holder.
  ///
  /// In tr, this message translates to:
  /// **'Kart Sahibi'**
  String get lcod_lbl_card_holder;

  /// No description provided for @lcod_lbl_payment_successful.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme başarılı'**
  String get lcod_lbl_payment_successful;

  /// No description provided for @lcod_lbl_wrong_card_information.
  ///
  /// In tr, this message translates to:
  /// **'Kart bilgileri hatalı lütfen kontrol edin'**
  String get lcod_lbl_wrong_card_information;

  /// No description provided for @lcod_lbl_confirm_payment.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeyi Onayla '**
  String get lcod_lbl_confirm_payment;

  /// No description provided for @lcod_lbl_statement.
  ///
  /// In tr, this message translates to:
  /// **'Hesap Dökümü'**
  String get lcod_lbl_statement;

  /// No description provided for @lcod_lbl_paid_bills.
  ///
  /// In tr, this message translates to:
  /// **'Ödenen Faturalar'**
  String get lcod_lbl_paid_bills;

  /// No description provided for @lcod_lbl_payment_bill.
  ///
  /// In tr, this message translates to:
  /// **'Lütfen Ödeme Yapın..'**
  String get lcod_lbl_payment_bill;

  /// No description provided for @lcod_lbl_no_invoice_paid.
  ///
  /// In tr, this message translates to:
  /// **'Ödenmiş Faturanız Bulunmamaktadır!!'**
  String get lcod_lbl_no_invoice_paid;

  /// No description provided for @lcod_lbl_payment_date_paid.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme Tarihi: '**
  String get lcod_lbl_payment_date_paid;

  /// No description provided for @lcod_lbl_debt.
  ///
  /// In tr, this message translates to:
  /// **'Borç'**
  String get lcod_lbl_debt;

  /// No description provided for @lcod_lbl_paid.
  ///
  /// In tr, this message translates to:
  /// **'Ödenen'**
  String get lcod_lbl_paid;

  /// No description provided for @lcod_lbl_payments.
  ///
  /// In tr, this message translates to:
  /// **'Ödemeler'**
  String get lcod_lbl_payments;

  /// No description provided for @lcod_lbl_payment_date_bill.
  ///
  /// In tr, this message translates to:
  /// **'Son Ödeme T: '**
  String get lcod_lbl_payment_date_bill;

  /// No description provided for @lcod_lbl_continue.
  ///
  /// In tr, this message translates to:
  /// **'Devam et '**
  String get lcod_lbl_continue;

  /// No description provided for @lcod_lbl_total_amount.
  ///
  /// In tr, this message translates to:
  /// **'Toplam\ntutar'**
  String get lcod_lbl_total_amount;

  /// No description provided for @lcod_lbl_selected_amount_double.
  ///
  /// In tr, this message translates to:
  /// **'Seçilen\ntutar'**
  String get lcod_lbl_selected_amount_double;

  /// No description provided for @lcod_lbl_unpaid_bills.
  ///
  /// In tr, this message translates to:
  /// **'Ödenmeyen Faturalar'**
  String get lcod_lbl_unpaid_bills;

  /// No description provided for @lcod_lbl_thanks.
  ///
  /// In tr, this message translates to:
  /// **'Teşekkürler..'**
  String get lcod_lbl_thanks;

  /// No description provided for @lcod_lbl_no_invoice_unpaid.
  ///
  /// In tr, this message translates to:
  /// **'Ödenmemiş Faturanız Bulunmamaktadır!!'**
  String get lcod_lbl_no_invoice_unpaid;

  /// No description provided for @lcod_lbl_payment_date_unpaid.
  ///
  /// In tr, this message translates to:
  /// **'Ödeme Tarihi: '**
  String get lcod_lbl_payment_date_unpaid;

  /// No description provided for @lcod_lbl_statement_unpaid.
  ///
  /// In tr, this message translates to:
  /// **'Ödenmeyen Faturalar'**
  String get lcod_lbl_statement_unpaid;

  /// No description provided for @lcod_lbl_statement_paid.
  ///
  /// In tr, this message translates to:
  /// **'Ödenen Faturalar'**
  String get lcod_lbl_statement_paid;

  /// No description provided for @lcod_lbl_statement_total.
  ///
  /// In tr, this message translates to:
  /// **'Toplam'**
  String get lcod_lbl_statement_total;

  /// No description provided for @lcod_lbl_statement_chart.
  ///
  /// In tr, this message translates to:
  /// **'Hesap Grafiği'**
  String get lcod_lbl_statement_chart;

  /// No description provided for @lcod_lbl_pending.
  ///
  /// In tr, this message translates to:
  /// **'Beklemede'**
  String get lcod_lbl_pending;

  /// No description provided for @lcod_lbl_concluded.
  ///
  /// In tr, this message translates to:
  /// **'Sonuçlandı'**
  String get lcod_lbl_concluded;

  /// No description provided for @lcod_lbl_fault.
  ///
  /// In tr, this message translates to:
  /// **'Arıza'**
  String get lcod_lbl_fault;

  /// No description provided for @lcod_lbl_question.
  ///
  /// In tr, this message translates to:
  /// **'Soru'**
  String get lcod_lbl_question;

  /// No description provided for @lcod_lbl_suggestion.
  ///
  /// In tr, this message translates to:
  /// **'Öneri'**
  String get lcod_lbl_suggestion;

  /// No description provided for @lcod_lbl_complaint.
  ///
  /// In tr, this message translates to:
  /// **'Şikayet'**
  String get lcod_lbl_complaint;

  /// No description provided for @lcod_lbl_update_profile_photo.
  ///
  /// In tr, this message translates to:
  /// **'Profil Resmi Güncelleme'**
  String get lcod_lbl_update_profile_photo;

  /// No description provided for @lcod_lbl_update_email.
  ///
  /// In tr, this message translates to:
  /// **'E-Mail Güncelleme'**
  String get lcod_lbl_update_email;

  /// No description provided for @lcod_lbl_update_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı Adı Güncelleme'**
  String get lcod_lbl_update_username;

  /// No description provided for @lcod_lbl_update_phone_number.
  ///
  /// In tr, this message translates to:
  /// **'Telefon Numarası Güncelleme'**
  String get lcod_lbl_update_phone_number;

  /// No description provided for @lcod_lbl_control_email.
  ///
  /// In tr, this message translates to:
  /// **'Mail\'inizi kontrol ediniz'**
  String get lcod_lbl_control_email;

  /// No description provided for @lcod_lbl_control_password.
  ///
  /// In tr, this message translates to:
  /// **'Şifrenizi kontrol ediniz'**
  String get lcod_lbl_control_password;

  /// No description provided for @lcod_lbl_control_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı adınızı kontrol ediniz'**
  String get lcod_lbl_control_username;

  /// No description provided for @lcod_lbl_control_name.
  ///
  /// In tr, this message translates to:
  /// **'Adınızı kontrol ediniz'**
  String get lcod_lbl_control_name;

  /// No description provided for @lcod_lbl_control_surname.
  ///
  /// In tr, this message translates to:
  /// **'Soyadınızı kontrol ediniz'**
  String get lcod_lbl_control_surname;

  /// No description provided for @lcod_lbl_control_building_name.
  ///
  /// In tr, this message translates to:
  /// **'Bina adını kontrol ediniz'**
  String get lcod_lbl_control_building_name;

  /// No description provided for @lcod_lbl_control_phone_number.
  ///
  /// In tr, this message translates to:
  /// **'Telefon numaranızı kontrol ediniz'**
  String get lcod_lbl_control_phone_number;

  /// No description provided for @lcod_lbl_control_card_number.
  ///
  /// In tr, this message translates to:
  /// **'Kart numarasını kontrol ediniz'**
  String get lcod_lbl_control_card_number;

  /// No description provided for @lcod_lbl_control_cvv_code.
  ///
  /// In tr, this message translates to:
  /// **'CVV kodunu kontrol ediniz'**
  String get lcod_lbl_control_cvv_code;

  /// No description provided for @lcod_lbl_control_double_name.
  ///
  /// In tr, this message translates to:
  /// **'İsminizi ve soyisminizi kontrol ediniz'**
  String get lcod_lbl_control_double_name;

  /// No description provided for @lcod_lbl_control_valid_thru.
  ///
  /// In tr, this message translates to:
  /// **'Son geçerlilik tarihini kontrol ediniz'**
  String get lcod_lbl_control_valid_thru;

  /// No description provided for @lcod_lbl_control_title.
  ///
  /// In tr, this message translates to:
  /// **'Başlığı kontrol ediniz'**
  String get lcod_lbl_control_title;

  /// No description provided for @lcod_lbl_control_apartment_number.
  ///
  /// In tr, this message translates to:
  /// **'Daire numaranızı kontrol ediniz'**
  String get lcod_lbl_control_apartment_number;

  /// No description provided for @lcod_lbl_control_request_type.
  ///
  /// In tr, this message translates to:
  /// **'Talep tipiniz seçiniz'**
  String get lcod_lbl_control_request_type;

  /// No description provided for @lcod_lbl_control_request_explanation.
  ///
  /// In tr, this message translates to:
  /// **'Talebinizin açıklamasını kontrol ediniz'**
  String get lcod_lbl_control_request_explanation;

  /// No description provided for @lcod_lbl_message_password.
  ///
  /// In tr, this message translates to:
  /// **'Geçerli şifre yanlış!'**
  String get lcod_lbl_message_password;

  /// No description provided for @lcod_lbl_message_taken_username.
  ///
  /// In tr, this message translates to:
  /// **'Bu kullanıcı adı zaten alınmış!'**
  String get lcod_lbl_message_taken_username;

  /// No description provided for @lcod_lbl_message_update_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı adınız güncellendi...'**
  String get lcod_lbl_message_update_username;

  /// No description provided for @lcod_lbl_message_error_username.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı adı güncelleme hatası.'**
  String get lcod_lbl_message_error_username;

  /// No description provided for @lcod_lbl_message_used_username.
  ///
  /// In tr, this message translates to:
  /// **'Bu kullanıcı adı zaten kullanılıyor.'**
  String get lcod_lbl_message_used_username;

  /// No description provided for @lcod_lbl_message_not_found_user.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı bulunamadı!'**
  String get lcod_lbl_message_not_found_user;

  /// No description provided for @lcod_lbl_message_error_profile_photo.
  ///
  /// In tr, this message translates to:
  /// **'Profil resmi güncellenirken bir hata oluştu.'**
  String get lcod_lbl_message_error_profile_photo;

  /// No description provided for @lcod_lbl_message_error_logout.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yaparken bir hata oluştu.'**
  String get lcod_lbl_message_error_logout;

  /// No description provided for @lcod_lbl_profile_settings.
  ///
  /// In tr, this message translates to:
  /// **'Profil Ayarları'**
  String get lcod_lbl_profile_settings;

  /// No description provided for @lcod_lbl_new_building.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Siteye Kayıt Olma'**
  String get lcod_lbl_new_building;

  /// No description provided for @lcod_lbl_kvkk.
  ///
  /// In tr, this message translates to:
  /// **' KVKK Metni'**
  String get lcod_lbl_kvkk;

  /// No description provided for @lcod_lbl_user_agreement.
  ///
  /// In tr, this message translates to:
  /// **'Kullanıcı Sözleşmesi'**
  String get lcod_lbl_user_agreement;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
    case 'tr': return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

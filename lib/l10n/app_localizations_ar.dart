import 'app_localizations.dart';

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get changeLanguage => 'تغيير اللغة';

  @override
  String get login => 'الصفحة التي تسجيل الدخول يمكن العثور عليها أدناه';

  @override
  String get lcod_lbl_login => 'تسجيل الدخول';

  @override
  String get lcod_lbl_email => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get lcod_lbl_password => 'أدخل كلمة المرور';

  @override
  String get lcod_lbl_welcome => 'مرحبًا بك في منطقة الجمهور';

  @override
  String get lcod_lbl_signup => 'إنشاء حساب';

  @override
  String get lcod_lbl_profilphoto => 'إضافة صورة الملف الشخصي';

  @override
  String get lcod_lbl_upload_gallery => 'تحميل من المعرض';

  @override
  String get lcod_lbl_create_password => 'إنشاء كلمة المرور';

  @override
  String get lcod_lbl_create_username => 'إنشاء اسم المستخدم';

  @override
  String get lcod_lbl_enter_name => 'أدخل اسمك';

  @override
  String get lcod_lbl_enter_surname => 'أدخل اسم العائلة الخاص بك';

  @override
  String get lcod_lbl_enter_building => 'أدخل اسم المبنى';

  @override
  String get lcod_lbl_enter_phonenumber => 'أدخل رقم هاتفك';

  @override
  String get main => 'الصفحة الرئيسية يمكن العثور عليها أدناه';

  @override
  String get lcod_lbl_announcements => 'الإعلانات';

  @override
  String get lcod_lbl_error_snapshot => 'خطأ: ';

  @override
  String get lcod_lbl_announcement_not_found => 'لم يتم العثور على الإعلان.';

  @override
  String lcod_lbl_dear_username_surname(String name, String surname) {
    return '$surname $name عزيزي';
  }

  @override
  String get lcod_lbl_your_debt => 'ديونك';

  @override
  String get lcod_lbl_error_data_not_received => 'خطأ: لم يتم استلام البيانات.';

  @override
  String get lcod_lbl_data_not_received => 'لم يتم العثور على البيانات أو حدث خطأ.';

  @override
  String get lcod_lbl_to_pay => 'ادفع الآن';

  @override
  String get lcod_lbl_see_all => 'عرض الكل ->';

  @override
  String get lcod_lbl_no_announcement_1 => 'سيتم سرد الإعلانات الجديدة هنا.';

  @override
  String get lcod_lbl_no_announcement_2 => 'ليس لديك إعلانات حالية.';

  @override
  String get lcod_lbl_no_announcement_3 => 'إذا لم تنضم بعد إلى المبنى ، اتصل بالمسؤول الخاص بك.';

  @override
  String get lcod_lbl_main_screen => 'الشاشة الرئيسية';

  @override
  String get lcod_lbl_statement_screen => 'كشف الحساب';

  @override
  String get lcod_lbl_request_screen => 'طلباتي';

  @override
  String get lcod_lbl_settings_screen => 'الإعدادات';

  @override
  String get request => 'الصفحة التي يمكن العثور عليها عند الطلب أدناه';

  @override
  String get lcod_lbl_no_request => 'لم يتم العثور على طلب.';

  @override
  String get lcod_lbl_request_continues => 'طلب  الذي تم إجراؤه في  قيد التقدم.';

  @override
  String get lcod_lbl_request_concluded => 'تم الانتهاء من طلبك في التاريخ ، \n نوع الطلب: ';

  @override
  String lcod_lbl_request_title(String name, String surname, String apartmentNumber) {
    return 'عزيزي ؛ $name $surname; \n $apartmentNumber لشقتك رقم ';
  }

  @override
  String get lcod_lbl_create_request => 'إنشاء طلب';

  @override
  String get lcod_lbl_subject => 'الموضوع';

  @override
  String get lcod_lbl_apartment => 'الشقة';

  @override
  String get lcod_lbl_request_type => 'نوع الطلب';

  @override
  String get lcod_lbl_request_list => '\'عطل\', \'سؤال\', \'اقتراح\', \'شكوى\'';

  @override
  String get lcod_lbl_request_malfunction => 'عطل';

  @override
  String get lcod_lbl_request_question => 'سؤال';

  @override
  String get lcod_lbl_request_suggestion => 'اقتراح';

  @override
  String get lcod_lbl_request_complaint => 'شكوى';

  @override
  String get lcod_lbl_explanation => 'الشرح';

  @override
  String get lcod_lbl_add_image => 'إضافة صورة..';

  @override
  String get lcod_lbl_shooting => 'التقاط صورة';

  @override
  String get lcod_lbl_upload_from_gallery => 'تحميل من المعرض';

  @override
  String get lcod_lbl_send_request => 'إرسال الطلب';

  @override
  String get lcod_lbl_new_request => 'طلب جديد';

  @override
  String get lcod_lbl_current_request => 'الطلبات الحالية';

  @override
  String get lcod_lbl_complete_request => 'الطلبات المكتملة';

  @override
  String get lcod_lbl_no_current_request => 'ليس لديك طلبات حالية.';

  @override
  String get lcod_lbl_new_request_article => 'يمكنك تقديم اقتراحاتك وطلباتك وشكاويك لإدارتك عن طريق إنشاء \'طلب جديد\'.';

  @override
  String get lcod_lbl_no_complete_request => 'ليس لديك طلبات مكتملة.';

  @override
  String get settings => 'الصفحة التي يمكن العثور عليها في الإعدادات أدناه';

  @override
  String get lcod_lbl_profile_screen => 'الشاشة الشخصية';

  @override
  String get lcod_lbl_update_profile_screen => 'تحديث صورة الملف الشخصي';

  @override
  String get lcod_lbl_name_surname => 'الاسم واللقب';

  @override
  String get lcod_lbl_email_text => 'البريد الإلكتروني';

  @override
  String get lcod_lbl_new_email => 'أدخل عنوان بريد إلكتروني جديد';

  @override
  String get lcod_lbl_password_2 => 'أدخل كلمة المرور الخاصة بك';

  @override
  String get lcod_lbl_updated_email => 'تم تحديث عنوان بريدك الإلكتروني...';

  @override
  String get lcod_lbl_wrong_password => 'كلمة المرور غير صحيحة.';

  @override
  String get lcod_lbl_update => 'تحديث';

  @override
  String get lcod_lbl_username => 'اسم المستخدم';

  @override
  String get lcod_lbl_new_username => 'أدخل اسم مستخدم جديد';

  @override
  String get lcod_lbl_phone_number => 'رقم الهاتف';

  @override
  String get lcod_lbl_phone_text => 'الهاتف';

  @override
  String get lcod_lbl_updated_phone_number => 'تم تحديث رقم هاتفك...';

  @override
  String get lcod_lbl_updated_username => 'تم تحديث اسم المستخدم الخاص بك ...';

  @override
  String get lcod_lbl_building => 'المبنى';

  @override
  String get lcod_lbl_current_password => 'أدخل كلمة المرور الحالية الخاصة بك';

  @override
  String get lcod_lbl_new_password => 'إنشاء كلمة مرور جديدة';

  @override
  String get lcod_lbl_new_password_again => 'أدخل كلمة المرور الجديدة مرة أخرى';

  @override
  String get lcod_lbl_wrong_password_long => 'كلمات المرور غير متطابقة ، يرجى التحقق وإعادة الإدخال...';

  @override
  String get lcod_lbl_update_password => 'تحديث كلمة المرور';

  @override
  String get lcod_lbl_logout => 'تسجيل الخروج';

  @override
  String get statement => 'الصفحة التي يمكن العثور عليها في الكشف أدناه';

  @override
  String get lcod_lbl_card_screen => 'الشاشة بطاقة';

  @override
  String get lcod_lbl_selected_amount => 'المبلغ المحدد';

  @override
  String get lcod_lbl_card_number => 'رقم البطاقة';

  @override
  String get lcod_lbl_expiration => 'تاريخ الانتهاء';

  @override
  String get lcod_lbl_card_holder => 'صاحب البطاقة';

  @override
  String get lcod_lbl_payment_successful => 'نجاح الدفع';

  @override
  String get lcod_lbl_wrong_card_information => 'معلومات البطاقة غير صحيحة ، يرجى التحقق';

  @override
  String get lcod_lbl_confirm_payment => 'تأكيد الدفع';

  @override
  String get lcod_lbl_statement => 'كشف الحساب';

  @override
  String get lcod_lbl_paid_bills => 'الفواتير المدفوعة';

  @override
  String get lcod_lbl_payment_bill => 'يرجى القيام بالدفع..';

  @override
  String get lcod_lbl_no_invoice_paid => 'ليس لديك فواتير مدفوعة !!';

  @override
  String get lcod_lbl_payment_date_paid => 'تاريخ الدفع: ';

  @override
  String get lcod_lbl_debt => 'دين';

  @override
  String get lcod_lbl_paid => 'المدفوع';

  @override
  String get lcod_lbl_payments => 'المدفوعات';

  @override
  String get lcod_lbl_payment_date_bill => 'تاريخ الدفع الأخير: ';

  @override
  String get lcod_lbl_continue => 'متابعة';

  @override
  String get lcod_lbl_total_amount => 'المبلغ الإجمالي';

  @override
  String get lcod_lbl_selected_amount_double => 'المبلغ المحدد';

  @override
  String get lcod_lbl_unpaid_bills => 'الفواتير الغير مدفوعة';

  @override
  String get lcod_lbl_thanks => 'شكراً لك..';

  @override
  String get lcod_lbl_no_invoice_unpaid => 'ليس لديك فواتير غير مدفوعة !!';

  @override
  String get lcod_lbl_payment_date_unpaid => 'تاريخ الدفع: ';

  @override
  String get lcod_lbl_statement_unpaid => 'غير مدفوعة الأجر';

  @override
  String get lcod_lbl_statement_paid => 'مدفوع';

  @override
  String get lcod_lbl_statement_total => 'المجموع';

  @override
  String get lcod_lbl_statement_chart => 'مخطط الحساب';

  @override
  String get lcod_lbl_pending => 'قيد الانتظار';

  @override
  String get lcod_lbl_concluded => 'انتهى';

  @override
  String get lcod_lbl_fault => 'عيب';

  @override
  String get lcod_lbl_question => 'سؤال';

  @override
  String get lcod_lbl_suggestion => 'اقتراح';

  @override
  String get lcod_lbl_complaint => 'شكوى';

  @override
  String get lcod_lbl_update_profile_photo => 'تحديث صورة الملف الشخصي';

  @override
  String get lcod_lbl_update_email => 'تحديث البريد الإلكتروني';

  @override
  String get lcod_lbl_update_username => 'تحديث اسم المستخدم';

  @override
  String get lcod_lbl_update_phone_number => 'تحديث رقم الهاتف';

  @override
  String get lcod_lbl_control_email => 'راجع بريدك';

  @override
  String get lcod_lbl_control_password => 'تحقق من كلمة المرور الخاصة بك';

  @override
  String get lcod_lbl_control_username => 'تحقق من اسم المستخدم الخاص بك';

  @override
  String get lcod_lbl_control_name => 'تحقق من اسمك';

  @override
  String get lcod_lbl_control_surname => 'تحقق من لقبك';

  @override
  String get lcod_lbl_control_building_name => 'تحقق من اسم المبنى';

  @override
  String get lcod_lbl_control_phone_number => 'تحقق من رقم هاتفك';

  @override
  String get lcod_lbl_control_card_number => 'تحقق من رقم البطاقة';

  @override
  String get lcod_lbl_control_cvv_code => 'تحقق من رمز CVV';

  @override
  String get lcod_lbl_control_double_name => 'تحقق من اسمك ولقبك';

  @override
  String get lcod_lbl_control_valid_thru => 'تحقق من تاريخ انتهاء الصلاحية';

  @override
  String get lcod_lbl_control_title => 'تحقق من العنوان';

  @override
  String get lcod_lbl_control_apartment_number => 'تحقق من رقم شقتك';

  @override
  String get lcod_lbl_control_request_type => 'اختر نوع طلبك';

  @override
  String get lcod_lbl_control_request_explanation => 'تحقق من وصف طلبك';

  @override
  String get lcod_lbl_message_password => 'كلمة المرور الحالية غير صحيحة!';

  @override
  String get lcod_lbl_message_taken_username => 'أسم المستخدم مأخوذ مسبقا!';

  @override
  String get lcod_lbl_message_update_username => 'تم تحديث اسم المستخدم الخاص بك ...';

  @override
  String get lcod_lbl_message_error_username => 'خطأ في تحديث اسم المستخدم.';

  @override
  String get lcod_lbl_message_used_username => 'اسم المستخدم هذا تم استخدامه.';

  @override
  String get lcod_lbl_message_not_found_user => 'لم يتم العثور على المستخدم!';

  @override
  String get lcod_lbl_message_error_profile_photo => 'حدث خطأ أثناء تحديث صورة الملف الشخصي.';

  @override
  String get lcod_lbl_message_error_logout => 'حدث خطأ أثناء تسجيل الخروج.';

  @override
  String get lcod_lbl_profile_settings => 'إعدادات الملف الشخصي';

  @override
  String get lcod_lbl_new_building => 'تسجيل موقع جديد';

  @override
  String get lcod_lbl_kvkk => 'نص KVKK';

  @override
  String get lcod_lbl_user_agreement => 'اتفاقية المستخدم';
}

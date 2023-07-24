import 'package:demo_publicarea/widgets/custom_numbered_list.dart';
import 'package:demo_publicarea/widgets/custom_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:demo_publicarea/utils/colors.dart';

class UserAgreementScreen extends StatefulWidget {
  static String routeName = '/useragreementscreen';

  const UserAgreementScreen({Key? key}) : super(key: key);

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState extends State<UserAgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Kullanıcı Sözleşmesi'),
            // const SingleChildScrollView(
            //   child: Text('Site Sakini Kullanıcı Sözleşmesi'),
            //   physics: BouncingScrollPhysics(),
            //   scrollDirection: Axis.horizontal,
            // ),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  CustomSubtitle(
                      title:
                          "PublicArea'yı ilk ziyaretinizden itibaren, aşağıda yazılı olan ve PublicArea'nın ziyaret edilmesine ve/veya kullanılmasına ilişkin önemli bilgiler içeren hususları bütünüyle anlamış ve tamamını ayrılmaz bir bütün olarak kabul etmiş sayılırsınız."),

                  CustomNumberedList(
                    title: '1. Taraflar ve Konu',
                    number: '1.1. ',
                    subtitle:
                        "İşbu Kullanım Koşulları, Site Sakini olarak PublicArea'ya erişim sağlayan kişilerin tamamı için geçerlidir. Bu nedenle lütfen aşağıda yazılı koşulları dikkatlice okuyunuz. Bu koşulları kabul etmiyorsanız PublicArea'yı kullanmayınız.",
                  ),
                  CustomNumberedList(
                    number: '1.2. ',
                    subtitle:
                        "PublicArea'nın sahibi, “OSTİM Teknopark Turkuaz Bina No:4/12 ANKARA” yerleşik olan NOYA Yazılım Sanayi ve Ticaret A.Ş. (“Noya”) adlı şirkettir. Noya üzerinden sunulan Hizmetler, Noya tarafından sağlanmaktadır. Noya Platform’da yer alan veya alacak olan bilgileri, formları, her neviden içeriği ve işbu Kullanım Koşulları’nı dilediği zaman, ayrıca herhangi bir bildirimde bulunmaksızın değiştirme hakkını saklı tutar.",
                  ),
                  CustomNumberedList(
                    number: '1.3. ',
                    subtitle:
                        "Noya, işbu Kullanım Koşulları’nda belirtilen koşulları her zaman ve herhangi bir ihbarda veya bildirimde bulunmadan değiştirebilir. Bu değişiklikler, Platform’da yayımlandığı tarihten itibaren Platform’u ziyaret eden veya kullanan her Site Sakini için geçerli olacaktır. İşbu Kullanım Koşulları Site Sakini’nin tek taraflı beyanı ile değiştirilemez.",
                  ),
                  CustomNumberedList(
                    number: '1.4. ',
                    subtitle:
                        "İşbu Sözleşme’nin konusu; Site Sakini’nin Platform’dan ve Hizmetler’den faydalanmasına ilişkin hüküm ve koşulların belirlenmesi ve bu doğrultuda Tarafların hak ve yükümlülüklerinin düzenlenmesidir. Platform’da, kullanıma ve sair hususlara ilişkin olarak sunulan her türlü kural, duyuru ve beyan Kullanım Koşulları’nın ayrılmaz parçası olarak kabul edilecektir. Kullanım Koşulları ile Site Sakini, Platform’da belirtilen her türlü kural, duyuru, uyarı ve beyanı peşinen kabul etmektedir.",
                  ),
                  ///////
                  CustomNumberedList(
                    title: '2. Tanımlar',
                    number: 'Noya; ',
                    subtitle:
                        " “OSTİM Teknopark Turkuaz Bina No:4/12 ANKARA” adresinde mukim, 0(532) 749 0606 telefon numaralı NOYA Yazılım Sanayi ve Ticaret Anonim Şirketi'dir.",
                  ),
                  CustomNumberedList(
                    number: 'Yönetici; ',
                    subtitle:
                        "634 s. Kat Mülkiyeti Kanunu'na göre atanmış yönetici veya yönetim kurulu tarafından yetkili kılınmış gerçek veya tüzel kişileri veyahut da Site Sakini’nin maliki ve/veya kiracısı olduğu her bir toplu yaşam alanının 634 s. Kat Mülkiyeti Kanunu'na göre atanmış yöneticisini veya yönetim kurulunu olup Apsiyon ile Hizmet Sözleşmesi imzalayarak sözleşme ilişkisi kurmuş kişileri ifade eder.",
                  ),
                  CustomNumberedList(
                    number: 'Site Sakini; ',
                    subtitle:
                        "Yönetici’nin onayladığı ve/veya talep ettiği Hizmetler’den faydalanan ve/veya Yönetici tarafından yetkilendirilmiş olan, Platform’a işbu Kullanım Koşulları’nı elektronik olarak onaylamak sureti giriş yapan kat maliki, kiracı, daire sakini ve benzeri kişilerdir. İşbu Kullanım Koşulları’nda Site Sakini, “Siz” olarak da belirtilebilecektir.",
                  ),
                  CustomNumberedList(
                    number: 'Platform; ',
                    subtitle:
                        "Tüm hakları Noya'ya ait olan www.noyaiot.com alan adında ve alt alan adlarında faaliyet gösteren internet sitesi, yazılım ve/veya uygulamadır.",
                  ),
                  CustomNumberedList(
                    number: 'Hizmetler; ',
                    subtitle: "Noya tarafından sunulan hizmetlerin tamamıdır.",
                  ),
                  CustomNumberedList(
                    number: 'Kullanım Koşulları; ',
                    subtitle:
                        "Site Sakini’nin Hizmetler’den yararlanması ve Platform’u kullanmasına ilişkin Tarafların hak ve yükümlülüklerini düzenleyen işbu Site Sakini Kullanım Koşulları’nı ifade eder.",
                  ),
                  CustomNumberedList(
                    number: 'İçerik; ',
                    subtitle:
                        "Site Sakini tarafından Platform’a yüklenen her neviden materyali ifade eder. Bu kapsamda, Site Sakini tarafından gönderilen mesajlar ve yayınlanan ilanlar ile bu ilanlarda yer alan fotoğraf ve metinler de işbu Kullanım Koşulları’nda İçerikler olarak belirtilmektedir.",
                  ),
                  CustomNumberedList(
                    number: 'Mucbir Sebep; ',
                    subtitle:
                        "Kullanım Koşulları’nın yürürlüğe girdiği tarihte öngörülmesi mümkün olmayan ve Tarafların dahli olmaksızın gelişen ve Tarafların yüklendikleri borç ve sorumlulukları kısmen veya tamamen yerine getirmelerini imkânsızlaştıran doğal afetler, harp, seferberlik, yangın, grev ve lokavt veya hükümet veya resmi makamlarca alınmış kararlar ile altyapı sorunları, telekomünikasyon şebekelerindeki arızalar, elektrik kesintileri veya beklenmedik hallerin tamamını ifade eder. Mücbir sebep sayılan tüm durumlarda Noya, Kullanım Koşulları ile belirlenen edimlerinden herhangi birini geç veya eksik ifa etme veya ifa etmeme nedeniyle sorumlu tutulamaz. Bu ve bunun gibi durumlar, Noya açısından, gecikme, ifa etmeme veya temerrüt addedilmeyecek veya bu durumlar için Noya'nın Site Sakini’nin herhangi bir zararını tazmin yükümlülüğü doğmayacaktır.",
                  ),
                  CustomNumberedList(
                    number: 'Taraflar; ',
                    subtitle:
                        "Kulanım Koşulları’nın tarafı olan Site Sakini ve PublicArea'yı ifade eder.",
                  ),

                  CustomNumberedList(
                    title: '3. Üyelik',
                    number: '3.1. ',
                    subtitle:
                        " Site Sakini, Platform’un kullanımına imkân veren hesaplar, kullanıcı adı ve şifre de dahil olmak üzere tüm bilgilerin kullanım ve yönetiminden bizzat sorumludur. Bu kapsamda, Site Sakini; hesaplarını, kullanıcı adı ve şifresi ile üyelik profillerini hiçbir şart ve koşulda başka bir kullanıcıya devredemez veya üçüncü kişilerce kullanımına izin veremez. Site Sakini’ne ait hesaptan, kullanıcı adı ve şifre ile gerçekleştirilen her işlem bizzat Site Sakini tarafından gerçekleştirilmiş sayılır ve bu bilgilerinin Site Sakini dışında bir kişi tarafından kullanılması, kaybolması veya el değiştirmesi nedeniyle Site Sakini’nin ve/veya üçüncü kişilerin uğradığı zararlardan münhasıran Site Sakini sorumlu olacaktır. Site Sakini, hesabının ve/veya şifresinin yetkisiz kullanımı veya hesaba ilişkin güvenliğin başka şekilde ihlalinden haberdar olduğunda, bu durumu derhal Noya'ya bildirmekle yükümlüdür. Noya, izinsiz kullanımı engellemek amacıyla Site Sakini’nin Platform’a erişimini engelleme ve/veya üyeliğini sona erdirme hakkına sahiptir.",
                  ),
                  CustomNumberedList(
                    number: '3.2. ',
                    subtitle:
                        "Site Sakini, Platform’un kullanımına imkân veren hesabına ilişkin kullanıcı adı ve şifre bilgilerini dilediği zaman değiştirebilir, güncelleyebilir ve kullanıcı hesabını istediği zaman Platform üzerinden kapatabilir. Site Sakini, kullanıcı hesabını kapadığında kullanıcı adı ve şifre bilgileri kullanılmaz hale gelir ve söz konusu bilgilere erişim engellenir. Site Sakini; hesap kapatma işlemi yaptığı hallerde Noya'nın 6698 sayılı kişisel Verilerin Korunması Kanunu (“KVKK”) uyarınca veri sorumlusu sıfatını haiz olduğu durumlarda Site Sakini, verilerinin yürürlükteki mevzuat uyarınca Noya'nın saklamakla yükümlü olduğu veriler hariç, Platform üzerinden silineceğini ancak Noya'nın veri işleyen sıfatını haiz olduğu durumlar için söz konusu verilerin silinmesine ilişkin veri sorumlusuna başvurması gerektiğini bildiğini kabul, beyan ve taahhüt eder.",
                  ),
                  CustomNumberedList(
                    number: '3.3. ',
                    subtitle:
                        "Site Sakini, Noya'nın verilen hiçbir bilgiyi kontrol etmekle yükümlü olmadığını ve kendisine verilen bilgilerin doğruluğunu hiçbir koşul altında taahhüt etmediğini peşinen kabul, beyan ve taahhüt eder. Bununla birlikte Site Sakini, Hizmetler’in talep edilen şekilde verilebilmesi için Platform’a kendilerine ait, gerçek ve eksiksiz bilgileri vermekle yükümlü olduklarını; aksi taktirde, söz konusu bilgileri yanlış vermelerinden dolayı Noya'nın her zararını karşılamakla yükümlüdür.",
                  ),
                  CustomNumberedList(
                    number: '3.4. ',
                    subtitle:
                        "Site Sakini, dilediği zaman herhangi bir bildirimde bulunmaksızın Platform’daki hesabını kapatma hakkına sahiptir. Ancak bu takdirde, Site Sakini’nin Platform üzerinden sağlanan Hizmetler’den faydalanması mümkün olmayacaktır.",
                  ),

                  CustomNumberedList(
                    title: '4. Tarafların Hak ve Yükümlülükleri',
                    number: '4.1. ',
                    subtitle:
                        "Noya, toplu yaşam alanı yöneticileri ve toplu yaşam alanları tarafından yetkilendirilen yönetim şirketleri için dijital hizmet veren yardımcı bir platformdur. Noya, toplu yaşam alanı yöneticileri ve toplu yaşam alanlarınca yetkilendirilen yönetim şirketleri ile akdettiği hizmet sözleşmesi çerçevesinde, Yöneticiler’e ve Site Sakini’ne kapsamlı hizmetler sunmaktadır. Site Sakini’ne işbu Kullanım Koşulları ile sağlananlar da dahil olmak üzere Noya tarafından sunulan tüm Hizmetler, Noya ile Yönetici arasında akdedilmiş olan Hizmet Sözleşmesi kapsamında sunulmaktadır. Bu kapsamda Noya, Platform üzerinden sağladığı Hizmetler bakımından 5651 sayılı İnternet Ortamında yapılan Yayınların Düzenlenmesi ve Bu Yayınlar Yoluyla İşlenen Suçlarla Mücadele Edilmesi Hakkında Kanun çerçevesinde tanımlandığı şekli ile “yer sağlayıcı” sıfatını haiz olup Site Sakini, bu kapsamda Noya’nın Platform’a Yönetici, Site Sakini ve/veya diğer Site Sakinleri tarafından girilmiş içerikler bakımından herhangi bir sorumluluğu bulunmadığını kabul ve beyan eder.",
                  ),
                  CustomNumberedList(
                    number: '4.2. ',
                    subtitle:
                        "Yönetici, Site Sakini ile olan sözleşme ilişkisi çerçevesinde ve Hizmet Sözleşmesi kapsamında Platform’a Site Sakini ile ilgili bazı bilgi ve/veya sair veriler yüklemiş, göndermiş veya sair şekillerde girilmiş olabilir. Noya, Yönetici tarafından Platform’a yüklenen, gönderilen veya sair şekillerde girilen bilgi ve veriler üzerinde herhangi bir tasarrufta bulunmamakta, söz konusu bilgi ve verileri yalnızca ve sadece Yönetici tarafından yönlendirilen talepler doğrultusunda Yönetici’nin kullanımına sunmak maksadıyla muhafaza hizmeti sağlamaktadır. Bu kapsamda, şahsınıza ait bazı bilgi ve/veya verilerin Platform’da muhafaza edilmemesini talep ediyorsanız, Noya’ya hukuk@noya.com e-posta adresine e-posta göndermek sureti ile bildirimde bulunmanız ve derhal 6698 sayılı Kişisel Verilerin Korunması Kanunu kapsamında veri sorumlusu sıfatını haiz Yöneticiniz ile iletişime geçmeniz gerektiğini bildiririz.",
                  ),
                  CustomNumberedList(
                    number: '4.3. ',
                    subtitle:
                        "Site Sakini ve/veya Yönetici tarafından sağlanan bilgi ve verilere ilişkin düzenlemeler Kullanım Koşulları ve Aydınlatma Metni kapsamında düzenlenmektedir. Site Sakini tarafından sağlanan kişisel verilerin 6698 sayılı Kişisel Verilerin Korunması Kanunu kapsamında ancak açık rıza ile işlenebileceği durumlarda, Platform üzerinden Site Sakini’nin açık rızaları ayrıca alınmaktadır. Noya, Site Sakini bilgilerini işbu Kullanım Koşulları ve Aydınlatma Metni’nde belirtilen kapsam dışında kullanmamakta ve üçüncü kişilere aktarmamaktadır.",
                  ),
                  CustomNumberedList(
                    number: '4.4. ',
                    subtitle:
                        "Site Sakini’nin, Platform’dan ve Hizmetler’den faydalanmak için talep edilen bilgileri tam, doğru ve güncel bir şekilde sağlayarak veya Yönetici tarafından Platform’a girilen bilgilerin doğruluğunu ve/veya güncelliğini kontrol ederek Kullanım Koşulları’nı onaylaması gerekmektedir. Bu kapsamda, Site Sakini; sağladığı veya Yönetici tarafından Platform’a girilmiş bilgilerde herhangi bir değişiklik olması halinde, bilgileri derhal güncellemekle yükümlüdür. Bu bilgilerin eksik veya gerçeğe aykırı olarak verilmesi ya da güncel olmaması nedeniyle Site Sakini’nin Platform’dan veya Hizmetler’den faydalanamamasından Noya sorumlu değildir.",
                  ),
                  CustomNumberedList(
                    number: '4.5. ',
                    subtitle:
                        "Yönetici, Site Sakinleri’ne Platform üzerinden info@noya.com uzantılı e-posta aracılığıyla yönetimini üstlendiği siteye ilişkin duyurular yapabilir. Yapılacak bu duyuruların, içeriğinden ve mevzuata uygunluğundan Yönetici sorumludur. Site Sakini, yapılacak duyuruların Yönetici tarafından yapıldığını, Noya’nın yapılacak duyuruların içeriğini denetleme yükümlülüğü olmadığını ve yapılacak duyurulara ilişkin her türlü yasal, idari ve cezai sorumluluk ile duyurulara ilişkin taleplerden Yönetici’nin sorumlu olduğunu kabul ve beyan eder.",
                  ),
                  CustomNumberedList(
                    number: '4.6. ',
                    subtitle:
                        "Yönetici Platform üzerinden Site Sakini’ne gönderilecek e-posta ve/veya SMS’lerin sadece yönetiminden sorumlu olduğu siteye ilişkin aidat ve benzeri içeriğe sahip iletiler amacıyla kullanabilir. Site Sakini, Platform üzerinden gönderilen tim e-posta ve SMS’lerin Yönetici tarafından gönderildiğini, gönderilen iletilerin 6563 sayılı Elektronik Ticaretin Düzenlenmesi Hakkında Kanun ve Ticari İletişim ve Ticari Elektronik İletiler Hakkında Yönetmelik uyarınca, ticari elektronik ileti olarak değerlendirilmesi halinde tüm taleplerden, Yönetici’nin sorumlu olduğunu ve mevzuata aykırı ileti gönderiminin söz konusu olması halinde Noya’nın herhangi bir sorumluluğu bulunmadığını kabul ve beyan eder.",
                  ),
                  CustomNumberedList(
                    number: '4.7. ',
                    subtitle:
                        "Site Sakini, 18 yaşını doldurduğunu ve Kullanım Koşulları’nı akdetmek için gereken yasal ehliyete sahip bulunduğunu beyan eder.",
                  ),
                  CustomNumberedList(
                    number: '4.8. ',
                    subtitle:
                        "Site Sakini, Platform’u ve Hizmetler’i, işbu Kullanım Koşulları ile belirlenmiş kullanım kurallarına uygun olarak kullanacağını ve Platform’daki her türlü faaliyetinin oluşturduğu tüm içeriğin kullanım kurallarına ve yürürlükteki mevzuata uygun olacağını peşinen kabul ve taahhüt eder. Bu kapsamda Site Sakini, Platform gerçekleştireceği tüm işlemlerde Kullanım Koşulları ile Platform’da yayınlanan kural ve koşullar ile kanuna, ahlaka ve adaba, dürüstlük ilkelerine uyacak, herhangi bir yöntem ile Platform’un işleyişini engelleyebilecek davranışlarda, üçüncü kişilerin haklarına tecavüz eden veya etme tehlikesi bulunan fiillerde bulunmayacaktır.",
                  ),
                  CustomNumberedList(
                    number: '4.9. ',
                    subtitle:
                        "Site Sakini, Noya’nın sağladığı herhangi bir iletişim kanalı üzerinden üçüncü kişilerin kişilik haklarını ihlal eden, uygunsuz, cinsel içerikli, hakaret ve nefret söylemi içeren, iftira niteliğinde veya tehdit, korkutmak ve/veya taciz amaçlı, içerik paylaşımlarında bulunmayacağını; belirtilen şekilde bir içeriği tespit etmesi halinde ise Noya’yı bilgilendirmekle yükümlü olduğunu kabul ve taahhüt eder.",
                  ),
                  CustomNumberedList(
                    number: '4.10. ',
                    subtitle:
                        "Platform’un kullanımından her türlü yasal, idari ve cezai sorumluluk Platform’u kullanan Site Sakini’ne aittir. Noya, Site Sakini’nin Platform üzerinde sırasında gerçekleştirdiği faaliyetler ve/veya Kullanım Koşulları ve yürürlükteki mevzuata aykırı eylemleri neticesinde üçüncü kişilerin uğradıkları veya uğrayabilecekleri zararlardan doğrudan ve/veya dolaylı olarak hiçbir şekilde sorumlu tutulamaz. Üçüncü kişilerden bu kapsamda gelecek her türlü talebe ilişkin olarak, Site Sakini’nin Kullanım Koşulları’nda veya ilgili mevzuatta belirtilen yükümlülüklerini yerine getirmemesi nedeniyle Noya’nın uğrayacağı zararlar için ilk talepte ferileri ile birlikte ödenmek üzere Site Sakini’ne rücu edilecektir.",
                  ),
                  CustomNumberedList(
                    number: '4.11. ',
                    subtitle:
                        "Platform üzerinden sağlanan Hizmetler’e erişim olanakları, büyük ölçüde ilgili internet servis sağlayıcısından verilen hizmetin kalitesine dayanmaktadır. Noya’nın, internet servis sağlayıcılar tarafından verilen hizmete veya bu hizmetin kalitesine ilişkin herhangi bir taahhüdü ve/veya sorumluluğu bulunmamaktadır. Bu kapsamda Site Sakini, Platform’un kusurdan ari olmadığını, Noya’nın aksi için elinden gelen iyi niyetli tüm çabayı sarf etmesine rağmen zaman zaman teknik aksaklıkların ve/veya erişim engellerinin yaşanmasının mümkün olduğunu peşinen kabul eder.",
                  ),
                  CustomNumberedList(
                    number: '4.12. ',
                    subtitle:
                        "Site Sakini, Platform üzerinden Noya’nın kontrolünde olmayan başka internet sitelerine ve/veya platformlara, dosyalara veya içeriklere bağlantı (link) verilebileceğini, üçüncü taraflara ait hizmetlerin sunulabileceği ve bu tür bağlantıların, yöneltildiği internet sitesini veya işletmecisini her ne şekilde olursa olsun desteklemek amacı içermediğini veya internet sitesi veya içerdiği bilgilere yönelik herhangi bir türde bir beyan veya garanti niteliği taşımadığını, söz konusu bağlantılar vasıtasıyla erişilen platformlar, internet siteleri, dosyalar ve içerikler, hizmetler veya ürünler veya bunların içeriği hakkında Noya’nın herhangi bir sorumluluğu bulunmadığını kabul ve beyan eder. Bu kapsamda, Platform üzerinden bağlantı (link) verilen herhangi bir içerik, ilgili içeriğin Noya tarafından onaylandığı anlamına gelmemektedir. İlgili içeriklerin Site Sakini tarafından tercih edilmesi durumunda ilgili Site Sakini’nin kişisel verilerinin tercih edilen içeriğe ilişkin olarak üçüncü kişilerle paylaşılmasının gerekmesi durumunda Site Sakini ilgili içeriğe ilişkin olarak bilgilendirilip bu konuda ayrıca açık rızası alındıktan sonra kişisel verileri söz konusu içeriği sağlayan taraf ile paylaşılacaktır.",
                  ),
                  CustomNumberedList(
                    title: '5. Mesajlaşma Özelliği',
                    number: '5.1. ',
                    subtitle:
                        "Site Sakini tarafından Mesajlaşma Özelliği’nin kullanılması sırasında gönderilen mesajlar şifrelenmemektedir. Paylaştığınız İçerik’i silmeyi tercih etmeniz halinde; İçerik, Mesajlaşma Özelliği bölümünden silinecektir.",
                  ),
                  CustomNumberedList(
                    number: '5.2. ',
                    subtitle:
                        "İçerikler’inizde hukuka aykırı bir kullanım tespit edilmesi halinde, bu içeriğin bir mahkeme kararı veya savcılık tarafından talep edilmesi söz konusu olursa anılan içerikler, Noya tarafından 6698 sayılı Kişisel Verilerin Korunması Kanunu m. 28 kapsamında talep sahibine iletilecektir.",
                  ),
                  CustomNumberedList(
                    number: '5.3. ',
                    subtitle:
                        "Site Sakini, Hizmetler’i hukuka ve yürürlükteki mevzuata uygun şekilde kullanmayı kabul ve taahhüt eder. Site Sakini, Hizmetler’i kullanırken yapacağı her işlem ve eylemden doğan hukuki ve cezai sorumluluktan bizzat sorumludur.",
                  ),
                  CustomNumberedList(
                    number: '5.4. ',
                    subtitle:
                        "Site Sakini, kendi kişisel verileri de dahil hiçbir gizli bilgiyi Mesajlaşma Özelliği üzerinden paylaşmayacağını, kendi kişisel verileri de dahil gizli bilgilerin paylaşılası nedeniyle doğabilecek tüm sorumluluğunun kendisine ait olduğunu, Noya’nın kişisel veriler ve gizli bilgilerin Site Sakini tarafından paylaşılması hususunda hiçbir sorumluluğu bulunmadığını kabul ve taahhüt eder.",
                  ),
                  CustomNumberedList(
                    number: '5.5. ',
                    subtitle:
                        "Noya, Site Sakini’nin davranışlarından sorumlu değildir. Noya’nın Mesajlaşma Özelliğinin kullanılması sebebiyle, Site Sakinler’i arasındaki çevrimiçi veya çevrimdışı her türlü iletişim ve etkileşimden doğan kayıp, hasar, zarar vs. gibi sonuçlardan sorumluluğu bulunmamaktadır. Noya’nın bu tür eylemler neticesinde uğrayabileceği her tür doğrudan veya dolaylı, maddi veya manevi zararın tazminini talep hakkı saklıdır.",
                  ),
                  CustomNumberedList(
                    number: '5.6. ',
                    subtitle:
                        "Noya; İçerikler’de hukuka ve/veya işbu Kullanım Koşulları ve diğer politika belgelerinde belirtilen kural ve koşullara aykırı bir paylaşım tespit etmesi halinde Hizmetler’i dilediği zaman, ayrıca herhangi bir gerekçe göstermeksizin duraklatabilir, durdurabilir veya Hizmetler’i sunmaya tamamen son verebilir. Bu durumda; İçerikler’in tamamı Platform üzerinden silinebilir. Aynı şekilde Noya, işbu Kullanım Koşulları ve diğer politika belgelerinde belirtilen kural ve koşullar çerçevesinde Site Sakini’nin hesabını belirli bir süre askıya alabilir veya iptal edebilir.",
                  ),
                  CustomNumberedList(
                    title: '6. İlan Paylaşma',
                    number: '6.1. ',
                    subtitle:
                        "İlan Paylaşma Özelliği’ni kullanılarak Site Sakini tarafından yüklenen fotoğraflara ve verilen bilgilere ilişkin tüm sorumluluk Site Sakini’ne ait olup Noya’nın yayınlanan ilan ve İçerikler’e ilişkin kontrol ve denetleme de dahil olmak ve fakat bunlarla sınırlı olmamak üzere herhangi bir sorumluluğu bulunmamaktadır.",
                  ),
                  CustomNumberedList(
                    number: '6.2. ',
                    subtitle:
                        "Noya; İçerikler’de hukuka ve/veya işbu Kullanım Koşulları ve diğer politika belgelerinde belirtilen kural ve koşullara aykırı bir paylaşım tespit etmesi ve/veya kendisine bu yönde üçüncü kişilerden bir bildirim yönlendirilmesi halinde Hizmetler’i dilediği zaman, ayrıca herhangi bir gerekçe göstermeksizin duraklatabilir, durdurabilir veya Hizmetler’i sunmaya tamamen son verebilir, İçerikler’in bir kısmını veya tamamını Platform üzerinden silebilir. Aynı şekilde Noya, işbu Kullanım Koşulları ve diğer politika belgelerinde belirtilen kural ve koşullar çerçevesinde Site Sakini’nin hesabını belirli bir süre askıya alabilir veya iptal edebilir.",
                  ),
                  CustomNumberedList(
                    number: '6.3. ',
                    subtitle:
                        "İlan Paylaşma Özelliği’nin kullanılması sırasında, Noya tarafından belirlenen yasaklı ürünler listesinde yer alan ürünlerin yayınlanması kesinlikle yasaktır. Yasaklı ürünlerin bulunduğu İçerikler’den doğan hukuki ve cezai sorumluluktan bizzat Site Sakini sorumludur.",
                  ),
                  CustomNumberedList(
                    number: '6.4. ',
                    subtitle:
                        "Site Sakini tarafından paylaşılan ilanlar, paylaşımda bulunulan apartman veya sitenin ilanlar sayfasında yayınlanacak ve sadece bu siteye kayıtlı Site Sakinler’i tarafından görüntülenebilecektir.",
                  ),
                  CustomNumberedList(
                    number: '6.5. ',
                    subtitle:
                        "Site Sakini bir başkasının gizlilik hakkını ya da yayın haklarını çiğneyen; telif hakları, ticari marka hakları veya başka mülkiyet hakları tarafından korunan ya da belirtilen şekildeki İçerikler’i yayınlayamaz. Bu hükmün aykırılığının tespiti halinde Noya aykırılığa sebep olan Site Sakini’nin üyeliğini derhal ve ayrıca bir bildirimde bulunmaksızın sona erdirebilir.",
                  ),
                  CustomNumberedList(
                    title: '7. Fikri Haklar',
                    number: '7.1. ',
                    subtitle:
                        "Platform’da bulunan yazılım, görsel ve tasarımların, yazıların, logoların, grafiklerin her türlü hakkı Noya’ya aittir. Platform’un tasarımında, içeriğinde ve veri tabanı oluşturulmasında kullanılan bilgi ve/veya yazılımın kopyalanması ve/veya Platform’dan faydalanmanın ötesinde kullanılması, Platform dahilinde bulunan her türlü resim, metin, imge, dosya vb. verilerin kopyalanması, dağıtılması, işlenmesi ve sair şekillerde kullanılması kesinlikle yasaktır. Bu kapsamda Site Sakini, Noya’dan öncül açık ve yazılı izin almadan, Platform’u ve/veya içeriğini kopyalamayacağını, değiştirmeyeceğini, bu içerikten türevler yaratmayacağını ya da bunları teşhir etmeyeceğini, ticarete konu etmeyeceğini; aksi halde hukuki ve cezai olarak sorumlu olacağını ve bu taktirde Noya’nın tüm zararını karşılamakla yükümlü olacağını kabul ve taahhüt eder.",
                  ),
                  CustomNumberedList(
                    number: '7.2. ',
                    subtitle:
                        "Site Sakinleri’nin (i) Platform’un güvenliğini tehdit edebilecek, Platform’a ait yazılımların çalışmasını veya diğer Site Sakinleri’nin Platform’dan faydalanmasını engelleyebilecek ve/veya diğer Site Sakinleri’ne zarar verebilecek herhangi bir girişimde bulunması, (ii) Platform’a bu sonuçları oluşturacak şekilde orantısız yük bindirmesi, Platform’da yayımlanmış ve/veya başkaları tarafından girilmiş bilgilere yetkisiz bir şekilde erişmesi, bu bilgileri kopyalaması, silmesi, değiştirmesi ya da bu yönde denemeler yapması; (iii) Platform’un ve de kullanılan yazılımların çalışmasını engelleyecek yazılımların kullanılması, kullanılmaya çalışılması veya her türlü yazılım, donanımın ve sunucuların çalışmasının aksatılması, bozulmasına yol açılması, tersine mühendislik yapılması, saldırılar düzenlenmesi veya sair surette müdahale edilmesi, Noya sunucularına yetkisiz erişim sağlanmaya çalışılması kesinlikle yasaktır.",
                  ),
                  CustomNumberedList(
                    title: '8. Sorumluluğun Sınırlandırılması',
                    number: '8.1. ',
                    subtitle:
                        "Noya, Platform’a girilmesi, Platform’un ya da Platform’daki bilgilerin ve diğer verilerin programların vs. kullanılması, hizmetlerden yararlanılması, Kullanım Koşulları’nın ihlali, haksız fiil ya da başkaca sebeplere binaen, ağır kusuru dışında doğabilecek doğrudan ya da dolaylı hiçbir zarardan sorumlu değildir. Noya, Kullanım Koşulları’nın ihlali, haksız fiil, ihmal veya diğer sebepler neticesinde; hata, ihmal, verilerin silinmesi, kaybı, işlemin veya iletişimin gecikmesi, bilgisayar virüsü, iletişim hatası, hırsızlık, imha, izinsiz olarak kayıtlara girilmesi, kayıtların değiştirilmesi veya kullanılması hususunda herhangi bir sorumluluk kabul etmez. Site Sakini; Platform’a ya da bağlantı (link) verilen sitelere girilmesi, Platform’un kullanımı sonucunda doğabilecek her tür sorumluluktan, mahkeme masrafları ve diğer masraflar da dahil olmak üzere, Noya’yı her tür zarar ve talep hakkından ber’i kılmaktadır.",
                  ),
                  CustomNumberedList(
                    number: '8.2. ',
                    subtitle:
                        "Site Sakini, Noya’nın Platform üzerinden paylaşılan hiçbir bilginin gerçekliğini, orijinalliğini, güvenliğini, doğruluğunu araştırma, bunların paylaşılmasının hukuka uygun olup olmadığını tespit etme sorumluluğu bulunmadığını, söz konusu bilgiler sebebiyle ortaya çıkabilecek zararlardan dolayı Noya’nın herhangi bir sorumluluğu bulunmadığını kabul ve beyan eder.",
                  ),
                  CustomNumberedList(
                    number: '8.3. ',
                    subtitle:
                        "Site Sakini’nin Platform’u kullanması ve Hizmetler’den yararlanması ile ilgili her türlü risk münhasırsan Site Sakini üzerindedir. Site Sakini, Hizmetler’i Kullanım Koşulları’nı yürürlük tarihi itibarı ile mevcut haliyle, “olduğu gibi” kabul eder. Noya, Kullanım Koşulları kapsamında ticari elverişlilik, belli bir amaca veya kullanıma uygunluk veya ihlalin söz konusu olmamasına ilişkin olarak açık veya zımni herhangi bir taahhütte bulunmamaktadır. Noya, Site Sakini’nin tüm taleplerinin karşılanacağı garantisini vermez; ancak, hizmet kalitesini arttırmak, kapsamını genişletmek ya da çeşitlendirmek amacıyla hizmet içeriğinde, özelliklerinde ve/veya modüllerde, değişiklik yapma hakkını saklı tutar. İşbu değişiklikler çevrimiçi (online) olarak yayınlanacak olup yayını tarihinden itibaren geçerli olacaktır. Site Sakini’nin yapılan değişiklikleri gerekçe göstererek Noya’dan herhangi bir talepte bulunma hakkı yoktur. Site Sakini, Platform’un kullanımına ilişkin olarak Noya’dan hangi nam altında olursa olsun herhangi bir şekilde talepte bulunmayacağını, Noya’nın Platform’un ve/veya Hizmetler’in kusursuz olacağına ve/veya Site Sakini’nin tüm beklentilerini karşılayacağına dair herhangi bir garanti ya da taahhüt vermediğini kabul, beyan ve taahhüt eder. Noya, uygulanacak hukukun izin verdiği ölçüde, kar kaybı, şerefiye ve itibar kaybı, dahil ancak bunlarla sınırlı olmaksızın Hizmetler’in kullanımı Site Sakini’nin fiilleri nedeniyle meydana gelen hiçbir doğrudan, dolaylı, özel, arızı, cezai zarardan sorumlu olmayacaktır.",
                  ),
                  CustomNumberedList(
                    title: '9. Sözleşme’nin Askıya Alınması ve Feshi',
                    number: '9.1. ',
                    subtitle:
                        "Site Sakini, dilediği zaman Platform’daki hesabını kapatabilir. Bu takdirde, Site Sakini’nin Platform üzerinden sağlanan Hizmetler’den faydalanması mümkün olmayacaktır.",
                  ),
                  CustomNumberedList(
                    number: '9.2. ',
                    subtitle:
                        "Site Sakini’nin ikamet ettiği toplu yaşam alanından her ne nedenle olursa olsun taşınması veya sair bir şekilde ilgili toplu yaşam alanı ile herhangi bir bağının kalmaması durumunda Platform’un ilgili toplu yaşam alanına ilişkin kısmına girişi kısıtlanabilir veya tamamen engellenebilir. Bu takdirde, Site Sakini’nin hesabı kendiliğinden kapanmayacak olup Site Sakini Platform’u kullanmaya devam etmeyecek ise kendi hesabını kapatmakla veya bu yöndeki talebini Noya’ya bildirmekle yükümlüdür. Noya’nın bu hususta kendisine bildirim yapılmaması halinde herhangi bir yükümlülüğü bulunmamaktadır.",
                  ),
                  CustomNumberedList(
                    number: '9.3. ',
                    subtitle:
                        "Site Sakini’nin Kullanım Koşulları ve/veya eklerinde yer alan hükümlere, kural ve şartlara uymaması, faaliyetlerinin hukuki, teknik veya bilgi güvenliği anlamında risk oluşturması ya da üçüncü kişilerin şahsi ve ticari haklarına halel getirici mahiyette olması halinde Apsiyon, Site Sakini’nin Platform’u kullanımını geçici veya sürekli olarak durdurabilir yahut Kullanım Koşulları’nı feshedebilir. Site Sakini’nin bu nedenle Noya’dan herhangi bir talebi söz konusu olamaz.",
                  ),
                  CustomNumberedList(
                    number: '9.4. ',
                    subtitle:
                        "Noya dilediği zaman ayrıca herhangi bir gerekçe göstermeksizin Kullanım Koşulları’nı süreli veya süresiz olarak askıya alabilir veya sona erdirebilir, Site Sakini’nin hesabını öncül bir açıklama yapmaksızın askıya alabilir veya kapatabilir.",
                  ),
                  CustomNumberedList(
                    title: '10. Sözleşme’nin Askıya Alınması ve Feshi',
                    number: '10.1. ',
                    subtitle:
                        "Bu Kullanım Koşulları ile ilgili olarak çıkabilecek bütün uyuşmazlıklarda öncelikle işbu metinde yer alan hükümler, hüküm bulunmayan konularda ise Türkiye Cumhuriyeti mevzuatı uygulanacaktır. Kullanım Koşulları’nın uygulanmasından kaynaklanan ihtilafların çözümünde İstanbul Anadolu Mahkemeleri ve İcra Daireleri yetkili olacaktır.",
                  ),

                  //Image.asset('assets/images/noya.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class MyDynamicTexts extends StatelessWidget {
//   // Örnek metinlerin bulunduğu bir liste
//   final List<String> texts = [
//     'Metin 1',
//     'Metin 2',
//     'Metin 3',
//     // ... diğer metinler ...
//     'Metin 10',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         for (var text in texts)
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Text(
//               text,
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         Image.asset('assets/images/your_image.png'), // Sizin resminizi ekleyin
//       ],
//     );
//   }
// }
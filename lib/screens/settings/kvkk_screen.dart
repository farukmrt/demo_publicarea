import 'package:demo_publicarea/widgets/custom_numbered_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:demo_publicarea/utils/colors.dart';
import 'package:demo_publicarea/providers/user_providers.dart';

class KvkkScreen extends StatefulWidget {
  static String routeName = '/kvkkscreen';

  const KvkkScreen({Key? key}) : super(key: key);

  @override
  State<KvkkScreen> createState() => _KvkkScreenState();
}

class _KvkkScreenState extends State<KvkkScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      color: backgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('KVKK '),
          ),
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  Text(
                    'AYDINLATMA YÜKÜMLÜLÜĞÜNÜN YERİNE GETİRİLMESİNDE UYULACAK USUL VE ESASLAR HAKKINDA TEBLİĞ',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  CustomNumberedList(
                    title: 'Amaç ve Kapsam',
                    number: 'MADDE 1 - ',
                    subtitle:
                        "Bu Tebliğin amacı, 24/3/2016 tarihli ve 6698 sayılı Kişisel Verilerin Korunması Kanununun 10 uncu maddesi uyarınca veri sorumluları veya yetkilendirdiği kişilerce yerine getirilmesi gereken aydınlatma yükümlülüğü kapsamında uyulacak usul ve esasları belirlemektir.",
                  ),
                  CustomNumberedList(
                    title: 'Dayanak',
                    number: 'MADDE 2 - ',
                    subtitle:
                        "Bu Tebliğ, 6698 sayılı Kişisel Verilerin Korunması Kanununun 22 nci maddesinin birinci fıkrasının (e) ve (g) bentlerine dayanılarak hazırlanmıştır.",
                  ),
                  CustomNumberedList(
                    title: 'Tanımlar',
                    number: 'MADDE 3 - ',
                    subtitle: "Bu Tebliğde geçen;",
                  ),
                  CustomNumberedList(
                    number: 'Alıcı grubu: ',
                    subtitle:
                        "Veri sorumlusu tarafından kişisel verilerin aktarıldığı gerçek veya tüzel kişi kategorisini,",
                  ),
                  CustomNumberedList(
                    number: 'İlgili kişi: ',
                    subtitle: "Kişisel verisi işlenen gerçek kişiyi,",
                  ),
                  CustomNumberedList(
                    number: 'Alıcı grubu: ',
                    subtitle:
                        "Veri sorumlusu tarafından kişisel verilerin aktarıldığı gerçek veya tüzel kişi kategorisini,",
                  ),
                  CustomNumberedList(
                    number: 'Kanun: ',
                    subtitle:
                        "24/3/2016 tarihli ve 6698 sayılı Kişisel Verilerin Korunması Kanununu,",
                  ),
                  CustomNumberedList(
                    number: 'Kurul: ',
                    subtitle: "Kişisel Verileri Koruma Kurulunu,",
                  ),
                  CustomNumberedList(
                    number: 'Kurum: ',
                    subtitle: "Kişisel Verileri Koruma Kurulunu,",
                  ),
                  CustomNumberedList(
                    number: 'Sicil: ',
                    subtitle:
                        "Başkanlık tarafından tutulan Veri Sorumluları Sicilini,",
                  ),
                  CustomNumberedList(
                    number: 'Veri kayıt sistemi: ',
                    subtitle:
                        "Tamamen veya kısmen otomatik olan ya da herhangi bir veri kayıt sisteminin parçası olmak kaydıyla otomatik olmayan yollarla işlenen kişisel verilerin bulunduğu her türlü ortamı,",
                  ),
                  CustomNumberedList(
                    number: 'Veri sorumlusu: ',
                    subtitle:
                        "Kişisel verilerin işleme amaçlarını ve vasıtalarını belirleyen, veri kayıt sisteminin kurulmasından ve yönetilmesinden sorumlu olan gerçek veya tüzel kişiyi,",
                  ),
                  CustomNumberedList(
                    number: 'Veri sorumlusu temsilcisi: ',
                    subtitle:
                        "Türkiye’de yerleşik olmayan veri sorumlularını 30/12/2017 tarihli ve 30286 sayılı Resmî Gazete’de yayınlanan Veri Sorumluları Sicili Hakkında Yönetmeliğin 11 inci maddesinin ikinci fıkrasında belirtilen konularda asgari temsile yetkili Türkiye’de yerleşik tüzel kişi ya da Türkiye Cumhuriyeti vatandaşı gerçek kişiyi ifade eder.",
                  ),
                  CustomNumberedList(
                    number:
                        'Bu Tebliğde yer almayan tanımlar için Kanundaki tanımlar geçerli olacaktır.',
                    subtitle: '',
                  ),
                  CustomNumberedList(
                    title: 'Aydınlatma yükümlülüğünün kapsamı',
                    number: 'MADDE 4 - ',
                    subtitle:
                        "Kanunun 10 uncu maddesine göre; kişisel verilerin elde edilmesi sırasında veri sorumluları veya yetkilendirdiği kişilerce, ilgili kişilerin bilgilendirilmesi gerekmektedir. Bu yükümlülük yerine getirilirken veri sorumluları veya yetkilendirdiği kişilerce yapılacak bilgilendirmenin asgari olarak aşağıdaki konuları içermesi gerekmektedir:",
                  ),
                  CustomNumberedList(
                    number: 'a) ',
                    subtitle:
                        "Veri sorumlusunun ve varsa temsilcisinin kimliği,",
                  ),
                  CustomNumberedList(
                    number: 'b) ',
                    subtitle: "Kişisel verilerin hangi amaçla işleneceği,",
                  ),
                  CustomNumberedList(
                    number: 'c) ',
                    subtitle:
                        "Kişisel verilerin kimlere ve hangi amaçla aktarılabileceği,",
                  ),
                  CustomNumberedList(
                    number: 'ç) ',
                    subtitle:
                        "Kişisel veri toplamanın yöntemi ve hukuki sebebi,",
                  ),
                  CustomNumberedList(
                    number: 'd) ',
                    subtitle:
                        "İlgili kişinin Kanunun 11 inci maddesinde sayılan diğer hakları.",
                  ),
                  CustomNumberedList(
                    title: 'Aydınlatma yükümlülüğünün kapsamı',
                    number: 'MADDE 5 - ',
                    subtitle:
                        "Veri sorumlusu ya da yetkilendirdiği kişi tarafından sözlü, yazılı, ses kaydı, çağrı merkezi gibi fiziksel veya elektronik ortam kullanılmak suretiyle aydınlatma yükümlülüğünün yerine getirilmesi esnasında aşağıda sayılan usul ve esaslara uyulması gerekmektedir:",
                  ),
                  CustomNumberedList(
                    number: 'a) ',
                    subtitle:
                        "İlgili kişinin açık rızasına veya Kanundaki diğer işleme şartlarına bağlı olarak kişisel veri işlendiği her durumda aydınlatma yükümlülüğü yerine getirilmelidir.",
                  ),
                  CustomNumberedList(
                    number: 'b) ',
                    subtitle:
                        "Kişisel veri işleme amacı değiştiğinde, veri işleme faaliyetinden önce bu amaç için aydınlatma yükümlülüğü ayrıca yerine getirilmelidir.",
                  ),
                  CustomNumberedList(
                    number: 'c) ',
                    subtitle:
                        "Veri sorumlusunun farklı birimlerinde kişisel veriler farklı amaçlarla işleniyorsa, aydınlatma yükümlülüğü her bir birim nezdinde ayrıca yerine getirilmelidir.",
                  ),
                  CustomNumberedList(
                    number: 'ç) ',
                    subtitle:
                        "Sicile kayıt yükümlülüğünün bulunması durumunda, aydınlatma yükümlülüğü çerçevesinde ilgili kişiye verilecek bilgiler, Sicile açıklanan bilgilerle uyumlu olmalıdır.",
                  ),
                  CustomNumberedList(
                    number: 'd) ',
                    subtitle:
                        "Aydınlatma yükümlülüğünün yerine getirilmesi, ilgili kişinin talebine bağlı değildir.",
                  ),
                  CustomNumberedList(
                    number: 'e) ',
                    subtitle:
                        "Aydınlatma yükümlülüğünün yerine getirildiğinin ispatı veri sorumlusuna aittir.",
                  ),
                  CustomNumberedList(
                    number: 'f) ',
                    subtitle:
                        "Kişisel veri işleme faaliyetinin açık rıza şartına dayalı olarak gerçekleştirilmesi halinde, aydınlatma yükümlülüğü ve açık rızanın alınması işlemlerinin ayrı ayrı yerine getirilmesi gerekmektedir.",
                  ),
                  CustomNumberedList(
                    number: 'g) ',
                    subtitle:
                        "Aydınlatma yükümlülüğü kapsamında açıklanacak kişisel veri işleme amacının belirli, açık ve meşru olması gerekir. Aydınlatma yükümlülüğü yerine getirilirken, genel nitelikte ve muğlak ifadelere yer verilmemelidir. Gündeme gelmesi muhtemel başka amaçlar için kişisel verilerin işlenebileceği kanaatini uyandıran ifadeler kullanılmamalıdır.",
                  ),
                  CustomNumberedList(
                    number: 'ğ) ',
                    subtitle:
                        "Aydınlatma yükümlülüğü kapsamında ilgili kişiye yapılacak bildirimin anlaşılır, açık ve sade bir dil kullanılarak gerçekleştirilmesi gerekmektedir.",
                  ),
                  CustomNumberedList(
                    number: 'h) ',
                    subtitle:
                        "Kanunun 10 uncu maddesinin birinci fıkrasının (ç) bendinde yer alan “hukuki sebep” ten kasıt, aydınlatma yükümlülüğü kapsamında kişisel verilerin Kanunun 5 ve 6 ncı maddelerinde belirtilen işleme şartlarından hangisine dayanılarak işlendiğidir. Aydınlatma yükümlülüğünün yerine getirilmesi esnasında hukuki sebebin açıkça belirtilmesi gerekmektedir.",
                  ),
                  CustomNumberedList(
                    number: 'ı) ',
                    subtitle:
                        "Aydınlatma yükümlülüğü kapsamında, kişisel verilerin aktarılma amacı ve aktarılacak alıcı grupları belirtilmelidir.",
                  ),
                  CustomNumberedList(
                    number: 'i) ',
                    subtitle:
                        "Aydınlatma yükümlülüğü kapsamında kişisel verilerin, tamamen veya kısmen otomatik yollarla ya da veri kayıt sisteminin parçası olmak kaydıyla otomatik olmayan yöntemlerden hangisiyle elde edildiği açık bir şekilde belirtilmelidir.",
                  ),
                  CustomNumberedList(
                    number: 'j) ',
                    subtitle:
                        "Aydınlatma yükümlülüğü yerine getirilirken eksik, ilgili kişileri yanıltıcı ve yanlış bilgilere yer verilmemelidir.",
                  ),
                  CustomNumberedList(
                    title:
                        'Kişisel verilerin ilgili kişiden elde edilmemesi halinde aydınlatma yükümlülüğü',
                    number: 'MADDE 6 - ',
                    subtitle:
                        "Kişisel verilerin ilgili kişiden elde edilmemesi halinde;",
                  ),
                  CustomNumberedList(
                    number: 'a) ',
                    subtitle:
                        "Kişisel verilerin elde edilmesinden itibaren makul bir süre içerisinde,",
                  ),
                  CustomNumberedList(
                    number: 'b) ',
                    subtitle:
                        "Kişisel verilerin ilgili kişi ile iletişim amacıyla kullanılacak olması durumunda, ilk iletişim kurulması esnasında,",
                  ),
                  CustomNumberedList(
                    number: 'c) ',
                    subtitle:
                        "Kişisel verilerin aktarılacak olması halinde, en geç kişisel verilerin ilk kez aktarımının yapılacağı esnada ilgili kişiyi aydınlatma yükümlülüğünün yerine getirilmesi gerekir.",
                  ),
                  CustomNumberedList(
                    title: 'Yürürlülük',
                    number: 'MADDE 7 - ',
                    subtitle: "Bu Tebliğ yayımı tarihinde yürürlüğe girer.",
                  ),
                  CustomNumberedList(
                    title: 'Yürütme',
                    number: 'MADDE 8 - ',
                    subtitle:
                        "Bu Tebliğ hükümlerini Kişisel Verileri Koruma Kurumu Başkanı yürütür.",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

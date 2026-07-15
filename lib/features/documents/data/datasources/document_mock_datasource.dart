import '../../domain/entities/document_field.dart';
import '../../domain/entities/document_template.dart';

abstract interface class DocumentDataSource {
  Future<List<DocumentTemplate>> fetchTemplates();
}

/// Statik hujjat shablonlari.
class DocumentMockDataSource implements DocumentDataSource {
  @override
  Future<List<DocumentTemplate>> fetchTemplates() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      DocumentTemplate(
        id: 'claim',
        title: 'Da\'vo arizasi',
        subtitle: 'Fuqarolik sudi uchun',
        fields: [
          DocumentField(
            key: 'full_name',
            label: 'F.I.SH. (to\'liq)',
            hint: 'Rahimov Jasur Akmalovich',
          ),
          DocumentField(
            key: 'passport',
            label: 'Pasport',
            hint: 'AA 1234567',
            halfWidth: true,
          ),
          DocumentField(
            key: 'claim_amount',
            label: 'Da\'vo summasi',
            hint: '25 000 000',
            type: DocumentFieldType.number,
            halfWidth: true,
          ),
          DocumentField(
            key: 'subject',
            label: 'Da\'vo mohiyati',
            hint: 'Meros mulkini qonuniy ulushlarga muvofiq bo\'lish '
                'to\'g\'risida...',
            type: DocumentFieldType.multiline,
          ),
        ],
      ),
      DocumentTemplate(
        id: 'contract',
        title: 'Oldi-sotdi shartnomasi',
        subtitle: 'Ikki tomon o\'rtasida',
        fields: [
          DocumentField(
            key: 'seller',
            label: 'Sotuvchi F.I.SH.',
            hint: 'Aliyev Sardor',
          ),
          DocumentField(
            key: 'buyer',
            label: 'Xaridor F.I.SH.',
            hint: 'Karimova Dilnoza',
          ),
          DocumentField(
            key: 'amount',
            label: 'Bitim summasi',
            hint: '50 000 000',
            type: DocumentFieldType.number,
            halfWidth: true,
          ),
          DocumentField(
            key: 'object',
            label: 'Bitim predmeti',
            hint: 'Avtomobil',
            halfWidth: true,
          ),
          DocumentField(
            key: 'terms',
            label: 'Qo\'shimcha shartlar',
            hint: 'To\'lov muddati, kafolat...',
            type: DocumentFieldType.multiline,
            required: false,
          ),
        ],
      ),
      DocumentTemplate(
        id: 'application',
        title: 'Ariza',
        subtitle: 'Davlat organiga murojaat',
        fields: [
          DocumentField(
            key: 'full_name',
            label: 'F.I.SH. (to\'liq)',
            hint: 'Rahimov Jasur Akmalovich',
          ),
          DocumentField(
            key: 'organ',
            label: 'Qaysi organga',
            hint: 'Toshkent shahar hokimligi',
          ),
          DocumentField(
            key: 'text',
            label: 'Ariza matni',
            hint: 'Murojaat mazmuni...',
            type: DocumentFieldType.multiline,
          ),
        ],
      ),
    ];
  }
}

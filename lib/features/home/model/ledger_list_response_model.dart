import 'package:xml/xml.dart';

class LedgerListResponseModel {
  LedgerListResponseModel({this.envelope});

  Envelope? envelope;

  factory LedgerListResponseModel.fromXml(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final envelopeNode = document.findElements('ENVELOPE').first;

    return LedgerListResponseModel(
      envelope: Envelope.fromXml(envelopeNode),
    );
  }
}

class Envelope {
  Envelope({this.header, this.body});

  Header? header;
  Body? body;

  factory Envelope.fromXml(XmlElement element) {
    return Envelope(
      header: element.findElements('HEADER').isNotEmpty
          ? Header.fromXml(element.findElements('HEADER').first)
          : null,
      body: element.findElements('BODY').isNotEmpty
          ? Body.fromXml(element.findElements('BODY').first)
          : null,
    );
  }
}

class Header {
  Header({this.version, this.status});

  String? version;
  String? status;

  factory Header.fromXml(XmlElement element) {
    return Header(
      version: element.findElements('VERSION').first.text,
      status: element.findElements('STATUS').first.text,
    );
  }
}

class Body {
  Body({this.desc, this.data});

  Desc? desc;
  Data? data;

  factory Body.fromXml(XmlElement element) {
    return Body(
      desc: element.findElements('DESC').isNotEmpty
          ? Desc.fromXml(element.findElements('DESC').first)
          : null,
      data: element.findElements('DATA').isNotEmpty
          ? Data.fromXml(element.findElements('DATA').first)
          : null,
    );
  }
}

class Desc {
  Desc({this.cmpinfo});

  Cmpinfo? cmpinfo;

  factory Desc.fromXml(XmlElement element) {
    return Desc(
      cmpinfo: element.findElements('CMPINFO').isNotEmpty
          ? Cmpinfo.fromXml(element.findElements('CMPINFO').first)
          : null,
    );
  }
}

class Cmpinfo {
  Cmpinfo({this.company, this.group, this.ledger});

  String? company;
  String? group;
  String? ledger;

  factory Cmpinfo.fromXml(XmlElement element) {
    return Cmpinfo(
      company: element.findElements('COMPANY').first.text,
      group: element.findElements('GROUP').first.text,
      ledger: element.findElements('LEDGER').first.text,
    );
  }
}

class Data {
  Data({this.collection});

  Collection? collection;

  factory Data.fromXml(XmlElement element) {
    return Data(
      collection: element.findElements('COLLECTION').isNotEmpty
          ? Collection.fromXml(element.findElements('COLLECTION').first)
          : null,
    );
  }
}

class Collection {
  Collection({this.ledgerList, this.ismstdeptype, this.mstdeptype});

  List<Ledger>? ledgerList;
  String? ismstdeptype;
  String? mstdeptype;

  factory Collection.fromXml(XmlElement element) {
    return Collection(
      ismstdeptype: element.getAttribute('ISMSTDEPTYPE'),
      mstdeptype: element.getAttribute('MSTDEPTYPE'),
      ledgerList: element.findElements('LEDGER').map((e) => Ledger.fromXml(e)).toList(),
    );
  }
}

class Ledger {
  Ledger({this.isdeleted, this.languagenameList, this.name, this.reservedname});

  Isdeleted? isdeleted;
  LanguagenameList? languagenameList;
  String? name;
  String? reservedname;

  factory Ledger.fromXml(XmlElement element) {
    return Ledger(
      name: element.getAttribute('NAME'),
      reservedname: element.getAttribute('RESERVEDNAME'),
      isdeleted: element.findElements('ISDELETED').isNotEmpty
          ? Isdeleted.fromXml(element.findElements('ISDELETED').first)
          : null,
      languagenameList: element.findElements('LANGUAGENAME.LIST').isNotEmpty
          ? LanguagenameList.fromXml(element.findElements('LANGUAGENAME.LIST').first)
          : null,
    );
  }
}

class Isdeleted {
  Isdeleted({this.type});

  String? type;

  factory Isdeleted.fromXml(XmlElement element) {
    return Isdeleted(
      type: element.getAttribute('TYPE'),
    );
  }
}

class LanguagenameList {
  LanguagenameList({this.nameList, this.languageid});

  NameList? nameList;
  String? languageid;

  factory LanguagenameList.fromXml(XmlElement element) {
    return LanguagenameList(
      languageid: element.findElements('LANGUAGEID').first.text.trim(),
      nameList: element.findElements('NAME.LIST').isNotEmpty
          ? NameList.fromXml(element.findElements('NAME.LIST').first)
          : null,
    );
  }
}

class NameList {
  NameList({this.name, this.type});

  String? name;
  String? type;

  factory NameList.fromXml(XmlElement element) {
    return NameList(
      type: element.getAttribute('TYPE'),
      name: element.findElements('NAME').first.text,
    );
  }
}

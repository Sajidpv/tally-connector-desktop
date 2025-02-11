import 'package:xml/xml.dart' as xml;

class StockListReponseModel {
  final Header header;
  final Body body;

  StockListReponseModel({required this.header, required this.body});

  factory StockListReponseModel.fromXml(String xmlString) {
    final document = xml.XmlDocument.parse(xmlString);
    final envelopeElement = document.getElement('ENVELOPE');
    return StockListReponseModel(
      header: Header.fromXml(envelopeElement!.getElement('HEADER')!),
      body: Body.fromXml(envelopeElement.getElement('BODY')!),
    );
  }
}

class Header {
  final String version;
  final String status;

  Header({required this.version, required this.status});

  factory Header.fromXml(xml.XmlElement element) {
    return Header(
      version: element.getElement('VERSION')?.innerText ?? '',
      status: element.getElement('STATUS')?.innerText ?? '',
    );
  }
}

class Body {
  final Desc desc;
  final Data data;

  Body({required this.desc, required this.data});

  factory Body.fromXml(xml.XmlElement element) {
    return Body(
      desc: Desc.fromXml(element.getElement('DESC')!),
      data: Data.fromXml(element.getElement('DATA')!),
    );
  }
}

class Desc {
  final Map<String, String> cmpInfo;

  Desc({required this.cmpInfo});

  factory Desc.fromXml(xml.XmlElement element) {
    final cmpInfoElement = element.getElement('CMPINFO');
    final Map<String, String> cmpInfo = {};
    cmpInfoElement?.children.whereType<xml.XmlElement>().forEach((e) {
      cmpInfo[e.name.toString()] = e.innerText;
    });
    return Desc(cmpInfo: cmpInfo);
  }
}

class Data {
  final List<StockItem> stockItems;

  Data({required this.stockItems});

  factory Data.fromXml(xml.XmlElement element) {
    final collectionElement = element.getElement('COLLECTION');
    final stockItemElements = collectionElement?.findAllElements('STOCKITEM') ?? [];
    return Data(
      stockItems: stockItemElements.map((e) => StockItem.fromXml(e)).toList(),
    );
  }
}

class StockItem {
  final String name;
  final String gstApplicable;
  final String baseUnits;
  final String openingBalance;
  final String openingValue;
  final String openingRate;
  final String standardPrice;
  final String languageName;

  StockItem({
    required this.name,
    required this.gstApplicable,
    required this.baseUnits,
    required this.openingBalance,
    required this.openingValue,
    required this.openingRate,
    required this.standardPrice,
    required this.languageName,
  });

  factory StockItem.fromXml(xml.XmlElement element) {
    return StockItem(
      name: element.getAttribute('NAME') ?? '',
      gstApplicable: element.getElement('GSTAPPLICABLE')?.innerText ?? '',
      baseUnits: element.getElement('BASEUNITS')?.innerText ?? '',
      openingBalance: element.getElement('OPENINGBALANCE')?.innerText ?? '',
      openingValue: element.getElement('OPENINGVALUE')?.innerText ?? '',
      openingRate: element.getElement('OPENINGRATE')?.innerText ?? '',
      standardPrice: element.getElement('STANDARDPRICE')?.innerText ?? '',
      languageName: element
              .getElement('LANGUAGENAME.LIST')
              ?.getElement('NAME.LIST')
              ?.getElement('NAME')
              ?.innerText ??
          '',
    );
  }
}

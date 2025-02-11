final String xmlAddNewStockRequest = '''<ENVELOPE>
    <HEADER>
        <TALLYREQUEST>Import Data</TALLYREQUEST>
    </HEADER>
    <BODY>
        <IMPORTDATA>
            <REQUESTDESC>
                <REPORTNAME>All Masters</REPORTNAME>
            </REQUESTDESC>
            <REQUESTDATA>
                <TALLYMESSAGE xmlns:UDF="TallyUDF">
                    <STOCKITEM NAME="Samsung Mobile" ACTION="Alter">
                        <NAME>Samsung Mobile</NAME>
                        <PARENT>Electronics</PARENT>
                        <GSTAPPLICABLE>Applicable</GSTAPPLICABLE>
                        <BASEUNITS>BOX</BASEUNITS>
                        <OPENINGBALANCE>12 BOX</OPENINGBALANCE>
                        <OPENINGVALUE>2000.00</OPENINGVALUE>
                        <OPENINGRATE>2000.00/PCS</OPENINGRATE>
                        <STANDARDPRICE>20020.00/PCS</STANDARDPRICE>
                    </STOCKITEM>
                </TALLYMESSAGE>
            </REQUESTDATA>
        </IMPORTDATA>
    </BODY>
</ENVELOPE>

''';

final String xmlAddNewStockGrouprequest = '''<ENVELOPE>
    <HEADER>
        <TALLYREQUEST>Import Data</TALLYREQUEST>
    </HEADER>
    <BODY>
        <IMPORTDATA>
            <REQUESTDESC>
                <REPORTNAME>All Masters</REPORTNAME>
            </REQUESTDESC>
            <REQUESTDATA>
                <TALLYMESSAGE xmlns:UDF="TallyUDF">
              
                         <STOCKGROUP NAME="Electronics"  ACTION="Create">
                        <NAME>Electronics</NAME>
                        <PARENT/>
                        <ISADDABLE>Yes</ISADDABLE>
                     
                    </STOCKGROUP>
                </TALLYMESSAGE>
            </REQUESTDATA>
        </IMPORTDATA>
    </BODY>
</ENVELOPE>

''';

final String xmlAddNewStockCategoryRequest = '''<ENVELOPE>
    <HEADER>
        <TALLYREQUEST>Import Data</TALLYREQUEST>
    </HEADER>
    <BODY>
        <IMPORTDATA>
            <REQUESTDESC>
                <REPORTNAME>All Masters</REPORTNAME>
            </REQUESTDESC>
            <REQUESTDATA>
                <TALLYMESSAGE xmlns:UDF="TallyUDF">
              
                         <STOCKCATEGORY NAME="Imported"  ACTION="Create">
                        <NAME>Imported</NAME>
                        <PARENT/>
                        <ISADDABLE>Yes</ISADDABLE>
                    </STOCKCATEGORY>
                </TALLYMESSAGE>
            </REQUESTDATA>
        </IMPORTDATA>
    </BODY>
</ENVELOPE>

''';

final String xmlTransactionVoucherAddRequest='''
<ENVELOPE>
    <HEADER>
        <TALLYREQUEST>Import Data</TALLYREQUEST>
    </HEADER>
    <BODY>
        <IMPORTDATA>
            <REQUESTDESC>
                <REPORTNAME>Vouchers</REPORTNAME>
            </REQUESTDESC>
            <REQUESTDATA>
                <TALLYMESSAGE xmlns:UDF="TallyUDF">
                    <VOUCHERTYPE NAME="Purchase" ACTION="Create"/>
                    <VOUCHER VOUCHERTYPENAME="Purchase">
                        <DATE>20250210</DATE>
                        <PARTYLEDGERNAME>Supplier ABC</PARTYLEDGERNAME>
                        <ALLINVENTORYENTRIES.LIST>
                            <STOCKITEMNAME>Samsung Mobile</STOCKITEMNAME>
                            <ACTUALQTY>5 PCS</ACTUALQTY>
                            <BILLEDQTY>5 PCS</BILLEDQTY>
                            <RATE>50000.00/PCS</RATE>
                            <AMOUNT>250000.00</AMOUNT>
                        </ALLINVENTORYENTRIES.LIST>
                    </VOUCHER>
                </TALLYMESSAGE>
            </REQUESTDATA>
        </IMPORTDATA>
    </BODY>
</ENVELOPE>

''';














final accountTypes='''<ENVELOPE>

<HEADER>

<VERSION>1</VERSION>

<TALLYREQUEST>Export</TALLYREQUEST>

<TYPE>Data</TYPE>

<ID>List of Accounts</ID>

</HEADER>

<BODY>

<DESC>

<STATICVARIABLES>

         <AccountType>Stock Items</AccountType>

</STATICVARIABLES>

</DESC>

</BODY>

</ENVELOPE>''';  

final String xmlFetchLedger = '''<ENVELOPE>
    <HEADER>
        <VERSION>1</VERSION>
        <TALLYREQUEST>Export</TALLYREQUEST>
        <TYPE>Collection</TYPE>
        <ID>List of Ledgers</ID>
    </HEADER>
    <BODY>
        <DESC>
            <STATICVARIABLES>
                <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
            </STATICVARIABLES>
            <TDL>
                <TDLMESSAGE>
                    <COLLECTION NAME="List of Ledgers" ISMODIFY="No">
                        <TYPE>Ledger</TYPE>
                        <FETCH>NAME,ADDRESS,LEDGER PHONE</FETCH>
                    </COLLECTION>
                </TDLMESSAGE>
            </TDL>
        </DESC>
    </BODY>
</ENVELOPE>''';

final String xmlFetchAllStockItems='''<ENVELOPE>
    <HEADER>
        <VERSION>1</VERSION>
        <TALLYREQUEST>Export</TALLYREQUEST>
        <TYPE>Collection</TYPE>
        <ID>Stock Items</ID>
    </HEADER>
    <BODY>
        <DESC>
            <STATICVARIABLES>
                <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
            </STATICVARIABLES>
            <TDL>
                <TDLMESSAGE>
                    <COLLECTION NAME="Stock Items" ISMODIFY="No">
                        <TYPE>StockItem</TYPE>
                        <FETCH>NAME,OPENINGBALANCE,STOCKGROUP,BASEUNITS,HSNCODE,GSTAPPLICABLE,
                        MANUFACTURINGDATE,EXPIRYDATE,SALESTAXCLASSIFICATION,PURCHASETAXCLASSIFICATION,
                        OPENINGVALUE,STANDARDPRICE,MRP,OPENINGRATE,STOCKCATEGORY</FETCH>
                    </COLLECTION>
                </TDLMESSAGE>
            </TDL>
        </DESC>
    </BODY>
</ENVELOPE>''';

final String xmlFetchBalanceSheet='''<ENVELOPE>
    <HEADER>
        <VERSION>1</VERSION>
        <TALLYREQUEST>Export</TALLYREQUEST>
        <TYPE>Report</TYPE>
        <ID>Balance Sheet</ID>
    </HEADER>
    <BODY>
        <DESC>
            <STATICVARIABLES>
                <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
                <SVFROMDATE>20240401</SVFROMDATE> <!-- Set Financial Year Start Date -->
                <SVTODATE>20250331</SVTODATE> <!-- Set Financial Year End Date -->
            </STATICVARIABLES>
        </DESC>
    </BODY>
</ENVELOPE>''';

final String xmlFetchGstAndInvoices='''<ENVELOPE>
    <HEADER>
        <VERSION>1</VERSION>
        <TALLYREQUEST>Export</TALLYREQUEST>
        <TYPE>Collection</TYPE>
        <ID>GST Invoices</ID>
    </HEADER>
    <BODY>
        <DESC>
            <STATICVARIABLES>
                <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
            </STATICVARIABLES>
            <TDL>
                <TDLMESSAGE>
                    <COLLECTION NAME="GST Invoices" ISMODIFY="No">
                        <TYPE>Voucher</TYPE>
                        <FILTER>GST_FILTER</FILTER>
                        <FETCH>DATE,VOUCHERTYPENAME,PARTYLEDGERNAME,VOUCHERNUMBER,GSTDETAILS,
                        PLACEOFSUPPLY,INVOICETYPE,LEDGERENTRIES.LIST,TAXCLASSIFICATIONDETAILS.LIST</FETCH>
                    </COLLECTION>
                    <SYSTEM TYPE="FORMULA" NAME="GST_FILTER">
                        \$VOUCHERTYPENAME CONTAINS "GST"
                    </SYSTEM>
                </TDLMESSAGE>
            </TDL>
        </DESC>
    </BODY>
</ENVELOPE>''';

final String xmlGetStockSummary='''<ENVELOPE>
    <HEADER>
        <TALLYREQUEST>Export</TALLYREQUEST>
    </HEADER>
    <BODY>
        <EXPORTDATA>
            <REQUESTDESC>
                <REPORTNAME>Stock Summary</REPORTNAME>
            </REQUESTDESC>
        </EXPORTDATA>
    </BODY>
</ENVELOPE>
''';

final String xmlGetStockItemDetails='''<ENVELOPE>
    <HEADER>
        <TALLYREQUEST>Export</TALLYREQUEST>
    </HEADER>
    <BODY>
        <EXPORTDATA>
            <REQUESTDESC>
                <REPORTNAME>Stock Item</REPORTNAME>
                <STATICVARIABLES>
                    <STOCKITEMNAME>Samsung Mobile</STOCKITEMNAME>
                </STATICVARIABLES>
            </REQUESTDESC>
        </EXPORTDATA>
    </BODY>
</ENVELOPE>

''';




final String xmlFetchAllVouchers='''<ENVELOPE>
    <HEADER>
        <VERSION>1</VERSION>
        <TALLYREQUEST>Export</TALLYREQUEST>
        <TYPE>Collection</TYPE>
        <ID>List of Vouchers</ID>
    </HEADER>
    <BODY>
        <DESC>
            <STATICVARIABLES>
                <SVEXPORTFORMAT>\$\$SysName:XML</SVEXPORTFORMAT>
            </STATICVARIABLES>
            <TDL>
                <TDLMESSAGE>
                    <COLLECTION NAME="List of Vouchers" ISMODIFY="No">
                        <TYPE>Voucher</TYPE>
                        <FETCH>DATE,PARTYLEDGERNAME,VOUCHERTYPENAME,VOUCHERNUMBER,REFERENCE,
                        AMOUNT,EFFECTIVEDATE,INVOICEDELNOTES,PLACEOFSUPPLY,BUYERSADDRESS,
                        DISPATCHDOCKETNO,DISPATCHTHROUGH,DESTINATION,TERMSOFPAYMENT,LEDGERENTRIES.LIST</FETCH>
                    </COLLECTION>
                </TDLMESSAGE>
            </TDL>
        </DESC>
    </BODY>
</ENVELOPE>''';
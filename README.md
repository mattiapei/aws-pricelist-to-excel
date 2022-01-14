# aws-pricelist-to-excel
A simple excel spreadsheet that downloads aws pricelists.
This file does not replace the official pricing tool. It is intended just to help you to get AWS prices in a spreadsheet.
For official pricies please **always** refer to the official pricing calculator at https://calculator.aws
# How to use it 
1. Open the file and enable Macros
2. Select the Service you are interested in
3. Select the region
4. Click the download button
# How it works
The spreadsheet creates an URL according to the service and region you select. Then a macro gets the csv file from AWS API and put it into the file.

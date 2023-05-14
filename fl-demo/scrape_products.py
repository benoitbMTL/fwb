#!/usr/bin/env python3

import requests
from prettytable import PrettyTable, DOUBLE_BORDER, SINGLE_BORDER

# Define Global Variables; adjust as needed
url = "http://shop.corp.fabriclab.ca"
column_width = 80
table_width = 250
round = 0
# adjust this to False if you do not want to output anything
output = False
headers = {
    "Accept": "application/json",
}

# Retrieve all possible Quantities per product
def get_quantitys(url, headers, id):
    r = requests.get(url+ "/api/Quantitys/", headers=headers)
    quantitys = r.json()
    for item in quantitys['data']:
        if item['id'] == id:
            return item

# Retrieve all reviewes of a product including Message & Author
def get_review(url, headers, id):
    r = requests.get(url + "/rest/products/" + str(id) + "/reviews", headers=headers)
    review = r.json()
    return review['data']

# Setup Table to format output
table = PrettyTable(field_names=["ProductName", "Quantity"], max_table_width = table_width, max_width = column_width)
#table = PrettyTable(field_names=["ProductName", "Quantity", "Description", "Review", "Author"], max_table_width = table_width, max_width = column_width)
table.align["ProductName"] = "l"
#table.align["Description"] = "l"
#table.align["Review"] = "l"
#table.set_style(DOUBLE_BORDER)
table.set_style(SINGLE_BORDER)

## Main Function
# retrieve all products
while round <= 2:
    r0 = requests.get(url + "/api/products/", headers=headers)
    products = r0.json()
    # Loop through Products
    for p in products['data']:
        # retrieve details of product to generate some API traffic ;-)
        r1 = requests.get(url + "/api/products/" + str(p['id']), headers=headers)
        product = r1.json()
        product = product['data']
        # Get Quantity per product
        quantity = get_quantitys(url=url, headers=headers, id=p['id'])
        # Get every review of Product if exists
        review = get_review(url=url, headers=headers, id=p['id'])
        for review in review:
            # Generate table or output plaintext
            #table.add_row([product['name'], quantity['quantity'], product['description'], review['message'], review['author'] ])
            table.add_row([product['name'], quantity['quantity'] ])
            #print(f"ProductName: {product['name']}\nDescription: {product['description']}\nAmmount: {quantity['quantity']}\nMessage: {(review['message'])}\nUsername: {review['author']}\n")
    print(f"Scraping data from Fortinet Juice-Shop...")
    round += 1

if output:
    # print table
    print(table)

# Print Table in a file
with open('output.txt', 'w') as f:
    print(table, file=f)
print("Scraping Done")

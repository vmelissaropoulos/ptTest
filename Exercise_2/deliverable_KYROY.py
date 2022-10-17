import os
import xml.etree.ElementTree as ET
import csv

directory = 'XMLS'

cvlist=[]

for file in os.listdir(directory):

    f = os.path.join(directory,file)
    if os.path.isfile(f):

        path=os.path.abspath(f)
        result=[path]

        tree=ET.parse(f)
        for child in tree.findall('.//Item'):
            # >>> Not looking for '_pdg_list' but for 'inputSymbol' tag. 
            if child.find('inputSymbol') is not  None:
                value=child.find('value')
                values=value.text.split(",")                
                for val in values:
                     result.append(val)
        if len(result)>1:
         cvlist.append(result)


with open("results.csv",'w',newline='') as file:
    writer=csv.writer(file, delimiter=';')
    writer.writerows(cvlist)

             
        
       
        

        
        




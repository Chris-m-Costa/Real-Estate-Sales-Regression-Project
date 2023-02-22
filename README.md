# Mid-Bootcamp-Real-Estate-Regression_Project
 
 This project is based on a dataset of ~22000 home sold in King County, WA. between 2014-2015 ranging in age from 1900-2015 and sales price ranging from $78,000-$7.7 Million. The variety of features in this data set will be used to construct a supervised machine learning model to attempt to predict the sales price of a given home. 
 The project will also aim to determine those factors that are the most responsible for the highest value homes ($650k and up). 
 
 #Python/Machine Learning Analysis
 
 Enclosed in the Python folder are three data files as well as my finished Jupyter workbooks: 
   
   regression_data.xls is the original given data set
   
   cleaned_data.csv is output from the first workbook after all cleaning, duplicate/nan checking, and exploratory analysis
  
   baseline_model_data.csv is an output of workbook 2 with the 'purchase month' and 'zipcode' columns encoded. No transformation has been done to this data.
   
   final_model_data.csv is an output of workbook2 with categorical columns encoded as above as well as transformations/outlier triimming performed on the rest of the non-target data
   
   finally workbook 3 imports and models the 'basline model data' fitting a linear regression model as well as a k-nearest-neighbors model with the intent to predict the 'price' column from out dataset when given the values in all other columns. 
   We will then check and score the acuracy of the models using a R_sq function. R_sq will measure the amount of the variation in the predicted values from the known 'price' values. An r_sq score of .71 can be taken as a 78% accuracy score. 
   
   We will then repeat the modeling on the 'final_model_data' which has been transformed and trimmed of outliers in an attempt at improving the accuracy of the model. 
   As they are all scored the same, all of the model results can be directly compared. 
   
   
   
   ###
   Also included in the proect is a SQL query file building a database/table from the original data set for further analysis.
   
   A Tableau visualization story asessing the factors affecting housing price with detailed visual aides.
   The Tableau story can be accessed at this link 
  https://public.tableau.com/app/profile/chris.costa2338/viz/C_CostaRegressionProjectComplete/Story1?publish=yes
  
  
  
  Finally a brief powerpoint presentation presenting my findings on the project. 
  
  

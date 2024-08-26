## **Victoria Road Crash Data Analysis**

### **About the Project**
This project focuses on analyzing road crash data from Victoria to uncover patterns and insights related to accidents. The goal is to identify factors contributing to accidents, the most common accident types, and their severity. Insights gained will aid in developing strategies to enhance road safety and reduce accident frequency. The dataset is sourced from a public road safety database.

**Objective:**
- Explore accident data to identify patterns and trends.
- Analyze factors such as accident types, light conditions, and road geometry.
- Provide insights to improve road safety strategies.

### **Project Objectives**
The primary aim is to analyze Victoria’s road crash data to:
- Understand factors influencing the occurrence and severity of accidents.
- Identify common accident types and conditions leading to severe accidents.

### **Data Overview**
The dataset contains records of road crashes from various locations in Victoria with the following columns:

| **Column**            | **Description**                                           | **Data Type**       |
|-----------------------|-----------------------------------------------------------|---------------------|
| accident_no           | Unique identifier for each accident                      | VARCHAR(255)        |
| accident_date         | Date of the accident                                      | DATE                |
| accident_time         | Time of the accident                                      | TIME                |
| accident_type         | Code for the type of accident                             | VARCHAR(255)        |
| accident_type_desc    | Description of the accident type                          | VARCHAR(255)        |
| day_of_week           | Code for the day of the week                              | INT                 |
| day_week_desc         | Description of the day of the week                       | VARCHAR(255)        |
| dca_code              | Defined Cause of Accident code                            | VARCHAR(255)        |
| dca_desc              | Description of the Defined Cause of Accident              | VARCHAR(255)        |
| light_condition       | Code for lighting condition during the accident           | VARCHAR(255)        |
| node_id               | Code for specific location or intersection                | VARCHAR(255)        |
| road_geometry_desc    | Description of the road layout at the accident location   | VARCHAR(255)        |
| severity              | Code indicating the severity of the accident              | INT                 |
| speed_zone            | Speed limit of the road where the accident occurred       | INT                 |
| rma                   | Road Management Authority responsible for the road        | VARCHAR(255)        |

### **Analysis Plan**

**Accident Analysis:**
- Investigate accident types, conditions, and severity.
- Identify common accident types and conditions leading to severe accidents.

**Severity Analysis:**
- Analyze how factors such as speed zones, light conditions, and accident types relate to severity.
- Determine key factors contributing to severe accidents.

**Environmental Analysis:**
- Assess the impact of environmental conditions (e.g., light conditions, road geometry) on accident frequency and severity.
- Identify hazardous conditions for drivers.

### **Approach**

1. **Data Wrangling:**
   - Inspect data for NULL and missing values.
   - Apply data replacement methods as needed.

2. **Database Setup:**
   - Create a database and tables.
   - Insert data, ensuring no NULL values by setting fields as NOT NULL.

3. **Feature Engineering:**
   - Add columns to categorize accidents by time of day, day name, month name, and detailed descriptions of light conditions, severity, speed zones, and accident types.

4. **Exploratory Data Analysis (EDA):**
   - Conduct EDA to address project goals and answer key questions.
   - Use visualizations to identify trends and patterns.

### **Key Questions**

**General:**
1. How many unique locations are recorded?
2. Which locations have the highest number of accidents?
3. What is the date range of the data?
4. Total number of accidents recorded?
5. Average number of accidents per day?
6. Distribution of accidents by time of day?
7. Variation of accidents by month?
8. Accidents by speed zone category (Low, Moderate, High)?
9. Most common day of the week for accidents?
10. Trend in accident numbers over the years?
11. Most frequent road geometry descriptions?
12. Accident frequency by road management authority (RMA)?

**Accident-Specific:**
1. Number of unique accident types?
2. Most common accident type?
3. Total number of accidents by month?
4. Accident type with the highest occurrences?
5. Location with the highest number of accidents?

**Severity Analysis:**
1. Accident type with the highest severity?
2. Speed zone with the highest average severity?
3. Common accident types by severity?
4. Light condition associated with highest severity?

**Environmental Analysis:**
1. Unique light conditions recorded?
2. Most common light condition during accidents?
3. Road geometry description with the highest number of accidents?
4. Light condition with the highest severity?
5. Time of day with the most accidents?
6. Day of the week with the most accidents?
7. Month with the most accidents?
8. Variation of accidents by speed zone?

**Additional Queries:**
1. Detailed information on accidents including type, cause, light condition, severity, and speed zone?
2. Accidents on each day of the week by type and severity?
3. Total number of accidents each month?
4. Severity of accidents for different light conditions?

### **Conclusion**
The analysis aims to uncover significant patterns and insights from the Victoria road crash data, providing a foundation for improving road safety measures and reducing accident rates.

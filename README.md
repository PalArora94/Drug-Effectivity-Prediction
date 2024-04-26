# Drug-Effectivity-Prediction
Drug resistance is the biggest barrier in cancer treatment so we want to predict the sensitivity of the drugs.

## Deliverables
Current therapies for Cancer treatment include:
- Radiotherapy
- Chemotherapy
- Targeted therapy
- Immunotherapy

Drug resistance accounts for 90% of treatment failures.

![image](https://github.com/PalArora94/Drug-Effectivity-Prediction/assets/112106840/b7a3ad6c-82f8-4f87-a327-1992f19ceb91)

Tumors have various ways to resist drugs.

We want to predict the **precise medication** for better clinical outcomes.

## Who does this project benefit?
- Oncologists
- Biologists
- Healthcare
- Pharmaceutical manufacturers

## Table of Contents
- [Data and EDA](#data-and-eda)
- [Modelling](#modelling)
- [Installation and Usage](#installation-and-usage)

### Data and EDA
Different cells have different RNA sequences (each sequence can be viewed as a collection of weights among different genes). These weights are the defining features of a tumor. The IC50 of a drug is the concentration required to inhibit a specific biological or biochemical function by 50%. Hence, the drug efficacy on different tumors could be inferred based on the IC50 data. We used the following data:

- RNA-sequence data of cell lines from the [CCLE database](https://www.cancerrxgene.org/gdsc1000/GDSC1000_WebResources/Home.html)
- Drug IC50 data of cell lines from [GDSC](https://depmap.org/portal/download/all/)

We have about **17,000 genes**, which are used to describe tumor cells, **800 Tumor cells**, and **13 Drugs**.

We cleaned the data a bit and merged the two data sets. After some exploration, we found  left skewness in our data and overfitting due to the high number of features compared to the data points. Thus we used the following 'feature selection' for our models:

- Normalize features and choose the 50 with the largest variances
- SHAP importance based on XG Boost results
  
### Modelling
Four models we used:

- Linear Regression
- SVR (with rbf kernel)
- XG Boost
- Three-layer NN (2 hidden layer)
  
We then compared the RMSE between models and the Benchmark, the Standard Deviation of the features for each drug.

Checking: used 80-20 split in training

<img width="338" alt="Drug sensitivity final result" src="https://github.com/PalArora94/Drug-Effectivity-Prediction/assets/112106840/1f1f9ea0-89be-428f-8064-2230c667e921">


#### Prerequisites

- Python 3.8 or later.
- [Git](https://git-scm.com/downloads) for cloning the repository.
  
#### Cloning the Repository

Clone the repository to your local machine by running:

```bash
git clone https://github.com/PalArora94/Drug-Effectivity-Prediction
cd Drug Effectivity Prediction
pip install-r requirements.txt

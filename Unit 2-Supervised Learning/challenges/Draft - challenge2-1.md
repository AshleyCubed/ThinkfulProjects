

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
import math
import scipy.stats as stats
from matplotlib.mlab import PCA as mlabPCA
from sklearn import preprocessing
from sklearn.preprocessing import StandardScaler
from sklearn.decomposition import PCA 
```


```python
sns.set_style("white")

df = pd.read_csv('BlackFriday.csv')
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>User_ID</th>
      <th>Product_ID</th>
      <th>Gender</th>
      <th>Age</th>
      <th>Occupation</th>
      <th>City_Category</th>
      <th>Stay_In_Current_City_Years</th>
      <th>Marital_Status</th>
      <th>Product_Category_1</th>
      <th>Product_Category_2</th>
      <th>Product_Category_3</th>
      <th>Purchase</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>1000001</td>
      <td>P00069042</td>
      <td>F</td>
      <td>0-17</td>
      <td>10</td>
      <td>A</td>
      <td>2</td>
      <td>0</td>
      <td>3</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>8370</td>
    </tr>
    <tr>
      <th>1</th>
      <td>1000001</td>
      <td>P00248942</td>
      <td>F</td>
      <td>0-17</td>
      <td>10</td>
      <td>A</td>
      <td>2</td>
      <td>0</td>
      <td>1</td>
      <td>6.0</td>
      <td>14.0</td>
      <td>15200</td>
    </tr>
    <tr>
      <th>2</th>
      <td>1000001</td>
      <td>P00087842</td>
      <td>F</td>
      <td>0-17</td>
      <td>10</td>
      <td>A</td>
      <td>2</td>
      <td>0</td>
      <td>12</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>1422</td>
    </tr>
    <tr>
      <th>3</th>
      <td>1000001</td>
      <td>P00085442</td>
      <td>F</td>
      <td>0-17</td>
      <td>10</td>
      <td>A</td>
      <td>2</td>
      <td>0</td>
      <td>12</td>
      <td>14.0</td>
      <td>NaN</td>
      <td>1057</td>
    </tr>
    <tr>
      <th>4</th>
      <td>1000002</td>
      <td>P00285442</td>
      <td>M</td>
      <td>55+</td>
      <td>16</td>
      <td>C</td>
      <td>4+</td>
      <td>0</td>
      <td>8</td>
      <td>NaN</td>
      <td>NaN</td>
      <td>7969</td>
    </tr>
  </tbody>
</table>
</div>




```python
print(df.columns)
print(df.shape)
print(df.dtypes)
df.describe()
```

    Index(['User_ID', 'Product_ID', 'Gender', 'Age', 'Occupation', 'City_Category',
           'Stay_In_Current_City_Years', 'Marital_Status', 'Product_Category_1',
           'Product_Category_2', 'Product_Category_3', 'Purchase'],
          dtype='object')
    (537577, 12)
    User_ID                         int64
    Product_ID                     object
    Gender                         object
    Age                            object
    Occupation                      int64
    City_Category                  object
    Stay_In_Current_City_Years     object
    Marital_Status                  int64
    Product_Category_1              int64
    Product_Category_2            float64
    Product_Category_3            float64
    Purchase                        int64
    dtype: object
    




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>User_ID</th>
      <th>Occupation</th>
      <th>Marital_Status</th>
      <th>Product_Category_1</th>
      <th>Product_Category_2</th>
      <th>Product_Category_3</th>
      <th>Purchase</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>5.375770e+05</td>
      <td>537577.00000</td>
      <td>537577.000000</td>
      <td>537577.000000</td>
      <td>370591.000000</td>
      <td>164278.000000</td>
      <td>537577.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>1.002992e+06</td>
      <td>8.08271</td>
      <td>0.408797</td>
      <td>5.295546</td>
      <td>9.842144</td>
      <td>12.669840</td>
      <td>9333.859853</td>
    </tr>
    <tr>
      <th>std</th>
      <td>1.714393e+03</td>
      <td>6.52412</td>
      <td>0.491612</td>
      <td>3.750701</td>
      <td>5.087259</td>
      <td>4.124341</td>
      <td>4981.022133</td>
    </tr>
    <tr>
      <th>min</th>
      <td>1.000001e+06</td>
      <td>0.00000</td>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>2.000000</td>
      <td>3.000000</td>
      <td>185.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>1.001495e+06</td>
      <td>2.00000</td>
      <td>0.000000</td>
      <td>1.000000</td>
      <td>5.000000</td>
      <td>9.000000</td>
      <td>5866.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>1.003031e+06</td>
      <td>7.00000</td>
      <td>0.000000</td>
      <td>5.000000</td>
      <td>9.000000</td>
      <td>14.000000</td>
      <td>8062.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>1.004417e+06</td>
      <td>14.00000</td>
      <td>1.000000</td>
      <td>8.000000</td>
      <td>15.000000</td>
      <td>16.000000</td>
      <td>12073.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>1.006040e+06</td>
      <td>20.00000</td>
      <td>1.000000</td>
      <td>18.000000</td>
      <td>18.000000</td>
      <td>18.000000</td>
      <td>23961.000000</td>
    </tr>
  </tbody>
</table>
</div>



#### Categorical data:
>- User ID
- Product ID
- Gender
- Occupation
- City Category
- Marital Status
- Product Category 1
- Product Category 2
- Product Category 3
    
#### Continuous data: 
>- Age
- Stay in current city (years)
- Purchase


```python
df['Stay_In_Current_City_Years'] = df['Stay_In_Current_City_Years'].map(lambda x: x.lstrip('+').rstrip('+'))
```


```python
df['Stay_In_Current_City_Years'] = df['Stay_In_Current_City_Years'].astype('int64')
```


```python
df['City_Category'] = df['City_Category'].replace('A', 1)
df['City_Category'] = df['City_Category'].replace('B', 2)
df['City_Category'] = df['City_Category'].replace('C', 3)
```


```python
df['City_Category'] = df['City_Category'].astype('int64')
```


```python
df['Age'] = df['Age'].replace('0-17', 0)
df['Age'] = df['Age'].replace('18-25', 1)
df['Age'] = df['Age'].replace('26-35', 2)
df['Age'] = df['Age'].replace('36-45', 3)
df['Age'] = df['Age'].replace('46-50', 4)
df['Age'] = df['Age'].replace('51-55', 5)
df['Age'] = df['Age'].replace('55+', 6)

df['Age'] = df['Age'].astype('int64')
```


```python
# df['Gender'] = df['Gender'].replace('F', 0)
# df['Gender'] = df['Gender'].replace('M', 1)

# df['Gender'] = df['Gender'].astype('int64')

#never ran the contents. only the comment. so gender is still an object
```


```python
print(df['Product_Category_1'].isnull().sum())
print(df['Product_Category_2'].isnull().sum())
print(df['Product_Category_3'].isnull().sum())
```

    0
    166986
    373299
    


```python
# replace the null values with 0 because a customer doesn't have to buy products from all three categories.
df['Product_Category_2'].fillna(0, inplace=True)
df['Product_Category_3'].fillna(0, inplace=True)
```


```python
df.isnull().sum()
```




    User_ID                       0
    Product_ID                    0
    Gender                        0
    Age                           0
    Occupation                    0
    City_Category                 0
    Stay_In_Current_City_Years    0
    Marital_Status                0
    Product_Category_1            0
    Product_Category_2            0
    Product_Category_3            0
    Purchase                      0
    dtype: int64




```python
df[(df['Product_Category_2']>0)].sum()
```




    User_ID                                                            371701398309
    Product_ID                    P00248942P00085442P00193542P00184942P00346142P...
    Gender                        FFMMMMMMFFFFMMMMMMMFFFFFFFFFFFFFFFMMMMMMMMMMMM...
    Age                           0-170-1726-3546-5046-5046-5026-3526-3551-5551-...
    Occupation                                                              3010452
    City_Category                 AAABBBAAAAAABCCCCCCBBBBBBBBBBBBCCCCCCCCCAAAAAA...
    Stay_In_Current_City_Years    22322211111114+4+4+0004+4+4+4+4+4+4+4+4+4+4+4+...
    Marital_Status                                                           150266
    Product_Category_1                                                      1570147
    Product_Category_2                                                  3.64741e+06
    Product_Category_3                                                  2.08138e+06
    Purchase                                                             3732568444
    dtype: object




```python
df_men = df.loc[ (df['Gender'] == 'M'),
                ['Age','City_Category','Stay_In_Current_City_Years','Marital_Status', 'Product_Category_1',
                 'Product_Category_2', 'Product_Category_3', 'Purchase']
].dropna()
corrmat = df_men.corr()
plt.figure(figsize = (20,8))
sns.heatmap(corrmat, vmax=.8, square=True)
```




    <matplotlib.axes._subplots.AxesSubplot at 0x171079ff048>




![png](output_14_1.png)



```python
# Scatterplot matrix.
g = sns.PairGrid(df_men.dropna(), diag_sharey=False)
# Scatterplot.
g.map_upper(plt.scatter, alpha=.5)
# Fit line summarizing the linear relationship of the two variables.
g.map_lower(sns.regplot, scatter_kws=dict(alpha=0))
# Information about the univariate distributions of the variables.
g.map_diag(sns.kdeplot, lw=3)
plt.show()
```

    C:\Users\AES\Anaconda3\lib\site-packages\scipy\stats\stats.py:1713: FutureWarning: Using a non-tuple sequence for multidimensional indexing is deprecated; use `arr[tuple(seq)]` instead of `arr[seq]`. In the future this will be interpreted as an array index, `arr[np.array(seq)]`, which will result either in an error or a different result.
      return np.add.reduce(sorted[indexer] * weights, axis=axis) / sumval
    


![png](output_15_1.png)



```python
# First center and scale the data
scaled_data = preprocessing.scale(df.T)
 
pca = PCA() # create a PCA object
pca.fit(scaled_data) # do the math
pca_data = pca.transform(scaled_data) # get PCA coordinates for scaled_data
```


    ---------------------------------------------------------------------------

    ValueError                                Traceback (most recent call last)

    <ipython-input-21-d3fbdbb19348> in <module>
          1 # First center and scale the data
    ----> 2 scaled_data = preprocessing.scale(df.T)
          3 
          4 pca = PCA() # create a PCA object
          5 pca.fit(scaled_data) # do the math
    

    ~\Anaconda3\lib\site-packages\sklearn\preprocessing\data.py in scale(X, axis, with_mean, with_std, copy)
        143     X = check_array(X, accept_sparse='csc', copy=copy, ensure_2d=False,
        144                     warn_on_dtype=True, estimator='the scale function',
    --> 145                     dtype=FLOAT_DTYPES, force_all_finite='allow-nan')
        146     if sparse.issparse(X):
        147         if with_mean:
    

    ~\Anaconda3\lib\site-packages\sklearn\utils\validation.py in check_array(array, accept_sparse, accept_large_sparse, dtype, order, copy, force_all_finite, ensure_2d, allow_nd, ensure_min_samples, ensure_min_features, warn_on_dtype, estimator)
        520             try:
        521                 warnings.simplefilter('error', ComplexWarning)
    --> 522                 array = np.asarray(array, dtype=dtype, order=order)
        523             except ComplexWarning:
        524                 raise ValueError("Complex data not supported\n"
    

    ~\Anaconda3\lib\site-packages\numpy\core\numeric.py in asarray(a, dtype, order)
        499 
        500     """
    --> 501     return array(a, dtype, copy=False, order=order)
        502 
        503 
    

    ValueError: could not convert string to float: 'M'


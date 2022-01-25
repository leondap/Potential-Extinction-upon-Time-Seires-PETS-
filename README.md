<img src="https://github.com/leondap/images/blob/main/pets.jpg?raw=true" width="250" img align="right">


# Potential-Extinction-upon-Time-Series-PETS

Monitoring is essential for detecting trends and to identify species deserving conservation efforts. However, in most regions and areas, monitoring scheme did not exist or they have been only recently implemented. For this reason it is fundamental to evaluate the degree to which a community appears eroded in time as a possible outcome of two possible causes: 1) species that went extinct; 2) lack of recent occurrence data providing a false signal of extinction.
We implemented an index to calculate Potential Extincion upon Time Series (PETS) at community level and provided the pets function to calculate it.

The PETS algorithm is based on comparing times when each species has been first and last observed for a given area as shown below. Time between first and last datum is considered as the persistence of the species in a given area while time since the last observation is considered as continuos measure for potential extinction. The PETS algorithm measure which is the overall fraction of the potential extinction (red area) against the total time since the first observation on the entire community by computing the formula:


![](https://github.com/leondap/images/blob/main/petsexample.jpg?raw=true|width=20)

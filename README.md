<img src="https://github.com/leondap/images/blob/main/pets.jpg?raw=true" width="250" img align="right">
<img src="https://github.com/leondap/images/blob/main/pnrr.jpg?raw=true"width="200" img align="right">


# Potential-Extinction-upon-Time-Series-PETS

Monitoring is essential for detecting trends and to identify species deserving conservation efforts. However, in most regions and areas, monitoring scheme did not exist or they have been only recently implemented. For this reason it is fundamental to evaluate the degree to which a community appears eroded in time as a possible outcome of two possible causes: 1) species that went extinct; 2) lack of recent occurrence data providing a false signal of extinction.
We implemented an index to calculate Potential Extincion upon Time Series (PETS) at community level and provided the pets function to calculate it.

The PETS algorithm introduced by Labadessa et al. (2021) is a modification of the extinctions per million species-years formula (Pimm et al. 2014) but instead of number of extinctions it evaluates the apparent absence in recent time for each species for a given area as shown below.


<img src="https://github.com/leondap/images/blob/main/petsexample.jpg?raw=true" width="600">

The difference between the first and last datum is considered as the persistence of a species in a given area while time since the last observation is considered as continuos measure for potential extinction. The PETS algorithm measure which is the overall fraction of the potential extinction (red area) against the total time since the first observation on the entire community by computing the formula:

<img src="https://github.com/leondap/images/blob/main/petsformulanew.png?raw=true" width=400>


Where _first occ_ and _last occ_ are the year of the first and of the last observation of the species _i_, respectively and last year is the _last year_ of observation; _n_ is the number of species occurring in the community.
This formula has desirable properties, as it ranges between 0 and 1, with a score of 0 indicating that all species were observed in the last year, and 1 indicating that all species have been observed. Moreover, it intuitively calculates the overall fraction of completeness in recent time series.
                                                                                             

To use PETS first install the pets package
```
install.packages("remotes")
remotes::install_github("leondap/pets")
library(pets)
```
load and inspect the data in Darwin core format for the butterflies of the national park of the Gran Sasso-Monti della Laga
```
data(gransasso)
head(gransasso)
```
We are interested in the following characteristics of occurrence data: species memebership (gransasso$scientificName), year of record: gransasso$year, type of observation (Literature, SAmple, iNaturalist): gransasso$basisOfRecord)
The simplest pets analysis only requires species membership and year.
```
pets_run<-pets(gransasso$scientificName,gransasso$year)
```
The analysis produces a figure where each row represent a species and the dots the years when it was recorded in the park. Species are ordered from those recorded more recently (top) to those last recorded in older times (bottom).
![](https://github.com/leondap/images/blob/main/pets_res1.png?raw=true)

The PET index (ranging between 0 and 1) is provided in the $extinctionP value 
```
pets_run$extinctionP
```
The last year of sampling can be imposed by using the end parametern (e.g. end=2021). Moreover, different types of observations can be visualised by including a obs_type vector.
```
pets_run2<-pets(gransasso$scientificName,gransasso$year, obs_type=gransasso$basisOfRecord, end=2021)
```
Now the three kinds of obsrevations are reported in the figure with different colours (and indicated in the main title as a legend). The last colour of the colours argument (purple here) is used for occurrence data belonging to more than one kind of source.
![](https://github.com/leondap/images/blob/main/pets_res2.png?raw=true)
Now some basic assessments can be done like removing inaturalist data and verify their importance in reducing the perception of potential extinction
```
noinat<-gransasso[-which(gransasso$basisOfRecord=="inaturalist"),]
pets_run3<-pets(noinat$scientificName,noinat$year, obs_type=noinat$basisOfRecord, end=2021)
```
![](https://github.com/leondap/images/blob/main/pets_res3.png?raw=true)
And the difference in the index values reveal the contribution of citizen science
```
pets_run$extinctionP
pets_run3$extinctionP
```
Where it is clear that the more than half of the potental extinction of the community of the Park was due to the lack of recent data and that iNaturalist observations halved the index:

 pets_run$extinctionP
0.09149984

pets_run3$extinctionP
0.1854186

The pets function also provides a table
```
pets_run$table
```
where the species are ordered from the ones with a longer last occ to those observed in more recent time (same order from 1 to n in the graph). The first and the last year of observation together of an individual pets value (last year-last occ)/((last year-first occ)+1) is provided in the last column.


# References

Labadessa, R., Cagnetta, G., Desaphy, J. F., Bonifacino, M., Dodaro, G., Festa, D., ... & Dapporto, L. (2021). Using occurrence data to evaluate extinction reveals a strong resilience of butterflies in a National Park of Southern Europe (Alta Murgia National Park). Journal of Insect Biodiversity, 28(1), 1-12.

Pimm, S. L., Jenkins, C. N., Abell, R., Brooks, T. M., Gittleman, J. L., Joppa, L. N., ... & Sexton, J. O. (2014). The biodiversity of species and their rates of extinction, distribution, and protection. science, 344(6187), 1246752.

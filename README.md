# comissions_modeling_for_cryptoexchange

В файлах 1.-3. содержится схема движения денежных потоков, построенная в [drawio.io](https://www.drawio.com), при совершении обменной операции (можно использовать для расчета unit-экономики). В ф. 4. построена стат. модель расчета переменной комиссии (с целью минимизации комиссий за обмен). В файлах 5.-6. модель реализована в postgresql.

Используемые библиотеки:
 - работа с данными:
   - [pandas](https://pandas.pydata.org/docs/user_guide/index.html#user-guide)
   - [numpy](https://numpy.org)
 - визуализация:
   - [matplotlib](https://matplotlib.org)
   - [seaborn](https://seaborn.pydata.org)
 - статистическое моделирование
   - [scipy](https://scipy.org)
   - [statsmodels](https://www.statsmodels.org/stable/)
 - подключение к PostgreSQL
   - [psycopg2](https://www.psycopg.org)

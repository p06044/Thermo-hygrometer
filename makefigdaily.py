#!/usr/bin/env python
# -*- coding: utf-8 -*-
import csv
import sys
from datetime import datetime as dt
from datetime import timedelta
import matplotlib.pyplot as plt
import matplotlib.dates as mdates
import numpy as np
import os.path
import time
param = sys.argv
csv_reader = np.loadtxt(param[1], delimiter=",", usecols=(0,1,2,3,4,5,6,7,8,9), dtype=object, converters={0: lambda x:dt.strptime(x,"%Y/%m/%d"), 1:np.float, 2:np.float, 3:np.float, 4:np.float, 5:np.float, 6:np.float, 7:np.float, 8:np.float, 9:np.float})

fig = plt.figure()
# 1つめ
fig.add_subplot(311)
plt.grid()
plt.plot(csv_reader[:, 0], csv_reader[:, 1], "r", label="temperature")
plt.plot(csv_reader[:, 0], csv_reader[:, 4], "r", label="temperature")
plt.plot(csv_reader[:, 0], csv_reader[:, 7], "r", label="temperature")

# 2つめ
fig.add_subplot(312)
plt.grid()
plt.plot(csv_reader[:, 0], csv_reader[:, 2], "b", label="humidity")
plt.plot(csv_reader[:, 0], csv_reader[:, 5], "b", label="humidity")
plt.plot(csv_reader[:, 0], csv_reader[:, 7], "b", label="humidity")

#3つめ
ax = fig.add_subplot(313)
daysFmt = mdates.DateFormatter('%m/%d')
ax.xaxis.set_major_formatter(daysFmt)
ax.plot(csv_reader[:, 0], csv_reader[:, 3], "g", label="pressure")
ax.plot(csv_reader[:, 0], csv_reader[:, 6], "g", label="pressure")
ax.plot(csv_reader[:, 0], csv_reader[:, 9], "g", label="pressure")
fig.autofmt_xdate()

# 出力の方法
name, ext = os.path.splitext(os.path.basename(param[1]))
plt.grid()
plt.savefig(name+".png")
#plt.show()


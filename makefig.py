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
csv_reader = np.loadtxt(param[1], delimiter=",", usecols=(0,1,2,3), dtype=object, converters={0: lambda x:dt.strptime(x,"%Y/%m/%d %H:%M:%S"), 1:np.float, 2:np.float, 3:np.float})

fig = plt.figure()
# 1つめ
fig.add_subplot(311)
plt.grid()
plt.plot(csv_reader[:, 0], csv_reader[:, 1], "r", label="temperature")

# 2つめ
fig.add_subplot(312)
plt.grid()
plt.plot(csv_reader[:, 0], csv_reader[:, 2], "b", label="humidity")

#3つめ
ax = fig.add_subplot(313)
daysFmt = mdates.DateFormatter('%H:%M')
ax.xaxis.set_major_formatter(daysFmt)
ax.plot(csv_reader[:, 0], csv_reader[:, 3], "g", label="pressure")
fig.autofmt_xdate()

# 出力の方法
name, ext = os.path.splitext(os.path.basename(param[1]))
plt.grid()
plt.savefig(name+".png")
#plt.show()


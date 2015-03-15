from yahoo import Quote, YahooQuote

stocks = ['AA', 'AXP', 'BA', 'BAC', 'CAT', 'CSCO', 'CVX', 'DD', 'DIS', 'GE', 'HD', 'HPQ', 'IBM', 'INTC', 'JNJ']
stocks += ['JPM', 'KO', 'MCD', 'MMM', 'MRK', 'MSFT', 'PFE', 'PG', 'T', 'TRV', 'UNH', 'UTX', 'VZ', 'WMT', 'XOM']

price = {}
quotes = {}
returns = {}
for s in stocks:
    print 'Stock', s
    for year in range(1993, 2015):
        try:
            quotes[year, s] = YahooQuote(s,'%s-01-01'%(str(year)), '%s-01-08'%(str(year)))
        except ValueError:
            pass
        for q in str(quotes[year, s]).split('\n'):
            if q.split(',')[0] == s:
                price[year, s] = float(q.split(',')[5])
                break

for s in stocks:
    for year in range(1994, 2015):
        returns[year, s] = (price[year, s]-price[year -1, s])/price[year -1, s]
    
f = open('DJIA.dat', 'w')
f.write('set assets := ')
for s in stocks:
    f.write(s+' ')
f.write(';\n')
f.write('param R :')
for s in stocks:
    f.write(s+' ')
f.write(':=\n')
for year in range(1994, 2015):
    f.write(str(year)+' ') 
    for s in stocks:
        f.write('%.3f '%(returns[year, s]))
    f.write('\n')
f.write(';\n')
f.close()

print 'param R :',
for s in stocks:
    print s,
print ':='
for year in range(1994, 2015):
    print year, 
    for s in stocks:
        print '%.3f'%(returns[year, s]),
    print

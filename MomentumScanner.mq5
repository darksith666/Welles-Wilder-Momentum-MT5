//+------------------------------------------------------------------+
//|                                              MomentumScanner.mq5 |
//|                                Copyright 2018, InvestDataSystems |
//|                 https://tradingbot.wixsite.com/robots-de-trading |
//+------------------------------------------------------------------+
#property copyright "Copyright 2018, InvestDataSystems"
#property link      "https://tradingbot.wixsite.com/robots-de-trading"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }

static int BARS;
bool first_run_done;
double open_array[];
double high_array[];
double low_array[];
double close_array[];
int maxhisto=4;
int handle;

static datetime LastBarTime=-1;
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   datetime ThisBarTime=(datetime)SeriesInfoInteger(Symbol(),Period(),SERIES_LASTBAR_DATE);
   if(ThisBarTime==LastBarTime)
     {
      //printf("Same bar time ("+Symbol()+")");
     }
   else
     {
      if(LastBarTime==-1)
        {
         //printf("First bar ("+Symbol()+")");
         LastBarTime=ThisBarTime;
        }
      else
        {
         //printf("New bar time ("+Symbol()+")");
         LastBarTime=ThisBarTime;

         int numO=-1,numH=-1,numL=-1,numC=-1;

         ArraySetAsSeries(open_array,true);
         numO=CopyOpen(Symbol(),Period(),0,maxhisto,open_array);

         ArraySetAsSeries(high_array,true);
         numH=CopyHigh(Symbol(),Period(),0,maxhisto,high_array);

         ArraySetAsSeries(low_array,true);
         numL=CopyLow(Symbol(),Period(),0,maxhisto,low_array);

         ArraySetAsSeries(close_array,true);
         numC=CopyClose(Symbol(),Period(),0,maxhisto,close_array);

         if (numC>1)
         {
            double last_close = close_array[1];
            double close_n2 = close_array[3];
            double diff = close_array[1] - close_array[3];
            printf("close[-1] - close[-3] = " + DoubleToString(diff));
         }

         ArrayFree(open_array);
         ArrayFree(close_array);
         ArrayFree(high_array);
         ArrayFree(low_array);

         IndicatorRelease(handle);

        }
     }

  }
//+------------------------------------------------------------------+

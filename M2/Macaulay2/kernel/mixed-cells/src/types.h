
namespace mixedCells
{
  // service functions ////////////////////////////////////////////////
  int round(double x) { return (x>0)? int(x+.499999) : int(x-.499999); }
  
  /// returns g = gcd(a,b)
  /// sgn(g) == sgn(a) 
  int gcd(int a, int b) 
  {
    bool p = (a>=0);
    while (true) {
      if (b == 0) return ((a>=0)==p)?a:-a;
      else {
	int c = a%b;
	a = b;
	b = c;
      }
    }
  }
  bool isPositive(double a)
  {
    return a>EPSILON;
  }
  bool isNegative(double a)
  {
    return a<-EPSILON;
  }
  bool isZero(double a)
  {
    return (a<EPSILON)&&(a>-EPSILON);
  }
  bool isZero2(double a)
  {
    return (a<EPSILON)&&(a>-EPSILON);
  }

  int volumeToInt(double d)
  {
    return (int)(((d>=0)?d:-d)+0.25);
  }

  double toDoubleForPrinting(double s)
  {
    return s;
  }

  bool isGreaterEqual(double a, double b)
  {
    return a>=b;
  }

  bool isEpsilonLessThan(double a, double b)
  {
    return a+EPSILON<b;
  }

  class DoubleGen; // g++ 4.1.2 wants this
  
  /** An inmitation integer class
   */

  class DoubleInt{
    double rep;
  public:
    DoubleInt(double a)
    {
      rep=(double)a;
    }
    
    MY_INLINE static bool isField() 
    {
      return true; // this is true!
      //return false; // for experiment!!!
    }

    friend bool isZero(DoubleInt const &a)
    {
      return isZero(a.rep);
    }
    friend bool isZero2(DoubleInt const &a)
    {
      return isZero(a.rep);
    }
    friend bool isOne(DoubleInt const &a)
    {
      return isZero(a.rep-1);
    }
    friend DoubleInt operator/(DoubleInt const &a, DoubleInt const &b)
    {
      return DoubleInt(a.rep/b.rep);
    }
    friend DoubleInt operator-(DoubleInt const &a)
    {
      return DoubleInt(-a.rep);
    }
    friend DoubleInt operator-(DoubleInt const &a, DoubleInt const &b)
    {
      return DoubleInt(a.rep-b.rep);
    }
    friend DoubleInt operator+(DoubleInt const &a, DoubleInt const &b)
    {
      return DoubleInt(a.rep+b.rep);
    }
    friend class DoubleGen;
    friend class DoubleGen operator*(DoubleInt const &a, DoubleGen const &b);
    //    friend class DoubleGen operator/(DoubleInt const &a, DoubleGen const &b);//!!!!!!!!!!
    friend int volumeToInt(DoubleInt const &a)
    {
      return volumeToInt(a.rep);
    }
    friend DoubleInt operator*(DoubleInt const &s, DoubleInt const &t)
    {
      return DoubleInt(s.rep*t.rep);
    }
    friend DoubleInt gcd(DoubleInt const &s, DoubleInt const &t)
    {
      //assert(false);
      return gcd(round(s.rep),round(t.rep));
    }
    void operator+=(DoubleInt const &a)
    {
      rep+=a.rep;
    }
    void operator-=(DoubleInt const &a)
    {
      rep-=a.rep;
    }
    void operator/=(DoubleInt const &a)
    {
      // only exact divisions should be allowed (no round off).
      assert(round(rep)%round(a.rep)==0);
      rep/=a.rep;
    }
    void operator*=(DoubleInt const &a)
    {
      rep*=a.rep;
    }
    friend double toDoubleForPrinting(DoubleInt const &s)//change this to produce string
    {
      return s.rep;
    }
    friend std::ostream& operator<<(std::ostream& s, const DoubleInt &a)
    {
      s<<toDoubleForPrinting(a);
      return s;
    }
    /*    friend bool isGreaterEqual(DoubleInt const &a, DoubleInt const &b)
    {
      return greaterEqual(a,b);
      }*/
    friend bool isNegative(DoubleInt const &a)
    {
      return a.rep<-EPSILON;
    }
    friend bool isEpsilonLessThan(DoubleInt const &a, DoubleInt const &b)
    {
      return isEpsilonLessThan(a.rep,b.rep);
    }
  };

  class ShortInt{
    int rep;
  public:
    ShortInt(int a)
    {
      rep=a;
    }
    
    MY_INLINE static bool isField() {return false;}

    friend bool isZero(ShortInt const &a)
    {
      return (a.rep==0);
    }
    friend bool isZero2(ShortInt const &a)
    {
      return (a.rep==0);
    }
    friend bool isOne(ShortInt const &a)
    {
      return isZero(a.rep-1);
    }
    friend ShortInt operator/(ShortInt const &a, ShortInt const &b)
    {
      assert(a.rep%b.rep==0);
      return ShortInt(a.rep/b.rep);
    }
    friend ShortInt operator-(ShortInt const &a)
    {
      return ShortInt(-a.rep);
    }
    friend ShortInt operator-(ShortInt const &a, ShortInt const &b)
    {
      return ShortInt(a.rep-b.rep);
    }
    friend ShortInt operator+(ShortInt const &a, ShortInt const &b)
    {
      return ShortInt(a.rep+b.rep);
    }
    friend class TrueGen;
    friend class TrueGen operator*(ShortInt const &a, TrueGen const &b);
    //    friend class TrueGen operator/(ShortInt const &a, TrueGen const &b);//!!!!!!!!!!
    friend int volumeToInt(ShortInt const &a)
    {
      return a.rep;
    }
    friend ShortInt operator*(ShortInt const &s, ShortInt const &t)
    {
      return ShortInt(s.rep*t.rep);
    }
    void operator+=(ShortInt const &a)
    {
      rep+=a.rep;
    }
    void operator-=(ShortInt const &a)
    {
      rep-=a.rep;
    }
    void operator/=(ShortInt const &a)
    {
      // only exact divisions should be allowed (no round off).
      assert(rep%a.rep==0);
      rep/=a.rep;
    }
    void operator*=(ShortInt const &a)
    {
      rep*=a.rep;
    }
    friend ShortInt gcd(ShortInt const &s, ShortInt const &t)
    {
      return gcd(s.rep,t.rep);
    }
    friend double toDoubleForPrinting(ShortInt const &s)//change this to produce string
    {
      return s.rep;
    }
    friend std::ostream& operator<<(std::ostream& s, const ShortInt &a)
    {
      s<<a.rep;
      return s;
    }
    /*    friend bool isGreaterEqual(ShortInt const &a, ShortInt const &b)
    {
      return greaterEqual(a,b);
      }*/
    friend bool isNegative(ShortInt const &a)
    {
      return a.rep<0;
    }
    friend bool isEpsilonLessThan(ShortInt const &a, ShortInt const &b)
    {
      return a.rep<b.rep;
    }
  };

  /** short rational numbers ************************************
   */
  class ShortRat{
    int c,d,;
  public:
    ShortRat(int a, int b)
    {
      assert (b!=0);
      c=a; d=b;
    }
    ShortRat(int a)
    {
      c=a;
      d=1;
    }
    void reduce()
    {
      if (c==0) {
	d = 1;
      } else {
	int g = gcd(d,c);
	d /= g;
	c /= g;
      }
    }
    bool isInteger() const
    {
      return gcd(d,c)==d;
    }
    MY_INLINE static bool isField() 
    {
      return true;
    }
    friend bool isZero(ShortRat const &a)
    {
      return (a.c==0);
    }
    friend bool isZero2(ShortRat const &a)
    {
      return (a.c==0);
    }
    friend bool isOne(ShortRat const &a)
    {
      return (a.c==a.d);
    }
    friend ShortRat operator/(ShortRat const &a, ShortRat const &b)
    {
      assert (!isZero(b));
      return ShortRat(a.c*b.d, a.d*b.c);
    }
    friend ShortRat operator-(ShortRat const &a)
    {
      return ShortRat(-a.c,a.d);
    }
    friend ShortRat operator-(ShortRat const &a, ShortRat const &b)
    {
      return ShortRat(a.c*b.d-b.c*a.d, a.d*b.d);
    }
    friend ShortRat operator+(ShortRat const &a, ShortRat const &b)
    {
      return ShortRat(a.c*b.d+b.c*a.d, a.d*b.d);
    }
    friend class DoubleGen;
    friend class DoubleGen operator*(ShortRat const &a, DoubleGen const &b);
    friend int volumeToInt(ShortRat const &a)
    {
      assert(a.isInteger());
      return a.c;
    }
    friend ShortRat operator*(ShortRat const &s, ShortRat const &t)
    {
      return ShortRat(s.c*t.c, s.d*t.d);
    }
    void operator+=(ShortRat const &a)
    {
      c = c*a.d+d*a.c;
      d *= a.d; 
    }
    void operator-=(ShortRat const &a)
    {
      c = c*a.d-d*a.c;
      d *= a.d; 
    }
    void operator/=(ShortRat const &a)
    {
      assert(!isZero(a));
      c *= a.d;
      d *= a.c;
    }
    void operator*=(ShortRat const &a)
    {
      c *= a.c;
      d *= a.d;
    }
    friend ShortRat gcd(ShortRat const &s, ShortRat const &t)
    {
      return ShortRat(1);
    }
    friend double toDoubleForPrinting(ShortRat const &s)//change this to produce string
    {
      return ((double)s.c)/s.d;
    }
    friend std::ostream& operator<<(std::ostream& s, const ShortRat &a)
    {
      s<<toDoubleForPrinting(a);
      return s;
    }
    friend bool isNegative(ShortRat const &a)
    {
      return a.c<0&&a.d>0 || a.c>0&&a.d<0;
    }
    friend bool isEpsilonLessThan(ShortRat const &a, ShortRat const &b)
    {
      return isNegative(a-b);
    }
  };

  class DoubleGen{
    double rep;
  public:
    DoubleGen()
    {
      rep=0;
    }
    DoubleGen(double a)
    {
      rep=(double)a;
    }
    
    friend bool isZero(DoubleGen const &a)
    {
      return isZero(a.rep);
    }
    friend bool isZero2(DoubleGen const &a)
    {
      return isZero(a.rep);
    }
    friend bool isOne(DoubleGen const &a)
    {
      return isZero(a.rep-1);
    }

    friend DoubleGen operator/(DoubleGen const &a, DoubleGen const &b)
    {
      return DoubleGen(a.rep/b.rep);
    }
    friend DoubleGen operator-(DoubleGen const &a)
    {
      return DoubleGen(-a.rep);
    }
    friend DoubleGen operator-(DoubleGen const &a, DoubleGen const &b)
    {
      return DoubleGen(a.rep-b.rep);
    }
    friend DoubleGen operator+(DoubleGen const &a, DoubleGen const &b)
    {
      return DoubleGen(a.rep+b.rep);
    }
    friend class DoubleGen operator*(DoubleInt const &a, DoubleGen const &b)
    {
      return DoubleGen(a.rep*b.rep);
    }
    friend class DoubleGen operator*(ShortRat const &a, DoubleGen const &b)
    {
      return DoubleGen(a.c*b.rep/a.d);
    }
    friend class TrueGen operator*(ShortInt const &a, TrueGen const &b)
    {
      return TrueGen(a.rep*b.rep);
    }
    friend DoubleGen operator*(DoubleGen const &s, DoubleGen const &t)
    {
      //      assert(0);//WHY IS THIS CALLED?
      return DoubleGen(s.rep*t.rep);
    }
    /*    friend class DoubleGen operator/(DoubleInt const &a, DoubleGen const &b)
    {
      return DoubleGen(a.rep/b.rep);
      }*/
    void operator+=(DoubleGen const &a)
    {
      rep+=a.rep;
    }
    void operator-=(DoubleGen const &a)
    {
      rep-=a.rep;
    }
    void operator/=(DoubleInt const &a)
    {
      // only exact divisions should be allowed (no round off).
      assert(round(rep)%round(a.rep)==0);
      rep/=a.rep;
    }
    void operator/=(ShortInt const &a)
    {
      // only exact divisions should be allowed (no round off).
      assert(round(rep)%a.rep==0);
      rep/=a.rep;
    }
    void operator/=(ShortRat const &a)
    {
      rep = rep * a.d / a.c;
    }
    friend bool isPositive(DoubleGen const &a)
    {
      return a.rep>EPSILON;
    }
    friend bool isNegative(DoubleGen const &a)
    {
      return a.rep<-EPSILON;
    }
    friend double toDoubleForPrinting(DoubleGen const &s)//change this to produce string
    {
      return s.rep;
    }
    friend std::ostream& operator<<(std::ostream& s, const DoubleGen &a)
    {
      s<<toDoubleForPrinting(a);
      return s;
    }
    friend bool isGreaterEqual(DoubleGen const &a, DoubleGen const &b)
    {
      return isGreaterEqual(a.rep,b.rep);
    }
    friend bool operator<(DoubleGen const &a, DoubleGen const &b)
    {
      return a.rep<b.rep;
    }
    /**
       This will return the largest integer by which *this is
       divisible. If all integers divide, then 0 is returned.
     */
    void assignGCD(DoubleInt &dest)const
    {
      dest=DoubleInt(0);
    }
    void assignGCD(ShortInt &dest)const
    {
      dest=ShortInt(0);
    }
    void assignGCD(ShortRat &dest)const
    {
      dest=ShortRat(0);
    }
  };

};// end namespace mixedCells
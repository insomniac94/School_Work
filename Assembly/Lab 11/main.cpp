// Name: Brandon Hough
// CPEN 3710 - 0
// Date: November 14, 2018

#include <iostream>

//added so I dont have to type std before every print out
using namespace std;

//import asm file, returns a char value
extern "C" char calculateQuadFormula(float a, float b, float c, float *root1ptr, float *root2ptr);

int main()
{
     //initalize 3 float variables for a, b, and c
     float a;
     float b;
     float c;

     //initalize 2 variables for the root(s)
     float root1;
     float root2;

     //initalize the two pointers and
     //give the pointers the address of root1 and root2
     float * root1ptr = &root1;
     float * root2ptr = &root2;

     //value to store the error code
     int errorCodeValue;

     cout << "Please enter the coefficients of the quadratic forumla" << endl;
     cout << "such that Ax^2 + Bx + C = 0 \n";

     cout << "Enter value for a: ";     //prompt user for input of a
     cin >> a;                          //stores user input in a

     //if user enters 0 for a
     if (a == 0)
     {
          cout << "Invalid quadratic equation! Re-enter values! \n" << endl; //inform user the value of '0' for a is invalid
          main(); //reprompt user for input of a
     }

     cout << "Enter value for b: ";     //prompt user for input of b
     cin >> b;                          //stores user input in b

     cout << "Enter value for c: ";     //prompt user for input of c
     cin >> c;                          //stores user input in c

     //call asm file to find root(s), will return 1(not complex) or -1 (complex number)
     errorCodeValue = calculateQuadFormula(a, b, c, root1ptr, root2ptr);

     switch (errorCodeValue)
     {
          case 0:
               cout << "Root 1: " << "x = " << root1 << endl; //print out root1 to console
               cout << "Root 2: " << "x = " << root2 << endl << "\n"; //print out root2 to console

               main(); //added for testing purposes
               break;

          case -1:
               cout << "Complex Roots! The determinate is less than 0!" << endl; //print complex roots

               main(); //added for testing purposes
               break;
     }
     return errorCodeValue;
}
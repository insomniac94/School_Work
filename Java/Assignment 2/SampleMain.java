/*
Expected output of this program:

0 [(adding)size=1;0]
1 0 [(adding)size=2;1]
2 1 0 [(adding)size=3;2]
3 2 1 0 [(adding)size=4;3]
4 3 2 1 0 [(adding)size=5;4]
5 4 3 2 1 0 [(adding)size=6;5]
6 5 4 3 2 1 0 [(adding)size=7;6]
7 6 5 4 3 2 1 0 [(adding)size=8;7]
8 7 6 5 4 3 2 1 0 [(adding)size=9;8]
9 8 7 6 5 4 3 2 1 0 [(adding)size=10;9]
size: 10
8 7 6 5 4 3 2 1 0 [(removing)size=9;8]
7 6 5 4 3 2 1 0 [(removing)size=8;7]
6 5 4 3 2 1 0 [(removing)size=7;6]
5 4 3 2 1 0 [(removing)size=6;5]
4 3 2 1 0 [(removing)size=5;4]
3 2 1 0 [(removing)size=4;3]
2 1 0 [(removing)size=3;2]
1 0 [(removing)size=2;1]
0 [(removing)size=1;0]
*/


public class SampleMain {

    public static void main(String[] args) 
    {
        SList<Integer> lst = new SList<>();

        for (int i=0; i<10; i++)
        {
            lst.addFirst(i);

            for (Integer val : lst)
            {
                System.out.print(val + " ");
            }
            System.out.println("[(adding)size="+lst.size()+";"+lst.get(0)+"]");
        }


        System.out.println("size: " + lst.size());

        while (lst.size() > 1)
        {
            lst.removeFirst();

            for (Integer val : lst)
            {
                System.out.print(val + " ");
            }

            System.out.println("[(removing)size="+lst.size()+";"+lst.get(0)+"]");
        }

    }
}
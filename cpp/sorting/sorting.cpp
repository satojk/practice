#include <utility>
#include <iostream>

const int length = 5;

struct Test
{
    int unsorted[length];
    int sorted[length];
};

Test test1 = { { 1, 5, 2, 4, 3 }, { 1, 2, 3, 4, 5 } };
Test test2 = { { 1, 2, 3, 4, 5 }, { 1, 2, 3, 4, 5 } };
Test test3 = { { 5, 4, 3, 2, 1 }, { 1, 2, 3, 4, 5 } };
Test test4 = { { 2, 4, 3, 1, 5 }, { 1, 2, 3, 4, 5 } };
Test tests[4] = { test1, test2, test3, test4 };

bool compare(int arr1[length], int arr2[length])
{
    for (int i = 0; i < length; i++)
    {
        if (arr1[i] != arr2[i])
            return false;
    }
    return true;
}

void selectionSort(int arr[length])
{
    for (int i = 0; i < length; i++)
    {
        int minInd = i;
        for (int j = i; j < length; j++)
        {
            if (arr[j] < arr[minInd])
            {
                minInd = j;
            }
        }
        std::swap(arr[i], arr[minInd]);
    }
}

void bubbleSort(int arr[length]) //unoptimized
{
    bool isUnsorted = true;
    while (isUnsorted)
    {
        isUnsorted = false;
        for (int i = 0; i < length - 1; i ++)
        {
            if (arr[i] > arr[i+1])
            {
                std::swap(arr[i], arr[i+1]);
                isUnsorted = true;
            }
        }
    }
}

int main()
{
    for (int i = 0; i < 4; i++)
    {
        bubbleSort(tests[i].unsorted);
        std::cout << (compare(tests[i].unsorted, tests[i].sorted) ? "Success" : "Fail") << std::endl;
    }
    return 0;
}

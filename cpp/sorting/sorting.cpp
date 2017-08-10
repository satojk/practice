#include <utility>
#include <iostream>

const int length = 5;

void selectionSort(int arr[length])
{
    for (int i = 0; i < length; i++)
    {
        int minInd = i;
        for (int j = i; j < length; j++)
        {
            if (arr[j] < arr[i])
            {
                minInd = j;
            }
        }
        std::swap(arr[i], arr[minInd]);
    }
}

int main()
{
    int arr[length] = { 50, 40, 30, 20, 10 };
    selectionSort(arr);
    for (int i = 0; i < length; i++)
        std::cout << arr[i] << " ";
    std::cout << std::endl;
    return 0;
}

void reverseColumns(int arr[R][C])
{
    for (int i = 0; i < C; i++)
        for (int j = 0, k = C - 1; j < k; j++, k--)
            swap(arr[j][i], arr[k][i]);
}

// Function for do transpose of matrix
void transpose(int arr[R][C])
{
    for (int i = 0; i < R; i++)
        for (int j = i; j < C; j++)
            swap(arr[i][j], arr[j][i]);
}
// Function to anticlockwise rotate matrix
// by 90 degree
void rotate90(int arr[R][C])
{
    transpose(arr);
    reverseColumns(arr);
}


//only do left swipes

//0, 1, 2, or 3 that denotes a left, up, right, or down

void workingMatrix(int arr[R][C], int direction){
	switch(direction)
	case 0:
		return arr;
		break;
	case 1 :
		return rotate90(arr);
		break;
	case 2 :
		rotate90(arr);
		return rotate90(arr);
		break;
	case 3 :
		rotate90(arr);
		rotate90(arr);
		return rotate90(arr);
}

void finalMatrix(int arr[R][C], int direction){
	switch(direction)
	case 0:
		return arr;
		break;
	case 1 :
	    rotate90(arr);
		rotate90(arr);
		return rotate90(arr);
		break;
	case 2 :
		rotate90(arr);
		return rotate90(arr);
		break;
	case 3 :
		return rotate90(arr);
}

void magic(int arr[R][C]){
	 for (int i = 0; i < 4; ++i){
        for (int j = 1; j < 4; ++j){
			if(arr[i][j] == 0) continue;
			bool flag = true;   // we never pushed through a combined field
			for( int k = j-1 ; k >=0; --k){
				if(arr[i][k] == 0){
					arr[i][k] = arr[i][j];
					arr[i][j] = 0;
				}
				else if(arr[i][k] == -1){
					flag = false;
					arr[i][k] = arr[i][j];
					arr[i][j] = 0;
				}
				else if(arr[i][k] == arr[i][j] && flag){
					flag = false;
					arr[i][k] = 2 * arr[i][k];
					arr[i][j] = -1;
				}
			}
		}
		// fix last column
		for (int j = 0; j < 4; ++j){
		if(arr[i][j] == -1)
			arr[i][j] = 0;
	 }
}



}
main(){
	//read in array as arr and swipe direction as direction

	workingMatrix(arr,direction);

	magic(arr,direction

	finalMatrix(arr,direction);

	// print out matrix;


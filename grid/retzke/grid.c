#include <stdio.h>
#include <stdlib.h>

typedef unsigned char grid_t;

int n, m;
grid_t **grid;
grid_t **mirror;

void printa(grid_t **a, int n, int m) {
	for (int j = 0; j < n; j++) {
		for (int i = 0; i < m; i++) {
			printf("%d ",a[j][i]);
		}
		printf("\n");
	}
}

void print_grid() {
	printa(grid, n, m);
}

void print_mirror() {
	printa(mirror, n, m);
}

int find_next(int i, int j, int last) {
	int r = -1;
	for (int ii = 0; ii < m; ii++) {
		if (ii-i == grid[j][ii] || i-ii == grid[j][ii]) {
			r++;
			mirror[j][ii] = last+1;
		}
	}
	for (int jj = 0; jj < n; jj++) {
		if (jj-j == grid[jj][i] || j-jj == grid[jj][i]) {
			r++;
			mirror[jj][i] = last+1;
		}
	}
	return r;
}

int main() {
	if (scanf("%d %d", &n, &m) != 2) {
		fprintf(stderr, "error reading n m\n");
		return 1;
	}
	grid = calloc(n, sizeof(grid_t*));
	mirror = calloc(n, sizeof(grid_t*));
	for (int j = 0; j < n; j++) {
		grid[j] = calloc(m, sizeof(grid_t));
		mirror[j] = calloc(m, sizeof(grid_t));
		for (int i = 0; i < m; i++) {
			scanf("%1d",&grid[j][i]);
		}
	}
	print_grid();
	printf("%d\n",find_next(m-1,n-1,1));
	print_mirror();

}

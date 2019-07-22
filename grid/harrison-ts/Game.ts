export function buildBoard(data: number[][], rows: number, cols: number) {
    const result: number[][] = [];

    data.map((datum, xPosition) => {
        datum.map((cellValue, yPosition) => {
            const location = xPosition * cols + yPosition;

            result[location] = [];

            if (xPosition + cellValue < rows) {
                result[location].push((xPosition + cellValue) * cols + yPosition);
            }
            if (xPosition - cellValue >= 0) {
                result[location].push((xPosition - cellValue) * cols + yPosition);
            }
            if (yPosition + cellValue < cols) {
                result[location].push((xPosition * cols) + yPosition + cellValue);
            }
            if (yPosition - cellValue >= 0) {
                result[location].push((xPosition * cols) + yPosition - cellValue);
            }
        });
    });

    return result;
}

export function play(data: number[][], rows: number, cols: number) {
    const board = Array(rows * cols).fill(-1);
    const queue = [[0, 0]];
    const target = rows * cols - 1;

    board[0] = 0;

    while (queue.length > 0) {
        const [cellValue, xPosition] = queue.pop()!;

        for (const boardPosition of data[xPosition]) {
            if (board[boardPosition] === -1 || board[boardPosition] > cellValue + 1) {
                board[boardPosition] = cellValue + 1;

                if (boardPosition === target) {
                    return cellValue + 1;
                }

                queue[0] = [board[boardPosition], boardPosition];
            }
        }
    }

    return board[board.length - 1];
}

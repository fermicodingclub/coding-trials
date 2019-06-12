import Queen from "./Queen";

function isSafe(queensPositions: Queen[], comparisonQueen: Queen) {
    for (const currentQueen of queensPositions) {
        if (
            comparisonQueen !== currentQueen
            && (
                comparisonQueen.columnIndex === currentQueen.columnIndex
                || comparisonQueen.rowIndex === currentQueen.rowIndex
                || comparisonQueen.leftDiagonal === currentQueen.leftDiagonal
                || comparisonQueen.rightDiagonal === currentQueen.rightDiagonal
            )
        ) {
            return false
        }
    }

    return true
  }

function isCorrect(queensPositions: Queen[]) {
    return queensPositions.every((queen) => isSafe(queensPositions, queen))
    ? "CORRECT"
    : "INCORRECT"
}

export default function Game(positions: number[][]) {
    const queensPositions = positions.map((position) => {
        return new Queen(position[0], position[1])
    })

    return isCorrect(queensPositions)
}

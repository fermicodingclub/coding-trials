export default class Queen {
    public rowIndex: number;
    public columnIndex: number;
    constructor(rowIndex: number, columnIndex: number) {
        this.rowIndex = rowIndex;
        this.columnIndex = columnIndex;
    }

    get leftDiagonal() {
        return this.rowIndex - this.columnIndex;
    }

    get rightDiagonal() {
        return this.rowIndex + this.columnIndex;
    }

    public toString() {
        return `${this.rowIndex},${this.columnIndex}`;
    }
}

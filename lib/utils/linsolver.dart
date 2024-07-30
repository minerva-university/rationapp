// The Following solves a linear programming problem
// In standardized form using the simplex method
// Please the read below.
/************************************************USAGE*************************************************************
 * 1.Create an instance of the Simplex class
 * 2.Fill in the table with the standardized form of the problem by calling Simplex.fillTable()
 * 3.Create a while loop and call the Simplex.compute() method until it returns Error.IS_OPTIMAL or Error.UNBOUNDED 
 * ****************************************************************************************************************/

enum Error { NOT_OPTIMAL, IS_OPTIMAL, UNBOUNDED }

class Simplex {
  int rows, cols;
  List<List<double>> table;
  bool solutionIsUnbounded = false;

  Simplex(int numOfConstraints, int numOfUnknowns)
      : rows = numOfConstraints + 1,
        cols = numOfUnknowns + 1,
        table = List.generate(
            numOfConstraints + 1, (_) => List.filled(numOfUnknowns + 1, 0.0));

  void printTable() {
    for (var row in table) {
      for (var value in row) {
        print('${value.toStringAsFixed(2)}\t');
      }
      print('');
    }
    print('');
  }

  void fillTable(List<List<double>> data) {
    for (int i = 0; i < table.length; i++) {
      table[i] = List.from(data[i]);
    }
  }

  Error compute() {
    if (checkOptimality()) {
      return Error.IS_OPTIMAL;
    }

    int pivotColumn = findEnteringColumn();
    print('Pivot Column: $pivotColumn');

    List<double> ratios = calculateRatios(pivotColumn);
    if (solutionIsUnbounded) {
      return Error.UNBOUNDED;
    }
    int pivotRow = findSmallestValue(ratios);

    formNextTableau(pivotRow, pivotColumn);

    return Error.NOT_OPTIMAL;
  }

  void formNextTableau(int pivotRow, int pivotColumn) {
    double pivotValue = table[pivotRow][pivotColumn];
    List<double> pivotRowVals = List.from(table[pivotRow]);
    List<double> pivotColumnVals = List.filled(rows, 0.0);
    List<double> rowNew = List.filled(cols, 0.0);

    for (int i = 0; i < rows; i++) {
      pivotColumnVals[i] = table[i][pivotColumn];
    }

    for (int i = 0; i < cols; i++) {
      rowNew[i] = pivotRowVals[i] / pivotValue;
    }

    for (int i = 0; i < rows; i++) {
      if (i != pivotRow) {
        for (int j = 0; j < cols; j++) {
          double c = pivotColumnVals[i];
          table[i][j] = table[i][j] - (c * rowNew[j]);
        }
      }
    }
    for (int i = 0; i < cols; i++) {
      table[pivotRow][i] = rowNew[i];
    }
  }

  List<double> calculateRatios(int column) {
    List<double> positiveEntries = List.filled(rows, 0.0);
    List<double> res = List.filled(rows, 0.0);
    int allNegativeCount = 0;

    for (int i = 0; i < rows; i++) {
      if (table[i][column] > 0) {
        positiveEntries[i] = table[i][column];
      } else {
        positiveEntries[i] = 0;
        allNegativeCount++;
      }
    }

    if (allNegativeCount == rows) {
      solutionIsUnbounded = true;
    } else {
      for (int i = 0; i < rows; i++) {
        double val = positiveEntries[i];
        if (val > 0) {
          res[i] = table[i][cols - 1] / val;
        }
      }
    }

    return res;
  }

  int findEnteringColumn() {
    List<double> values = List.filled(cols, 0.0);
    int location = 0;

    int pos, count = 0;
    for (pos = 0; pos < cols - 1; pos++) {
      if (table[rows - 1][pos] < 0) {
        count++;
      }
    }

    if (count > 1) {
      for (int i = 0; i < cols - 1; i++) {
        values[i] = table[rows - 1][i].abs();
      }
      location = findLargestValue(values);
    } else {
      location = count - 1;
    }

    return location;
  }

  int findSmallestValue(List<double> data) {
    double minimum = data[0];
    int location = 0;

    for (int c = 1; c < data.length; c++) {
      if (data[c] > 0) {
        if (data[c] < minimum) {
          minimum = data[c];
          location = c;
        }
      }
    }

    return location;
  }

  int findLargestValue(List<double> data) {
    double maximum = data[0];
    int location = 0;

    for (int c = 1; c < data.length; c++) {
      if (data[c] > maximum) {
        maximum = data[c];
        location = c;
      }
    }

    return location;
  }

  bool checkOptimality() {
    bool isOptimal = false;
    int vCount = 0;

    for (int i = 0; i < cols - 1; i++) {
      double val = table[rows - 1][i];
      if (val >= 0) {
        vCount++;
      }
    }

    if (vCount == cols - 1) {
      isOptimal = true;
    }

    return isOptimal;
  }

  List<List<double>> getTable() {
    return table;
  }
}

Map<String, double> extractSolution(List<List<double>> tableau) {
  // Extracts the solution from the final tableau
  int numRows = tableau.length;
  int numCols = tableau[0].length;

  double x = 0.0;
  double y = 0.0;
  double maxValue = tableau[numRows - 1][numCols - 1];

  // Identify the basic variables
  for (int j = 0; j < numCols - 1; j++) {
    int count = 0;
    int row = -1;
    for (int i = 0; i < numRows; i++) {
      if (tableau[i][j] != 0.0) {
        count++;
        row = i;
      }
    }
    if (count == 1) {
      if (j == 0) {
        x = tableau[row][numCols - 1];
      } else if (j == 1) {
        y = tableau[row][numCols - 1];
      }
    }
  }

  return {'x': x, 'y': y, 'max': maxValue};
}

void main() {
  // Objective function: Maximize x + 2 * y
  // Standardized form for simplex method requires equations in the form of <=, so we rewrite the constraints accordingly.
  // Constraints:
  // x + y <= 4
  // 2x + y >= 2  -> -2x - y <= -2 (rewriting it for <= form)
  // 0 <= y <= 3 -> y <= 3 and -y <= 0

  // Standardized form of the problem with slack variables:
  // x + y + s1 = 4
  // -2x - y + s2 = -2
  // y + s3 = 3
  // y + s4 = 0 (representing 0 <= y)
  // Objective function: z - x - 2y = 0

  // Fill in the table with the coefficients
  // Last row represents the objective function in the tableau
  var data = [
    [1.0, 1.0, 1.0, 0.0, 0.0, 0.0, 4.0], // Constraint 1
    [-2.0, -1.0, 0.0, 1.0, 0.0, 0.0, -2.0], // Constraint 2
    [0.0, 1.0, 0.0, 0.0, 1.0, 0.0, 3.0], // Constraint 3
    [0.0, 1.0, 0.0, 0.0, 0.0, 1.0, 0.0], // Constraint 4 (y >= 0)
    [-1.0, -2.0, 0.0, 0.0, 0.0, 0.0, 0.0] // Objective function
  ];
  // Create an instance of the Simplex class
  var simplex = Simplex(4, 6);

  simplex.fillTable(data);

  // Perform the simplex algorithm
  var result;
  do {
    result = simplex.compute();
  } while (result == Error.NOT_OPTIMAL);

  // Check the result and print the solution
  if (result == Error.IS_OPTIMAL) {
    print('Optimal solution found:');
    simplex.printTable();
    print(extractSolution(simplex.table));
  } else if (result == Error.UNBOUNDED) {
    print('The solution is unbounded.');
  }
}

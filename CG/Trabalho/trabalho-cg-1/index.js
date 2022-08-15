/**
 * Função que desenha um pixel na tela do navegador
 * @param x Pixel no eixo X.
 * @param y Pixel no eixo Y.
 */
function drawPixel(x, y) {
  var c = document.getElementById("g");
  var ctx = c.getContext("2d");
  ctx.fillStyle = "black";
  ctx.fillRect(x, y, 1, 1);
}

/**
 * Função que desenha uma reta.
 * @param x1 Pixel inicial no eixo X.
 * @param y1 Pixel inicial no eixo Y.
 * @param x2 Pixel final no eixo X.
 * @param y2 Pixel final no eixo Y.
 */
async function drawLine(x1, y1, x2, y2) {
  let yList = [];
  //variaveis auxiliares para alteração dos pixels
  let auxX1 = x1;
  let auxY1 = y1;

  let deltaX = x2 - x1;
  let deltaY = y2 - y1;
  //armazenamento dos eixos
  let eixoMaior, eixoMenor;
  let incrementoX0 = 0,
    incrementoY0 = 0,
    incrementoX1 = 0,
    incrementoY1 = 0,
    numerador;

  //testes para analisar se os eixos estão crescendo ou decrescendo de acordo com o delta
  if (deltaX > 0) incrementoX0 = incrementoX1 = 1;
  if (deltaX < 0) incrementoX0 = incrementoX1 = -1;
  if (deltaY > 0) incrementoY0 = 1;
  if (deltaY < 0) incrementoY0 = -1;
  if (Math.abs(deltaX) >= Math.abs(deltaY)) {
    eixoMaior = Math.abs(deltaX);
    eixoMenor = Math.abs(deltaY);
  } else {
    eixoMaior = Math.abs(deltaY);
    eixoMenor = Math.abs(deltaX);
    if (deltaY > 0) incrementoY1 = 1;
    if (deltaY < 0) incrementoY1 = -1;
    incrementoX1 = 0;
  }
  numerador = eixoMaior / 2;

  for (let i = 0; i <= eixoMaior; i++) {
    await sleep(100);
    drawPixel(auxX1, auxY1);

    yList.push({
      y: auxY1,
      xList: [auxX1],
    });

    numerador += eixoMenor;
    if (numerador > eixoMaior) {
      numerador -= eixoMaior;
      auxX1 += incrementoX0;
      auxY1 += incrementoY0;
    } else {
      auxX1 += incrementoX1;
      auxY1 += incrementoY1;
    }
  }
  return yList;
}

/**
 * Função que limpa a tela do navegador.
 */
function clearAll() {
  var c = document.getElementById("g");
  var ctx = c.getContext("2d");
  ctx.clearRect(0, 0, c.width, c.height);
}
function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}
/**
 * Função que desenha um circulo.
 * @param x_centre Pixel central do circulo no eixo X.
 * @param y_centre Pixel central do circulo no eixo Y.
 * @param r raio do circulo.
 */
async function midPointCircleDraw(x_centre, y_centre, r) {
  let x = r,
    y = 0;

  drawPixel(x + x_centre, y + y_centre);

  if (r > 0) {
    drawPixel(x + x_centre, -y + y_centre);
    drawPixel(y + x_centre, x + y_centre);
    drawPixel(-y + x_centre, x + y_centre);
  }

  let P = 1 - r;
  while (x > y) {
    await sleep(500);
    y++;
    if (P <= 0) P = P + 2 * y + 1;
    else {
      x--;
      P = P + 2 * y - 2 * x + 1;
    }

    if (x < y) break;
    drawPixel(x + x_centre, y + y_centre);
    drawPixel(-x + x_centre, y + y_centre);
    drawPixel(x + x_centre, -y + y_centre);
    drawPixel(-x + x_centre, -y + y_centre);

    if (x != y) {
      drawPixel(y + x_centre, x + y_centre);
      drawPixel(-y + x_centre, x + y_centre);
      drawPixel(y + x_centre, -x + y_centre);
      drawPixel(-y + x_centre, -x + y_centre);
    }
  }
}

/**
 * Função que retorna o menor y de um polígono.
 * @param points Lista de vertices do polígono.
 * @returns menor y do polígono
 */
function getMinY(points) {
  let min = 99999;
  for (let v of points) {
    if (v.y < min) {
      min = v.y;
    }
  }
  return min;
}

/**
 * Função que retorna o maior y de um polígono.
 * @param points Lista de vertices do polígono.
 * @returns maior y do polígono
 */
function getMaxY(points) {
  let max = -99999;
  for (let v of points) {
    if (v.y > max) {
      max = v.y;
    }
  }
  return max;
}

/**
 * Função que retorna o menor x de um polígono.
 * @param points Lista de vertices do polígono.
 * @returns menor x do polígono
 */
function getMinX(points) {
  let min = 99999;
  for (let v of points) {
    if (v.x < min) {
      min = v.x;
    }
  }
  return min;
}

/**
 * Função que retorna o maior x de um polígono.
 * @param points Lista de vertices do polígono.
 * @returns maior x do polígono
 */
function getMaxX(points) {
  let max = -99999;
  for (let v of points) {
    if (v.x > max) {
      max = v.x;
    }
  }
  return max;
}

/**
 * Função que desenha o polígono.
 * @param pointsArray Lista de vertices do polígono.
 * @returns Objeto referente ao polígono.
 */
function drawPolygon(pointsArray) {
  if (pointsArray.length <= 2) {
    return;
  }

  let polygon = {
    vertices: pointsArray.slice(),
    minY: getMinY(pointsArray),
    maxY: getMaxY(pointsArray),
    minX: getMinX(pointsArray),
    maxX: getMaxX(pointsArray),
  };

  for (let i in pointsArray) {
    let yList;
    if (i == pointsArray.length - 1) {
      yList = drawLine(
        pointsArray[i].x,
        pointsArray[i].y,
        pointsArray[0].x,
        pointsArray[0].y
      );
    } else {
      yList = drawLine(
        pointsArray[i].x,
        pointsArray[i].y,
        pointsArray[parseInt(i) + 1].x,
        pointsArray[parseInt(i) + 1].y
      );
    }
    // console.log(yList);
    for (let v of yList) {
      if (polygon[v.y]) {
        polygon[v.y] = polygon[v.y].concat(v.xList);
      } else {
        polygon[v.y] = [].concat(v.xList);
      }

      polygon[v.y] = [...new Set(polygon[v.y])];
    }
  }

  return polygon;
}

/**
 * Função que preenche o polígono.
 * @param polygon Objeto polígono.
 * @returns null
 */
function fillPolygon(polygon) {
  for (let i = polygon.minY + 1; i < polygon.maxY - 1; i++) {
    for (let j = polygon.minX + 1; j < polygon.maxX; j++) {
      if (polygon[i].length >= 2) {
        let left = false;
        let right = false;

        for (let w of polygon[i]) {
          if (w < j) {
            left = true;
          }
          if (w > j) {
            right = true;
          }
        }
        if (left && right) {
          drawPixel(j, i);
        }
      }
    }
  }
}

const points = [
  {
    x: 10,
    y: 100,
  },
  {
    x: 130,
    y: 190,
  },
  {
    x: 195,
    y: 50,
  },
  {
    x: 170,
    y: 50,
  },
];

drawPolygon(points);

// fillPolygon(p);

// function run(vet, i) {
//   drawLine(vet[i][0], vet[i][1], vet[i][2], vet[i][3]);
//   if (i < vet.length) {
//     setTimeout(() => {
//       clearAll();
//       run(vet, i + 1);
//     }, 2000);
//   }
// }
// drawLine(10, 100, 100, 10);
// drawLine(100, 10, 10, 100);
// drawLine(200, 100, 1, 1);
// drawLine(1, 1, 200, 100);
// drawLine(200, 100, 200, 10);
// drawLine(200, 10, 200, 100);
// drawLine(50, 100, 200, 100);
// drawLine(200, 100, 50, 100);
// midPointCircleDraw(100, 100, 50);
// vet = [
//   [10, 100, 100, 10],
//   [100, 10, 10, 100],
//   [200, 100, 1, 1],
//   [1, 1, 200, 100],
//   [200, 100, 200, 10],
//   [200, 10, 200, 100],
//   [50, 100, 200, 100],
//   [200, 100, 50, 100],
// ];
// run(vet, 0);

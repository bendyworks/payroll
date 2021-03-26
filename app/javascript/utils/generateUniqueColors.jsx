export function generateUniqueColors(amount, saturation = 100, lightness = 50, alpha = 1) {
  let colors = [];
  let hueDelta = Math.trunc(360 / amount);

  for (let i = 0; i < amount; i++) {
    let hue = i * hueDelta;
    colors.push(`hsla(${hue},${saturation}%,${lightness}%,${alpha})`);
  }

  return colors;
}

num formatAmount(String amount) {
  if (amount.contains(",")) {
    return num.parse(amount.replaceAll(",", "."));
  } else {
    return num.parse(amount);
  }
}

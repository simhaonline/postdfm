commaValues -> value
{% ([value]) => [value] %}

commaValues -> commaValues _ "," _ value
{% ([values, after, _, before, value]) => {
  const prevValue = values[values.length - 1];
  prevValue.raws = { ...(prevValue.raws || {}), after };
  value.raws = { ...(value.raws || {}), before };
  return [].concat(values, value);
}%}

variantValues -> value
{% ([value]) => [value] %}

variantValues -> variantValues __ value
{% ([values, before, value]) => {
  value.raws = { ...(values.raws || {}), before };
  return [].concat(values, value);
} %}

hexValues -> hexString
{% id %}

hexValues -> hexValues __ hexString
{% ([left, _, right]) => `${left}${right}` %}

itemValues -> item
{% ([value]) => [value] %}

itemValues -> itemValues _ item
{% ([items, before, item]) => {
  item.raws = { ...(item.raws || {}), before };
  return [].concat(items, item);
} %}

identifierList -> "[" _ "]"
{% ([_, beforeClose]) => {
  const node = new AST.IdentifierList();
  node.raws = { beforeClose };
  return node;
} %}

identifierList -> "[" _ commaValues _ "]"
{% ([_, afterOpen, commaValues, beforeClose]) => {
  const node = new AST.IdentifierList(commaValues);
  node.raws = { afterOpen, beforeClose };
  return node;
} %}

variantList -> "(" _ ")"
{% ([_, beforeClose]) => {
  const node = new AST.VariantList();
  node.raws = { beforeClose };
  return node;
} %}

variantList -> "(" _ variantValues _ ")"
{% ([_, afterOpen, variantValues, beforeClose]) => {
  const node = new AST.VariantList(variantValues);
  node.raws = { afterOpen, beforeClose };
  return node;
} %}

hexStringList -> "{" _ "}"
{% ([_, beforeClose]) => {
  const node = new AST.HexStringValue();
  node.raws = { beforeClose };
  return node;
} %}

hexStringList -> "{" _ hexValues _ "}"
{% ([_, afterOpen, hexValues, beforeClose]) => {
  const node = new AST.HexStringValue(hexValues);
  node.raws = { afterOpen, beforeClose };
  return node;
} %}

itemList -> "<" _ ">"
{% ([_, beforeClose]) => {
  const node = new AST.ItemList();
  node.raws = { beforeClose };
  return node;
} %}

itemList -> "<" _ itemValues _ ">"
{% ([_, afterOpen, itemValues, beforeClose]) => {
  const node = new AST.ItemList(itemValues)
  node.raws = { afterOpen, beforeClose };
  return node;
} %}

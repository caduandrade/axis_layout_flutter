[![](https://img.shields.io/pub/v/axis_layout.svg)](https://pub.dev/packages/axis_layout) [![](https://img.shields.io/badge/Flutter-%E2%9D%A4-red)](https://flutter.dev/) ![](https://img.shields.io/badge/final%20version-as%20soon%20as%20possible-blue) [![](https://img.shields.io/badge/donate-crypto-green)](#support-this-project)

# Axis Layout

## Usage

* [Horizontal](#horizontal)
* [Vertical](#vertical)
* [Shrink](#shrink)
* [Expand](#expand)
* [Support this project](#support-this-project)

## Horizontal

```dart
AxisLayout(axis: Axis.horizontal, children: [child]);
```

## Vertical

```dart
AxisLayout(axis: Axis.vertical, children: [child]);
```

## Shrink

```dart
AxisLayout(axis: Axis.horizontal, children: [
  AxisLayoutChild(child: child1, shrink: 1, shrinkOrder: 1),
  child2,
  AxisLayoutChild(child: child3, shrink: 1, shrinkOrder: 2)
]);
```

## Expand

```dart
AxisLayout(
  axis: Axis.horizontal,
  children: [child1, AxisLayoutChild(child: child2, expand: 1)]);
```

## Support this project

### Bitcoin

[bc1qhqy84y45gya58gtfkvrvass38k4mcyqnav803h](https://www.blockchain.com/pt/btc/address/bc1qhqy84y45gya58gtfkvrvass38k4mcyqnav803h)

### Ethereum (ERC-20) or Binance Smart Chain (BEP-20)

[0x9eB815FD4c88A53322304143A9Aa8733D3369985](https://etherscan.io/address/0x9eb815fd4c88a53322304143a9aa8733d3369985)

### Helium

[13A2fDqoApT9VnoxFjHWcy8kPQgVFiVnzps32MRAdpTzvs3rq68](https://explorer.helium.com/accounts/13A2fDqoApT9VnoxFjHWcy8kPQgVFiVnzps32MRAdpTzvs3rq68)
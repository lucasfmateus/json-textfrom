import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:json_schema_form/components/SelectionPage.dart';
import 'package:json_schema_form/models/Schema.dart';
import 'package:mockito/mockito.dart';

void main() {
  group("Selection Page Test", () {
    final Type radioListTileType = const RadioListTile<int>(
      value: 0,
      groupValue: 0,
      onChanged: null,
    ).runtimeType;

    List<RadioListTile<dynamic>> findTiles() => find
        .byType(RadioListTile)
        .evaluate()
        .map<Widget>((Element element) => element.widget)
        .cast<RadioListTile<dynamic>>()
        .toList();
    testWidgets("Render page without value", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectionPage(
            title: "ABC",
            selections: [
              Choice(label: "a", value: "a"),
              Choice(label: "b", value: "b"),
              Choice(label: "c", value: "c")
            ],
          ),
        ),
      );
      expect(find.text("a"), findsOneWidget);
      expect(find.text("b"), findsOneWidget);
      expect(find.text("c"), findsOneWidget);
      var radios = findTiles();
      expect(radios[0].checked, equals(false));
      expect(radios[1].checked, equals(false));
      expect(radios[2].checked, equals(false));
    });

    testWidgets("Render page with value", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectionPage(
            title: "ABC",
            selections: [
              Choice(label: "a", value: "a"),
              Choice(label: "b", value: "b"),
              Choice(label: "c", value: "c")
            ],
            value: "a",
          ),
        ),
      );
      expect(find.text("a"), findsOneWidget);
      expect(find.text("b"), findsOneWidget);
      expect(find.text("c"), findsOneWidget);
      var radios = findTiles();
      expect(radios[0].checked, equals(true));
      expect(radios[1].checked, equals(false));
      expect(radios[2].checked, equals(false));
    });

    testWidgets("Render page with value but not in selection", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectionPage(
            title: "ABC",
            selections: [
              Choice(label: "a", value: "a"),
              Choice(label: "b", value: "b"),
              Choice(label: "c", value: "c")
            ],
            value: "d",
          ),
        ),
      );
      expect(find.text("a"), findsOneWidget);
      expect(find.text("b"), findsOneWidget);
      expect(find.text("c"), findsOneWidget);
      var radios = findTiles();
      expect(radios[0].checked, equals(false));
      expect(radios[1].checked, equals(false));
      expect(radios[2].checked, equals(false));
    });

    testWidgets("Render page with value and change selection", (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SelectionPage(
            title: "ABC",
            selections: [
              Choice(label: "a", value: "a"),
              Choice(label: "b", value: "b"),
              Choice(label: "c", value: "c")
            ],
            value: "a",
          ),
        ),
      );
      await tester.tap(find.text("b"));
      await tester.pump();
      var radios = findTiles();
      expect(radios[0].checked, equals(false));
      expect(radios[1].checked, equals(true));
      expect(radios[2].checked, equals(false));
      await tester.tap(find.byIcon(Icons.done));
      await tester.pump();
    });
  });
}
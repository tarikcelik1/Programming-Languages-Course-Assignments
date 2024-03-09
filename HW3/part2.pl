classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-setosa') :-
    PetalLength =< 2.45.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-versicolor') :-
    PetalLength > 2.45,
    PetalWidth =< 1.75,
    PetalLength =< 4.95,
    PetalWidth =< 1.65.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-virginica') :-
    PetalLength > 2.45,
    PetalWidth =< 1.75,
    PetalLength =< 4.95,
    PetalWidth > 1.65.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-virginica') :-
    PetalLength > 2.45,
    PetalWidth =< 1.75,
    PetalLength > 4.95,
    PetalWidth =< 1.55.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-versicolor') :-
    PetalLength > 2.45,
    PetalWidth =< 1.75,
    PetalLength > 4.95,
    PetalWidth > 1.55,
    PetalLength =< 5.45.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-virginica') :-
    PetalLength > 2.45,
    PetalWidth =< 1.75,
    PetalLength > 4.95,
    PetalWidth > 1.55,
    PetalLength > 5.45.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-virginica') :-
    PetalLength > 2.45,
    PetalWidth > 1.75,
    PetalLength =< 4.85,
    SepalWidth =< 3.1.

classify(SepalLength, SepalWidth, PetalLength, PetalWidth, 'Iris-versicolor') :-
    PetalLength > 2.45,
    PetalWidth > 1.75,
    PetalLength =< 4.85,
    SepalWidth > 3.1.

classify(SepalLength, _, PetalLength, PetalWidth, 'Iris-virginica') :-
    PetalLength > 2.45,
    PetalWidth > 1.75,
    PetalLength > 4.85.


% Define a predicate for direct classification without specifying the class in the query.
classify(SepalLength, SepalWidth, PetalLength, PetalWidth) :-
    classify(SepalLength, SepalWidth, PetalLength, PetalWidth, Class),
    write(Class).

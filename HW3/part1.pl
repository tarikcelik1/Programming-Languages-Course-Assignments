% delivery_person(ID, Capacity, WorkHours, CurrentJob, CurrentLocation).
delivery_person('DP1', 10, 12, none, 'Lecture Hall A').
delivery_person('DP2', 15, 16, none, 'Cafeteria').
delivery_person('DP3', 20, 30, 'Obj4', 'Engineering Bld.').

% object(ID, Weight, PickupPlace, DropOffPlace, Urgency, InTransitWith).
object('Obj1', 7, 'Admin Office', 'Cafeteria', medium, none).
object('Obj2', 5, 'Library', 'Social Sciences Bld.', high, none).
object('Obj3', 3, 'Cafeteria', 'Lecture Hall A', low, none).
object('Obj4', 7, 'Institute X', 'Engineering Bld.', medium, 'DP3').
object('Obj5', 14, 'Social Sciences Bld.', 'Institute Y', high, none).

% map_route(Place1, Place2, Time).
map_route('Admin Office', 'Admin Office', 0).
map_route('Admin Office', 'Engineering Bld.', 3).
map_route('Admin Office', 'Library', 1).
map_route('Admin Office', 'Cafeteria', 4).
map_route('Admin Office', 'Social Sciences Bld.', 3).
map_route('Admin Office', 'Institute X', 11).
map_route('Admin Office', 'Lecture Hall A', 5).
map_route('Admin Office', 'Institute Y', 4).
map_route('Engineering Bld.', 'Engineering Bld.', 0).
map_route('Engineering Bld.', 'Admin Office', 3).
map_route('Engineering Bld.', 'Library', 4).
map_route('Engineering Bld.', 'Lecture Hall A', 2).
map_route('Engineering Bld.', 'Institute Y', 5).
map_route('Engineering Bld.', 'Cafeteria', 7).
map_route('Engineering Bld.', 'Social Sciences Bld.', 6).
map_route('Engineering Bld.', 'Institute X', 14).
map_route('Lecture Hall A', 'Lecture Hall A', 0).
map_route('Lecture Hall A', 'Engineering Bld.', 2).
map_route('Lecture Hall A', 'Admin Office', 5).
map_route('Lecture Hall A', 'Institute Y', 3).
map_route('Lecture Hall A', 'Library', 6).
map_route('Lecture Hall A', 'Cafeteria', 9).
map_route('Lecture Hall A', 'Social Sciences Bld.', 8).
map_route('Lecture Hall A', 'Institute X', 16).
map_route('Library', 'Library', 0).
map_route('Library', 'Admin Office', 1).
map_route('Library', 'Engineering Bld.', 4).
map_route('Library', 'Lecture Hall A', 6).
map_route('Library', 'Institute Y', 3).
map_route('Library', 'Cafeteria', 4).
map_route('Library', 'Social Sciences Bld.', 2).
map_route('Library', 'Institute X', 10).
map_route('Institute Y', 'Institute Y', 0).
map_route('Institute Y', 'Admin Office', 4).
map_route('Institute Y', 'Engineering Bld.', 5).
map_route('Institute Y', 'Lecture Hall A', 3).
map_route('Institute Y', 'Library', 3).
map_route('Institute Y', 'Cafeteria', 7).
map_route('Institute Y', 'Social Sciences Bld.', 5).
map_route('Institute Y', 'Institute X', 13).
map_route('Cafeteria', 'Cafeteria', 0).
map_route('Cafeteria', 'Admin Office', 4).
map_route('Cafeteria', 'Engineering Bld.', 7).
map_route('Cafeteria', 'Lecture Hall A', 9).
map_route('Cafeteria', 'Library', 4).
map_route('Cafeteria', 'Institute Y', 7).
map_route('Cafeteria', 'Social Sciences Bld.', 2).
map_route('Cafeteria', 'Institute X', 10).
map_route('Social Sciences Bld.', 'Social Sciences Bld.', 0).
map_route('Social Sciences Bld.', 'Admin Office', 3).
map_route('Social Sciences Bld.', 'Engineering Bld.', 6).
map_route('Social Sciences Bld.', 'Lecture Hall A', 8).
map_route('Social Sciences Bld.', 'Library', 2).
map_route('Social Sciences Bld.', 'Institute Y', 5).
map_route('Social Sciences Bld.', 'Cafeteria', 2).
map_route('Social Sciences Bld.', 'Institute X', 8).
map_route('Institute X', 'Institute X', 0).
map_route('Institute X', 'Admin Office', 11).
map_route('Institute X', 'Engineering Bld.', 14).
map_route('Institute X', 'Lecture Hall A', 16).
map_route('Institute X', 'Library', 10).
map_route('Institute X', 'Cafeteria', 10).
map_route('Institute X', 'Social Sciences Bld.', 8).
map_route('Institute X', 'Institute Y', 13).


% Predicate to check if a delivery person is available to pick and deliver an object
delivery_available(DeliveryPerson, Object, TotalTime) :-
    object(Object, Weight, PickupPlace, DropOffPlace, _, InTransitWith),
    (InTransitWith \= none ->
        write('Object is already in transit. '),
        available_route(PickupPlace, DropOffPlace, DeliveryTime),
        DeliveryPerson = InTransitWith,
        TotalTime is DeliveryTime
    ;   delivery_person(DeliveryPerson, Capacity, WorkHours, none, CurrentLocation),
        Capacity >= Weight,
        available_route(CurrentLocation, PickupPlace, PickupTime),
        available_route(PickupPlace, DropOffPlace, DeliveryTime),
        TotalTime is PickupTime + DeliveryTime,
        WorkHours >= TotalTime
    ).

% Predicate to find available routes between two places
available_route(Place1, Place2, Time) :-
    (map_route(Place1, Place2, Time) ; map_route(Place2, Place1, Time)).

% Predicate to print available delivery persons and total time for a given object
print_delivery_info(Object) :-
    setof(DeliveryPerson-Time, delivery_available(DeliveryPerson, Object, Time), DeliveryPersons),
    print_delivery_persons(DeliveryPersons).

% Helper predicate to print the list of delivery persons
print_delivery_persons([]).
print_delivery_persons([Person-Time | Rest]) :-
    format('Delivery Person: ~w, Total Time: ~w hours', [Person, Time]),
    nl,
    print_delivery_persons(Rest).


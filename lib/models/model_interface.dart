class ModelInterface<T>
{
    insert ( Map< String, T > object ) async {}
    update ( Map< String, T > object ) async {}
    delete ( Map< String, T > object ) async {}
    select ( Map< String, T > object ) async {}
}
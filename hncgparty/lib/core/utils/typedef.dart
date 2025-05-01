// File: lib/core/utils/typedef.dart

/// Custom type definitions for cleaner code

/// A type definition for Future that returns a value of type T
typedef ResultFuture<T> = Future<T>;

/// A type definition for Future that returns no value (void)
typedef ResultVoid = Future<void>;

/// A type definition for Stream of type T
typedef ResultStream<T> = Stream<T>;

/// A type definition for functions that return nothing
typedef VoidCallback = void Function();

/// A type definition for functions that take a single parameter of type T
typedef ValueChanged<T> = void Function(T value);

/// A type definition for functions that filter items of type T
typedef FilterFunction<T> = bool Function(T item);

/// A type definition for mapper functions that convert type A to type B
typedef Mapper<A, B> = B Function(A a);

/// A type definition for asynchronous mapper functions
typedef AsyncMapper<A, B> = Future<B> Function(A a);

/// A type definition for error handlers
typedef ErrorHandler = void Function(Object error, StackTrace stackTrace);
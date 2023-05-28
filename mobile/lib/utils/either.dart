abstract class Either<L, R> {
  const Either();

  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);
}

class Left<L, R> extends Either<L, R> {
  final L _l;

  const Left(this._l);

  L get value => _l;

  @override
  bool operator ==(other) => other is Left && other._l == _l;

  @override
  int get hashCode => _l.hashCode;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) {
    return ifLeft(_l);
  }
}

class Right<L, R> extends Either<L, R> {
  final R _r;

  const Right(this._r);

  R get value => _r;

  @override
  bool operator ==(other) => other is Right && other._r == _r;

  @override
  int get hashCode => _r.hashCode;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) {
    return ifRight(_r);
  }
}

Either<L, R> left<L, R>(L l) => Left(l);

Either<L, R> right<L, R>(R r) => Right(r);

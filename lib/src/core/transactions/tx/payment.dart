part of ripplelib.core;


class Payment extends Transaction {

  @override
  Map<Field, FieldRequirement> get _rippleFormat => _rippleFormatMap;
  static final Map<Field, FieldRequirement> _rippleFormatMap = {
      Field.Destination:    FieldRequirement.REQUIRED,
      Field.Amount:         FieldRequirement.REQUIRED,
      Field.Paths:          FieldRequirement.DEFAULT,
      Field.SendMax:        FieldRequirement.OPTIONAL,
      Field.DestinationTag: FieldRequirement.OPTIONAL,
      Field.InvoiceID:      FieldRequirement.OPTIONAL
  }..addAll(Transaction._rippleFormatMap);

  Payment(AccountID destination, Amount amount, {Iterable<Path> paths, Amount sendMax}) : super(TransactionType.PAYMENT) {
    this.destination = destination;
    this.amount = amount;
    this.paths = paths is PathSet ? paths : new PathSet(paths);
    this.sendMax = sendMax;
  }

  TransactionType get type => TransactionType.PAYMENT;
  set type(TransactionType type) => throw new StateError("Cannot change transaction type");

  AccountID get destination => _get(Field.Destination);
  set destination(AccountID destination) => _put(Field.Destination, destination);

  Amount get amount => _get(Field.Amount);
  set amount(Amount amount) => _put(Field.Amount, amount);

  Amount get sendMax => _get(Field.SendMax);
  set sendMax(Amount sendMax) => _put(Field.SendMax, sendMax);

  PathSet get paths => _get(Field.Paths);
  set paths(PathSet paths) => _put(Field.Paths, paths);

  int get destinationTag => _get(Field.DestinationTag);
  set destinationTag(int destinationTag) => _put(Field.DestinationTag, destinationTag);

  Hash256 get invoiceId => _get(Field.InvoiceID);
  set invoiceId(Hash256 invoiceId) => _put(Field.InvoiceID, invoiceId);

  Payment.fromJson(dynamic json, [bool skipFieldCheck = RippleSerializedObject._DEFAULT_SKIP_FIELDCHECK]) :
      super._fromJson(json, skipFieldCheck) {
    _assertTransactionType(TransactionType.PAYMENT);
  }

}
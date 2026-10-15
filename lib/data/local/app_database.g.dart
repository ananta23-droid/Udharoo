// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ShopsTableTable extends ShopsTable
    with TableInfo<$ShopsTableTable, ShopsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerUidMeta = const VerificationMeta(
    'ownerUid',
  );
  @override
  late final GeneratedColumn<String> ownerUid = GeneratedColumn<String>(
    'owner_uid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerUid,
    name,
    phone,
    address,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shops';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_uid')) {
      context.handle(
        _ownerUidMeta,
        ownerUid.isAcceptableOrUnknown(data['owner_uid']!, _ownerUidMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerUidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShopsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerUid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_uid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShopsTableTable createAlias(String alias) {
    return $ShopsTableTable(attachedDatabase, alias);
  }
}

class ShopsTableData extends DataClass implements Insertable<ShopsTableData> {
  final String id;
  final String ownerUid;
  final String name;
  final String? phone;
  final String? address;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ShopsTableData({
    required this.id,
    required this.ownerUid,
    required this.name,
    this.phone,
    this.address,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_uid'] = Variable<String>(ownerUid);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShopsTableCompanion toCompanion(bool nullToAbsent) {
    return ShopsTableCompanion(
      id: Value(id),
      ownerUid: Value(ownerUid),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShopsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopsTableData(
      id: serializer.fromJson<String>(json['id']),
      ownerUid: serializer.fromJson<String>(json['ownerUid']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerUid': serializer.toJson<String>(ownerUid),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ShopsTableData copyWith({
    String? id,
    String? ownerUid,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> address = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ShopsTableData(
    id: id ?? this.id,
    ownerUid: ownerUid ?? this.ownerUid,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    address: address.present ? address.value : this.address,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ShopsTableData copyWithCompanion(ShopsTableCompanion data) {
    return ShopsTableData(
      id: data.id.present ? data.id.value : this.id,
      ownerUid: data.ownerUid.present ? data.ownerUid.value : this.ownerUid,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopsTableData(')
          ..write('id: $id, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ownerUid, name, phone, address, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopsTableData &&
          other.id == this.id &&
          other.ownerUid == this.ownerUid &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ShopsTableCompanion extends UpdateCompanion<ShopsTableData> {
  final Value<String> id;
  final Value<String> ownerUid;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ShopsTableCompanion({
    this.id = const Value.absent(),
    this.ownerUid = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopsTableCompanion.insert({
    required String id,
    required String ownerUid,
    required String name,
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerUid = Value(ownerUid),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ShopsTableData> custom({
    Expression<String>? id,
    Expression<String>? ownerUid,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerUid != null) 'owner_uid': ownerUid,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerUid,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? address,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ShopsTableCompanion(
      id: id ?? this.id,
      ownerUid: ownerUid ?? this.ownerUid,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerUid.present) {
      map['owner_uid'] = Variable<String>(ownerUid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsTableCompanion(')
          ..write('id: $id, ')
          ..write('ownerUid: $ownerUid, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTableTable extends CustomersTable
    with TableInfo<$CustomersTableTable, CustomersTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    phone,
    email,
    createdAt,
    updatedAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomersTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomersTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomersTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $CustomersTableTable createAlias(String alias) {
    return $CustomersTableTable(attachedDatabase, alias);
  }
}

class CustomersTableData extends DataClass
    implements Insertable<CustomersTableData> {
  final String id;
  final String shopId;
  final String name;
  final String? phone;
  final String? email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String syncStatus;
  const CustomersTableData({
    required this.id,
    required this.shopId,
    required this.name,
    this.phone,
    this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  CustomersTableCompanion toCompanion(bool nullToAbsent) {
    return CustomersTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory CustomersTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomersTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'email': serializer.toJson<String?>(email),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  CustomersTableData copyWith({
    String? id,
    String? shopId,
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    String? syncStatus,
  }) => CustomersTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  CustomersTableData copyWithCompanion(CustomersTableCompanion data) {
    return CustomersTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    phone,
    email,
    createdAt,
    updatedAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomersTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.syncStatus == this.syncStatus);
}

class CustomersTableCompanion extends UpdateCompanion<CustomersTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> email;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const CustomersTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersTableCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CustomersTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? email,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return CustomersTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTableTable extends TransactionsTable
    with TableInfo<$TransactionsTableTable, TransactionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountInPaisaMeta = const VerificationMeta(
    'amountInPaisa',
  );
  @override
  late final GeneratedColumn<int> amountInPaisa = GeneratedColumn<int>(
    'amount_in_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _staffNameMeta = const VerificationMeta(
    'staffName',
  );
  @override
  late final GeneratedColumn<String> staffName = GeneratedColumn<String>(
    'staff_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    customerId,
    type,
    amountInPaisa,
    note,
    staffId,
    staffName,
    dueDate,
    paymentMethod,
    createdAt,
    syncStatus,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<TransactionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('amount_in_paisa')) {
      context.handle(
        _amountInPaisaMeta,
        amountInPaisa.isAcceptableOrUnknown(
          data['amount_in_paisa']!,
          _amountInPaisaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountInPaisaMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    }
    if (data.containsKey('staff_name')) {
      context.handle(
        _staffNameMeta,
        staffName.isAcceptableOrUnknown(data['staff_name']!, _staffNameMeta),
      );
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      amountInPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_in_paisa'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      ),
      staffName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_name'],
      ),
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      ),
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
    );
  }

  @override
  $TransactionsTableTable createAlias(String alias) {
    return $TransactionsTableTable(attachedDatabase, alias);
  }
}

class TransactionsTableData extends DataClass
    implements Insertable<TransactionsTableData> {
  final String id;
  final String shopId;
  final String customerId;
  final String type;
  final int amountInPaisa;
  final String? note;
  final String? staffId;
  final String? staffName;
  final DateTime? dueDate;
  final String? paymentMethod;
  final DateTime createdAt;
  final String syncStatus;
  const TransactionsTableData({
    required this.id,
    required this.shopId,
    required this.customerId,
    required this.type,
    required this.amountInPaisa,
    this.note,
    this.staffId,
    this.staffName,
    this.dueDate,
    this.paymentMethod,
    required this.createdAt,
    required this.syncStatus,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['customer_id'] = Variable<String>(customerId);
    map['type'] = Variable<String>(type);
    map['amount_in_paisa'] = Variable<int>(amountInPaisa);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || staffId != null) {
      map['staff_id'] = Variable<String>(staffId);
    }
    if (!nullToAbsent || staffName != null) {
      map['staff_name'] = Variable<String>(staffName);
    }
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || paymentMethod != null) {
      map['payment_method'] = Variable<String>(paymentMethod);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['sync_status'] = Variable<String>(syncStatus);
    return map;
  }

  TransactionsTableCompanion toCompanion(bool nullToAbsent) {
    return TransactionsTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      customerId: Value(customerId),
      type: Value(type),
      amountInPaisa: Value(amountInPaisa),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      staffId: staffId == null && nullToAbsent
          ? const Value.absent()
          : Value(staffId),
      staffName: staffName == null && nullToAbsent
          ? const Value.absent()
          : Value(staffName),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      paymentMethod: paymentMethod == null && nullToAbsent
          ? const Value.absent()
          : Value(paymentMethod),
      createdAt: Value(createdAt),
      syncStatus: Value(syncStatus),
    );
  }

  factory TransactionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionsTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      customerId: serializer.fromJson<String>(json['customerId']),
      type: serializer.fromJson<String>(json['type']),
      amountInPaisa: serializer.fromJson<int>(json['amountInPaisa']),
      note: serializer.fromJson<String?>(json['note']),
      staffId: serializer.fromJson<String?>(json['staffId']),
      staffName: serializer.fromJson<String?>(json['staffName']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      paymentMethod: serializer.fromJson<String?>(json['paymentMethod']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'customerId': serializer.toJson<String>(customerId),
      'type': serializer.toJson<String>(type),
      'amountInPaisa': serializer.toJson<int>(amountInPaisa),
      'note': serializer.toJson<String?>(note),
      'staffId': serializer.toJson<String?>(staffId),
      'staffName': serializer.toJson<String?>(staffName),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'paymentMethod': serializer.toJson<String?>(paymentMethod),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'syncStatus': serializer.toJson<String>(syncStatus),
    };
  }

  TransactionsTableData copyWith({
    String? id,
    String? shopId,
    String? customerId,
    String? type,
    int? amountInPaisa,
    Value<String?> note = const Value.absent(),
    Value<String?> staffId = const Value.absent(),
    Value<String?> staffName = const Value.absent(),
    Value<DateTime?> dueDate = const Value.absent(),
    Value<String?> paymentMethod = const Value.absent(),
    DateTime? createdAt,
    String? syncStatus,
  }) => TransactionsTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    customerId: customerId ?? this.customerId,
    type: type ?? this.type,
    amountInPaisa: amountInPaisa ?? this.amountInPaisa,
    note: note.present ? note.value : this.note,
    staffId: staffId.present ? staffId.value : this.staffId,
    staffName: staffName.present ? staffName.value : this.staffName,
    dueDate: dueDate.present ? dueDate.value : this.dueDate,
    paymentMethod: paymentMethod.present
        ? paymentMethod.value
        : this.paymentMethod,
    createdAt: createdAt ?? this.createdAt,
    syncStatus: syncStatus ?? this.syncStatus,
  );
  TransactionsTableData copyWithCompanion(TransactionsTableCompanion data) {
    return TransactionsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      type: data.type.present ? data.type.value : this.type,
      amountInPaisa: data.amountInPaisa.present
          ? data.amountInPaisa.value
          : this.amountInPaisa,
      note: data.note.present ? data.note.value : this.note,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      staffName: data.staffName.present ? data.staffName.value : this.staffName,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('amountInPaisa: $amountInPaisa, ')
          ..write('note: $note, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('dueDate: $dueDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    customerId,
    type,
    amountInPaisa,
    note,
    staffId,
    staffName,
    dueDate,
    paymentMethod,
    createdAt,
    syncStatus,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionsTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.customerId == this.customerId &&
          other.type == this.type &&
          other.amountInPaisa == this.amountInPaisa &&
          other.note == this.note &&
          other.staffId == this.staffId &&
          other.staffName == this.staffName &&
          other.dueDate == this.dueDate &&
          other.paymentMethod == this.paymentMethod &&
          other.createdAt == this.createdAt &&
          other.syncStatus == this.syncStatus);
}

class TransactionsTableCompanion
    extends UpdateCompanion<TransactionsTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> customerId;
  final Value<String> type;
  final Value<int> amountInPaisa;
  final Value<String?> note;
  final Value<String?> staffId;
  final Value<String?> staffName;
  final Value<DateTime?> dueDate;
  final Value<String?> paymentMethod;
  final Value<DateTime> createdAt;
  final Value<String> syncStatus;
  final Value<int> rowid;
  const TransactionsTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.type = const Value.absent(),
    this.amountInPaisa = const Value.absent(),
    this.note = const Value.absent(),
    this.staffId = const Value.absent(),
    this.staffName = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsTableCompanion.insert({
    required String id,
    required String shopId,
    required String customerId,
    required String type,
    required int amountInPaisa,
    this.note = const Value.absent(),
    this.staffId = const Value.absent(),
    this.staffName = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    required DateTime createdAt,
    this.syncStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       customerId = Value(customerId),
       type = Value(type),
       amountInPaisa = Value(amountInPaisa),
       createdAt = Value(createdAt);
  static Insertable<TransactionsTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? customerId,
    Expression<String>? type,
    Expression<int>? amountInPaisa,
    Expression<String>? note,
    Expression<String>? staffId,
    Expression<String>? staffName,
    Expression<DateTime>? dueDate,
    Expression<String>? paymentMethod,
    Expression<DateTime>? createdAt,
    Expression<String>? syncStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (customerId != null) 'customer_id': customerId,
      if (type != null) 'type': type,
      if (amountInPaisa != null) 'amount_in_paisa': amountInPaisa,
      if (note != null) 'note': note,
      if (staffId != null) 'staff_id': staffId,
      if (staffName != null) 'staff_name': staffName,
      if (dueDate != null) 'due_date': dueDate,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (createdAt != null) 'created_at': createdAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? customerId,
    Value<String>? type,
    Value<int>? amountInPaisa,
    Value<String?>? note,
    Value<String?>? staffId,
    Value<String?>? staffName,
    Value<DateTime?>? dueDate,
    Value<String?>? paymentMethod,
    Value<DateTime>? createdAt,
    Value<String>? syncStatus,
    Value<int>? rowid,
  }) {
    return TransactionsTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      type: type ?? this.type,
      amountInPaisa: amountInPaisa ?? this.amountInPaisa,
      note: note ?? this.note,
      staffId: staffId ?? this.staffId,
      staffName: staffName ?? this.staffName,
      dueDate: dueDate ?? this.dueDate,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      syncStatus: syncStatus ?? this.syncStatus,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (amountInPaisa.present) {
      map['amount_in_paisa'] = Variable<int>(amountInPaisa.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (staffName.present) {
      map['staff_name'] = Variable<String>(staffName.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('type: $type, ')
          ..write('amountInPaisa: $amountInPaisa, ')
          ..write('note: $note, ')
          ..write('staffId: $staffId, ')
          ..write('staffName: $staffName, ')
          ..write('dueDate: $dueDate, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('createdAt: $createdAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StaffTableTable extends StaffTable
    with TableInfo<$StaffTableTable, StaffTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StaffTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('cashier'),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    name,
    email,
    phone,
    role,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'staff';
  @override
  VerificationContext validateIntegrity(
    Insertable<StaffTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StaffTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StaffTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $StaffTableTable createAlias(String alias) {
    return $StaffTableTable(attachedDatabase, alias);
  }
}

class StaffTableData extends DataClass implements Insertable<StaffTableData> {
  final String id;
  final String shopId;
  final String name;
  final String email;
  final String? phone;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const StaffTableData({
    required this.id,
    required this.shopId,
    required this.name,
    required this.email,
    this.phone,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  StaffTableCompanion toCompanion(bool nullToAbsent) {
    return StaffTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      name: Value(name),
      email: Value(email),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      role: Value(role),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory StaffTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StaffTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  StaffTableData copyWith({
    String? id,
    String? shopId,
    String? name,
    String? email,
    Value<String?> phone = const Value.absent(),
    String? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => StaffTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone.present ? phone.value : this.phone,
    role: role ?? this.role,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  StaffTableData copyWithCompanion(StaffTableCompanion data) {
    return StaffTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StaffTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    name,
    email,
    phone,
    role,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.name == this.name &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class StaffTableCompanion extends UpdateCompanion<StaffTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> name;
  final Value<String> email;
  final Value<String?> phone;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const StaffTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StaffTableCompanion.insert({
    required String id,
    required String shopId,
    required String name,
    required String email,
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       name = Value(name),
       email = Value(email),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<StaffTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StaffTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? name,
    Value<String>? email,
    Value<String?>? phone,
    Value<String>? role,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return StaffTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StaffTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShopSettingsTableTable extends ShopSettingsTable
    with TableInfo<$ShopSettingsTableTable, ShopSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShopSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultRepaymentDaysMeta =
      const VerificationMeta('defaultRepaymentDays');
  @override
  late final GeneratedColumn<int> defaultRepaymentDays = GeneratedColumn<int>(
    'default_repayment_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _emailRemindersEnabledMeta =
      const VerificationMeta('emailRemindersEnabled');
  @override
  late final GeneratedColumn<bool> emailRemindersEnabled =
      GeneratedColumn<bool>(
        'email_reminders_enabled',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("email_reminders_enabled" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _senderEmailMeta = const VerificationMeta(
    'senderEmail',
  );
  @override
  late final GeneratedColumn<String> senderEmail = GeneratedColumn<String>(
    'sender_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderIntervalDaysMeta =
      const VerificationMeta('reminderIntervalDays');
  @override
  late final GeneratedColumn<int> reminderIntervalDays = GeneratedColumn<int>(
    'reminder_interval_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _smsRemindersEnabledMeta =
      const VerificationMeta('smsRemindersEnabled');
  @override
  late final GeneratedColumn<bool> smsRemindersEnabled = GeneratedColumn<bool>(
    'sms_reminders_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("sms_reminders_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _smsProviderConfigJsonMeta =
      const VerificationMeta('smsProviderConfigJson');
  @override
  late final GeneratedColumn<String> smsProviderConfigJson =
      GeneratedColumn<String>(
        'sms_provider_config_json',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    shopId,
    defaultRepaymentDays,
    emailRemindersEnabled,
    senderEmail,
    reminderIntervalDays,
    smsRemindersEnabled,
    smsProviderConfigJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shop_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShopSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('default_repayment_days')) {
      context.handle(
        _defaultRepaymentDaysMeta,
        defaultRepaymentDays.isAcceptableOrUnknown(
          data['default_repayment_days']!,
          _defaultRepaymentDaysMeta,
        ),
      );
    }
    if (data.containsKey('email_reminders_enabled')) {
      context.handle(
        _emailRemindersEnabledMeta,
        emailRemindersEnabled.isAcceptableOrUnknown(
          data['email_reminders_enabled']!,
          _emailRemindersEnabledMeta,
        ),
      );
    }
    if (data.containsKey('sender_email')) {
      context.handle(
        _senderEmailMeta,
        senderEmail.isAcceptableOrUnknown(
          data['sender_email']!,
          _senderEmailMeta,
        ),
      );
    }
    if (data.containsKey('reminder_interval_days')) {
      context.handle(
        _reminderIntervalDaysMeta,
        reminderIntervalDays.isAcceptableOrUnknown(
          data['reminder_interval_days']!,
          _reminderIntervalDaysMeta,
        ),
      );
    }
    if (data.containsKey('sms_reminders_enabled')) {
      context.handle(
        _smsRemindersEnabledMeta,
        smsRemindersEnabled.isAcceptableOrUnknown(
          data['sms_reminders_enabled']!,
          _smsRemindersEnabledMeta,
        ),
      );
    }
    if (data.containsKey('sms_provider_config_json')) {
      context.handle(
        _smsProviderConfigJsonMeta,
        smsProviderConfigJson.isAcceptableOrUnknown(
          data['sms_provider_config_json']!,
          _smsProviderConfigJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {shopId};
  @override
  ShopSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShopSettingsTableData(
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      defaultRepaymentDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_repayment_days'],
      )!,
      emailRemindersEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}email_reminders_enabled'],
      )!,
      senderEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sender_email'],
      ),
      reminderIntervalDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_interval_days'],
      )!,
      smsRemindersEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}sms_reminders_enabled'],
      )!,
      smsProviderConfigJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sms_provider_config_json'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShopSettingsTableTable createAlias(String alias) {
    return $ShopSettingsTableTable(attachedDatabase, alias);
  }
}

class ShopSettingsTableData extends DataClass
    implements Insertable<ShopSettingsTableData> {
  final String shopId;
  final int defaultRepaymentDays;
  final bool emailRemindersEnabled;
  final String? senderEmail;
  final int reminderIntervalDays;
  final bool smsRemindersEnabled;
  final String? smsProviderConfigJson;
  final DateTime updatedAt;
  const ShopSettingsTableData({
    required this.shopId,
    required this.defaultRepaymentDays,
    required this.emailRemindersEnabled,
    this.senderEmail,
    required this.reminderIntervalDays,
    required this.smsRemindersEnabled,
    this.smsProviderConfigJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['shop_id'] = Variable<String>(shopId);
    map['default_repayment_days'] = Variable<int>(defaultRepaymentDays);
    map['email_reminders_enabled'] = Variable<bool>(emailRemindersEnabled);
    if (!nullToAbsent || senderEmail != null) {
      map['sender_email'] = Variable<String>(senderEmail);
    }
    map['reminder_interval_days'] = Variable<int>(reminderIntervalDays);
    map['sms_reminders_enabled'] = Variable<bool>(smsRemindersEnabled);
    if (!nullToAbsent || smsProviderConfigJson != null) {
      map['sms_provider_config_json'] = Variable<String>(smsProviderConfigJson);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShopSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return ShopSettingsTableCompanion(
      shopId: Value(shopId),
      defaultRepaymentDays: Value(defaultRepaymentDays),
      emailRemindersEnabled: Value(emailRemindersEnabled),
      senderEmail: senderEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(senderEmail),
      reminderIntervalDays: Value(reminderIntervalDays),
      smsRemindersEnabled: Value(smsRemindersEnabled),
      smsProviderConfigJson: smsProviderConfigJson == null && nullToAbsent
          ? const Value.absent()
          : Value(smsProviderConfigJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShopSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShopSettingsTableData(
      shopId: serializer.fromJson<String>(json['shopId']),
      defaultRepaymentDays: serializer.fromJson<int>(
        json['defaultRepaymentDays'],
      ),
      emailRemindersEnabled: serializer.fromJson<bool>(
        json['emailRemindersEnabled'],
      ),
      senderEmail: serializer.fromJson<String?>(json['senderEmail']),
      reminderIntervalDays: serializer.fromJson<int>(
        json['reminderIntervalDays'],
      ),
      smsRemindersEnabled: serializer.fromJson<bool>(
        json['smsRemindersEnabled'],
      ),
      smsProviderConfigJson: serializer.fromJson<String?>(
        json['smsProviderConfigJson'],
      ),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'shopId': serializer.toJson<String>(shopId),
      'defaultRepaymentDays': serializer.toJson<int>(defaultRepaymentDays),
      'emailRemindersEnabled': serializer.toJson<bool>(emailRemindersEnabled),
      'senderEmail': serializer.toJson<String?>(senderEmail),
      'reminderIntervalDays': serializer.toJson<int>(reminderIntervalDays),
      'smsRemindersEnabled': serializer.toJson<bool>(smsRemindersEnabled),
      'smsProviderConfigJson': serializer.toJson<String?>(
        smsProviderConfigJson,
      ),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ShopSettingsTableData copyWith({
    String? shopId,
    int? defaultRepaymentDays,
    bool? emailRemindersEnabled,
    Value<String?> senderEmail = const Value.absent(),
    int? reminderIntervalDays,
    bool? smsRemindersEnabled,
    Value<String?> smsProviderConfigJson = const Value.absent(),
    DateTime? updatedAt,
  }) => ShopSettingsTableData(
    shopId: shopId ?? this.shopId,
    defaultRepaymentDays: defaultRepaymentDays ?? this.defaultRepaymentDays,
    emailRemindersEnabled: emailRemindersEnabled ?? this.emailRemindersEnabled,
    senderEmail: senderEmail.present ? senderEmail.value : this.senderEmail,
    reminderIntervalDays: reminderIntervalDays ?? this.reminderIntervalDays,
    smsRemindersEnabled: smsRemindersEnabled ?? this.smsRemindersEnabled,
    smsProviderConfigJson: smsProviderConfigJson.present
        ? smsProviderConfigJson.value
        : this.smsProviderConfigJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ShopSettingsTableData copyWithCompanion(ShopSettingsTableCompanion data) {
    return ShopSettingsTableData(
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      defaultRepaymentDays: data.defaultRepaymentDays.present
          ? data.defaultRepaymentDays.value
          : this.defaultRepaymentDays,
      emailRemindersEnabled: data.emailRemindersEnabled.present
          ? data.emailRemindersEnabled.value
          : this.emailRemindersEnabled,
      senderEmail: data.senderEmail.present
          ? data.senderEmail.value
          : this.senderEmail,
      reminderIntervalDays: data.reminderIntervalDays.present
          ? data.reminderIntervalDays.value
          : this.reminderIntervalDays,
      smsRemindersEnabled: data.smsRemindersEnabled.present
          ? data.smsRemindersEnabled.value
          : this.smsRemindersEnabled,
      smsProviderConfigJson: data.smsProviderConfigJson.present
          ? data.smsProviderConfigJson.value
          : this.smsProviderConfigJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShopSettingsTableData(')
          ..write('shopId: $shopId, ')
          ..write('defaultRepaymentDays: $defaultRepaymentDays, ')
          ..write('emailRemindersEnabled: $emailRemindersEnabled, ')
          ..write('senderEmail: $senderEmail, ')
          ..write('reminderIntervalDays: $reminderIntervalDays, ')
          ..write('smsRemindersEnabled: $smsRemindersEnabled, ')
          ..write('smsProviderConfigJson: $smsProviderConfigJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    shopId,
    defaultRepaymentDays,
    emailRemindersEnabled,
    senderEmail,
    reminderIntervalDays,
    smsRemindersEnabled,
    smsProviderConfigJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShopSettingsTableData &&
          other.shopId == this.shopId &&
          other.defaultRepaymentDays == this.defaultRepaymentDays &&
          other.emailRemindersEnabled == this.emailRemindersEnabled &&
          other.senderEmail == this.senderEmail &&
          other.reminderIntervalDays == this.reminderIntervalDays &&
          other.smsRemindersEnabled == this.smsRemindersEnabled &&
          other.smsProviderConfigJson == this.smsProviderConfigJson &&
          other.updatedAt == this.updatedAt);
}

class ShopSettingsTableCompanion
    extends UpdateCompanion<ShopSettingsTableData> {
  final Value<String> shopId;
  final Value<int> defaultRepaymentDays;
  final Value<bool> emailRemindersEnabled;
  final Value<String?> senderEmail;
  final Value<int> reminderIntervalDays;
  final Value<bool> smsRemindersEnabled;
  final Value<String?> smsProviderConfigJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ShopSettingsTableCompanion({
    this.shopId = const Value.absent(),
    this.defaultRepaymentDays = const Value.absent(),
    this.emailRemindersEnabled = const Value.absent(),
    this.senderEmail = const Value.absent(),
    this.reminderIntervalDays = const Value.absent(),
    this.smsRemindersEnabled = const Value.absent(),
    this.smsProviderConfigJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShopSettingsTableCompanion.insert({
    required String shopId,
    this.defaultRepaymentDays = const Value.absent(),
    this.emailRemindersEnabled = const Value.absent(),
    this.senderEmail = const Value.absent(),
    this.reminderIntervalDays = const Value.absent(),
    this.smsRemindersEnabled = const Value.absent(),
    this.smsProviderConfigJson = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : shopId = Value(shopId),
       updatedAt = Value(updatedAt);
  static Insertable<ShopSettingsTableData> custom({
    Expression<String>? shopId,
    Expression<int>? defaultRepaymentDays,
    Expression<bool>? emailRemindersEnabled,
    Expression<String>? senderEmail,
    Expression<int>? reminderIntervalDays,
    Expression<bool>? smsRemindersEnabled,
    Expression<String>? smsProviderConfigJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (shopId != null) 'shop_id': shopId,
      if (defaultRepaymentDays != null)
        'default_repayment_days': defaultRepaymentDays,
      if (emailRemindersEnabled != null)
        'email_reminders_enabled': emailRemindersEnabled,
      if (senderEmail != null) 'sender_email': senderEmail,
      if (reminderIntervalDays != null)
        'reminder_interval_days': reminderIntervalDays,
      if (smsRemindersEnabled != null)
        'sms_reminders_enabled': smsRemindersEnabled,
      if (smsProviderConfigJson != null)
        'sms_provider_config_json': smsProviderConfigJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShopSettingsTableCompanion copyWith({
    Value<String>? shopId,
    Value<int>? defaultRepaymentDays,
    Value<bool>? emailRemindersEnabled,
    Value<String?>? senderEmail,
    Value<int>? reminderIntervalDays,
    Value<bool>? smsRemindersEnabled,
    Value<String?>? smsProviderConfigJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ShopSettingsTableCompanion(
      shopId: shopId ?? this.shopId,
      defaultRepaymentDays: defaultRepaymentDays ?? this.defaultRepaymentDays,
      emailRemindersEnabled:
          emailRemindersEnabled ?? this.emailRemindersEnabled,
      senderEmail: senderEmail ?? this.senderEmail,
      reminderIntervalDays: reminderIntervalDays ?? this.reminderIntervalDays,
      smsRemindersEnabled: smsRemindersEnabled ?? this.smsRemindersEnabled,
      smsProviderConfigJson:
          smsProviderConfigJson ?? this.smsProviderConfigJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (defaultRepaymentDays.present) {
      map['default_repayment_days'] = Variable<int>(defaultRepaymentDays.value);
    }
    if (emailRemindersEnabled.present) {
      map['email_reminders_enabled'] = Variable<bool>(
        emailRemindersEnabled.value,
      );
    }
    if (senderEmail.present) {
      map['sender_email'] = Variable<String>(senderEmail.value);
    }
    if (reminderIntervalDays.present) {
      map['reminder_interval_days'] = Variable<int>(reminderIntervalDays.value);
    }
    if (smsRemindersEnabled.present) {
      map['sms_reminders_enabled'] = Variable<bool>(smsRemindersEnabled.value);
    }
    if (smsProviderConfigJson.present) {
      map['sms_provider_config_json'] = Variable<String>(
        smsProviderConfigJson.value,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopSettingsTableCompanion(')
          ..write('shopId: $shopId, ')
          ..write('defaultRepaymentDays: $defaultRepaymentDays, ')
          ..write('emailRemindersEnabled: $emailRemindersEnabled, ')
          ..write('senderEmail: $senderEmail, ')
          ..write('reminderIntervalDays: $reminderIntervalDays, ')
          ..write('smsRemindersEnabled: $smsRemindersEnabled, ')
          ..write('smsProviderConfigJson: $smsProviderConfigJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AuditLogsTableTable extends AuditLogsTable
    with TableInfo<$AuditLogsTableTable, AuditLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actorIdMeta = const VerificationMeta(
    'actorId',
  );
  @override
  late final GeneratedColumn<String> actorId = GeneratedColumn<String>(
    'actor_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actorNameMeta = const VerificationMeta(
    'actorName',
  );
  @override
  late final GeneratedColumn<String> actorName = GeneratedColumn<String>(
    'actor_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actionMeta = const VerificationMeta('action');
  @override
  late final GeneratedColumn<String> action = GeneratedColumn<String>(
    'action',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsJsonMeta = const VerificationMeta(
    'detailsJson',
  );
  @override
  late final GeneratedColumn<String> detailsJson = GeneratedColumn<String>(
    'details_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    actorId,
    actorName,
    action,
    entityType,
    entityId,
    detailsJson,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('actor_id')) {
      context.handle(
        _actorIdMeta,
        actorId.isAcceptableOrUnknown(data['actor_id']!, _actorIdMeta),
      );
    }
    if (data.containsKey('actor_name')) {
      context.handle(
        _actorNameMeta,
        actorName.isAcceptableOrUnknown(data['actor_name']!, _actorNameMeta),
      );
    }
    if (data.containsKey('action')) {
      context.handle(
        _actionMeta,
        action.isAcceptableOrUnknown(data['action']!, _actionMeta),
      );
    } else if (isInserting) {
      context.missing(_actionMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('details_json')) {
      context.handle(
        _detailsJsonMeta,
        detailsJson.isAcceptableOrUnknown(
          data['details_json']!,
          _detailsJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_detailsJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AuditLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      actorId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_id'],
      ),
      actorName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_name'],
      ),
      action: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      detailsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AuditLogsTableTable createAlias(String alias) {
    return $AuditLogsTableTable(attachedDatabase, alias);
  }
}

class AuditLogsTableData extends DataClass
    implements Insertable<AuditLogsTableData> {
  final String id;
  final String shopId;
  final String? actorId;
  final String? actorName;
  final String action;
  final String entityType;
  final String entityId;
  final String detailsJson;
  final DateTime createdAt;
  const AuditLogsTableData({
    required this.id,
    required this.shopId,
    this.actorId,
    this.actorName,
    required this.action,
    required this.entityType,
    required this.entityId,
    required this.detailsJson,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || actorId != null) {
      map['actor_id'] = Variable<String>(actorId);
    }
    if (!nullToAbsent || actorName != null) {
      map['actor_name'] = Variable<String>(actorName);
    }
    map['action'] = Variable<String>(action);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['details_json'] = Variable<String>(detailsJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AuditLogsTableCompanion toCompanion(bool nullToAbsent) {
    return AuditLogsTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      actorId: actorId == null && nullToAbsent
          ? const Value.absent()
          : Value(actorId),
      actorName: actorName == null && nullToAbsent
          ? const Value.absent()
          : Value(actorName),
      action: Value(action),
      entityType: Value(entityType),
      entityId: Value(entityId),
      detailsJson: Value(detailsJson),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      actorId: serializer.fromJson<String?>(json['actorId']),
      actorName: serializer.fromJson<String?>(json['actorName']),
      action: serializer.fromJson<String>(json['action']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      detailsJson: serializer.fromJson<String>(json['detailsJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'actorId': serializer.toJson<String?>(actorId),
      'actorName': serializer.toJson<String?>(actorName),
      'action': serializer.toJson<String>(action),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'detailsJson': serializer.toJson<String>(detailsJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AuditLogsTableData copyWith({
    String? id,
    String? shopId,
    Value<String?> actorId = const Value.absent(),
    Value<String?> actorName = const Value.absent(),
    String? action,
    String? entityType,
    String? entityId,
    String? detailsJson,
    DateTime? createdAt,
  }) => AuditLogsTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    actorId: actorId.present ? actorId.value : this.actorId,
    actorName: actorName.present ? actorName.value : this.actorName,
    action: action ?? this.action,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    detailsJson: detailsJson ?? this.detailsJson,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLogsTableData copyWithCompanion(AuditLogsTableCompanion data) {
    return AuditLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      actorId: data.actorId.present ? data.actorId.value : this.actorId,
      actorName: data.actorName.present ? data.actorName.value : this.actorName,
      action: data.action.present ? data.action.value : this.action,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      detailsJson: data.detailsJson.present
          ? data.detailsJson.value
          : this.detailsJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('actorId: $actorId, ')
          ..write('actorName: $actorName, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    actorId,
    actorName,
    action,
    entityType,
    entityId,
    detailsJson,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogsTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.actorId == this.actorId &&
          other.actorName == this.actorName &&
          other.action == this.action &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.detailsJson == this.detailsJson &&
          other.createdAt == this.createdAt);
}

class AuditLogsTableCompanion extends UpdateCompanion<AuditLogsTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> actorId;
  final Value<String?> actorName;
  final Value<String> action;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> detailsJson;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AuditLogsTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.actorId = const Value.absent(),
    this.actorName = const Value.absent(),
    this.action = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.detailsJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AuditLogsTableCompanion.insert({
    required String id,
    required String shopId,
    this.actorId = const Value.absent(),
    this.actorName = const Value.absent(),
    required String action,
    required String entityType,
    required String entityId,
    required String detailsJson,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       action = Value(action),
       entityType = Value(entityType),
       entityId = Value(entityId),
       detailsJson = Value(detailsJson),
       createdAt = Value(createdAt);
  static Insertable<AuditLogsTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? actorId,
    Expression<String>? actorName,
    Expression<String>? action,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? detailsJson,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (actorId != null) 'actor_id': actorId,
      if (actorName != null) 'actor_name': actorName,
      if (action != null) 'action': action,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (detailsJson != null) 'details_json': detailsJson,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AuditLogsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? actorId,
    Value<String?>? actorName,
    Value<String>? action,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? detailsJson,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AuditLogsTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      actorId: actorId ?? this.actorId,
      actorName: actorName ?? this.actorName,
      action: action ?? this.action,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      detailsJson: detailsJson ?? this.detailsJson,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (actorId.present) {
      map['actor_id'] = Variable<String>(actorId.value);
    }
    if (actorName.present) {
      map['actor_name'] = Variable<String>(actorName.value);
    }
    if (action.present) {
      map['action'] = Variable<String>(action.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (detailsJson.present) {
      map['details_json'] = Variable<String>(detailsJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('actorId: $actorId, ')
          ..write('actorName: $actorName, ')
          ..write('action: $action, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('detailsJson: $detailsJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReminderLogsTableTable extends ReminderLogsTable
    with TableInfo<$ReminderLogsTableTable, ReminderLogsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReminderLogsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientMeta = const VerificationMeta(
    'recipient',
  );
  @override
  late final GeneratedColumn<String> recipient = GeneratedColumn<String>(
    'recipient',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('sent'),
  );
  static const VerificationMeta _scheduledForMeta = const VerificationMeta(
    'scheduledFor',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledFor = GeneratedColumn<DateTime>(
    'scheduled_for',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    customerId,
    customerName,
    recipient,
    type,
    title,
    content,
    status,
    scheduledFor,
    sentAt,
    errorMessage,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminder_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderLogsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('recipient')) {
      context.handle(
        _recipientMeta,
        recipient.isAcceptableOrUnknown(data['recipient']!, _recipientMeta),
      );
    } else if (isInserting) {
      context.missing(_recipientMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('scheduled_for')) {
      context.handle(
        _scheduledForMeta,
        scheduledFor.isAcceptableOrUnknown(
          data['scheduled_for']!,
          _scheduledForMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledForMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderLogsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderLogsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      recipient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      scheduledFor: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_for'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ReminderLogsTableTable createAlias(String alias) {
    return $ReminderLogsTableTable(attachedDatabase, alias);
  }
}

class ReminderLogsTableData extends DataClass
    implements Insertable<ReminderLogsTableData> {
  final String id;
  final String shopId;
  final String customerId;
  final String customerName;
  final String recipient;
  final String type;
  final String title;
  final String content;
  final String status;
  final DateTime scheduledFor;
  final DateTime? sentAt;
  final String? errorMessage;
  final DateTime createdAt;
  const ReminderLogsTableData({
    required this.id,
    required this.shopId,
    required this.customerId,
    required this.customerName,
    required this.recipient,
    required this.type,
    required this.title,
    required this.content,
    required this.status,
    required this.scheduledFor,
    this.sentAt,
    this.errorMessage,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['customer_id'] = Variable<String>(customerId);
    map['customer_name'] = Variable<String>(customerName);
    map['recipient'] = Variable<String>(recipient);
    map['type'] = Variable<String>(type);
    map['title'] = Variable<String>(title);
    map['content'] = Variable<String>(content);
    map['status'] = Variable<String>(status);
    map['scheduled_for'] = Variable<DateTime>(scheduledFor);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ReminderLogsTableCompanion toCompanion(bool nullToAbsent) {
    return ReminderLogsTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      customerId: Value(customerId),
      customerName: Value(customerName),
      recipient: Value(recipient),
      type: Value(type),
      title: Value(title),
      content: Value(content),
      status: Value(status),
      scheduledFor: Value(scheduledFor),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
    );
  }

  factory ReminderLogsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderLogsTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      customerId: serializer.fromJson<String>(json['customerId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      recipient: serializer.fromJson<String>(json['recipient']),
      type: serializer.fromJson<String>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      content: serializer.fromJson<String>(json['content']),
      status: serializer.fromJson<String>(json['status']),
      scheduledFor: serializer.fromJson<DateTime>(json['scheduledFor']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'customerId': serializer.toJson<String>(customerId),
      'customerName': serializer.toJson<String>(customerName),
      'recipient': serializer.toJson<String>(recipient),
      'type': serializer.toJson<String>(type),
      'title': serializer.toJson<String>(title),
      'content': serializer.toJson<String>(content),
      'status': serializer.toJson<String>(status),
      'scheduledFor': serializer.toJson<DateTime>(scheduledFor),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ReminderLogsTableData copyWith({
    String? id,
    String? shopId,
    String? customerId,
    String? customerName,
    String? recipient,
    String? type,
    String? title,
    String? content,
    String? status,
    DateTime? scheduledFor,
    Value<DateTime?> sentAt = const Value.absent(),
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
  }) => ReminderLogsTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    customerId: customerId ?? this.customerId,
    customerName: customerName ?? this.customerName,
    recipient: recipient ?? this.recipient,
    type: type ?? this.type,
    title: title ?? this.title,
    content: content ?? this.content,
    status: status ?? this.status,
    scheduledFor: scheduledFor ?? this.scheduledFor,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
  );
  ReminderLogsTableData copyWithCompanion(ReminderLogsTableCompanion data) {
    return ReminderLogsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      recipient: data.recipient.present ? data.recipient.value : this.recipient,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      content: data.content.present ? data.content.value : this.content,
      status: data.status.present ? data.status.value : this.status,
      scheduledFor: data.scheduledFor.present
          ? data.scheduledFor.value
          : this.scheduledFor,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderLogsTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('recipient: $recipient, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('sentAt: $sentAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    customerId,
    customerName,
    recipient,
    type,
    title,
    content,
    status,
    scheduledFor,
    sentAt,
    errorMessage,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderLogsTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.recipient == this.recipient &&
          other.type == this.type &&
          other.title == this.title &&
          other.content == this.content &&
          other.status == this.status &&
          other.scheduledFor == this.scheduledFor &&
          other.sentAt == this.sentAt &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt);
}

class ReminderLogsTableCompanion
    extends UpdateCompanion<ReminderLogsTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> customerId;
  final Value<String> customerName;
  final Value<String> recipient;
  final Value<String> type;
  final Value<String> title;
  final Value<String> content;
  final Value<String> status;
  final Value<DateTime> scheduledFor;
  final Value<DateTime?> sentAt;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ReminderLogsTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.recipient = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.status = const Value.absent(),
    this.scheduledFor = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReminderLogsTableCompanion.insert({
    required String id,
    required String shopId,
    required String customerId,
    required String customerName,
    required String recipient,
    required String type,
    required String title,
    required String content,
    this.status = const Value.absent(),
    required DateTime scheduledFor,
    this.sentAt = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       customerId = Value(customerId),
       customerName = Value(customerName),
       recipient = Value(recipient),
       type = Value(type),
       title = Value(title),
       content = Value(content),
       scheduledFor = Value(scheduledFor),
       createdAt = Value(createdAt);
  static Insertable<ReminderLogsTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? customerId,
    Expression<String>? customerName,
    Expression<String>? recipient,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? content,
    Expression<String>? status,
    Expression<DateTime>? scheduledFor,
    Expression<DateTime>? sentAt,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (recipient != null) 'recipient': recipient,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (status != null) 'status': status,
      if (scheduledFor != null) 'scheduled_for': scheduledFor,
      if (sentAt != null) 'sent_at': sentAt,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReminderLogsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? customerId,
    Value<String>? customerName,
    Value<String>? recipient,
    Value<String>? type,
    Value<String>? title,
    Value<String>? content,
    Value<String>? status,
    Value<DateTime>? scheduledFor,
    Value<DateTime?>? sentAt,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return ReminderLogsTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      recipient: recipient ?? this.recipient,
      type: type ?? this.type,
      title: title ?? this.title,
      content: content ?? this.content,
      status: status ?? this.status,
      scheduledFor: scheduledFor ?? this.scheduledFor,
      sentAt: sentAt ?? this.sentAt,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (recipient.present) {
      map['recipient'] = Variable<String>(recipient.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (scheduledFor.present) {
      map['scheduled_for'] = Variable<DateTime>(scheduledFor.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReminderLogsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('recipient: $recipient, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('status: $status, ')
          ..write('scheduledFor: $scheduledFor, ')
          ..write('sentAt: $sentAt, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingSyncOperationsTableTable extends PendingSyncOperationsTable
    with
        TableInfo<
          $PendingSyncOperationsTableTable,
          PendingSyncOperationsTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingSyncOperationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationTypeMeta = const VerificationMeta(
    'operationType',
  );
  @override
  late final GeneratedColumn<String> operationType = GeneratedColumn<String>(
    'operation_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadJsonMeta = const VerificationMeta(
    'payloadJson',
  );
  @override
  late final GeneratedColumn<String> payloadJson = GeneratedColumn<String>(
    'payload_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    entityType,
    entityId,
    operationType,
    payloadJson,
    createdAt,
    retryCount,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_sync_operations';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingSyncOperationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation_type')) {
      context.handle(
        _operationTypeMeta,
        operationType.isAcceptableOrUnknown(
          data['operation_type']!,
          _operationTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operationTypeMeta);
    }
    if (data.containsKey('payload_json')) {
      context.handle(
        _payloadJsonMeta,
        payloadJson.isAcceptableOrUnknown(
          data['payload_json']!,
          _payloadJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_payloadJsonMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PendingSyncOperationsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingSyncOperationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operationType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation_type'],
      )!,
      payloadJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload_json'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $PendingSyncOperationsTableTable createAlias(String alias) {
    return $PendingSyncOperationsTableTable(attachedDatabase, alias);
  }
}

class PendingSyncOperationsTableData extends DataClass
    implements Insertable<PendingSyncOperationsTableData> {
  final String id;
  final String shopId;
  final String entityType;
  final String entityId;
  final String operationType;
  final String payloadJson;
  final DateTime createdAt;
  final int retryCount;
  final String? lastError;
  const PendingSyncOperationsTableData({
    required this.id,
    required this.shopId,
    required this.entityType,
    required this.entityId,
    required this.operationType,
    required this.payloadJson,
    required this.createdAt,
    required this.retryCount,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation_type'] = Variable<String>(operationType);
    map['payload_json'] = Variable<String>(payloadJson);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  PendingSyncOperationsTableCompanion toCompanion(bool nullToAbsent) {
    return PendingSyncOperationsTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operationType: Value(operationType),
      payloadJson: Value(payloadJson),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory PendingSyncOperationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingSyncOperationsTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operationType: serializer.fromJson<String>(json['operationType']),
      payloadJson: serializer.fromJson<String>(json['payloadJson']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operationType': serializer.toJson<String>(operationType),
      'payloadJson': serializer.toJson<String>(payloadJson),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  PendingSyncOperationsTableData copyWith({
    String? id,
    String? shopId,
    String? entityType,
    String? entityId,
    String? operationType,
    String? payloadJson,
    DateTime? createdAt,
    int? retryCount,
    Value<String?> lastError = const Value.absent(),
  }) => PendingSyncOperationsTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operationType: operationType ?? this.operationType,
    payloadJson: payloadJson ?? this.payloadJson,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  PendingSyncOperationsTableData copyWithCompanion(
    PendingSyncOperationsTableCompanion data,
  ) {
    return PendingSyncOperationsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operationType: data.operationType.present
          ? data.operationType.value
          : this.operationType,
      payloadJson: data.payloadJson.present
          ? data.payloadJson.value
          : this.payloadJson,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncOperationsTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operationType: $operationType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    entityType,
    entityId,
    operationType,
    payloadJson,
    createdAt,
    retryCount,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingSyncOperationsTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operationType == this.operationType &&
          other.payloadJson == this.payloadJson &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount &&
          other.lastError == this.lastError);
}

class PendingSyncOperationsTableCompanion
    extends UpdateCompanion<PendingSyncOperationsTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operationType;
  final Value<String> payloadJson;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  final Value<String?> lastError;
  final Value<int> rowid;
  const PendingSyncOperationsTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operationType = const Value.absent(),
    this.payloadJson = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingSyncOperationsTableCompanion.insert({
    required String id,
    required String shopId,
    required String entityType,
    required String entityId,
    required String operationType,
    required String payloadJson,
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
    this.lastError = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       entityType = Value(entityType),
       entityId = Value(entityId),
       operationType = Value(operationType),
       payloadJson = Value(payloadJson),
       createdAt = Value(createdAt);
  static Insertable<PendingSyncOperationsTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operationType,
    Expression<String>? payloadJson,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
    Expression<String>? lastError,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operationType != null) 'operation_type': operationType,
      if (payloadJson != null) 'payload_json': payloadJson,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (lastError != null) 'last_error': lastError,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingSyncOperationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operationType,
    Value<String>? payloadJson,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
    Value<String?>? lastError,
    Value<int>? rowid,
  }) {
    return PendingSyncOperationsTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operationType: operationType ?? this.operationType,
      payloadJson: payloadJson ?? this.payloadJson,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      lastError: lastError ?? this.lastError,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operationType.present) {
      map['operation_type'] = Variable<String>(operationType.value);
    }
    if (payloadJson.present) {
      map['payload_json'] = Variable<String>(payloadJson.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingSyncOperationsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operationType: $operationType, ')
          ..write('payloadJson: $payloadJson, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('lastError: $lastError, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationsTableTable extends NotificationsTable
    with TableInfo<$NotificationsTableTable, NotificationsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipientStaffIdMeta = const VerificationMeta(
    'recipientStaffId',
  );
  @override
  late final GeneratedColumn<String> recipientStaffId = GeneratedColumn<String>(
    'recipient_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actorStaffIdMeta = const VerificationMeta(
    'actorStaffId',
  );
  @override
  late final GeneratedColumn<String> actorStaffId = GeneratedColumn<String>(
    'actor_staff_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _actorStaffNameMeta = const VerificationMeta(
    'actorStaffName',
  );
  @override
  late final GeneratedColumn<String> actorStaffName = GeneratedColumn<String>(
    'actor_staff_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _transactionIdMeta = const VerificationMeta(
    'transactionId',
  );
  @override
  late final GeneratedColumn<String> transactionId = GeneratedColumn<String>(
    'transaction_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountInPaisaMeta = const VerificationMeta(
    'amountInPaisa',
  );
  @override
  late final GeneratedColumn<int> amountInPaisa = GeneratedColumn<int>(
    'amount_in_paisa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _remainingBalanceInPaisaMeta =
      const VerificationMeta('remainingBalanceInPaisa');
  @override
  late final GeneratedColumn<int> remainingBalanceInPaisa =
      GeneratedColumn<int>(
        'remaining_balance_in_paisa',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _isReadMeta = const VerificationMeta('isRead');
  @override
  late final GeneratedColumn<bool> isRead = GeneratedColumn<bool>(
    'is_read',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_read" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _readAtMeta = const VerificationMeta('readAt');
  @override
  late final GeneratedColumn<DateTime> readAt = GeneratedColumn<DateTime>(
    'read_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    recipientStaffId,
    actorStaffId,
    actorStaffName,
    eventType,
    title,
    message,
    customerId,
    customerName,
    transactionId,
    amountInPaisa,
    remainingBalanceInPaisa,
    isRead,
    readAt,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('recipient_staff_id')) {
      context.handle(
        _recipientStaffIdMeta,
        recipientStaffId.isAcceptableOrUnknown(
          data['recipient_staff_id']!,
          _recipientStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('actor_staff_id')) {
      context.handle(
        _actorStaffIdMeta,
        actorStaffId.isAcceptableOrUnknown(
          data['actor_staff_id']!,
          _actorStaffIdMeta,
        ),
      );
    }
    if (data.containsKey('actor_staff_name')) {
      context.handle(
        _actorStaffNameMeta,
        actorStaffName.isAcceptableOrUnknown(
          data['actor_staff_name']!,
          _actorStaffNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actorStaffNameMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('transaction_id')) {
      context.handle(
        _transactionIdMeta,
        transactionId.isAcceptableOrUnknown(
          data['transaction_id']!,
          _transactionIdMeta,
        ),
      );
    }
    if (data.containsKey('amount_in_paisa')) {
      context.handle(
        _amountInPaisaMeta,
        amountInPaisa.isAcceptableOrUnknown(
          data['amount_in_paisa']!,
          _amountInPaisaMeta,
        ),
      );
    }
    if (data.containsKey('remaining_balance_in_paisa')) {
      context.handle(
        _remainingBalanceInPaisaMeta,
        remainingBalanceInPaisa.isAcceptableOrUnknown(
          data['remaining_balance_in_paisa']!,
          _remainingBalanceInPaisaMeta,
        ),
      );
    }
    if (data.containsKey('is_read')) {
      context.handle(
        _isReadMeta,
        isRead.isAcceptableOrUnknown(data['is_read']!, _isReadMeta),
      );
    }
    if (data.containsKey('read_at')) {
      context.handle(
        _readAtMeta,
        readAt.isAcceptableOrUnknown(data['read_at']!, _readAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotificationsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      recipientStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipient_staff_id'],
      ),
      actorStaffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_staff_id'],
      ),
      actorStaffName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}actor_staff_name'],
      )!,
      eventType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_type'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      )!,
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      transactionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transaction_id'],
      ),
      amountInPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_in_paisa'],
      )!,
      remainingBalanceInPaisa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_balance_in_paisa'],
      )!,
      isRead: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_read'],
      )!,
      readAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}read_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotificationsTableTable createAlias(String alias) {
    return $NotificationsTableTable(attachedDatabase, alias);
  }
}

class NotificationsTableData extends DataClass
    implements Insertable<NotificationsTableData> {
  final String id;
  final String shopId;
  final String? recipientStaffId;
  final String? actorStaffId;
  final String actorStaffName;
  final String eventType;
  final String title;
  final String message;
  final String customerId;
  final String customerName;
  final String? transactionId;
  final int amountInPaisa;
  final int remainingBalanceInPaisa;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;
  const NotificationsTableData({
    required this.id,
    required this.shopId,
    this.recipientStaffId,
    this.actorStaffId,
    required this.actorStaffName,
    required this.eventType,
    required this.title,
    required this.message,
    required this.customerId,
    required this.customerName,
    this.transactionId,
    required this.amountInPaisa,
    required this.remainingBalanceInPaisa,
    required this.isRead,
    this.readAt,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    if (!nullToAbsent || recipientStaffId != null) {
      map['recipient_staff_id'] = Variable<String>(recipientStaffId);
    }
    if (!nullToAbsent || actorStaffId != null) {
      map['actor_staff_id'] = Variable<String>(actorStaffId);
    }
    map['actor_staff_name'] = Variable<String>(actorStaffName);
    map['event_type'] = Variable<String>(eventType);
    map['title'] = Variable<String>(title);
    map['message'] = Variable<String>(message);
    map['customer_id'] = Variable<String>(customerId);
    map['customer_name'] = Variable<String>(customerName);
    if (!nullToAbsent || transactionId != null) {
      map['transaction_id'] = Variable<String>(transactionId);
    }
    map['amount_in_paisa'] = Variable<int>(amountInPaisa);
    map['remaining_balance_in_paisa'] = Variable<int>(remainingBalanceInPaisa);
    map['is_read'] = Variable<bool>(isRead);
    if (!nullToAbsent || readAt != null) {
      map['read_at'] = Variable<DateTime>(readAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotificationsTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationsTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      recipientStaffId: recipientStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(recipientStaffId),
      actorStaffId: actorStaffId == null && nullToAbsent
          ? const Value.absent()
          : Value(actorStaffId),
      actorStaffName: Value(actorStaffName),
      eventType: Value(eventType),
      title: Value(title),
      message: Value(message),
      customerId: Value(customerId),
      customerName: Value(customerName),
      transactionId: transactionId == null && nullToAbsent
          ? const Value.absent()
          : Value(transactionId),
      amountInPaisa: Value(amountInPaisa),
      remainingBalanceInPaisa: Value(remainingBalanceInPaisa),
      isRead: Value(isRead),
      readAt: readAt == null && nullToAbsent
          ? const Value.absent()
          : Value(readAt),
      createdAt: Value(createdAt),
    );
  }

  factory NotificationsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationsTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      recipientStaffId: serializer.fromJson<String?>(json['recipientStaffId']),
      actorStaffId: serializer.fromJson<String?>(json['actorStaffId']),
      actorStaffName: serializer.fromJson<String>(json['actorStaffName']),
      eventType: serializer.fromJson<String>(json['eventType']),
      title: serializer.fromJson<String>(json['title']),
      message: serializer.fromJson<String>(json['message']),
      customerId: serializer.fromJson<String>(json['customerId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      transactionId: serializer.fromJson<String?>(json['transactionId']),
      amountInPaisa: serializer.fromJson<int>(json['amountInPaisa']),
      remainingBalanceInPaisa: serializer.fromJson<int>(
        json['remainingBalanceInPaisa'],
      ),
      isRead: serializer.fromJson<bool>(json['isRead']),
      readAt: serializer.fromJson<DateTime?>(json['readAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'recipientStaffId': serializer.toJson<String?>(recipientStaffId),
      'actorStaffId': serializer.toJson<String?>(actorStaffId),
      'actorStaffName': serializer.toJson<String>(actorStaffName),
      'eventType': serializer.toJson<String>(eventType),
      'title': serializer.toJson<String>(title),
      'message': serializer.toJson<String>(message),
      'customerId': serializer.toJson<String>(customerId),
      'customerName': serializer.toJson<String>(customerName),
      'transactionId': serializer.toJson<String?>(transactionId),
      'amountInPaisa': serializer.toJson<int>(amountInPaisa),
      'remainingBalanceInPaisa': serializer.toJson<int>(
        remainingBalanceInPaisa,
      ),
      'isRead': serializer.toJson<bool>(isRead),
      'readAt': serializer.toJson<DateTime?>(readAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NotificationsTableData copyWith({
    String? id,
    String? shopId,
    Value<String?> recipientStaffId = const Value.absent(),
    Value<String?> actorStaffId = const Value.absent(),
    String? actorStaffName,
    String? eventType,
    String? title,
    String? message,
    String? customerId,
    String? customerName,
    Value<String?> transactionId = const Value.absent(),
    int? amountInPaisa,
    int? remainingBalanceInPaisa,
    bool? isRead,
    Value<DateTime?> readAt = const Value.absent(),
    DateTime? createdAt,
  }) => NotificationsTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    recipientStaffId: recipientStaffId.present
        ? recipientStaffId.value
        : this.recipientStaffId,
    actorStaffId: actorStaffId.present ? actorStaffId.value : this.actorStaffId,
    actorStaffName: actorStaffName ?? this.actorStaffName,
    eventType: eventType ?? this.eventType,
    title: title ?? this.title,
    message: message ?? this.message,
    customerId: customerId ?? this.customerId,
    customerName: customerName ?? this.customerName,
    transactionId: transactionId.present
        ? transactionId.value
        : this.transactionId,
    amountInPaisa: amountInPaisa ?? this.amountInPaisa,
    remainingBalanceInPaisa:
        remainingBalanceInPaisa ?? this.remainingBalanceInPaisa,
    isRead: isRead ?? this.isRead,
    readAt: readAt.present ? readAt.value : this.readAt,
    createdAt: createdAt ?? this.createdAt,
  );
  NotificationsTableData copyWithCompanion(NotificationsTableCompanion data) {
    return NotificationsTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      recipientStaffId: data.recipientStaffId.present
          ? data.recipientStaffId.value
          : this.recipientStaffId,
      actorStaffId: data.actorStaffId.present
          ? data.actorStaffId.value
          : this.actorStaffId,
      actorStaffName: data.actorStaffName.present
          ? data.actorStaffName.value
          : this.actorStaffName,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      title: data.title.present ? data.title.value : this.title,
      message: data.message.present ? data.message.value : this.message,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      transactionId: data.transactionId.present
          ? data.transactionId.value
          : this.transactionId,
      amountInPaisa: data.amountInPaisa.present
          ? data.amountInPaisa.value
          : this.amountInPaisa,
      remainingBalanceInPaisa: data.remainingBalanceInPaisa.present
          ? data.remainingBalanceInPaisa.value
          : this.remainingBalanceInPaisa,
      isRead: data.isRead.present ? data.isRead.value : this.isRead,
      readAt: data.readAt.present ? data.readAt.value : this.readAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('recipientStaffId: $recipientStaffId, ')
          ..write('actorStaffId: $actorStaffId, ')
          ..write('actorStaffName: $actorStaffName, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('transactionId: $transactionId, ')
          ..write('amountInPaisa: $amountInPaisa, ')
          ..write('remainingBalanceInPaisa: $remainingBalanceInPaisa, ')
          ..write('isRead: $isRead, ')
          ..write('readAt: $readAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    shopId,
    recipientStaffId,
    actorStaffId,
    actorStaffName,
    eventType,
    title,
    message,
    customerId,
    customerName,
    transactionId,
    amountInPaisa,
    remainingBalanceInPaisa,
    isRead,
    readAt,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationsTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.recipientStaffId == this.recipientStaffId &&
          other.actorStaffId == this.actorStaffId &&
          other.actorStaffName == this.actorStaffName &&
          other.eventType == this.eventType &&
          other.title == this.title &&
          other.message == this.message &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.transactionId == this.transactionId &&
          other.amountInPaisa == this.amountInPaisa &&
          other.remainingBalanceInPaisa == this.remainingBalanceInPaisa &&
          other.isRead == this.isRead &&
          other.readAt == this.readAt &&
          other.createdAt == this.createdAt);
}

class NotificationsTableCompanion
    extends UpdateCompanion<NotificationsTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String?> recipientStaffId;
  final Value<String?> actorStaffId;
  final Value<String> actorStaffName;
  final Value<String> eventType;
  final Value<String> title;
  final Value<String> message;
  final Value<String> customerId;
  final Value<String> customerName;
  final Value<String?> transactionId;
  final Value<int> amountInPaisa;
  final Value<int> remainingBalanceInPaisa;
  final Value<bool> isRead;
  final Value<DateTime?> readAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotificationsTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.recipientStaffId = const Value.absent(),
    this.actorStaffId = const Value.absent(),
    this.actorStaffName = const Value.absent(),
    this.eventType = const Value.absent(),
    this.title = const Value.absent(),
    this.message = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.transactionId = const Value.absent(),
    this.amountInPaisa = const Value.absent(),
    this.remainingBalanceInPaisa = const Value.absent(),
    this.isRead = const Value.absent(),
    this.readAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationsTableCompanion.insert({
    required String id,
    required String shopId,
    this.recipientStaffId = const Value.absent(),
    this.actorStaffId = const Value.absent(),
    required String actorStaffName,
    required String eventType,
    required String title,
    required String message,
    required String customerId,
    required String customerName,
    this.transactionId = const Value.absent(),
    this.amountInPaisa = const Value.absent(),
    this.remainingBalanceInPaisa = const Value.absent(),
    this.isRead = const Value.absent(),
    this.readAt = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       actorStaffName = Value(actorStaffName),
       eventType = Value(eventType),
       title = Value(title),
       message = Value(message),
       customerId = Value(customerId),
       customerName = Value(customerName),
       createdAt = Value(createdAt);
  static Insertable<NotificationsTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? recipientStaffId,
    Expression<String>? actorStaffId,
    Expression<String>? actorStaffName,
    Expression<String>? eventType,
    Expression<String>? title,
    Expression<String>? message,
    Expression<String>? customerId,
    Expression<String>? customerName,
    Expression<String>? transactionId,
    Expression<int>? amountInPaisa,
    Expression<int>? remainingBalanceInPaisa,
    Expression<bool>? isRead,
    Expression<DateTime>? readAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (recipientStaffId != null) 'recipient_staff_id': recipientStaffId,
      if (actorStaffId != null) 'actor_staff_id': actorStaffId,
      if (actorStaffName != null) 'actor_staff_name': actorStaffName,
      if (eventType != null) 'event_type': eventType,
      if (title != null) 'title': title,
      if (message != null) 'message': message,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (transactionId != null) 'transaction_id': transactionId,
      if (amountInPaisa != null) 'amount_in_paisa': amountInPaisa,
      if (remainingBalanceInPaisa != null)
        'remaining_balance_in_paisa': remainingBalanceInPaisa,
      if (isRead != null) 'is_read': isRead,
      if (readAt != null) 'read_at': readAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String?>? recipientStaffId,
    Value<String?>? actorStaffId,
    Value<String>? actorStaffName,
    Value<String>? eventType,
    Value<String>? title,
    Value<String>? message,
    Value<String>? customerId,
    Value<String>? customerName,
    Value<String?>? transactionId,
    Value<int>? amountInPaisa,
    Value<int>? remainingBalanceInPaisa,
    Value<bool>? isRead,
    Value<DateTime?>? readAt,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotificationsTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      recipientStaffId: recipientStaffId ?? this.recipientStaffId,
      actorStaffId: actorStaffId ?? this.actorStaffId,
      actorStaffName: actorStaffName ?? this.actorStaffName,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      message: message ?? this.message,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      transactionId: transactionId ?? this.transactionId,
      amountInPaisa: amountInPaisa ?? this.amountInPaisa,
      remainingBalanceInPaisa:
          remainingBalanceInPaisa ?? this.remainingBalanceInPaisa,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (recipientStaffId.present) {
      map['recipient_staff_id'] = Variable<String>(recipientStaffId.value);
    }
    if (actorStaffId.present) {
      map['actor_staff_id'] = Variable<String>(actorStaffId.value);
    }
    if (actorStaffName.present) {
      map['actor_staff_name'] = Variable<String>(actorStaffName.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (transactionId.present) {
      map['transaction_id'] = Variable<String>(transactionId.value);
    }
    if (amountInPaisa.present) {
      map['amount_in_paisa'] = Variable<int>(amountInPaisa.value);
    }
    if (remainingBalanceInPaisa.present) {
      map['remaining_balance_in_paisa'] = Variable<int>(
        remainingBalanceInPaisa.value,
      );
    }
    if (isRead.present) {
      map['is_read'] = Variable<bool>(isRead.value);
    }
    if (readAt.present) {
      map['read_at'] = Variable<DateTime>(readAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationsTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('recipientStaffId: $recipientStaffId, ')
          ..write('actorStaffId: $actorStaffId, ')
          ..write('actorStaffName: $actorStaffName, ')
          ..write('eventType: $eventType, ')
          ..write('title: $title, ')
          ..write('message: $message, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('transactionId: $transactionId, ')
          ..write('amountInPaisa: $amountInPaisa, ')
          ..write('remainingBalanceInPaisa: $remainingBalanceInPaisa, ')
          ..write('isRead: $isRead, ')
          ..write('readAt: $readAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DeviceTokensTableTable extends DeviceTokensTable
    with TableInfo<$DeviceTokensTableTable, DeviceTokensTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DeviceTokensTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deviceTokenMeta = const VerificationMeta(
    'deviceToken',
  );
  @override
  late final GeneratedColumn<String> deviceToken = GeneratedColumn<String>(
    'device_token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _platformMeta = const VerificationMeta(
    'platform',
  );
  @override
  late final GeneratedColumn<String> platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    shopId,
    staffId,
    deviceToken,
    platform,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'device_tokens';
  @override
  VerificationContext validateIntegrity(
    Insertable<DeviceTokensTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('device_token')) {
      context.handle(
        _deviceTokenMeta,
        deviceToken.isAcceptableOrUnknown(
          data['device_token']!,
          _deviceTokenMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deviceTokenMeta);
    }
    if (data.containsKey('platform')) {
      context.handle(
        _platformMeta,
        platform.isAcceptableOrUnknown(data['platform']!, _platformMeta),
      );
    } else if (isInserting) {
      context.missing(_platformMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DeviceTokensTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DeviceTokensTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      deviceToken: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_token'],
      )!,
      platform: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}platform'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $DeviceTokensTableTable createAlias(String alias) {
    return $DeviceTokensTableTable(attachedDatabase, alias);
  }
}

class DeviceTokensTableData extends DataClass
    implements Insertable<DeviceTokensTableData> {
  final String id;
  final String shopId;
  final String staffId;
  final String deviceToken;
  final String platform;
  final DateTime updatedAt;
  const DeviceTokensTableData({
    required this.id,
    required this.shopId,
    required this.staffId,
    required this.deviceToken,
    required this.platform,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['shop_id'] = Variable<String>(shopId);
    map['staff_id'] = Variable<String>(staffId);
    map['device_token'] = Variable<String>(deviceToken);
    map['platform'] = Variable<String>(platform);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  DeviceTokensTableCompanion toCompanion(bool nullToAbsent) {
    return DeviceTokensTableCompanion(
      id: Value(id),
      shopId: Value(shopId),
      staffId: Value(staffId),
      deviceToken: Value(deviceToken),
      platform: Value(platform),
      updatedAt: Value(updatedAt),
    );
  }

  factory DeviceTokensTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DeviceTokensTableData(
      id: serializer.fromJson<String>(json['id']),
      shopId: serializer.fromJson<String>(json['shopId']),
      staffId: serializer.fromJson<String>(json['staffId']),
      deviceToken: serializer.fromJson<String>(json['deviceToken']),
      platform: serializer.fromJson<String>(json['platform']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'shopId': serializer.toJson<String>(shopId),
      'staffId': serializer.toJson<String>(staffId),
      'deviceToken': serializer.toJson<String>(deviceToken),
      'platform': serializer.toJson<String>(platform),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  DeviceTokensTableData copyWith({
    String? id,
    String? shopId,
    String? staffId,
    String? deviceToken,
    String? platform,
    DateTime? updatedAt,
  }) => DeviceTokensTableData(
    id: id ?? this.id,
    shopId: shopId ?? this.shopId,
    staffId: staffId ?? this.staffId,
    deviceToken: deviceToken ?? this.deviceToken,
    platform: platform ?? this.platform,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  DeviceTokensTableData copyWithCompanion(DeviceTokensTableCompanion data) {
    return DeviceTokensTableData(
      id: data.id.present ? data.id.value : this.id,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      deviceToken: data.deviceToken.present
          ? data.deviceToken.value
          : this.deviceToken,
      platform: data.platform.present ? data.platform.value : this.platform,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTokensTableData(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('staffId: $staffId, ')
          ..write('deviceToken: $deviceToken, ')
          ..write('platform: $platform, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, shopId, staffId, deviceToken, platform, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DeviceTokensTableData &&
          other.id == this.id &&
          other.shopId == this.shopId &&
          other.staffId == this.staffId &&
          other.deviceToken == this.deviceToken &&
          other.platform == this.platform &&
          other.updatedAt == this.updatedAt);
}

class DeviceTokensTableCompanion
    extends UpdateCompanion<DeviceTokensTableData> {
  final Value<String> id;
  final Value<String> shopId;
  final Value<String> staffId;
  final Value<String> deviceToken;
  final Value<String> platform;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const DeviceTokensTableCompanion({
    this.id = const Value.absent(),
    this.shopId = const Value.absent(),
    this.staffId = const Value.absent(),
    this.deviceToken = const Value.absent(),
    this.platform = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DeviceTokensTableCompanion.insert({
    required String id,
    required String shopId,
    required String staffId,
    required String deviceToken,
    required String platform,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       shopId = Value(shopId),
       staffId = Value(staffId),
       deviceToken = Value(deviceToken),
       platform = Value(platform),
       updatedAt = Value(updatedAt);
  static Insertable<DeviceTokensTableData> custom({
    Expression<String>? id,
    Expression<String>? shopId,
    Expression<String>? staffId,
    Expression<String>? deviceToken,
    Expression<String>? platform,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (shopId != null) 'shop_id': shopId,
      if (staffId != null) 'staff_id': staffId,
      if (deviceToken != null) 'device_token': deviceToken,
      if (platform != null) 'platform': platform,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DeviceTokensTableCompanion copyWith({
    Value<String>? id,
    Value<String>? shopId,
    Value<String>? staffId,
    Value<String>? deviceToken,
    Value<String>? platform,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return DeviceTokensTableCompanion(
      id: id ?? this.id,
      shopId: shopId ?? this.shopId,
      staffId: staffId ?? this.staffId,
      deviceToken: deviceToken ?? this.deviceToken,
      platform: platform ?? this.platform,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (deviceToken.present) {
      map['device_token'] = Variable<String>(deviceToken.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(platform.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DeviceTokensTableCompanion(')
          ..write('id: $id, ')
          ..write('shopId: $shopId, ')
          ..write('staffId: $staffId, ')
          ..write('deviceToken: $deviceToken, ')
          ..write('platform: $platform, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotificationPreferencesTableTable extends NotificationPreferencesTable
    with
        TableInfo<
          $NotificationPreferencesTableTable,
          NotificationPreferencesTableData
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotificationPreferencesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _staffIdMeta = const VerificationMeta(
    'staffId',
  );
  @override
  late final GeneratedColumn<String> staffId = GeneratedColumn<String>(
    'staff_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _shopIdMeta = const VerificationMeta('shopId');
  @override
  late final GeneratedColumn<String> shopId = GeneratedColumn<String>(
    'shop_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notifyOnCreditMeta = const VerificationMeta(
    'notifyOnCredit',
  );
  @override
  late final GeneratedColumn<bool> notifyOnCredit = GeneratedColumn<bool>(
    'notify_on_credit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_on_credit" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyOnPaymentMeta = const VerificationMeta(
    'notifyOnPayment',
  );
  @override
  late final GeneratedColumn<bool> notifyOnPayment = GeneratedColumn<bool>(
    'notify_on_payment',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notify_on_payment" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _notifyOnFullClearanceMeta =
      const VerificationMeta('notifyOnFullClearance');
  @override
  late final GeneratedColumn<bool> notifyOnFullClearance =
      GeneratedColumn<bool>(
        'notify_on_full_clearance',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notify_on_full_clearance" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _notifyOwnTransactionsMeta =
      const VerificationMeta('notifyOwnTransactions');
  @override
  late final GeneratedColumn<bool> notifyOwnTransactions =
      GeneratedColumn<bool>(
        'notify_own_transactions',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("notify_own_transactions" IN (0, 1))',
        ),
        defaultValue: const Constant(false),
      );
  static const VerificationMeta _pushEnabledMeta = const VerificationMeta(
    'pushEnabled',
  );
  @override
  late final GeneratedColumn<bool> pushEnabled = GeneratedColumn<bool>(
    'push_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("push_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    staffId,
    shopId,
    notifyOnCredit,
    notifyOnPayment,
    notifyOnFullClearance,
    notifyOwnTransactions,
    pushEnabled,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notification_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotificationPreferencesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('staff_id')) {
      context.handle(
        _staffIdMeta,
        staffId.isAcceptableOrUnknown(data['staff_id']!, _staffIdMeta),
      );
    } else if (isInserting) {
      context.missing(_staffIdMeta);
    }
    if (data.containsKey('shop_id')) {
      context.handle(
        _shopIdMeta,
        shopId.isAcceptableOrUnknown(data['shop_id']!, _shopIdMeta),
      );
    } else if (isInserting) {
      context.missing(_shopIdMeta);
    }
    if (data.containsKey('notify_on_credit')) {
      context.handle(
        _notifyOnCreditMeta,
        notifyOnCredit.isAcceptableOrUnknown(
          data['notify_on_credit']!,
          _notifyOnCreditMeta,
        ),
      );
    }
    if (data.containsKey('notify_on_payment')) {
      context.handle(
        _notifyOnPaymentMeta,
        notifyOnPayment.isAcceptableOrUnknown(
          data['notify_on_payment']!,
          _notifyOnPaymentMeta,
        ),
      );
    }
    if (data.containsKey('notify_on_full_clearance')) {
      context.handle(
        _notifyOnFullClearanceMeta,
        notifyOnFullClearance.isAcceptableOrUnknown(
          data['notify_on_full_clearance']!,
          _notifyOnFullClearanceMeta,
        ),
      );
    }
    if (data.containsKey('notify_own_transactions')) {
      context.handle(
        _notifyOwnTransactionsMeta,
        notifyOwnTransactions.isAcceptableOrUnknown(
          data['notify_own_transactions']!,
          _notifyOwnTransactionsMeta,
        ),
      );
    }
    if (data.containsKey('push_enabled')) {
      context.handle(
        _pushEnabledMeta,
        pushEnabled.isAcceptableOrUnknown(
          data['push_enabled']!,
          _pushEnabledMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {staffId};
  @override
  NotificationPreferencesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotificationPreferencesTableData(
      staffId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}staff_id'],
      )!,
      shopId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}shop_id'],
      )!,
      notifyOnCredit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_on_credit'],
      )!,
      notifyOnPayment: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_on_payment'],
      )!,
      notifyOnFullClearance: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_on_full_clearance'],
      )!,
      notifyOwnTransactions: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notify_own_transactions'],
      )!,
      pushEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}push_enabled'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotificationPreferencesTableTable createAlias(String alias) {
    return $NotificationPreferencesTableTable(attachedDatabase, alias);
  }
}

class NotificationPreferencesTableData extends DataClass
    implements Insertable<NotificationPreferencesTableData> {
  final String staffId;
  final String shopId;
  final bool notifyOnCredit;
  final bool notifyOnPayment;
  final bool notifyOnFullClearance;
  final bool notifyOwnTransactions;
  final bool pushEnabled;
  final DateTime updatedAt;
  const NotificationPreferencesTableData({
    required this.staffId,
    required this.shopId,
    required this.notifyOnCredit,
    required this.notifyOnPayment,
    required this.notifyOnFullClearance,
    required this.notifyOwnTransactions,
    required this.pushEnabled,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['staff_id'] = Variable<String>(staffId);
    map['shop_id'] = Variable<String>(shopId);
    map['notify_on_credit'] = Variable<bool>(notifyOnCredit);
    map['notify_on_payment'] = Variable<bool>(notifyOnPayment);
    map['notify_on_full_clearance'] = Variable<bool>(notifyOnFullClearance);
    map['notify_own_transactions'] = Variable<bool>(notifyOwnTransactions);
    map['push_enabled'] = Variable<bool>(pushEnabled);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotificationPreferencesTableCompanion toCompanion(bool nullToAbsent) {
    return NotificationPreferencesTableCompanion(
      staffId: Value(staffId),
      shopId: Value(shopId),
      notifyOnCredit: Value(notifyOnCredit),
      notifyOnPayment: Value(notifyOnPayment),
      notifyOnFullClearance: Value(notifyOnFullClearance),
      notifyOwnTransactions: Value(notifyOwnTransactions),
      pushEnabled: Value(pushEnabled),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotificationPreferencesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotificationPreferencesTableData(
      staffId: serializer.fromJson<String>(json['staffId']),
      shopId: serializer.fromJson<String>(json['shopId']),
      notifyOnCredit: serializer.fromJson<bool>(json['notifyOnCredit']),
      notifyOnPayment: serializer.fromJson<bool>(json['notifyOnPayment']),
      notifyOnFullClearance: serializer.fromJson<bool>(
        json['notifyOnFullClearance'],
      ),
      notifyOwnTransactions: serializer.fromJson<bool>(
        json['notifyOwnTransactions'],
      ),
      pushEnabled: serializer.fromJson<bool>(json['pushEnabled']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'staffId': serializer.toJson<String>(staffId),
      'shopId': serializer.toJson<String>(shopId),
      'notifyOnCredit': serializer.toJson<bool>(notifyOnCredit),
      'notifyOnPayment': serializer.toJson<bool>(notifyOnPayment),
      'notifyOnFullClearance': serializer.toJson<bool>(notifyOnFullClearance),
      'notifyOwnTransactions': serializer.toJson<bool>(notifyOwnTransactions),
      'pushEnabled': serializer.toJson<bool>(pushEnabled),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotificationPreferencesTableData copyWith({
    String? staffId,
    String? shopId,
    bool? notifyOnCredit,
    bool? notifyOnPayment,
    bool? notifyOnFullClearance,
    bool? notifyOwnTransactions,
    bool? pushEnabled,
    DateTime? updatedAt,
  }) => NotificationPreferencesTableData(
    staffId: staffId ?? this.staffId,
    shopId: shopId ?? this.shopId,
    notifyOnCredit: notifyOnCredit ?? this.notifyOnCredit,
    notifyOnPayment: notifyOnPayment ?? this.notifyOnPayment,
    notifyOnFullClearance: notifyOnFullClearance ?? this.notifyOnFullClearance,
    notifyOwnTransactions: notifyOwnTransactions ?? this.notifyOwnTransactions,
    pushEnabled: pushEnabled ?? this.pushEnabled,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotificationPreferencesTableData copyWithCompanion(
    NotificationPreferencesTableCompanion data,
  ) {
    return NotificationPreferencesTableData(
      staffId: data.staffId.present ? data.staffId.value : this.staffId,
      shopId: data.shopId.present ? data.shopId.value : this.shopId,
      notifyOnCredit: data.notifyOnCredit.present
          ? data.notifyOnCredit.value
          : this.notifyOnCredit,
      notifyOnPayment: data.notifyOnPayment.present
          ? data.notifyOnPayment.value
          : this.notifyOnPayment,
      notifyOnFullClearance: data.notifyOnFullClearance.present
          ? data.notifyOnFullClearance.value
          : this.notifyOnFullClearance,
      notifyOwnTransactions: data.notifyOwnTransactions.present
          ? data.notifyOwnTransactions.value
          : this.notifyOwnTransactions,
      pushEnabled: data.pushEnabled.present
          ? data.pushEnabled.value
          : this.pushEnabled,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesTableData(')
          ..write('staffId: $staffId, ')
          ..write('shopId: $shopId, ')
          ..write('notifyOnCredit: $notifyOnCredit, ')
          ..write('notifyOnPayment: $notifyOnPayment, ')
          ..write('notifyOnFullClearance: $notifyOnFullClearance, ')
          ..write('notifyOwnTransactions: $notifyOwnTransactions, ')
          ..write('pushEnabled: $pushEnabled, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    staffId,
    shopId,
    notifyOnCredit,
    notifyOnPayment,
    notifyOnFullClearance,
    notifyOwnTransactions,
    pushEnabled,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotificationPreferencesTableData &&
          other.staffId == this.staffId &&
          other.shopId == this.shopId &&
          other.notifyOnCredit == this.notifyOnCredit &&
          other.notifyOnPayment == this.notifyOnPayment &&
          other.notifyOnFullClearance == this.notifyOnFullClearance &&
          other.notifyOwnTransactions == this.notifyOwnTransactions &&
          other.pushEnabled == this.pushEnabled &&
          other.updatedAt == this.updatedAt);
}

class NotificationPreferencesTableCompanion
    extends UpdateCompanion<NotificationPreferencesTableData> {
  final Value<String> staffId;
  final Value<String> shopId;
  final Value<bool> notifyOnCredit;
  final Value<bool> notifyOnPayment;
  final Value<bool> notifyOnFullClearance;
  final Value<bool> notifyOwnTransactions;
  final Value<bool> pushEnabled;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const NotificationPreferencesTableCompanion({
    this.staffId = const Value.absent(),
    this.shopId = const Value.absent(),
    this.notifyOnCredit = const Value.absent(),
    this.notifyOnPayment = const Value.absent(),
    this.notifyOnFullClearance = const Value.absent(),
    this.notifyOwnTransactions = const Value.absent(),
    this.pushEnabled = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotificationPreferencesTableCompanion.insert({
    required String staffId,
    required String shopId,
    this.notifyOnCredit = const Value.absent(),
    this.notifyOnPayment = const Value.absent(),
    this.notifyOnFullClearance = const Value.absent(),
    this.notifyOwnTransactions = const Value.absent(),
    this.pushEnabled = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : staffId = Value(staffId),
       shopId = Value(shopId),
       updatedAt = Value(updatedAt);
  static Insertable<NotificationPreferencesTableData> custom({
    Expression<String>? staffId,
    Expression<String>? shopId,
    Expression<bool>? notifyOnCredit,
    Expression<bool>? notifyOnPayment,
    Expression<bool>? notifyOnFullClearance,
    Expression<bool>? notifyOwnTransactions,
    Expression<bool>? pushEnabled,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (staffId != null) 'staff_id': staffId,
      if (shopId != null) 'shop_id': shopId,
      if (notifyOnCredit != null) 'notify_on_credit': notifyOnCredit,
      if (notifyOnPayment != null) 'notify_on_payment': notifyOnPayment,
      if (notifyOnFullClearance != null)
        'notify_on_full_clearance': notifyOnFullClearance,
      if (notifyOwnTransactions != null)
        'notify_own_transactions': notifyOwnTransactions,
      if (pushEnabled != null) 'push_enabled': pushEnabled,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotificationPreferencesTableCompanion copyWith({
    Value<String>? staffId,
    Value<String>? shopId,
    Value<bool>? notifyOnCredit,
    Value<bool>? notifyOnPayment,
    Value<bool>? notifyOnFullClearance,
    Value<bool>? notifyOwnTransactions,
    Value<bool>? pushEnabled,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return NotificationPreferencesTableCompanion(
      staffId: staffId ?? this.staffId,
      shopId: shopId ?? this.shopId,
      notifyOnCredit: notifyOnCredit ?? this.notifyOnCredit,
      notifyOnPayment: notifyOnPayment ?? this.notifyOnPayment,
      notifyOnFullClearance:
          notifyOnFullClearance ?? this.notifyOnFullClearance,
      notifyOwnTransactions:
          notifyOwnTransactions ?? this.notifyOwnTransactions,
      pushEnabled: pushEnabled ?? this.pushEnabled,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (staffId.present) {
      map['staff_id'] = Variable<String>(staffId.value);
    }
    if (shopId.present) {
      map['shop_id'] = Variable<String>(shopId.value);
    }
    if (notifyOnCredit.present) {
      map['notify_on_credit'] = Variable<bool>(notifyOnCredit.value);
    }
    if (notifyOnPayment.present) {
      map['notify_on_payment'] = Variable<bool>(notifyOnPayment.value);
    }
    if (notifyOnFullClearance.present) {
      map['notify_on_full_clearance'] = Variable<bool>(
        notifyOnFullClearance.value,
      );
    }
    if (notifyOwnTransactions.present) {
      map['notify_own_transactions'] = Variable<bool>(
        notifyOwnTransactions.value,
      );
    }
    if (pushEnabled.present) {
      map['push_enabled'] = Variable<bool>(pushEnabled.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotificationPreferencesTableCompanion(')
          ..write('staffId: $staffId, ')
          ..write('shopId: $shopId, ')
          ..write('notifyOnCredit: $notifyOnCredit, ')
          ..write('notifyOnPayment: $notifyOnPayment, ')
          ..write('notifyOnFullClearance: $notifyOnFullClearance, ')
          ..write('notifyOwnTransactions: $notifyOwnTransactions, ')
          ..write('pushEnabled: $pushEnabled, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShopsTableTable shopsTable = $ShopsTableTable(this);
  late final $CustomersTableTable customersTable = $CustomersTableTable(this);
  late final $TransactionsTableTable transactionsTable =
      $TransactionsTableTable(this);
  late final $StaffTableTable staffTable = $StaffTableTable(this);
  late final $ShopSettingsTableTable shopSettingsTable =
      $ShopSettingsTableTable(this);
  late final $AuditLogsTableTable auditLogsTable = $AuditLogsTableTable(this);
  late final $ReminderLogsTableTable reminderLogsTable =
      $ReminderLogsTableTable(this);
  late final $PendingSyncOperationsTableTable pendingSyncOperationsTable =
      $PendingSyncOperationsTableTable(this);
  late final $NotificationsTableTable notificationsTable =
      $NotificationsTableTable(this);
  late final $DeviceTokensTableTable deviceTokensTable =
      $DeviceTokensTableTable(this);
  late final $NotificationPreferencesTableTable notificationPreferencesTable =
      $NotificationPreferencesTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    shopsTable,
    customersTable,
    transactionsTable,
    staffTable,
    shopSettingsTable,
    auditLogsTable,
    reminderLogsTable,
    pendingSyncOperationsTable,
    notificationsTable,
    deviceTokensTable,
    notificationPreferencesTable,
  ];
}

typedef $$ShopsTableTableCreateCompanionBuilder = ShopsTableCompanion Function({
  required String id,
  required String ownerUid,
  required String name,
  Value<String?> phone,
  Value<String?> address,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ShopsTableTableUpdateCompanionBuilder = ShopsTableCompanion Function({
  Value<String> id,
  Value<String> ownerUid,
  Value<String> name,
  Value<String?> phone,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$ShopsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerUid => $composableBuilder(
    column: $table.ownerUid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopsTableTable> {
  $$ShopsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerUid =>
      $composableBuilder(column: $table.ownerUid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShopsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopsTableTable,
          ShopsTableData,
          $$ShopsTableTableFilterComposer,
          $$ShopsTableTableOrderingComposer,
          $$ShopsTableTableAnnotationComposer,
          $$ShopsTableTableCreateCompanionBuilder,
          $$ShopsTableTableUpdateCompanionBuilder,
          (
            ShopsTableData,
            BaseReferences<_$AppDatabase, $ShopsTableTable, ShopsTableData>,
          ),
          ShopsTableData,
          PrefetchHooks Function()
        > {
  $$ShopsTableTableTableManager(_$AppDatabase db, $ShopsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerUid = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopsTableCompanion(
                id: id,
                ownerUid: ownerUid,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerUid,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> address = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShopsTableCompanion.insert(
                id: id,
                ownerUid: ownerUid,
                name: name,
                phone: phone,
                address: address,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopsTableTable, ShopsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ShopsTableTable,
                    ShopsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopsTableTable,
      ShopsTableData,
      $$ShopsTableTableFilterComposer,
      $$ShopsTableTableOrderingComposer,
      $$ShopsTableTableAnnotationComposer,
      $$ShopsTableTableCreateCompanionBuilder,
      $$ShopsTableTableUpdateCompanionBuilder,
      (
        ShopsTableData,
        BaseReferences<_$AppDatabase, $ShopsTableTable, ShopsTableData>,
      ),
      ShopsTableData,
      PrefetchHooks Function()
    >;
typedef $$CustomersTableTableCreateCompanionBuilder =
    CustomersTableCompanion Function({
      required String id,
      required String shopId,
      required String name,
      Value<String?> phone,
      Value<String?> email,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$CustomersTableTableUpdateCompanionBuilder =
    CustomersTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> name,
      Value<String?> phone,
      Value<String?> email,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$CustomersTableTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CustomersTableTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CustomersTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTableTable> {
  $$CustomersTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$CustomersTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTableTable,
          CustomersTableData,
          $$CustomersTableTableFilterComposer,
          $$CustomersTableTableOrderingComposer,
          $$CustomersTableTableAnnotationComposer,
          $$CustomersTableTableCreateCompanionBuilder,
          $$CustomersTableTableUpdateCompanionBuilder,
          (
            CustomersTableData,
            BaseReferences<
              _$AppDatabase,
              $CustomersTableTable,
              CustomersTableData
            >,
          ),
          CustomersTableData,
          PrefetchHooks Function()
        > {
  $$CustomersTableTableTableManager(
    _$AppDatabase db,
    $CustomersTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersTableCompanion(
                id: id,
                shopId: shopId,
                name: name,
                phone: phone,
                email: email,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersTableCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                phone: phone,
                email: email,
                createdAt: createdAt,
                updatedAt: updatedAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomersTableTable, CustomersTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $CustomersTableTable,
                    CustomersTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomersTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTableTable,
      CustomersTableData,
      $$CustomersTableTableFilterComposer,
      $$CustomersTableTableOrderingComposer,
      $$CustomersTableTableAnnotationComposer,
      $$CustomersTableTableCreateCompanionBuilder,
      $$CustomersTableTableUpdateCompanionBuilder,
      (
        CustomersTableData,
        BaseReferences<_$AppDatabase, $CustomersTableTable, CustomersTableData>,
      ),
      CustomersTableData,
      PrefetchHooks Function()
    >;
typedef $$TransactionsTableTableCreateCompanionBuilder =
    TransactionsTableCompanion Function({
      required String id,
      required String shopId,
      required String customerId,
      required String type,
      required int amountInPaisa,
      Value<String?> note,
      Value<String?> staffId,
      Value<String?> staffName,
      Value<DateTime?> dueDate,
      Value<String?> paymentMethod,
      required DateTime createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });
typedef $$TransactionsTableTableUpdateCompanionBuilder =
    TransactionsTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> customerId,
      Value<String> type,
      Value<int> amountInPaisa,
      Value<String?> note,
      Value<String?> staffId,
      Value<String?> staffName,
      Value<DateTime?> dueDate,
      Value<String?> paymentMethod,
      Value<DateTime> createdAt,
      Value<String> syncStatus,
      Value<int> rowid,
    });

class $$TransactionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountInPaisa => $composableBuilder(
    column: $table.amountInPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffName => $composableBuilder(
    column: $table.staffName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TransactionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountInPaisa => $composableBuilder(
    column: $table.amountInPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffName => $composableBuilder(
    column: $table.staffName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TransactionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTableTable> {
  $$TransactionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountInPaisa => $composableBuilder(
    column: $table.amountInPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get staffName =>
      $composableBuilder(column: $table.staffName, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );
}

class $$TransactionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData,
          $$TransactionsTableTableFilterComposer,
          $$TransactionsTableTableOrderingComposer,
          $$TransactionsTableTableAnnotationComposer,
          $$TransactionsTableTableCreateCompanionBuilder,
          $$TransactionsTableTableUpdateCompanionBuilder,
          (
            TransactionsTableData,
            BaseReferences<
              _$AppDatabase,
              $TransactionsTableTable,
              TransactionsTableData
            >,
          ),
          TransactionsTableData,
          PrefetchHooks Function()
        > {
  $$TransactionsTableTableTableManager(
    _$AppDatabase db,
    $TransactionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> amountInPaisa = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> staffId = const Value.absent(),
                Value<String?> staffName = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion(
                id: id,
                shopId: shopId,
                customerId: customerId,
                type: type,
                amountInPaisa: amountInPaisa,
                note: note,
                staffId: staffId,
                staffName: staffName,
                dueDate: dueDate,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String customerId,
                required String type,
                required int amountInPaisa,
                Value<String?> note = const Value.absent(),
                Value<String?> staffId = const Value.absent(),
                Value<String?> staffName = const Value.absent(),
                Value<DateTime?> dueDate = const Value.absent(),
                Value<String?> paymentMethod = const Value.absent(),
                required DateTime createdAt,
                Value<String> syncStatus = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TransactionsTableCompanion.insert(
                id: id,
                shopId: shopId,
                customerId: customerId,
                type: type,
                amountInPaisa: amountInPaisa,
                note: note,
                staffId: staffId,
                staffName: staffName,
                dueDate: dueDate,
                paymentMethod: paymentMethod,
                createdAt: createdAt,
                syncStatus: syncStatus,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TransactionsTableTable, TransactionsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $TransactionsTableTable,
                    TransactionsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TransactionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransactionsTableTable,
      TransactionsTableData,
      $$TransactionsTableTableFilterComposer,
      $$TransactionsTableTableOrderingComposer,
      $$TransactionsTableTableAnnotationComposer,
      $$TransactionsTableTableCreateCompanionBuilder,
      $$TransactionsTableTableUpdateCompanionBuilder,
      (
        TransactionsTableData,
        BaseReferences<
          _$AppDatabase,
          $TransactionsTableTable,
          TransactionsTableData
        >,
      ),
      TransactionsTableData,
      PrefetchHooks Function()
    >;
typedef $$StaffTableTableCreateCompanionBuilder = StaffTableCompanion Function({
  required String id,
  required String shopId,
  required String name,
  required String email,
  Value<String?> phone,
  Value<String> role,
  Value<bool> isActive,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$StaffTableTableUpdateCompanionBuilder = StaffTableCompanion Function({
  Value<String> id,
  Value<String> shopId,
  Value<String> name,
  Value<String> email,
  Value<String?> phone,
  Value<String> role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$StaffTableTableFilterComposer
    extends Composer<_$AppDatabase, $StaffTableTable> {
  $$StaffTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StaffTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StaffTableTable> {
  $$StaffTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StaffTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StaffTableTable> {
  $$StaffTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$StaffTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StaffTableTable,
          StaffTableData,
          $$StaffTableTableFilterComposer,
          $$StaffTableTableOrderingComposer,
          $$StaffTableTableAnnotationComposer,
          $$StaffTableTableCreateCompanionBuilder,
          $$StaffTableTableUpdateCompanionBuilder,
          (
            StaffTableData,
            BaseReferences<_$AppDatabase, $StaffTableTable, StaffTableData>,
          ),
          StaffTableData,
          PrefetchHooks Function()
        > {
  $$StaffTableTableTableManager(_$AppDatabase db, $StaffTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StaffTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StaffTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StaffTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StaffTableCompanion(
                id: id,
                shopId: shopId,
                name: name,
                email: email,
                phone: phone,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String name,
                required String email,
                Value<String?> phone = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => StaffTableCompanion.insert(
                id: id,
                shopId: shopId,
                name: name,
                email: email,
                phone: phone,
                role: role,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$StaffTableTable, StaffTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $StaffTableTable,
                    StaffTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StaffTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StaffTableTable,
      StaffTableData,
      $$StaffTableTableFilterComposer,
      $$StaffTableTableOrderingComposer,
      $$StaffTableTableAnnotationComposer,
      $$StaffTableTableCreateCompanionBuilder,
      $$StaffTableTableUpdateCompanionBuilder,
      (
        StaffTableData,
        BaseReferences<_$AppDatabase, $StaffTableTable, StaffTableData>,
      ),
      StaffTableData,
      PrefetchHooks Function()
    >;
typedef $$ShopSettingsTableTableCreateCompanionBuilder =
    ShopSettingsTableCompanion Function({
      required String shopId,
      Value<int> defaultRepaymentDays,
      Value<bool> emailRemindersEnabled,
      Value<String?> senderEmail,
      Value<int> reminderIntervalDays,
      Value<bool> smsRemindersEnabled,
      Value<String?> smsProviderConfigJson,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ShopSettingsTableTableUpdateCompanionBuilder =
    ShopSettingsTableCompanion Function({
      Value<String> shopId,
      Value<int> defaultRepaymentDays,
      Value<bool> emailRemindersEnabled,
      Value<String?> senderEmail,
      Value<int> reminderIntervalDays,
      Value<bool> smsRemindersEnabled,
      Value<String?> smsProviderConfigJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ShopSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultRepaymentDays => $composableBuilder(
    column: $table.defaultRepaymentDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get emailRemindersEnabled => $composableBuilder(
    column: $table.emailRemindersEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get senderEmail => $composableBuilder(
    column: $table.senderEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderIntervalDays => $composableBuilder(
    column: $table.reminderIntervalDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get smsRemindersEnabled => $composableBuilder(
    column: $table.smsRemindersEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get smsProviderConfigJson => $composableBuilder(
    column: $table.smsProviderConfigJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShopSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultRepaymentDays => $composableBuilder(
    column: $table.defaultRepaymentDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get emailRemindersEnabled => $composableBuilder(
    column: $table.emailRemindersEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get senderEmail => $composableBuilder(
    column: $table.senderEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderIntervalDays => $composableBuilder(
    column: $table.reminderIntervalDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get smsRemindersEnabled => $composableBuilder(
    column: $table.smsRemindersEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get smsProviderConfigJson => $composableBuilder(
    column: $table.smsProviderConfigJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShopSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShopSettingsTableTable> {
  $$ShopSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<int> get defaultRepaymentDays => $composableBuilder(
    column: $table.defaultRepaymentDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get emailRemindersEnabled => $composableBuilder(
    column: $table.emailRemindersEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get senderEmail => $composableBuilder(
    column: $table.senderEmail,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderIntervalDays => $composableBuilder(
    column: $table.reminderIntervalDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get smsRemindersEnabled => $composableBuilder(
    column: $table.smsRemindersEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<String> get smsProviderConfigJson => $composableBuilder(
    column: $table.smsProviderConfigJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShopSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShopSettingsTableTable,
          ShopSettingsTableData,
          $$ShopSettingsTableTableFilterComposer,
          $$ShopSettingsTableTableOrderingComposer,
          $$ShopSettingsTableTableAnnotationComposer,
          $$ShopSettingsTableTableCreateCompanionBuilder,
          $$ShopSettingsTableTableUpdateCompanionBuilder,
          (
            ShopSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $ShopSettingsTableTable,
              ShopSettingsTableData
            >,
          ),
          ShopSettingsTableData,
          PrefetchHooks Function()
        > {
  $$ShopSettingsTableTableTableManager(
    _$AppDatabase db,
    $ShopSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShopSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShopSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShopSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> shopId = const Value.absent(),
                Value<int> defaultRepaymentDays = const Value.absent(),
                Value<bool> emailRemindersEnabled = const Value.absent(),
                Value<String?> senderEmail = const Value.absent(),
                Value<int> reminderIntervalDays = const Value.absent(),
                Value<bool> smsRemindersEnabled = const Value.absent(),
                Value<String?> smsProviderConfigJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShopSettingsTableCompanion(
                shopId: shopId,
                defaultRepaymentDays: defaultRepaymentDays,
                emailRemindersEnabled: emailRemindersEnabled,
                senderEmail: senderEmail,
                reminderIntervalDays: reminderIntervalDays,
                smsRemindersEnabled: smsRemindersEnabled,
                smsProviderConfigJson: smsProviderConfigJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String shopId,
                Value<int> defaultRepaymentDays = const Value.absent(),
                Value<bool> emailRemindersEnabled = const Value.absent(),
                Value<String?> senderEmail = const Value.absent(),
                Value<int> reminderIntervalDays = const Value.absent(),
                Value<bool> smsRemindersEnabled = const Value.absent(),
                Value<String?> smsProviderConfigJson = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShopSettingsTableCompanion.insert(
                shopId: shopId,
                defaultRepaymentDays: defaultRepaymentDays,
                emailRemindersEnabled: emailRemindersEnabled,
                senderEmail: senderEmail,
                reminderIntervalDays: reminderIntervalDays,
                smsRemindersEnabled: smsRemindersEnabled,
                smsProviderConfigJson: smsProviderConfigJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShopSettingsTableTable, ShopSettingsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ShopSettingsTableTable,
                    ShopSettingsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShopSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShopSettingsTableTable,
      ShopSettingsTableData,
      $$ShopSettingsTableTableFilterComposer,
      $$ShopSettingsTableTableOrderingComposer,
      $$ShopSettingsTableTableAnnotationComposer,
      $$ShopSettingsTableTableCreateCompanionBuilder,
      $$ShopSettingsTableTableUpdateCompanionBuilder,
      (
        ShopSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $ShopSettingsTableTable,
          ShopSettingsTableData
        >,
      ),
      ShopSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$AuditLogsTableTableCreateCompanionBuilder =
    AuditLogsTableCompanion Function({
      required String id,
      required String shopId,
      Value<String?> actorId,
      Value<String?> actorName,
      required String action,
      required String entityType,
      required String entityId,
      required String detailsJson,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$AuditLogsTableTableUpdateCompanionBuilder =
    AuditLogsTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> actorId,
      Value<String?> actorName,
      Value<String> action,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> detailsJson,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AuditLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AuditLogsTableTable> {
  $$AuditLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorId => $composableBuilder(
    column: $table.actorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorName => $composableBuilder(
    column: $table.actorName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AuditLogsTableTable> {
  $$AuditLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorId => $composableBuilder(
    column: $table.actorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorName => $composableBuilder(
    column: $table.actorName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get action => $composableBuilder(
    column: $table.action,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AuditLogsTableTable> {
  $$AuditLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get actorId =>
      $composableBuilder(column: $table.actorId, builder: (column) => column);

  GeneratedColumn<String> get actorName =>
      $composableBuilder(column: $table.actorName, builder: (column) => column);

  GeneratedColumn<String> get action =>
      $composableBuilder(column: $table.action, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get detailsJson => $composableBuilder(
    column: $table.detailsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AuditLogsTableTable,
          AuditLogsTableData,
          $$AuditLogsTableTableFilterComposer,
          $$AuditLogsTableTableOrderingComposer,
          $$AuditLogsTableTableAnnotationComposer,
          $$AuditLogsTableTableCreateCompanionBuilder,
          $$AuditLogsTableTableUpdateCompanionBuilder,
          (
            AuditLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $AuditLogsTableTable,
              AuditLogsTableData
            >,
          ),
          AuditLogsTableData,
          PrefetchHooks Function()
        > {
  $$AuditLogsTableTableTableManager(
    _$AppDatabase db,
    $AuditLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AuditLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AuditLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AuditLogsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> actorId = const Value.absent(),
                Value<String?> actorName = const Value.absent(),
                Value<String> action = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> detailsJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsTableCompanion(
                id: id,
                shopId: shopId,
                actorId: actorId,
                actorName: actorName,
                action: action,
                entityType: entityType,
                entityId: entityId,
                detailsJson: detailsJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> actorId = const Value.absent(),
                Value<String?> actorName = const Value.absent(),
                required String action,
                required String entityType,
                required String entityId,
                required String detailsJson,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AuditLogsTableCompanion.insert(
                id: id,
                shopId: shopId,
                actorId: actorId,
                actorName: actorName,
                action: action,
                entityType: entityType,
                entityId: entityId,
                detailsJson: detailsJson,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AuditLogsTableTable, AuditLogsTableData>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AuditLogsTableTable,
                    AuditLogsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AuditLogsTableTable,
      AuditLogsTableData,
      $$AuditLogsTableTableFilterComposer,
      $$AuditLogsTableTableOrderingComposer,
      $$AuditLogsTableTableAnnotationComposer,
      $$AuditLogsTableTableCreateCompanionBuilder,
      $$AuditLogsTableTableUpdateCompanionBuilder,
      (
        AuditLogsTableData,
        BaseReferences<_$AppDatabase, $AuditLogsTableTable, AuditLogsTableData>,
      ),
      AuditLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$ReminderLogsTableTableCreateCompanionBuilder =
    ReminderLogsTableCompanion Function({
      required String id,
      required String shopId,
      required String customerId,
      required String customerName,
      required String recipient,
      required String type,
      required String title,
      required String content,
      Value<String> status,
      required DateTime scheduledFor,
      Value<DateTime?> sentAt,
      Value<String?> errorMessage,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$ReminderLogsTableTableUpdateCompanionBuilder =
    ReminderLogsTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> customerId,
      Value<String> customerName,
      Value<String> recipient,
      Value<String> type,
      Value<String> title,
      Value<String> content,
      Value<String> status,
      Value<DateTime> scheduledFor,
      Value<DateTime?> sentAt,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$ReminderLogsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ReminderLogsTableTable> {
  $$ReminderLogsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReminderLogsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ReminderLogsTableTable> {
  $$ReminderLogsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipient => $composableBuilder(
    column: $table.recipient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReminderLogsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReminderLogsTableTable> {
  $$ReminderLogsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recipient =>
      $composableBuilder(column: $table.recipient, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledFor => $composableBuilder(
    column: $table.scheduledFor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ReminderLogsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReminderLogsTableTable,
          ReminderLogsTableData,
          $$ReminderLogsTableTableFilterComposer,
          $$ReminderLogsTableTableOrderingComposer,
          $$ReminderLogsTableTableAnnotationComposer,
          $$ReminderLogsTableTableCreateCompanionBuilder,
          $$ReminderLogsTableTableUpdateCompanionBuilder,
          (
            ReminderLogsTableData,
            BaseReferences<
              _$AppDatabase,
              $ReminderLogsTableTable,
              ReminderLogsTableData
            >,
          ),
          ReminderLogsTableData,
          PrefetchHooks Function()
        > {
  $$ReminderLogsTableTableTableManager(
    _$AppDatabase db,
    $ReminderLogsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReminderLogsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReminderLogsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReminderLogsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> recipient = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> scheduledFor = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReminderLogsTableCompanion(
                id: id,
                shopId: shopId,
                customerId: customerId,
                customerName: customerName,
                recipient: recipient,
                type: type,
                title: title,
                content: content,
                status: status,
                scheduledFor: scheduledFor,
                sentAt: sentAt,
                errorMessage: errorMessage,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String customerId,
                required String customerName,
                required String recipient,
                required String type,
                required String title,
                required String content,
                Value<String> status = const Value.absent(),
                required DateTime scheduledFor,
                Value<DateTime?> sentAt = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => ReminderLogsTableCompanion.insert(
                id: id,
                shopId: shopId,
                customerId: customerId,
                customerName: customerName,
                recipient: recipient,
                type: type,
                title: title,
                content: content,
                status: status,
                scheduledFor: scheduledFor,
                sentAt: sentAt,
                errorMessage: errorMessage,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReminderLogsTableTable, ReminderLogsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $ReminderLogsTableTable,
                    ReminderLogsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReminderLogsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReminderLogsTableTable,
      ReminderLogsTableData,
      $$ReminderLogsTableTableFilterComposer,
      $$ReminderLogsTableTableOrderingComposer,
      $$ReminderLogsTableTableAnnotationComposer,
      $$ReminderLogsTableTableCreateCompanionBuilder,
      $$ReminderLogsTableTableUpdateCompanionBuilder,
      (
        ReminderLogsTableData,
        BaseReferences<
          _$AppDatabase,
          $ReminderLogsTableTable,
          ReminderLogsTableData
        >,
      ),
      ReminderLogsTableData,
      PrefetchHooks Function()
    >;
typedef $$PendingSyncOperationsTableTableCreateCompanionBuilder =
    PendingSyncOperationsTableCompanion Function({
      required String id,
      required String shopId,
      required String entityType,
      required String entityId,
      required String operationType,
      required String payloadJson,
      required DateTime createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<int> rowid,
    });
typedef $$PendingSyncOperationsTableTableUpdateCompanionBuilder =
    PendingSyncOperationsTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operationType,
      Value<String> payloadJson,
      Value<DateTime> createdAt,
      Value<int> retryCount,
      Value<String?> lastError,
      Value<int> rowid,
    });

class $$PendingSyncOperationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PendingSyncOperationsTableTable> {
  $$PendingSyncOperationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingSyncOperationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingSyncOperationsTableTable> {
  $$PendingSyncOperationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingSyncOperationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingSyncOperationsTableTable> {
  $$PendingSyncOperationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operationType => $composableBuilder(
    column: $table.operationType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get payloadJson => $composableBuilder(
    column: $table.payloadJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$PendingSyncOperationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingSyncOperationsTableTable,
          PendingSyncOperationsTableData,
          $$PendingSyncOperationsTableTableFilterComposer,
          $$PendingSyncOperationsTableTableOrderingComposer,
          $$PendingSyncOperationsTableTableAnnotationComposer,
          $$PendingSyncOperationsTableTableCreateCompanionBuilder,
          $$PendingSyncOperationsTableTableUpdateCompanionBuilder,
          (
            PendingSyncOperationsTableData,
            BaseReferences<
              _$AppDatabase,
              $PendingSyncOperationsTableTable,
              PendingSyncOperationsTableData
            >,
          ),
          PendingSyncOperationsTableData,
          PrefetchHooks Function()
        > {
  $$PendingSyncOperationsTableTableTableManager(
    _$AppDatabase db,
    $PendingSyncOperationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingSyncOperationsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PendingSyncOperationsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PendingSyncOperationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operationType = const Value.absent(),
                Value<String> payloadJson = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingSyncOperationsTableCompanion(
                id: id,
                shopId: shopId,
                entityType: entityType,
                entityId: entityId,
                operationType: operationType,
                payloadJson: payloadJson,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String entityType,
                required String entityId,
                required String operationType,
                required String payloadJson,
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingSyncOperationsTableCompanion.insert(
                id: id,
                shopId: shopId,
                entityType: entityType,
                entityId: entityId,
                operationType: operationType,
                payloadJson: payloadJson,
                createdAt: createdAt,
                retryCount: retryCount,
                lastError: lastError,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $PendingSyncOperationsTableTable,
                    PendingSyncOperationsTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $PendingSyncOperationsTableTable,
                    PendingSyncOperationsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingSyncOperationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingSyncOperationsTableTable,
      PendingSyncOperationsTableData,
      $$PendingSyncOperationsTableTableFilterComposer,
      $$PendingSyncOperationsTableTableOrderingComposer,
      $$PendingSyncOperationsTableTableAnnotationComposer,
      $$PendingSyncOperationsTableTableCreateCompanionBuilder,
      $$PendingSyncOperationsTableTableUpdateCompanionBuilder,
      (
        PendingSyncOperationsTableData,
        BaseReferences<
          _$AppDatabase,
          $PendingSyncOperationsTableTable,
          PendingSyncOperationsTableData
        >,
      ),
      PendingSyncOperationsTableData,
      PrefetchHooks Function()
    >;
typedef $$NotificationsTableTableCreateCompanionBuilder =
    NotificationsTableCompanion Function({
      required String id,
      required String shopId,
      Value<String?> recipientStaffId,
      Value<String?> actorStaffId,
      required String actorStaffName,
      required String eventType,
      required String title,
      required String message,
      required String customerId,
      required String customerName,
      Value<String?> transactionId,
      Value<int> amountInPaisa,
      Value<int> remainingBalanceInPaisa,
      Value<bool> isRead,
      Value<DateTime?> readAt,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NotificationsTableTableUpdateCompanionBuilder =
    NotificationsTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String?> recipientStaffId,
      Value<String?> actorStaffId,
      Value<String> actorStaffName,
      Value<String> eventType,
      Value<String> title,
      Value<String> message,
      Value<String> customerId,
      Value<String> customerName,
      Value<String?> transactionId,
      Value<int> amountInPaisa,
      Value<int> remainingBalanceInPaisa,
      Value<bool> isRead,
      Value<DateTime?> readAt,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NotificationsTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recipientStaffId => $composableBuilder(
    column: $table.recipientStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorStaffId => $composableBuilder(
    column: $table.actorStaffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actorStaffName => $composableBuilder(
    column: $table.actorStaffName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountInPaisa => $composableBuilder(
    column: $table.amountInPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingBalanceInPaisa => $composableBuilder(
    column: $table.remainingBalanceInPaisa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recipientStaffId => $composableBuilder(
    column: $table.recipientStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorStaffId => $composableBuilder(
    column: $table.actorStaffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actorStaffName => $composableBuilder(
    column: $table.actorStaffName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountInPaisa => $composableBuilder(
    column: $table.amountInPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingBalanceInPaisa => $composableBuilder(
    column: $table.remainingBalanceInPaisa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRead => $composableBuilder(
    column: $table.isRead,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get readAt => $composableBuilder(
    column: $table.readAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationsTableTable> {
  $$NotificationsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get recipientStaffId => $composableBuilder(
    column: $table.recipientStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actorStaffId => $composableBuilder(
    column: $table.actorStaffId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actorStaffName => $composableBuilder(
    column: $table.actorStaffName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transactionId => $composableBuilder(
    column: $table.transactionId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountInPaisa => $composableBuilder(
    column: $table.amountInPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remainingBalanceInPaisa => $composableBuilder(
    column: $table.remainingBalanceInPaisa,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isRead =>
      $composableBuilder(column: $table.isRead, builder: (column) => column);

  GeneratedColumn<DateTime> get readAt =>
      $composableBuilder(column: $table.readAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotificationsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationsTableTable,
          NotificationsTableData,
          $$NotificationsTableTableFilterComposer,
          $$NotificationsTableTableOrderingComposer,
          $$NotificationsTableTableAnnotationComposer,
          $$NotificationsTableTableCreateCompanionBuilder,
          $$NotificationsTableTableUpdateCompanionBuilder,
          (
            NotificationsTableData,
            BaseReferences<
              _$AppDatabase,
              $NotificationsTableTable,
              NotificationsTableData
            >,
          ),
          NotificationsTableData,
          PrefetchHooks Function()
        > {
  $$NotificationsTableTableTableManager(
    _$AppDatabase db,
    $NotificationsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotificationsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotificationsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String?> recipientStaffId = const Value.absent(),
                Value<String?> actorStaffId = const Value.absent(),
                Value<String> actorStaffName = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> message = const Value.absent(),
                Value<String> customerId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String?> transactionId = const Value.absent(),
                Value<int> amountInPaisa = const Value.absent(),
                Value<int> remainingBalanceInPaisa = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationsTableCompanion(
                id: id,
                shopId: shopId,
                recipientStaffId: recipientStaffId,
                actorStaffId: actorStaffId,
                actorStaffName: actorStaffName,
                eventType: eventType,
                title: title,
                message: message,
                customerId: customerId,
                customerName: customerName,
                transactionId: transactionId,
                amountInPaisa: amountInPaisa,
                remainingBalanceInPaisa: remainingBalanceInPaisa,
                isRead: isRead,
                readAt: readAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                Value<String?> recipientStaffId = const Value.absent(),
                Value<String?> actorStaffId = const Value.absent(),
                required String actorStaffName,
                required String eventType,
                required String title,
                required String message,
                required String customerId,
                required String customerName,
                Value<String?> transactionId = const Value.absent(),
                Value<int> amountInPaisa = const Value.absent(),
                Value<int> remainingBalanceInPaisa = const Value.absent(),
                Value<bool> isRead = const Value.absent(),
                Value<DateTime?> readAt = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationsTableCompanion.insert(
                id: id,
                shopId: shopId,
                recipientStaffId: recipientStaffId,
                actorStaffId: actorStaffId,
                actorStaffName: actorStaffName,
                eventType: eventType,
                title: title,
                message: message,
                customerId: customerId,
                customerName: customerName,
                transactionId: transactionId,
                amountInPaisa: amountInPaisa,
                remainingBalanceInPaisa: remainingBalanceInPaisa,
                isRead: isRead,
                readAt: readAt,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotificationsTableTable, NotificationsTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationsTableTable,
                    NotificationsTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationsTableTable,
      NotificationsTableData,
      $$NotificationsTableTableFilterComposer,
      $$NotificationsTableTableOrderingComposer,
      $$NotificationsTableTableAnnotationComposer,
      $$NotificationsTableTableCreateCompanionBuilder,
      $$NotificationsTableTableUpdateCompanionBuilder,
      (
        NotificationsTableData,
        BaseReferences<
          _$AppDatabase,
          $NotificationsTableTable,
          NotificationsTableData
        >,
      ),
      NotificationsTableData,
      PrefetchHooks Function()
    >;
typedef $$DeviceTokensTableTableCreateCompanionBuilder =
    DeviceTokensTableCompanion Function({
      required String id,
      required String shopId,
      required String staffId,
      required String deviceToken,
      required String platform,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$DeviceTokensTableTableUpdateCompanionBuilder =
    DeviceTokensTableCompanion Function({
      Value<String> id,
      Value<String> shopId,
      Value<String> staffId,
      Value<String> deviceToken,
      Value<String> platform,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$DeviceTokensTableTableFilterComposer
    extends Composer<_$AppDatabase, $DeviceTokensTableTable> {
  $$DeviceTokensTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceToken => $composableBuilder(
    column: $table.deviceToken,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DeviceTokensTableTableOrderingComposer
    extends Composer<_$AppDatabase, $DeviceTokensTableTable> {
  $$DeviceTokensTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceToken => $composableBuilder(
    column: $table.deviceToken,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DeviceTokensTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $DeviceTokensTableTable> {
  $$DeviceTokensTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get deviceToken => $composableBuilder(
    column: $table.deviceToken,
    builder: (column) => column,
  );

  GeneratedColumn<String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$DeviceTokensTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DeviceTokensTableTable,
          DeviceTokensTableData,
          $$DeviceTokensTableTableFilterComposer,
          $$DeviceTokensTableTableOrderingComposer,
          $$DeviceTokensTableTableAnnotationComposer,
          $$DeviceTokensTableTableCreateCompanionBuilder,
          $$DeviceTokensTableTableUpdateCompanionBuilder,
          (
            DeviceTokensTableData,
            BaseReferences<
              _$AppDatabase,
              $DeviceTokensTableTable,
              DeviceTokensTableData
            >,
          ),
          DeviceTokensTableData,
          PrefetchHooks Function()
        > {
  $$DeviceTokensTableTableTableManager(
    _$AppDatabase db,
    $DeviceTokensTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DeviceTokensTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DeviceTokensTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DeviceTokensTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<String> staffId = const Value.absent(),
                Value<String> deviceToken = const Value.absent(),
                Value<String> platform = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DeviceTokensTableCompanion(
                id: id,
                shopId: shopId,
                staffId: staffId,
                deviceToken: deviceToken,
                platform: platform,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String shopId,
                required String staffId,
                required String deviceToken,
                required String platform,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => DeviceTokensTableCompanion.insert(
                id: id,
                shopId: shopId,
                staffId: staffId,
                deviceToken: deviceToken,
                platform: platform,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DeviceTokensTableTable, DeviceTokensTableData>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $DeviceTokensTableTable,
                    DeviceTokensTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DeviceTokensTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DeviceTokensTableTable,
      DeviceTokensTableData,
      $$DeviceTokensTableTableFilterComposer,
      $$DeviceTokensTableTableOrderingComposer,
      $$DeviceTokensTableTableAnnotationComposer,
      $$DeviceTokensTableTableCreateCompanionBuilder,
      $$DeviceTokensTableTableUpdateCompanionBuilder,
      (
        DeviceTokensTableData,
        BaseReferences<
          _$AppDatabase,
          $DeviceTokensTableTable,
          DeviceTokensTableData
        >,
      ),
      DeviceTokensTableData,
      PrefetchHooks Function()
    >;
typedef $$NotificationPreferencesTableTableCreateCompanionBuilder =
    NotificationPreferencesTableCompanion Function({
      required String staffId,
      required String shopId,
      Value<bool> notifyOnCredit,
      Value<bool> notifyOnPayment,
      Value<bool> notifyOnFullClearance,
      Value<bool> notifyOwnTransactions,
      Value<bool> pushEnabled,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$NotificationPreferencesTableTableUpdateCompanionBuilder =
    NotificationPreferencesTableCompanion Function({
      Value<String> staffId,
      Value<String> shopId,
      Value<bool> notifyOnCredit,
      Value<bool> notifyOnPayment,
      Value<bool> notifyOnFullClearance,
      Value<bool> notifyOwnTransactions,
      Value<bool> pushEnabled,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$NotificationPreferencesTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTableTable> {
  $$NotificationPreferencesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyOnCredit => $composableBuilder(
    column: $table.notifyOnCredit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyOnPayment => $composableBuilder(
    column: $table.notifyOnPayment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyOnFullClearance => $composableBuilder(
    column: $table.notifyOnFullClearance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notifyOwnTransactions => $composableBuilder(
    column: $table.notifyOwnTransactions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pushEnabled => $composableBuilder(
    column: $table.pushEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotificationPreferencesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTableTable> {
  $$NotificationPreferencesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get staffId => $composableBuilder(
    column: $table.staffId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shopId => $composableBuilder(
    column: $table.shopId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyOnCredit => $composableBuilder(
    column: $table.notifyOnCredit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyOnPayment => $composableBuilder(
    column: $table.notifyOnPayment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyOnFullClearance => $composableBuilder(
    column: $table.notifyOnFullClearance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notifyOwnTransactions => $composableBuilder(
    column: $table.notifyOwnTransactions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pushEnabled => $composableBuilder(
    column: $table.pushEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotificationPreferencesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotificationPreferencesTableTable> {
  $$NotificationPreferencesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get staffId =>
      $composableBuilder(column: $table.staffId, builder: (column) => column);

  GeneratedColumn<String> get shopId =>
      $composableBuilder(column: $table.shopId, builder: (column) => column);

  GeneratedColumn<bool> get notifyOnCredit => $composableBuilder(
    column: $table.notifyOnCredit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyOnPayment => $composableBuilder(
    column: $table.notifyOnPayment,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyOnFullClearance => $composableBuilder(
    column: $table.notifyOnFullClearance,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notifyOwnTransactions => $composableBuilder(
    column: $table.notifyOwnTransactions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pushEnabled => $composableBuilder(
    column: $table.pushEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$NotificationPreferencesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotificationPreferencesTableTable,
          NotificationPreferencesTableData,
          $$NotificationPreferencesTableTableFilterComposer,
          $$NotificationPreferencesTableTableOrderingComposer,
          $$NotificationPreferencesTableTableAnnotationComposer,
          $$NotificationPreferencesTableTableCreateCompanionBuilder,
          $$NotificationPreferencesTableTableUpdateCompanionBuilder,
          (
            NotificationPreferencesTableData,
            BaseReferences<
              _$AppDatabase,
              $NotificationPreferencesTableTable,
              NotificationPreferencesTableData
            >,
          ),
          NotificationPreferencesTableData,
          PrefetchHooks Function()
        > {
  $$NotificationPreferencesTableTableTableManager(
    _$AppDatabase db,
    $NotificationPreferencesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotificationPreferencesTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$NotificationPreferencesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$NotificationPreferencesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> staffId = const Value.absent(),
                Value<String> shopId = const Value.absent(),
                Value<bool> notifyOnCredit = const Value.absent(),
                Value<bool> notifyOnPayment = const Value.absent(),
                Value<bool> notifyOnFullClearance = const Value.absent(),
                Value<bool> notifyOwnTransactions = const Value.absent(),
                Value<bool> pushEnabled = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotificationPreferencesTableCompanion(
                staffId: staffId,
                shopId: shopId,
                notifyOnCredit: notifyOnCredit,
                notifyOnPayment: notifyOnPayment,
                notifyOnFullClearance: notifyOnFullClearance,
                notifyOwnTransactions: notifyOwnTransactions,
                pushEnabled: pushEnabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String staffId,
                required String shopId,
                Value<bool> notifyOnCredit = const Value.absent(),
                Value<bool> notifyOnPayment = const Value.absent(),
                Value<bool> notifyOnFullClearance = const Value.absent(),
                Value<bool> notifyOwnTransactions = const Value.absent(),
                Value<bool> pushEnabled = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => NotificationPreferencesTableCompanion.insert(
                staffId: staffId,
                shopId: shopId,
                notifyOnCredit: notifyOnCredit,
                notifyOnPayment: notifyOnPayment,
                notifyOnFullClearance: notifyOnFullClearance,
                notifyOwnTransactions: notifyOwnTransactions,
                pushEnabled: pushEnabled,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<
                    $NotificationPreferencesTableTable,
                    NotificationPreferencesTableData
                  >(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NotificationPreferencesTableTable,
                    NotificationPreferencesTableData
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotificationPreferencesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotificationPreferencesTableTable,
      NotificationPreferencesTableData,
      $$NotificationPreferencesTableTableFilterComposer,
      $$NotificationPreferencesTableTableOrderingComposer,
      $$NotificationPreferencesTableTableAnnotationComposer,
      $$NotificationPreferencesTableTableCreateCompanionBuilder,
      $$NotificationPreferencesTableTableUpdateCompanionBuilder,
      (
        NotificationPreferencesTableData,
        BaseReferences<
          _$AppDatabase,
          $NotificationPreferencesTableTable,
          NotificationPreferencesTableData
        >,
      ),
      NotificationPreferencesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShopsTableTableTableManager get shopsTable =>
      $$ShopsTableTableTableManager(_db, _db.shopsTable);
  $$CustomersTableTableTableManager get customersTable =>
      $$CustomersTableTableTableManager(_db, _db.customersTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(_db, _db.transactionsTable);
  $$StaffTableTableTableManager get staffTable =>
      $$StaffTableTableTableManager(_db, _db.staffTable);
  $$ShopSettingsTableTableTableManager get shopSettingsTable =>
      $$ShopSettingsTableTableTableManager(_db, _db.shopSettingsTable);
  $$AuditLogsTableTableTableManager get auditLogsTable =>
      $$AuditLogsTableTableTableManager(_db, _db.auditLogsTable);
  $$ReminderLogsTableTableTableManager get reminderLogsTable =>
      $$ReminderLogsTableTableTableManager(_db, _db.reminderLogsTable);
  $$PendingSyncOperationsTableTableTableManager
  get pendingSyncOperationsTable =>
      $$PendingSyncOperationsTableTableTableManager(
        _db,
        _db.pendingSyncOperationsTable,
      );
  $$NotificationsTableTableTableManager get notificationsTable =>
      $$NotificationsTableTableTableManager(_db, _db.notificationsTable);
  $$DeviceTokensTableTableTableManager get deviceTokensTable =>
      $$DeviceTokensTableTableTableManager(_db, _db.deviceTokensTable);
  $$NotificationPreferencesTableTableTableManager
  get notificationPreferencesTable =>
      $$NotificationPreferencesTableTableTableManager(
        _db,
        _db.notificationPreferencesTable,
      );
}

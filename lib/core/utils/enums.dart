import "package:sabalpara_family/sabalpara_family.dart";

enum Gender {
  male(value: "male"),
  female(value: "female");

  const Gender({required this.value});

  final String value;

  static Gender fromValue(String value) {
    return Gender.values.firstWhere(
      (e) => e.value == value,
      orElse: () => Gender.male,
    );
  }
}

enum ResultStatus {
  pending(value: "pending"),
  approved(value: "approved"),
  rejected(value: "rejected");

  const ResultStatus({required this.value});

  final String value;

  static ResultStatus fromValue(String value) {
    return ResultStatus.values.firstWhere(
      (e) => e.value == value,
      orElse: () => ResultStatus.pending,
    );
  }
}

enum CommitteeMemberPosition {
  president(value: "President"),
  vicePresident(value: "Vice President"),
  secretary(value: "Secretary"),
  treasurer(value: "Treasurer"),
  volunteer(value: "Volunteer"),
  member(value: "Member");

  const CommitteeMemberPosition({required this.value});

  final String value;

  static CommitteeMemberPosition fromValue(String value) {
    return CommitteeMemberPosition.values.firstWhere(
      (e) => e.value == value,
      orElse: () => .member,
    );
  }

  static String getString(
    BuildContext context,
    CommitteeMemberPosition position,
  ) {
    switch (position) {
      case .president:
        return context.l10n?.president ?? "";
      case .vicePresident:
        return context.l10n?.vicePresident ?? "";
      case .secretary:
        return context.l10n?.secretary ?? "";
      case .treasurer:
        return context.l10n?.treasurer ?? "";
      case .volunteer:
        return context.l10n?.volunteer ?? "";
      case .member:
        return context.l10n?.member ?? "";
    }
  }

  static Color getColor(CommitteeMemberPosition position) {
    switch (position) {
      case .president:
        return Color(0XFFDD6C1B);
      case .vicePresident:
        return Color(0XFF107917);
      case .secretary:
        return Color(0XFF106FD5);
      case .treasurer:
        return Color(0xFFD51083);
      case .volunteer:
        return Color(0xFFD59310);
      case .member:
        return Color(0XFFAE10D5);
    }
  }

  static List<CommitteeMemberPosition> getPositionsList(BuildContext context) {
    return [
      .president,
      .vicePresident,
      .secretary,
      .treasurer,
      .volunteer,
      .member,
    ];
  }
}

enum FamilyMemberRelation {
  father(value: "Father"),
  mother(value: "Mother"),
  son(value: "Son"),
  daughter(value: "Daughter"),
  brother(value: "Brother"),
  sister(value: "Sister");

  const FamilyMemberRelation({required this.value});

  final String value;

  static FamilyMemberRelation fromValue(String value) {
    return FamilyMemberRelation.values.firstWhere(
      (e) => e.value == value,
      orElse: () => .father,
    );
  }

  static String getString(BuildContext context, FamilyMemberRelation relation) {
    switch (relation) {
      case .father:
        return context.l10n?.father ?? "";
      case .mother:
        return context.l10n?.mother ?? "";
      case .son:
        return context.l10n?.son ?? "";
      case .daughter:
        return context.l10n?.daughter ?? "";
      case .brother:
        return context.l10n?.brother ?? "";
      case .sister:
        return context.l10n?.sister ?? "";
    }
  }

  static Color getColor(FamilyMemberRelation relation) {
    switch (relation) {
      case .father:
        return Color(0XFF106FD5);
      case .mother:
        return Color(0XFFDD6C1B);
      case .son:
        return Color(0XFF107917);
      case .daughter:
        return Color(0xFFD51083);
      case .brother:
        return Color(0XFFAE10D5);
      case .sister:
        return Color(0xFFD59310);
    }
  }

  static List<FamilyMemberRelation> getRelationsList(BuildContext context) {
    return [.father, .mother, .son, .daughter, .brother, .sister];
  }
}

enum FamilyMemberOccupation {
  job(value: "Job"),
  business(value: "Business"),
  study(value: "Study"),
  none(value: "None");

  const FamilyMemberOccupation({required this.value});

  final String value;

  static FamilyMemberOccupation fromValue(String value) {
    return FamilyMemberOccupation.values.firstWhere(
      (e) => e.value == value,
      orElse: () => .none,
    );
  }

  static String getString(
    BuildContext context,
    FamilyMemberOccupation occupation,
  ) {
    switch (occupation) {
      case .job:
        return context.l10n?.job ?? "";
      case .business:
        return context.l10n?.business ?? "";
      case .study:
        return context.l10n?.study ?? "";
      case .none:
        return context.l10n?.none ?? "";
    }
  }

  static List<FamilyMemberOccupation> getOccupationsList(BuildContext context) {
    return [.job, .business, .study, .none];
  }
}

enum FamilyMemberOccupationRole {
  owner(value: "Owner"),
  manager(value: "Manager"),
  worker(value: "Worker");

  const FamilyMemberOccupationRole({required this.value});

  final String value;

  static FamilyMemberOccupationRole fromValue(String value) {
    return FamilyMemberOccupationRole.values.firstWhere(
      (e) => e.value == value,
      orElse: () => .worker,
    );
  }

  static String getString(
    BuildContext context,
    FamilyMemberOccupationRole occupationRole,
  ) {
    switch (occupationRole) {
      case .owner:
        return context.l10n?.owner ?? "";
      case .manager:
        return context.l10n?.manager ?? "";
      case .worker:
        return context.l10n?.worker ?? "";
    }
  }

  static List<FamilyMemberOccupationRole> getOccupationRolesList(
    BuildContext context,
  ) {
    return [.owner, .manager, .worker];
  }
}

enum FamilyMemberWorkType {
  test(value: "Test"),
  test2(value: "Test 2"),
  test3(value: "Test 3");

  const FamilyMemberWorkType({required this.value});

  final String value;

  static FamilyMemberWorkType fromValue(String value) {
    return FamilyMemberWorkType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => .test,
    );
  }

  static String getString(FamilyMemberWorkType workType) {
    switch (workType) {
      case .test:
        return "Test";
      case .test2:
        return "Test 2";
      case .test3:
        return "Test 3";
    }
  }

  static List<FamilyMemberWorkType> getWorkTypesList(BuildContext context) {
    return [.test, .test2, .test3];
  }
}

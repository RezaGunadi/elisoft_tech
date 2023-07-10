
class Helpers {
  static String capitalizeString(String text) {
    return text
        .split(' ')
        .map((word) => word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join(' ');
  }

  static String convertNumberDash(String phoneNumber,
      {bool hideFourDigits = false, bool withDashSpaces = false}) {
    String dash = withDashSpaces ? ' - ' : '-';
    if (phoneNumber.length == 10) {
      return phoneNumber.substring(0, 3) +
          dash +
          phoneNumber.substring(3, 6) +
          dash +
          (hideFourDigits ? '' : (phoneNumber.substring(6, 10)));
    } else if (phoneNumber.length == 11) {
      return phoneNumber.substring(0, 3) +
          dash +
          phoneNumber.substring(3, 7) +
          dash +
          (hideFourDigits ? '' : (phoneNumber.substring(7, 11)));
    } else if (phoneNumber.length == 12) {
      return phoneNumber.substring(0, 4) +
          dash +
          phoneNumber.substring(4, 8) +
          dash +
          (hideFourDigits ? '' : (phoneNumber.substring(8, 12)));
    } else if (phoneNumber.length == 13) {
      return phoneNumber.substring(0, 4) +
          dash +
          phoneNumber.substring(4, 9) +
          dash +
          (hideFourDigits ? '' : (phoneNumber.substring(9, 13)));
    } else if (phoneNumber.length == 14) {
      return phoneNumber.substring(0, 5) +
          dash +
          phoneNumber.substring(5, 10) +
          dash +
          (hideFourDigits ? '' : (phoneNumber.substring(10, 14)));
    }
    return phoneNumber;
  }

  static String formatRupiah(String text) {
    RegExp exp = new RegExp(r"\d{3}");
    int sisa = text.length % 3;
    String rupiah = text.substring(0, sisa);

    var ribuan = exp.allMatches(text.substring(sisa));
    var listRupiah = ribuan.map((m) => m.group(0));

    if (listRupiah.length != 0) {
      String separator = sisa != 0 ? '.' : '';
      rupiah += separator + listRupiah.join('.');
    }
    return rupiah;
  }

  static String shortCityname(String cityVal) {
    cityVal = capitalizeString(cityVal);
    return cityVal.replaceAll('Kabupaten', 'Kab.');
  }

  static String getInitialName(String name) {
    List<String> initialName =
        name.split(' ').map((e) => e.substring(0, 1)).toList();
    return initialName[0].toUpperCase() +
        (initialName.length > 1 ? initialName[1].toUpperCase() : '');
  }

  static bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  static const List<String> _hari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu'
  ];
  static const List<String> _bulan = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  static const List<String> _bulanShort = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des'
  ];

  static String getLocalDayName(DateTime date) {
    return _hari[date.weekday - 1];
  }

  static String getLocalMonthName(DateTime date) {
    return _bulan[date.month - 1];
  }
  static String getLocalMonthNameShort(DateTime date) {
    return _bulanShort[date.month - 1];
  }

  static String getLocalDateFormat(DateTime date, {bool shortMonth = false}) {
    String month = getLocalMonthName(date);

    return '${date.day} ${shortMonth ? month.substring(0, 3) : month} ${date.year}';
  }

  static String getLocalDateFormatShort(DateTime date, {bool shortMonth = false}) {
    String month = getLocalMonthNameShort(date);

    return '${date.day} ${shortMonth ? month.substring(0, 3) : month} ${date.year}';
  }

  static String capitalizeEachWords(String inputValue) {
    String value =  inputValue.toLowerCase();
  var result = value[0].toUpperCase();
  for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
            result = result + value[i];
      }
  }
  return result;
}
}

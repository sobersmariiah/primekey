class AppStrings {
  // App
  static const String appName = 'Primekey Finance';
  static const String tagline = 'Fast. Simple. Reliable.';

  // Supported Countries
  static const List<Map<String, String>> supportedCountries = [
    {
      'name': 'Belize',
      'code': 'BZ',
      'currency': 'BZD',
      'symbol': 'BZ\$',
      'flag': '🇧🇿',
      'area': '+501',
    },
    {
      'name': 'Panama',
      'code': 'PA',
      'currency': 'USD',
      'symbol': '\$',
      'flag': '🇵🇦',
      'area': '+507',
    },
    {
      'name': 'Oman',
      'code': 'OM',
      'currency': 'OMR',
      'symbol': 'OMR',
      'flag': '🇴🇲',
      'area': '+968',
    },
    {
      'name': 'Bahamas',
      'code': 'BS',
      'currency': 'BSD',
      'symbol': 'B\$',
      'flag': '🇧🇸',
      'area': '+1-242',
    },
    {
      'name': 'Barbados',
      'code': 'BB',
      'currency': 'BBD',
      'symbol': 'Bds\$',
      'flag': '🇧🇧',
      'area': '+1-246',
    },
    {
      'name': 'Trinidad & Tobago',
      'code': 'TT',
      'currency': 'TTD',
      'symbol': 'TT\$',
      'flag': '🇹🇹',
      'area': '+1-868',
    },
    {
      'name': 'Guyana',
      'code': 'GY',
      'currency': 'GYD',
      'symbol': 'G\$',
      'flag': '🇬🇾',
      'area': '+592',
    },
    {
      'name': 'Nigeria',
      'code': 'NG',
      'currency': 'NGN',
      'symbol': '₦',
      'flag': '🇳🇬',
      'area': '+234',
    },
    {
      'name': 'Jamaica',
      'code': 'JM',
      'currency': 'JMD',
      'symbol': 'J\$',
      'flag': '🇯🇲',
      'area': '+1-876',
    },
    {
      'name': 'South Africa',
      'code': 'ZA',
      'currency': 'ZAR',
      'symbol': 'R',
      'flag': '🇿🇦',
      'area': '+27',
    },
    {
      'name': 'Turks & Caicos',
      'code': 'TC',
      'currency': 'USD',
      'symbol': '\$',
      'flag': '🇹🇨',
      'area': '+1-649',
    },
    {
      'name': 'Cayman Islands',
      'code': 'KY',
      'currency': 'KYD',
      'symbol': 'CI\$',
      'flag': '🇰🇾',
      'area': '+1-345',
    },
    {
      'name': 'Qatar',
      'code': 'QA',
      'currency': 'QAR',
      'symbol': 'QR',
      'flag': '🇶🇦',
      'area': '+974',
    },
    {
      'name': 'Papua New Guinea',
      'code': 'PG',
      'currency': 'PGK',
      'symbol': 'K',
      'flag': '🇵🇬',
      'area': '+675',
    },
  ];

  // Banks per Country
  static const Map<String, List<String>> banksByCountry = {
    'BZ': [
      'Belize Bank',
      'Atlantic Bank',
      'Heritage Bank',
      'National Bank of Belize',
    ],
    'NG': [
      'Access Bank',
      'GTBank',
      'Zenith Bank',
      'First Bank of Nigeria',
    ],
    'OM': [
      'Bank Muscat',
      'National Bank of Oman',
      'Bank Dhofar',
      'Bank Sohar',
    ],
    'ZA': [
      "First Treasury Bank",
      'Standard Bank of South Africa',
      'Capitec Bank',
      ' Nedbank',
      'FNB (First National Bank)',
    ],
    'PA': [
      'Banco General',
      'Banco Nacional de Panamá',
      'Banistmo',
      'BAC International Bank',
    ],
    'BB': [
      'Scotiabank',
      'Republic Banks'
          'CIBC FirstCaribbean International Bank'
          'First Citizens Bank'
          'Royal Bank of Canada (RBC)'
          'Affinity Plus Credit Union'
    ],
    'BS': [
      'Fidelity Bank',
      'Commonwealth Bank',
      'Bank of Bahamas(BOB)',
      'Scotiabank ',
      'CIBC FirstCaribbean International Bank',
      'Royal Bank of Canada (RBC)'
    ],
    'TT': [
      'Republic Bank',
      'First Citizens Bank',
      'Scotiabank Trinidad',
      'RBC Royal Bank',
    ],
    'GY': [
      'Demerara Bank',
      'Guyana Bank for Trade & Industry',
      'Republic Bank Guyana',
      'Citizens Bank Guyana',
    ],
    'JM': [
      'National Commercial Bank (NCB)',
      'Scotiabank Jamaica',
      'JMMB Bank',
      'First Global Bank',
    ],
    'TC': [
      'Scotiabank Turks and Caicos',
      'RBC Royal Bank',
      'FirstCaribbean International Bank',
      'British Caribbean Bank',
    ],
    'KY': [
      'Cayman National Bank',
      'Butterfield Bank',
      'Scotiabank Cayman',
      'Fidelity Bank',
    ],
    'QA': [
      'Qatar National Bank (QNB)',
      'Qatar Islamic Bank (QIB)',
      'Commercial Bank of Qatar',
      'Doha Bank',
    ],
    'PG': [
      'Bank South Pacific (BSP)',
      'Kina Bank',
      'Westpac PNG',
      'ANZ Papua New Guinea',
    ],
  };

  // Loan Purposes
  static const List<String> loanPurposes = [
    'Personal',
    'Business',
    'Education',
    'Home Improvement',
    'Medical',
    'Vehicle',
    'Debt Consolidation',
    'Other',
  ];

  // Employment Status
  static const List<String> employmentStatuses = [
    'Formally Employed',
    'Government Employee',
    'Self Employed',
    'Business Owner',
  ];

  // Default/Fallback Loan Rates (months: APR %)
  static Map<int, double> get loanRates => defaultLoanRates;

  static const Map<int, double> defaultLoanRates = {
    3: 24.0,
    6: 18.0,
    12: 15.0,
    18: 12.0,
    24: 12.0,
    36: 12.0,
    48: 10.0,
    60: 10.0,
    72: 10.0,
    84: 9.0,
    96: 9.0,
    108: 8.0,
    120: 7.0,
  };

  // Localized Loan Rates per Country
  static const Map<String, Map<int, double>> localizedLoanRates = {
    // Belize (BZD) - High inflation, higher rates
    'BZ': {
      3: 25.0,
      6: 20.0,
      12: 18.0,
      18: 16.0,
      24: 16.0,
      36: 16.0,
      48: 14.0,
      60: 14.0,
      72: 14.0,
      84: 13.0,
      96: 13.0,
      108: 10.0,
      120: 8.0,
    },
    // Panama (USD) - Low inflation, competitive rates
    'PA': {
      3: 12.0,
      6: 10.0,
      12: 8.5,
      18: 8.0,
      24: 8.0,
      36: 7.5,
      48: 7.0,
      60: 7.0,
      72: 7.0,
      84: 6.5,
      96: 6.5,
      108: 6.0,
      120: 5.5,
    },
    // South Africa (ZAR) - Medium inflation
    'ZA': {
      3: 28.0,
      6: 22.0,
      12: 18.0,
      18: 15.0,
      24: 15.0,
      36: 14.0,
      48: 12.0,
      60: 12.0,
      72: 12.0,
      84: 11.0,
      96: 11.0,
      108: 10.0,
      120: 9.0,
    },
    // Oman (OMR) - Low rates
    'OM': {
      3: 10.0,
      6: 8.0,
      12: 6.5,
      18: 6.0,
      24: 6.0,
      36: 5.5,
      48: 5.0,
      60: 5.0,
      72: 5.0,
      84: 4.5,
      96: 4.5,
      108: 4.5,
      120: 4.0,
    },
    // Nigeria (NGN) - Higher inflation
    'NG': {
      3: 35.0,
      6: 30.0,
      12: 25.0,
      18: 20.0,
      24: 20.0,
      36: 18.0,
      48: 15.0,
      60: 15.0,
      72: 15.0,
      84: 14.0,
      96: 14.0,
      108: 12.0,
      120: 10.0,
    },
  };

  static Map<int, double> getLoanRates(String? countryCode) {
    if (countryCode == null) return defaultLoanRates;
    return localizedLoanRates[countryCode] ?? defaultLoanRates;
  }

  static const Map<int, double> loanMinimums = {
    3: 0,
    6: 0,
    12: 0,
    18: 0,
    24: 0,
    36: 0,
    48: 0,
    60: 40000,
    72: 60000,
    84: 60000,
    96: 120000,
    108: 120000,
    120: 120000,
  };
}

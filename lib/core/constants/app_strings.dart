class AppStrings {
  // App
  static const String appName = 'Primekey Finance';
  static const String tagline = 'Fast. Simple. Reliable.';

  // Supported Countries
  static const List<Map<String, String>> supportedCountries = [
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
      'name': 'Jamaica',
      'code': 'JM',
      'currency': 'JMD',
      'symbol': 'J\$',
      'flag': '🇯🇲',
      'area': '+1-876',
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
      'name': 'Saint Lucia',
      'code': 'LC',
      'currency': 'XCD',
      'symbol': '\$',
      'flag': '🇱🇨',
      'area': '+1-758',
    },
    {
      'name': 'St. Vincent & Grenadines',
      'code': 'VC',
      'currency': 'XCD',
      'symbol': '\$',
      'flag': '🇻🇨',
      'area': '+1-784',
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
    'BS': [
      'Commonwealth Bank Limited',
      'Bank of The Bahamas Limited',
      'Fidelity Bank (Bahamas) Limited',
      'CIBC Caribbean (FirstCaribbean International Bank)',
      'Scotiabank (Bahamas) Limited',
      'RBC Royal Bank (Bahamas) Limited',
    ],
    'BB': [
      'Republic Bank (Barbados) Limited',
      'CIBC Caribbean (FirstCaribbean International Bank)',
      'Scotiabank Barbados',
      'First Citizens Bank (Barbados) Limited',
      'RBC Royal Bank (Barbados) Limited',
      "Barbados Public Workers' Co-operative Credit Union Limited (BPWCCUL)",
      "City of Bridgetown Co-operative Credit Union Limited (COBCCUL)",
      'Affinity Plus Credit Union Limited',
      'Sagicor Bank (Barbados) Limited',
    ],
    'JM': [
      'National Commercial Bank Jamaica Limited (NCB)',
      'Scotiabank Jamaica Limited',
      'JMMB Bank (Jamaica) Limited',
      'CIBC FirstCaribbean International Bank (Jamaica)',
      'Jamaica National Bank Limited (JN Bank)',
      'Victoria Mutual Building Society (VMBS)',
      'First Global Bank Limited',
      'Sagicor Bank Jamaica Limited',
    ],
    'TC': [
      'Scotiabank Turks and Caicos Limited',
      'CIBC Caribbean (FirstCaribbean International Bank)',
      'RBC Royal Bank (Turks and Caicos) Limited',
    ],
    'KY': [
      'The Bank of N.T. Butterfield & Son Limited (Cayman)',
      'Cayman National Bank Limited',
      'Proven Bank (Cayman) Limited',
      'Scotiabank & Trust (Cayman) Ltd.',
      'CIBC Caribbean (FirstCaribbean International Bank)',
      'RBC Royal Bank (Cayman) Limited',
    ],
    'LC': [
      'Bank of Saint Lucia Limited (BOSL)',
      '1st National Bank St. Lucia Limited',
      'CIBC Caribbean (FirstCaribbean International Bank)',
      'Republic Bank (EC) Limited',
      'First Citizens Bank (St. Lucia) Limited',
    ],
    'VC': [
      'Bank of St. Vincent and the Grenadines Limited (BOSVG)',
      'Republic Bank (EC) Limited',
      'First Citizens Bank (St. Vincent) Limited',
      '1st National Bank St. Vincent Limited',
      'St. Vincent Co-operative Bank Limited',
    ],
    'PG': [
      'Bank of South Pacific Limited (BSP)',
      'Kina Bank Limited',
      'Westpac Bank PNG Limited',
      'MiBank (Nationwide Microbank Limited)',
      'ANZ Bank (PNG) Limited',
      'TISA Bank Limited',
      'CreditBank PNG Limited',
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
    // Bahamas (BSD) - 10% baseline
    'BS': {
      3: 12.0,
      6: 11.0,
      12: 10.0,
      18: 9.5,
      24: 9.0,
      36: 8.5,
      48: 8.0,
      60: 7.5,
      72: 7.0,
      84: 6.5,
      96: 6.5,
      108: 6.0,
      120: 5.5,
    },
    // Barbados (BBD) - 10% baseline
    'BB': {
      3: 12.0,
      6: 11.0,
      12: 10.0,
      18: 9.5,
      24: 9.0,
      36: 8.5,
      48: 8.0,
      60: 7.5,
      72: 7.0,
      84: 6.5,
      96: 6.5,
      108: 6.0,
      120: 5.5,
    },
    // Jamaica (JMD) - 15% baseline
    'JM': {
      3: 17.0,
      6: 16.0,
      12: 15.0,
      18: 14.5,
      24: 14.0,
      36: 13.5,
      48: 13.0,
      60: 12.5,
      72: 12.0,
      84: 11.5,
      96: 11.5,
      108: 11.0,
      120: 10.0,
    },
    // Turks & Caicos (USD) - 10% baseline
    'TC': {
      3: 12.0,
      6: 11.0,
      12: 10.0,
      18: 9.5,
      24: 9.0,
      36: 8.5,
      48: 8.0,
      60: 7.5,
      72: 7.0,
      84: 6.5,
      96: 6.5,
      108: 6.0,
      120: 5.5,
    },
    // Cayman Islands (KYD) - 11% baseline
    'KY': {
      3: 13.0,
      6: 12.0,
      12: 11.0,
      18: 10.5,
      24: 10.0,
      36: 9.5,
      48: 9.0,
      60: 8.5,
      72: 8.0,
      84: 7.5,
      96: 7.5,
      108: 7.0,
      120: 6.5,
    },
    // Saint Lucia (XCD) - 10% baseline
    'LC': {
      3: 12.0,
      6: 11.0,
      12: 10.0,
      18: 9.5,
      24: 9.0,
      36: 8.5,
      48: 8.0,
      60: 7.5,
      72: 7.0,
      84: 6.5,
      96: 6.5,
      108: 6.0,
      120: 5.5,
    },
    // St. Vincent & Grenadines (XCD) - 11% baseline
    'VC': {
      3: 13.0,
      6: 12.0,
      12: 11.0,
      18: 10.5,
      24: 10.0,
      36: 9.5,
      48: 9.0,
      60: 8.5,
      72: 8.0,
      84: 7.5,
      96: 7.5,
      108: 7.0,
      120: 6.5,
    },
    // Papua New Guinea (PGK) - 18% baseline
    'PG': {
      3: 20.0,
      6: 19.0,
      12: 18.0,
      18: 17.0,
      24: 16.0,
      36: 15.0,
      48: 14.0,
      60: 13.0,
      72: 12.0,
      84: 11.0,
      96: 11.0,
      108: 10.0,
      120: 9.0,
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

class AppString {
  static const Map<String, String> mainStrings = {
    'manager': 'Manager',
    'secretary': 'Secretary',
    'representative': 'Representative',
  };
  static const Map<String, String> startScreenStrings = {
    'manager': 'Login as Manager',
    'secretary': 'Login as Secretary',
    'representative': 'Login as Representative',
  };

  static const Map<String, String> loginScreenStrings = {
    'username': 'Username',
    'username_warning': 'username can\'t be empty',
    'password': 'Password',
    'password_warning': 'password can\'t be empty',
    'remember_me': 'remember me',
    'login': 'LOGIN',
    'manager': 'Manager'
  };
  static const Map<String, String> managerScreenStrings = {
    'new_orders': 'New Orders',
    'checkout_orders': 'Checkout Orders',
    'delivered_orders': 'Delivered Orders',
    'checked_orders': 'Checked Orders',
    'add_account': 'Add Account',
    'delete_account': 'Delete Account',
    'secretary': 'Secretary',
    'representative': 'Representative',
    'orders': 'Orders',
    'accounts': 'Accounts',
    'employees': 'Employees',
    'save': 'SAVE',
    'modify': 'Modify',
    'remove': 'remove',
  };
  static const Map<String, String> secretaryScreenStrings = {
    'create_order': 'Create Order',
    'modify_order': 'Modify Order',
  };
  static const Map<String, String> representativeScreenStrings = {
    'new_orders': 'New Orders',
    'delivered_orders': 'Delivered Orders',
  };
  static const Map<String, String> orderScreenStrings = {
    'client_name': 'Client Name',
    'address': 'Address',
    'phone': 'Phone',
    'representative_name': 'Representative Name',
    'problem_type': 'Problem Type',
    'register_date': 'Register Date',
    'new': 'new',
    'checked': 'Checked',
    'checkout': 'Checkout',
    'fixed': 'Fixed',
    'not_fixed': 'Not Fixed',
    'delivered': 'Delivered',
    'paid': 'Paid',
  };
  static const Map<String, String> createUserScreenStrings = {
    'name': 'Name',
    'name_warning': 'name can\'t be empty',
    'username': 'Username',
    'username_warning': 'username can\'t be empty',
    'password': 'Password',
    'password_warning': 'password can\'t be empty',
    'secretary': 'Secretary',
    'representative': 'Representative',
    'save': 'SAVE',
  };
  static const Map<String, String> createOrderScreenStrings = {
    'client_name': 'Client Name',
    'client_address': 'Client Address',
    'client_phone': 'Client Phone',
    'device_problem': 'Device Problem',
    'device_type': 'Device Type',
    'send': 'SEND',
    'save': 'SAVE',
    'remove_order': 'Remove Order',
  };
  static const List<String> devices = [
    'Microwave',
    'Deep Freezer',
    'Refrigerator',
    'Washing Machine',
  ];
}

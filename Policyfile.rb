name 'rc'
default_source :community

cookbook 'rc', path: '.'

run_list %w{rc::default} # Remove guts from run due to issue with service restarting on windows

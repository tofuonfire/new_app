set :branch, 'master'

server '52.196.150.243',
  user: 'nt',
  roles: %w[web app db],
  port: 22,
  ssh_options: {
    user: 'nt',
    keys: [File.expand_path('~/.ssh/mewblr_key_rsa')],
    forward_agent: true,
}
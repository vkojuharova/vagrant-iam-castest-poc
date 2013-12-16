# = Class: iam_firewall::pre
#
# Manages packages and services required by the firewall specific for IAM.
# Has default rules to be applied first.
#
class iam_firewall::pre{
    Firewall{
        require=> undef,
    }
    # Default firewall rules
      firewall { '000 accept all icmp':
        proto   => 'icmp',
        action  => 'accept',
      }
      #->
      firewall { '001 accept all to lo interface':
        proto   => 'all',
        iniface => 'lo',
        action  => 'accept',
      }
      #->
      firewall { '002 accept related established rules':
        proto   => 'all',
        state   => ['RELATED', 'ESTABLISHED'],
        action  => 'accept',
      }
      firewall { '003 accept connection on SSH port':
        ensure  => 'present',
        proto   => 'tcp',
        dport   => '22',
        action  => 'accept',
      }
}
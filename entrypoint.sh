#!/bin/bash -e
USER_ID=${LOCAL_USER_ID:-501}
GROUP_ID=${LOCAL_GROUP_ID:-501}
export HOME=/var/lib/aptly

getent group aptly > /dev/null || groupadd --system -g $GROUP_ID aptly
getent passwd aptly > /dev/null || useradd --system --shell /bin/bash -u $USER_ID -g aptly -d ${HOME} -m aptly 1>/dev/null 2>/dev/null
mkdir -p /var/lib/aptly/.gnupg
chown -R aptly:aptly /var/lib/aptly/.gnupg
chmod 700 /var/lib/aptly/.gnupg

if [ $(stat -c '%u' ${HOME}) != $USER_ID ]; then
    chown -R aptly:aptly ${HOME}
fi

exec gosu aptly "$@"

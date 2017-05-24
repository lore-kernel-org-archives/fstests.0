Received: from mail-pf0-f195.google.com ([209.85.192.195]:34912 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757852AbdEXESY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 24 May 2017 00:18:24 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so31477807pfd.2
        for <fstests@vger.kernel.org>; Tue, 23 May 2017 21:18:23 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] test-appliance: revert logging change on startup
Date: Tue, 23 May 2017 21:17:08 -0700
Message-Id: <20170524041708.16580-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Commit 458ce3391003 ("Add support to optionally build gce-xfstests for
Debian stretch") made the output of kvm-xfstests.boot get redirected to
a file /var/log/kvm-xfstests-boot.log.  This actually isn't desirable,
because the output is supposed to be shown on the console.  This was
especially apparent for kvm-xfstests, since it hid the output of
runtests.sh.  But it was also applicable to gce-xfstests, since
'gce-xfstests console' can be used to show the console output.

We could send the output to both places using 'tee', but this seems
useless since the output can just be retrieved from the console instead
of from the log file.  Also, the 'set -vx' output is too verbose for the
console, and I don't think there would be a way to send it just to the
log file.

So just revert the change to kvm-xfstests.boot.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot b/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot
index 4b687d0..26ef2fd 100755
--- a/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot
+++ b/kvm-xfstests/test-appliance/files/root/kvm-xfstests.boot
@@ -11,13 +11,6 @@ else
 fi
 }
 
-date >> /var/log/kvm-xfstests-boot.log
-exec 1<&-
-exec 2<&-
-exec 1>> /var/log/kvm-xfstests-boot.log
-exec 2>&1
-set -vx
-
 . /root/test-config
 
 FSTESTCFG=$(parse fstestcfg | sed -e 's/,/ /g')
-- 
2.13.0


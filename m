Received: from mail-io0-f196.google.com ([209.85.223.196]:34527 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCFBeM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Mar 2018 20:34:12 -0500
Received: by mail-io0-f196.google.com with SMTP id e7so20217392ioj.1
        for <fstests@vger.kernel.org>; Mon, 05 Mar 2018 17:34:11 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [xfstests-bld PATCH] test-appliance: use --auto-deconfigure when installing extra packages
Date: Mon,  5 Mar 2018 17:32:09 -0800
Message-Id: <20180306013209.30082-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Trying to build the KVM or GCE test appliances with Debian packages
built from the latest e2fsprogs git tree placed into the
test-appliance/debs/ directory fails because of the recent renamings
from libcomerr2 to libcom-err2 and e2fslibs to libext2fs2, e.g.:

    dpkg: regarding .../libcom-err2_1.44.0~rc2-1_amd64.deb containing libcom-err2:amd64:
     libcom-err2 breaks libcomerr2 (<< 1.43.9-1~)
      libcomerr2:amd64 (version 1.43.4-2) is present and installed.

    dpkg: error processing archive /run/libcom-err2_1.44.0~rc2-1_amd64.deb (--install):
     installing libcom-err2:amd64 would break libcomerr2:amd64, and
     deconfiguration is not permitted (--auto-deconfigure might help)

Add the --auto-deconfigure argument to make it work.  I'm not sure it's
the best solution, but it works.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gce-xfstests-bld.sh | 2 +-
 kvm-xfstests/test-appliance/gen-image           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
index a7ad6e9..ed5eb75 100644
--- a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
+++ b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
@@ -145,7 +145,7 @@ systemctl enable telnet-getty@ttyS3.service
 
 if gsutil -m cp gs://$BUCKET/debs/*.deb /run
 then
-    dpkg -i --ignore-depends=e2fsprogs /run/*.deb
+    dpkg -i --ignore-depends=e2fsprogs --auto-deconfigure /run/*.deb
     rm -f /run/*.deb
 fi
 chmod +rx /usr/local/lib/gce-ltm/gce-xfs-ltm.fcgi
diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
index 6ba1320..bba7e88 100755
--- a/kvm-xfstests/test-appliance/gen-image
+++ b/kvm-xfstests/test-appliance/gen-image
@@ -273,14 +273,14 @@ if test -f "backport-packages-$SUITE" ; then
     ./get-backports-pkgs "$SUITE" "$ROOTDIR"
     if test -f "$ROOTDIR/debootstrap/debpaths" ; then
         DEBS=$(while read pkg path; do echo $path ; done <"$ROOTDIR/debootstrap/debpaths")
-        run_in_chroot "dpkg --ignore-depends=e2fsprogs -i $DEBS"
+        run_in_chroot "dpkg --ignore-depends=e2fsprogs --auto-deconfigure -i $DEBS"
     fi
     rm -rf "$ROOTDIR/debootstrap"
 fi
 DEBS=$(find debs -name \*.deb)
 if test -n "$DEBS"
 then
-    run_in_chroot "dpkg --ignore-depends=e2fsprogs -i $(echo $DEBS)"
+    run_in_chroot "dpkg --ignore-depends=e2fsprogs --auto-deconfigure -i $(echo $DEBS)"
 fi
 update_xfstests
 for i in vda vdb vdc vdd vde vdf results
-- 
2.16.2.395.g2e18187dfd-goog


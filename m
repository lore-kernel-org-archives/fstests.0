Received: from imap.thunk.org ([74.207.234.97]:38798 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbdHMRcb (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 13 Aug 2017 13:32:31 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [xfstest-bld PATCH 1/2] test-appliance: add safety check for "gen-image --out-tar"
Date: Sun, 13 Aug 2017 13:32:23 -0400
Message-Id: <20170813173224.28900-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

The gen-image script must not be run as root when generating a tar
file.  This is because it uses fakechroot and fakeroot, and if run as
root, the debootstrap script will end up damaging a large number of
devices in the /dev directory.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 kvm-xfstests/test-appliance/gen-image | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kvm-xfstests/test-appliance/gen-image b/kvm-xfstests/test-appliance/gen-image
index dbd9b84..e7bdb35 100755
--- a/kvm-xfstests/test-appliance/gen-image
+++ b/kvm-xfstests/test-appliance/gen-image
@@ -76,6 +76,10 @@ fi
 
 if test -n "$OUT_TAR" ; then
     if test "$FAKECHROOT" != "true" ; then
+	if test "$EUID" -eq 0 ; then
+	    echo "This script MUST NOT be run as root with --out_tar"
+	    exit 1;
+	fi
 	set -- "${SAVE_ARGS[@]}"
 	exec fakechroot $0 "$@"
     fi
-- 
2.11.0.rc0.7.gbe5a750


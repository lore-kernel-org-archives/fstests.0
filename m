Received: from imap.thunk.org ([74.207.234.97]:37542 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750973AbdHLShj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 12 Aug 2017 14:37:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] xfstests-bld: teach setup-buildchroot about /etc/schroot/chroot.d
Date: Sat, 12 Aug 2017 14:37:31 -0400
Message-Id: <20170812183731.20272-1-tytso@mit.edu>
In-Reply-To: <20170812183434.yy7vntirb5p4mcik@thunk.org>
References: <20170812183434.yy7vntirb5p4mcik@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: ebiggers3@gmail.com, Theodore Ts'o <tytso@mit.edu>
List-ID: <fstests@vger.kernel.org>

Check for the existence of a chroot definition in the chroot.d
directory, and if it exists, create the entry in that directory
instead of appending the entry to /etc/schroot/schroot.conf

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 setup-buildchroot | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/setup-buildchroot b/setup-buildchroot
index f649ed8..e43cba8 100755
--- a/setup-buildchroot
+++ b/setup-buildchroot
@@ -28,6 +28,7 @@ QEMU=
 BINFMT_MISC_MNT=/proc/sys/fs/binfmt_misc
 
 SCHROOT_CONFFILE=/etc/schroot/schroot.conf
+SCHROOT_CHROOT_D=/etc/schroot/chroot.d
 SCHROOT_FSTAB=xfstests-bld/fstab
 SCHROOT_FSTAB_FILE=/etc/schroot/$SCHROOT_FSTAB
 
@@ -356,10 +357,32 @@ validate_binfmt_misc()
     log "Detected foreign chroot, using user-mode emulation with $QEMU version $full_version"
 }
 
+# Get the schroot configuration from either schroot.conf or entries in
+# the chroot.d directory
+get_schroot_config()
+{
+    local files
+
+    if test ! -f $SCHROOT_CONFFILE
+    then
+	die $SCHROOT_CONFFILE does not exist
+    fi
+
+    if test -d $SCHROOT_CHROOT_D
+    then
+	(cd $SCHROOT_CHROOT_D ;
+	 find . -maxdepth 1 -type f |
+	     egrep '^./[a-ZA-Z0-09_-][a-ZA-Z0-09_.-]*$' |
+	     xargs cat $SCHROOT_CONFFILE)
+    else
+	cat $SCHROOT_CONFFILE
+    fi
+}
+
 # Extract the schroot.conf entry, if any, for $CHROOT_NAME
 extract_schroot_entry()
 {
-    awk '
+    get_schroot_config | awk '
 {
     if ($0 ~ /^[[:space:]]*\[.*\][[:space:]]*$/) {
 	sub(/\][[:space:]]*$/, "")
@@ -369,7 +392,7 @@ extract_schroot_entry()
 	print
     }
 }
-' "$SCHROOT_CONFFILE"
+'
 }
 
 generate_schroot_entry()
@@ -414,19 +437,26 @@ check_for_conflicting_schroot_entry()
 # Add an entry to schroot.conf for the chroot.
 add_schroot_conf_entry()
 {
+    local f
     check_for_conflicting_schroot_entry
     if [ -n "$(extract_schroot_entry)" ]; then
 	log "$CHROOT_NAME entry already exists in $SCHROOT_CONFFILE"
 	return
     fi
 
-    log "Adding new entry to $SCHROOT_CONFFILE:"
+    if test -d $SCHROOT_CHROOT_D
+    then
+	f="$SCHROOT_CHROOT_D/$CHROOT_NAME"
+    else
+	f="$SCHROOT_CONFFILE"
+    fi
+    log "Adding new entry to $f:"
     {
 	echo
 	echo "# entry added by $SCRIPTNAME"
 	echo "[$CHROOT_NAME]"
 	generate_schroot_entry
-    } | tee -a "$SCHROOT_CONFFILE"
+    } | tee -a "$f"
     echo
 }
 
-- 
2.11.0.rc0.7.gbe5a750


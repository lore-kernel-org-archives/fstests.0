Received: from mail-pg0-f68.google.com ([74.125.83.68]:35236 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752395AbcLUSHV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 13:07:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id i5so7490916pgh.2
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 10:07:20 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] xfstests-bld: correct file permissions on test appliance files
Date: Wed, 21 Dec 2016 10:06:27 -0800
Message-Id: <1482343592-135031-1-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The xfstests-bld repository may have been cloned with a umask that
masked out the other bits.  When using --update-files in this situation
or when creating a GCE image, the VM ended up in a state where non-root
users were unable to execute anything, which made all tests using the
fsgqa user get skipped.  Fix this by copying the r and x group bits to
the other bits when creating files.tar.gz.  Also set the owner and group
to root while we're at it.

[v2: also fix gce-create-image]

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/gce-xfstests                    | 3 ++-
 kvm-xfstests/kvm-xfstests                    | 3 ++-
 kvm-xfstests/test-appliance/gce-create-image | 3 ++-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kvm-xfstests/gce-xfstests b/kvm-xfstests/gce-xfstests
index 04eee78..8839ea2 100755
--- a/kvm-xfstests/gce-xfstests
+++ b/kvm-xfstests/gce-xfstests
@@ -471,7 +471,8 @@ then
 	exit 1
     fi
     (cd "$DIR/test-appliance"; \
-     tar -X gce-exclude-files --exclude=etc -C files -cf - . | \
+     tar -X gce-exclude-files --exclude=etc -C files \
+		--owner=root --group=root --mode=o+g-w -cf - . | \
 	 gzip -9n > $LOCAL_FILES)
     get_local_hash "$LOCAL_FILES"
     get_remote_hash "$GS_FILES"
diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
index fbdae7a..bcada9e 100755
--- a/kvm-xfstests/kvm-xfstests
+++ b/kvm-xfstests/kvm-xfstests
@@ -75,7 +75,8 @@ then
 	exit 1
     fi
     (cd "$DIR/test-appliance"; \
-     tar -X kvm-exclude-files -C files -cf - . | \
+     tar -X kvm-exclude-files -C files \
+		--owner=root --group=root --mode=o+g-w -cf - . | \
 	 gzip -9n > "$TDIR/files.tar.gz")
     tar -r -f $VDH -C "$TDIR" files.tar.gz
     rm -rf "$TDIR"
diff --git a/kvm-xfstests/test-appliance/gce-create-image b/kvm-xfstests/test-appliance/gce-create-image
index 56366d1..005cc8e 100755
--- a/kvm-xfstests/test-appliance/gce-create-image
+++ b/kvm-xfstests/test-appliance/gce-create-image
@@ -87,7 +87,8 @@ then
     cat ../../*.ver > files/root/xfstests/git-versions
 fi
 
-tar -X gce-exclude-files -C files -cf - . | gzip -9n > $t
+tar -X gce-exclude-files -C files --owner=root --group=root --mode=o+g-w \
+	-cf - . | gzip -9n > $t
 GS_FILES_TARBALL=gs://$GS_BUCKET/files.tar.gz
 
 if test -f files/root/xfstests/git-versions
-- 
2.8.0.rc3.226.g39d4020


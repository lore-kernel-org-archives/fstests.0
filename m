Received: from mail-it0-f68.google.com ([209.85.214.68]:33797 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbcL1VJE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Dec 2016 16:09:04 -0500
Received: by mail-it0-f68.google.com with SMTP id 75so37192084ite.1
        for <fstests@vger.kernel.org>; Wed, 28 Dec 2016 13:09:04 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v3] xfstests-bld: correct file permissions on test appliance files
Date: Wed, 28 Dec 2016 15:08:20 -0600
Message-Id: <20161228210820.13832-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The xfstests-bld repository may have been cloned with a umask that
masked out the group and/or the other bits.  When using --update-files
in this situation or when creating a GCE image, the VM ended up in a
state where non-root users were unable to execute anything, which made
all tests using the fsgqa user get skipped.  Fix this by copying the r
and x user bits to the group and other bits when creating files.tar.gz.
Also set the owner and group to root while we're at it.

Note that git doesn't actually store file owners, groups, or any mode
bits other than "is the file executable"?  So this patch really just
enforces a consistent, sane default for this "unstored" metadata.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 gen-tarball                                  | 2 +-
 kvm-xfstests/gce-xfstests                    | 3 ++-
 kvm-xfstests/kvm-xfstests                    | 3 ++-
 kvm-xfstests/test-appliance/gce-create-image | 3 ++-
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/gen-tarball b/gen-tarball
index 2626996..2c5229a 100755
--- a/gen-tarball
+++ b/gen-tarball
@@ -50,5 +50,5 @@ cp bld/lib/client.txt xfstests/lib
 echo "STRIP xfstests/*"
 find xfstests -mindepth 2 -type f -perm /0111 | xargs $STRIP 2> /dev/null
 echo "TAR xfstests"
-tar c --owner=root --group=root --mode=o+g-w xfstests | \
+tar c --owner=root --group=root --mode=go+u-w xfstests | \
 	$GZIP -9 > xfstests.tar.gz
diff --git a/kvm-xfstests/gce-xfstests b/kvm-xfstests/gce-xfstests
index 4553792..084b30c 100755
--- a/kvm-xfstests/gce-xfstests
+++ b/kvm-xfstests/gce-xfstests
@@ -456,7 +456,8 @@ then
 	exit 1
     fi
     (cd "$DIR/test-appliance"; \
-     tar -X gce-exclude-files --exclude=etc -C files -cf - . | \
+     tar -X gce-exclude-files --exclude=etc -C files \
+		--owner=root --group=root --mode=go+u-w -cf - . | \
 	 gzip -9n > $LOCAL_FILES)
     get_local_hash "$LOCAL_FILES"
     get_remote_hash "$GS_FILES"
diff --git a/kvm-xfstests/kvm-xfstests b/kvm-xfstests/kvm-xfstests
index fbdae7a..40c3632 100755
--- a/kvm-xfstests/kvm-xfstests
+++ b/kvm-xfstests/kvm-xfstests
@@ -75,7 +75,8 @@ then
 	exit 1
     fi
     (cd "$DIR/test-appliance"; \
-     tar -X kvm-exclude-files -C files -cf - . | \
+     tar -X kvm-exclude-files -C files \
+		--owner=root --group=root --mode=go+u-w -cf - . | \
 	 gzip -9n > "$TDIR/files.tar.gz")
     tar -r -f $VDH -C "$TDIR" files.tar.gz
     rm -rf "$TDIR"
diff --git a/kvm-xfstests/test-appliance/gce-create-image b/kvm-xfstests/test-appliance/gce-create-image
index 56366d1..a901476 100755
--- a/kvm-xfstests/test-appliance/gce-create-image
+++ b/kvm-xfstests/test-appliance/gce-create-image
@@ -87,7 +87,8 @@ then
     cat ../../*.ver > files/root/xfstests/git-versions
 fi
 
-tar -X gce-exclude-files -C files -cf - . | gzip -9n > $t
+tar -X gce-exclude-files -C files --owner=root --group=root --mode=go+u-w \
+	-cf - . | gzip -9n > $t
 GS_FILES_TARBALL=gs://$GS_BUCKET/files.tar.gz
 
 if test -f files/root/xfstests/git-versions
-- 
2.11.0


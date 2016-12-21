Received: from mail-pg0-f68.google.com ([74.125.83.68]:35409 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756462AbcLUSHp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 13:07:45 -0500
Received: by mail-pg0-f68.google.com with SMTP id i5so7491842pgh.2
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 10:07:45 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: remove dead code for gce-xfstests get-results
Date: Wed, 21 Dec 2016 10:06:31 -0800
Message-Id: <1482343592-135031-5-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The 'gce-xfstests get-results' command was implemented in two places.
Remove the dead version.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/gce-xfstests | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kvm-xfstests/gce-xfstests b/kvm-xfstests/gce-xfstests
index 8839ea2..2910ca4 100755
--- a/kvm-xfstests/gce-xfstests
+++ b/kvm-xfstests/gce-xfstests
@@ -308,21 +308,6 @@ case "$1" in
 	exec gcloud beta compute --project "$GCE_PROJECT" -q \
 	     connect-to-serial-port --zone "$GCE_ZONE" $PORT "$2"
 	;;
-    get-results)
-	case "$2" in
-	    --failures|-F)
-		OPT="-F"
-		shift
-		;;
-	esac
-	tmpfile=$(mktemp)
-	gcloud compute --project "$GCE_PROJECT" -q \
-	       copy-files "$2:/results/runtests.log" "$tmpfile" \
-	       --zone "$GCE_ZONE"
-	"$DIR/get-results" "$OPT" "$tmpfile"
-	/bin/rm -f "$tmpfile"
-	exit 0
-	;;
     create-image)
 	shift
 	"$DIR/test-appliance/gce-create-image" "$@"
-- 
2.8.0.rc3.226.g39d4020


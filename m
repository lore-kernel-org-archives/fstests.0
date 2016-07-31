Received: from mail-pf0-f173.google.com ([209.85.192.173]:35502 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbcGaV7w (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 31 Jul 2016 17:59:52 -0400
Received: by mail-pf0-f173.google.com with SMTP id x72so48507755pfd.2
        for <fstests@vger.kernel.org>; Sun, 31 Jul 2016 14:59:51 -0700 (PDT)
From: Omar Sandoval <osandov@osandov.com>
Subject: [PATCH] check: allow comments in exclude files
Date: Sun, 31 Jul 2016 14:53:44 -0700
Message-Id: <a860d00b5fdc3d88b0ce692585d0046e259c71c4.1470001873.git.osandov@fb.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

From: Omar Sandoval <osandov@fb.com>

Sometimes it's useful to keep track of why we're excluding a particular
test. Technically, we can include whatever explanation we want in the
exclude file since we just grep for the test names, but properly
supporting comments is a little more robust. This patch makes it so that
the rest of a line after a '#' is ignored.

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 check | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 9fbc305e9021..69341d8c4f72 100755
--- a/check
+++ b/check
@@ -224,14 +224,14 @@ while [ $# -gt 0 ]; do
 	-X)	xfile=$2; shift ;
 		for d in $SRC_GROUPS $FSTYP; do
 			[ -f $SRC_DIR/$d/$xfile ] || continue
-			for f in `cat $SRC_DIR/$d/$xfile`; do
+			for f in `sed "s/#.*$//" $SRC_DIR/$d/$xfile`; do
 				echo $d/$f >> $tmp.xlist
 			done
 		done
 		;;
 	-E)	xfile=$2; shift ;
 		if [ -f $xfile ]; then
-			cat "$xfile" >> $tmp.xlist
+			sed "s/#.*$//" "$xfile" >> $tmp.xlist
 	        fi
 		;;
 	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
-- 
2.9.2


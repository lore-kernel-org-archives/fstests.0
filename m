Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:40145 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbeKBKPI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Nov 2018 06:15:08 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gINy9-0000yL-3H
        for fstests@vger.kernel.org; Fri, 02 Nov 2018 12:09:49 +1100
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1gINy8-0002FI-W4
        for fstests@vger.kernel.org; Fri, 02 Nov 2018 12:09:49 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH] check: use full paths for diff on error
Date: Fri,  2 Nov 2018 12:09:48 +1100
Message-Id: <20181102010948.8594-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

i don't run fstests from the source directory, so when I get a
golden image mismatch the relative path to the golden output is
not useful:

(Run 'diff -u tests/generic/013.out /home/dave/src/xfstests-dev/results//xfs_64k/generic/013.out.bad'  to see the entire diff)

Change the output to emit the real path for the golden out so this
can be cut and pasted and run from anywhere.

(Run 'diff -u /home/dave/src/xfstests-dev/tests/generic/013.out /home/dave/src/xfstests-dev/results//xfs_64k/generic/013.out.bad'  to see the entire diff)

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index f3c8021d94b9..59f94c1c33f9 100755
--- a/check
+++ b/check
@@ -799,7 +799,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			else
 				head -n "$DIFF_LENGTH"
 				echo "..."
-				echo "(Run '$diff $seq.out $seqres.out.bad'" \
+				echo "(Run '$diff $here/$seq.out $seqres.out.bad'" \
 					" to see the entire diff)"
 			fi; } | sed -e 's/^\(.\)/    \1/'
 			err=true
-- 
2.19.1

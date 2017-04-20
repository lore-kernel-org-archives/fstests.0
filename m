Received: from mx1.redhat.com ([209.132.183.28]:49406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S970619AbdDTPai (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Apr 2017 11:30:38 -0400
Subject: [PATCH V3] make xfs/293 more robust
References: <bf7bdb00-59d0-2283-e040-af1e86f14b95@redhat.com>
 <6e4cecf7-dbcf-3cf3-22e0-50e8e1e859fd@sandeen.net>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <e9cefa11-7c22-ce0c-7649-55d5f6b84c0b@redhat.com>
Date: Thu, 20 Apr 2017 10:30:36 -0500
MIME-Version: 1.0
In-Reply-To: <6e4cecf7-dbcf-3cf3-22e0-50e8e1e859fd@sandeen.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>, "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

xfs/293 is supposed to make sure every command in xfs_io
is documented, but it was missing the inode command because
it's a common word, and depending on how man formatted the
page, the magic "   inode" string could show up and appear
to indicate that documentation is present for the command
when it's not actually there.

Change the test to inspect the manpage source directly, with
the assumption that each documented command will start
with ^\.B.*$COMMAND on a manpage line.

This handles a few different compressed manpage formats -
I don't know if anybody uses bz2 or xz, but hey.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: reduce cat assignment derp
    use _require_command instead of hand-rolling it

V3: all the gzips.

diff --git a/tests/xfs/293 b/tests/xfs/293
index ade6015..df44e98 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -48,8 +48,19 @@ _supported_os IRIX Linux
 
 echo "Silence is golden"
 
+MANPAGE=`man --path xfs_io`
+
+case "$MANPAGE" in
+*.gz|*.z\|*.Z)	CAT=zcat;;
+*.bz2)		CAT=bzcat;;
+*.xz)		CAT=xzcat;;
+*)		CAT=cat;;
+esac
+
+_require_command `which $CAT` $CAT
+
 for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
-  man xfs_io | col -b | grep -wq "   $COMMAND" || \
+  $CAT `man --path xfs_io` | egrep -q "^\.B.*$COMMAND" || \
 	echo "$COMMAND not documented in the xfs_io manpage"
 done
 



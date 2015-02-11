Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:51067 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344AbbBKRLL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 11 Feb 2015 12:11:11 -0500
Message-ID: <54DB8D2D.20104@sandeen.net>
Date: Wed, 11 Feb 2015 11:11:09 -0600
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH] fstests: shared/032 handle mkfs.* in either /sbin or /usr/sbin
References: <54DB35F0.1010203@plexistor.com>
In-Reply-To: <54DB35F0.1010203@plexistor.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Boaz Harrosh <boaz@plexistor.com>, Dave Chinner <david@fromorbit.com>, xfs@oss.sgi.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

mkfs programs may live in either /sbin or /usr/sbin, and
the current regexp in this test only catches the latter,
and so the test wont' run properly for the former.

Fix this by iterating over each full path to every mkfs.${FS}
program in ${MKFS.PROG}.*, and extracting the ${FS} part.

We found the paths in the first place by using a wildcard
with the found ${MKFS_PROG}, so we can use that string to
filter out everything except the wildcard match at the end,
which is the fs name we are looking for.

Reported-by: Boaz Harrosh <boaz@plexistor.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/shared/032 b/tests/shared/032
index a410003..8ffb54b 100755
--- a/tests/shared/032
+++ b/tests/shared/032
@@ -50,8 +50,9 @@ if [ "$FSTYP" == "btrfs" ]; then
 fi
 
 echo "Silence is golden."
-for fs in `echo ${MKFS_PROG}.* | sed -e 's/.sbin.mkfs.//g'`
+for mkfs in `echo ${MKFS_PROG}.*`
 do
+	fs=`echo $mkfs | sed -e s:${MKFS_PROG}.::`
 	preop=""	# for special input needs
 	preargs=""	# for any special pre-device options
 	postargs=""	# for any special post-device options



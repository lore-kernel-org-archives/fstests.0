Received: from mail-wj0-f196.google.com ([209.85.210.196]:36294 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932325AbdABNXR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jan 2017 08:23:17 -0500
Received: by mail-wj0-f196.google.com with SMTP id j10so68615921wjb.3
        for <fstests@vger.kernel.org>; Mon, 02 Jan 2017 05:23:16 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 2/2] check: support include/exclude of sub groups
Date: Mon,  2 Jan 2017 15:22:59 +0200
Message-Id: <1483363379-10210-2-git-send-email-amir73il@gmail.com>
In-Reply-To: <1483363379-10210-1-git-send-email-amir73il@gmail.com>
References: <1483363379-10210-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Allow including and/or excluding tests by test dir and group.
-g and -x command line arguments can take the form of
<subdir>/<group>.

For example:

./check -n -g xfs/quick
./check -n -g stress -x xfs/stress
./check -n -g xfs/punch -x dangerous_fuzzers

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/check b/check
index faf6281..8d1ec71 100755
--- a/check
+++ b/check
@@ -105,6 +105,14 @@ get_group_list()
 {
 	local grp=$1
 	local grpl=""
+	local sub=$(dirname $grp)
+
+	if [ -n "$sub" -a "$sub" != "." -a -d "$SRC_DIR/$sub" ]; then
+		# group is given as <subdir>/<group> (e.g. xfs/quick)
+		grp=$(basename $grp)
+		get_sub_group_list $sub $grp
+		return
+	fi
 
 	for d in $SRC_GROUPS $FSTYP; do
 		if ! test -d "$SRC_DIR/$d" ; then
-- 
2.7.4


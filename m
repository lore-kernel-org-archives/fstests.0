Received: from mx1.redhat.com ([209.132.183.28]:59753 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327AbbHNIY6 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Aug 2015 04:24:58 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 9D5CB40C50
	for <fstests@vger.kernel.org>; Fri, 14 Aug 2015 08:24:58 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] generic/084: check inotify limit before tail many files
Date: Fri, 14 Aug 2015 16:24:54 +0800
Message-Id: <1439540694-30259-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

generic/084 try to run 'tail' command, tail will use
inotify, and there're some limit about inotify. I think
the most important is fs.inotify.max_user_instances.

When I test on a machine with 154 cpu cores, this case
run failed, and hit many warning likes:

    +tail: inotify cannot be used, reverting to polling: Too many open files

Because the fs.inotify.max_user_instances is 128, so if
we try to tail 154 files, it will be failed.

Of course, fs.inotify.max_user_instances and open files limit
will effect this too. But generally max_user_instances is the
minimum number, so I don't check the others.

Signed-off-by: Zorro Lang <zlang@redhat.com>
Reviewed-by: Eryu Guan <eguan@redhat.com>
---
 tests/generic/084 | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/generic/084 b/tests/generic/084
index 3fec6c2..38ae932 100755
--- a/tests/generic/084
+++ b/tests/generic/084
@@ -63,6 +63,16 @@ link_unlink_storm()
 
 rm -f $seqres.full
 nr_cpu=`$here/src/feature -o`
+# max_user_instances limit the number of inotify instances that
+# can be created by per real user ID.
+user_instances=`sysctl -n fs.inotify.max_user_instances`
+
+# Generally already some processes have occupied a few of inotify instances
+# So maybe use user_instances/2 will be safe
+if [ $nr_cpu -ge $((user_instances/2)) ];then
+	nr_cpu=$((user_instances/2))
+fi
+
 echo "Silence is golden"
 
 _scratch_mkfs >>$seqres.full 2>&1
-- 
1.9.3


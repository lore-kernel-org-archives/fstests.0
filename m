Received: from mx1.redhat.com ([209.132.183.28]:54915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556AbcGEJab (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 5 Jul 2016 05:30:31 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 136F63B71B
	for <fstests@vger.kernel.org>; Tue,  5 Jul 2016 09:30:31 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v5 1/2] common/dmerror: fix nonsensical arguments handling
Date: Tue,  5 Jul 2016 17:30:23 +0800
Message-Id: <1467711024-12702-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

By default, _dmerror_load_*_table() suspends the dm device with
"--nolockfs" option. Callers have to feed two arguments to these
functions to change the behavior, with the second being 1, but the
first argument is not used at all, which doesn't make sense.

Fix it by checking if the first argument is "lockfs" and removing
"--nolockfs" option if so, or passing all options to dmsetup.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

At first, I want to change the code just likes:

  suspend_opts="$*"

But after talked with Darrick J. Wong(the original author of
dmerror), he suggest to keep use --nolockfs as default:

  <djwong> i used --nolockfs so that dmsetup doesn't try to flush
           the fs on the device that we're deliberately erroring
  <djwong> (most probably the test is midway through its own fsync,
           so dmsetup trying to sync the fs will just get hung up
           on the io errors)

So follow this suggestion, and keep --nolockfs still as the default
option.

Thanks,
Zorro

 common/dmerror | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/common/dmerror b/common/dmerror
index 6df87bd..5ad9994 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -68,7 +68,12 @@ _dmerror_cleanup()
 _dmerror_load_error_table()
 {
 	suspend_opt="--nolockfs"
-	[ $# -gt 1 ] && [ $2 -eq 1 ] && suspend_opt=""
+
+	if [ "$1" = "lockfs" ]; then
+		suspend_opt=""
+	elif [ -n "$*" ]; then
+		suspend_opt="$*"
+	fi
 
 	$DMSETUP_PROG suspend $suspend_opt error-test
 	[ $? -ne 0 ] && _fail  "dmsetup suspend failed"
@@ -83,7 +88,12 @@ _dmerror_load_error_table()
 _dmerror_load_working_table()
 {
 	suspend_opt="--nolockfs"
-	[ $# -gt 1 ] && [ $2 -eq 1 ] && suspend_opt=""
+
+	if [ "$1" = "lockfs" ]; then
+		suspend_opt=""
+	elif [ -n "$*" ]; then
+		suspend_opt="$*"
+	fi
 
 	$DMSETUP_PROG suspend $suspend_opt error-test
 	[ $? -ne 0 ] && _fail  "dmsetup suspend failed"
-- 
2.5.5


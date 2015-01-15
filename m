Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38971 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbbAOJaz (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 15 Jan 2015 04:30:55 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0F9UtOp025799
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 15 Jan 2015 04:30:55 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/3] check: log running test to dmesg
Date: Thu, 15 Jan 2015 17:30:29 +0800
Message-Id: <1421314231-11076-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1421314231-11076-1-git-send-email-eguan@redhat.com>
References: <1421314231-11076-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Sandeen <sandeen@redhat.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Sandeen <sandeen@redhat.com>

We already log the running test to system logs via "logger"
but viro pointed out that we can use /dev/kmsg to insert it
into dmesg as well.  When looking at the serial console that
could be pretty useful.

Thanks to viro for the test -w suggestion too.

[Eryu Guan adds timestamp to dmesg too]

Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---
 check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check b/check
index 10f4a18..3d42a8b 100755
--- a/check
+++ b/check
@@ -561,6 +561,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		$timestamp && echo -n "	["`date "+%T"`"]"
 		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
 		$LOGGER_PROG "run xfstest $seqnum"
+		if [ -w /dev/kmsg ]; then
+			date_time=`date +"%F %T"`
+			echo "run fstests $seqnum at $date_time" > /dev/kmsg
+		fi
 		./$seq >$tmp.rawout 2>&1
 		sts=$?
 		$timestamp && _timestamp
-- 
2.1.0


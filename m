Received: from mx1.redhat.com ([209.132.183.28]:38209 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbbFSJs0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Jun 2015 05:48:26 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id EA78E3017CF
	for <fstests@vger.kernel.org>; Fri, 19 Jun 2015 09:48:25 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/3] fstests: add _check_dmesg the ability to filter out intentional dmesg log
Date: Fri, 19 Jun 2015 17:33:38 +0800
Message-Id: <1434706419-5589-2-git-send-email-eguan@redhat.com>
In-Reply-To: <1434706419-5589-1-git-send-email-eguan@redhat.com>
References: <1434706419-5589-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Introduce a parameter to _check_dmesg which allows callers to provide a
customized filter function to filter out intentional dmesg logs. The
default filter is a simple 'cat' command.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 141ab5c..15e7795 100644
--- a/common/rc
+++ b/common/rc
@@ -2944,10 +2944,15 @@ _check_dmesg()
 	fi
 	rm -f ${RESULT_DIR}/check_dmesg
 
+	# default filter is a simple cat command, caller could provide a
+	# customized filter and pass the name through the first argument, to
+	# filter out intentional WARNINGs or Oopses
+	filter=${1:-cat}
+
 	# search the dmesg log of last run of $seqnum for possible failures
 	# use sed \cregexpc address type, since $seqnum contains "/"
 	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | \
-		tac >$seqres.dmesg
+		tac | $filter >$seqres.dmesg
 	grep -q -e "kernel BUG at" \
 	     -e "WARNING:" \
 	     -e "BUG:" \
-- 
1.8.3.1


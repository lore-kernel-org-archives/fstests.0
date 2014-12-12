Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50924 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934135AbaLLEnd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 11 Dec 2014 23:43:33 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id sBC4hXp2032485
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 11 Dec 2014 23:43:33 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH v3] generic/299: various fixes
Date: Fri, 12 Dec 2014 12:43:21 +0800
Message-Id: <1418359401-8240-1-git-send-email-eguan@redhat.com>
In-Reply-To: <1418295529-20565-1-git-send-email-eguan@redhat.com>
References: <1418295529-20565-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Fix two problems in generic/299

1. Remove $seqres.full before test, otherwise the file is growing all
the time.

2. Make sure fio really exits, otherwise fio would block umount. $pid is
the pid of function run_check not fio, sometimes fio is still there when
$pid is dead and blocking umount.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---

v3:
- rebase and skip the replacing fallocate/truncate part

v2:
- remove $seqres.full before _require_fio, which writes to $seqres.full too

 tests/generic/299 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/299 b/tests/generic/299
index e49eba9..e5de45b 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -109,6 +109,8 @@ rw=randrw
 filename=buffered-aio-verifier
 EOF
 
+rm -f $seqres.full
+
 _require_fio $fio_config
 _require_xfs_io_command "falloc"
 
@@ -136,7 +138,7 @@ _workout()
 	    done
 	    # Following like will check that pid is still run.
 	    # Once fio exit we can stop fallocate/truncate loop
-	    kill -0 $pid > /dev/null 2>&1 || break
+	    pgrep fio > /dev/null 2>&1 || break
 	done
 	wait $pid
 }
-- 
2.1.0


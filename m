Received: from mx1.redhat.com ([209.132.183.28]:35594 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751421AbcGSTx0 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 19 Jul 2016 15:53:26 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EAB6731A340
	for <fstests@vger.kernel.org>; Tue, 19 Jul 2016 19:53:25 +0000 (UTC)
Received: from Liberator.local (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u6JJrPYY000926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Tue, 19 Jul 2016 15:53:25 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] fix up fsx error handling in generic 075 and 112
Message-ID: <77036f23-97c3-2d62-e3f5-0c3571e71a5a@redhat.com>
Date: Tue, 19 Jul 2016 12:53:25 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

When fsx fails we try to copy failure state to the results/
dir, but in some cases we are using $seqres instead of
$seq or $seq instead of $here/$seq; fix this up so the
failure state is accurately captured in the results/ dir.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/075 b/tests/generic/075
index a2411c6..6a214bc 100755
--- a/tests/generic/075
+++ b/tests/generic/075
@@ -79,8 +79,10 @@ _do_test()
     then
 	echo "    fsx ($_param) failed, $? - compare $seqres.$_n.{good,bad,fsxlog}"
 	mv $out/$seq.$_n $seqres.$_n.full
+	mv $here/$seq.$_n.fsxlog $seqres.$_n.fsxlog
 	od -xAx $seqres.$_n.full > $seqres.$_n.bad
-	od -xAx $seqres.$_n.fsxgood > $seqres.$_n.good
+	od -xAx $here/$seq.$_n.fsxgood > $seqres.$_n.good
+	rm -f $here/$seq.$_n.fsxgood
 	status=1
 	exit
     fi
diff --git a/tests/generic/112 b/tests/generic/112
index b59cbfa..55be394 100755
--- a/tests/generic/112
+++ b/tests/generic/112
@@ -78,7 +78,7 @@ _do_test()
     if ! $here/ltp/fsx $_param -P $here $FSX_AVOID $seq.$_n &>/dev/null
     then
 	echo "    fsx ($_param) returned $? - see $seq.$_n.full"
-	mv $seq.$_n.fsxlog $seqres.$_n.full
+	mv $here/$seq.$_n.fsxlog $seqres.$_n.full
 	status=1
 	exit
     fi


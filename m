Received: from userp2120.oracle.com ([156.151.31.85]:47032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728373AbfDQBTa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Apr 2019 21:19:30 -0400
Date: Tue, 16 Apr 2019 18:19:26 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH 3/2] check: filter lockdep bugs when scanning dmesg
Message-ID: <20190417011926.GC22015@magnolia>
References: <20190416223459.GA22015@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416223459.GA22015@magnolia>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Darrick J. Wong <darrick.wong@oracle.com>

Ignore lockdep complaining about its own bugginess when scanning dmesg
output, because we shouldn't be failing filesystem tests on account of
lockdep.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 common/rc |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index e0dd3797..b2287766 100644
--- a/common/rc
+++ b/common/rc
@@ -3511,6 +3511,13 @@ _check_dmesg_for()
 	_dmesg_since_test_start | egrep -q "$1"
 }
 
+# Default filter for dmesg scanning
+_check_dmesg_filter()
+{
+	egrep -v -e "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low" \
+		-e "BUG: MAX_STACK_TRACE_ENTRIES too low"
+}
+
 # check dmesg log for WARNING/Oops/etc.
 _check_dmesg()
 {
@@ -3522,7 +3529,7 @@ _check_dmesg()
 	# default filter is a simple cat command, caller could provide a
 	# customized filter and pass the name through the first argument, to
 	# filter out intentional WARNINGs or Oopses
-	local filter=${1:-cat}
+	local filter=${1:-_check_dmesg_filter}
 
 	_dmesg_since_test_start | $filter >$seqres.dmesg
 	egrep -q -e "kernel BUG at" \

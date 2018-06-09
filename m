Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:32416 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752872AbeFIBzs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 21:55:48 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0007YM-VV
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:44 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0005C9-UI
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 9/9] fstests: make lsqa.pl work with SPDX tags
Date: Sat,  9 Jun 2018 11:55:40 +1000
Message-Id: <20180609015540.19385-10-david@fromorbit.com>
In-Reply-To: <20180609015540.19385-1-david@fromorbit.com>
References: <20180609015540.19385-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

The regex matches used to dump the test headers are no longer valid,
so update them to work with the new test header format.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 lsqa.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/lsqa.pl b/lsqa.pl
index dd45eeda4e2c..8ca1167f845c 100755
--- a/lsqa.pl
+++ b/lsqa.pl
@@ -95,9 +95,11 @@ sub get_qa_header($) {
     open(my $FH, $f) || die "couldn't open '$f': $!";
     while (<$FH>) {
 	#ignore.
-	m/^#\!/    		and next; #shebang
-	m/^#\s*\-{10}/		and last; #dashed lines
-	m/^#\s*copyright/i 	and last; #copyright lines
+	m/^#\!/			and next; # shebang
+	m/^# SPDX/i		and next; # SPDX tags
+	m/^# Copyright/i	and next; # Copyright tags
+	m/^#\s*\-{10}/		and last; # dashed lines
+	m/^seq/i		and last; # test start
 
 	s/^# *//;
 
-- 
2.17.0


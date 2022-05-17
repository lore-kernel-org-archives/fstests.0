Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34DFC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 17 May 2022 07:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiEQHBa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 17 May 2022 03:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbiEQHBX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 17 May 2022 03:01:23 -0400
Received: from mail104.syd.optusnet.com.au (mail104.syd.optusnet.com.au [211.29.132.246])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E928A15FE4
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 00:01:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id B6F885345F6
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 17:01:14 +1000 (AEST)
Received: from discord.disaster.area ([192.168.253.110])
        by dread.disaster.area with esmtp (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-00Cy75-8o
        for fstests@vger.kernel.org; Tue, 17 May 2022 17:01:13 +1000
Received: from dave by discord.disaster.area with local (Exim 4.95)
        (envelope-from <david@fromorbit.com>)
        id 1nqrCj-005njx-7M
        for fstests@vger.kernel.org;
        Tue, 17 May 2022 17:01:13 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 05/12] README: document _begin_fstests better
Date:   Tue, 17 May 2022 17:01:04 +1000
Message-Id: <20220517070111.1381936-6-david@fromorbit.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220517070111.1381936-1-david@fromorbit.com>
References: <20220517070111.1381936-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6283483a
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=cW3PQDqm_EACmSyWozIA:9
        a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Because how it actually gets used by the fstests infrastructure
has been undocumented and that has impact on how it should be set
up.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 README | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/README b/README
index 7da66cb6..eacf1acd 100644
--- a/README
+++ b/README
@@ -368,19 +368,42 @@ Test script environment:
 
      6. Test group membership: Each test can be associated with any number
 	of groups for convenient selection of subsets of tests.  Group names
-	can be any sequence of non-whitespace characters.  Test authors
-	associate a test with groups by passing the names of those groups as
-	arguments to the _begin_fstest function.  For example, the code:
+	can be any sequence of non-whitespace characters, though human-readable
+	names that match the set [A-Za-z0-9\-] are highly prefered.
 
-	_begin_fstest auto quick subvol snapshot
+	Test authors associate a test with groups by passing the names of those
+	groups as arguments to the _begin_fstest function. While _begin_fstests
+	is a shell function that must be called at the start of a test to
+	initialise the test environment correctly, the the build infrastructure
+	also scans the test files for _begin_fstests invocations. It does this
+	to compile the group lists that are used to determine which tests to run
+	when `check` is executed. In other words, test files files must call
+	_begin_fstest with their intended groups or they will not be run.
+
+	However, because the build infrastructure also uses _begin_fstests as
+	a defined keyword, addition restrictions are placed on how it must be
+	formatted:
+
+	(a) It must be a single line with no multi-line continuations.
+
+	(b) group names should be separated by spaces and not other whitespace
+
+	(c) A '#' placed anywhere in the list, even in the middle of a group
+	    name, will cause everything from the # to the end of the line to be
+	    ignored.
+
+	For example, the code:
+
+	_begin_fstest auto quick subvol snapshot # metadata
 
 	associates the current test with the "auto", "quick", "subvol", and
-	"snapshot" groups.  It is not necessary to specify the "all" group
-	in the list because that group is computed at run time.
+	"snapshot" groups. Because "metadata" is after the "#" comment
+	delimiter, it is ignored by the build infrastructure and so it will not
+	be associated with that group.
+
+	It is not necessary to specify the "all" group in the list because that
+	group is always computed at run time from the group lists.
 
-	The build process scans test files for _begin_fstest invocations and
-	compiles the group list from that information.  In other words, test
-	files must call _begin_fstest or they will not be run.
 
 Verified output:
 
-- 
2.35.1


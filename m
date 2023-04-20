Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E994C77B72
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 16:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbjDTQWL (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbjDTQWE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Apr 2023 12:22:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08F6423C
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 09:22:02 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLpSY022500
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007712; bh=E0ptPMwZdwrOf6cjeiZCqopv//SU9Ed5IHm8B7eRAUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=p14cJZbYjN1XoeakPwmvC13tHQe3FCKdC4oQgXqr+aJkG9Y/VEc6YFG7adGRhFY6X
         Z0PmZGC/sTB4dBM1kDwL4j7U6dMxV5Mt1AFYLg5gi23w1lW2mnNgZ7EQMO0XmH880F
         PfyYdc2TU0MId2bS5YbAE/Gt5jSHUJEqDKweas095DRnV2aTVtWil1K/BoIJk3N6I6
         HUY6SknxlTQ9M0ShIqoNoYGPk1n0i0ZmNSMQshqlIjeHIugGfbTinLaIVKGsVGXNMf
         j07a+h9xpiJW33j91mc1o1UGceDxgABQr9omeP4vEOnf+mxsRNjT3YGswhytsjQCNd
         bYXbG/+KIgF2A==
Received: by cwcc.thunk.org (Postfix, from userid 0)
        id 9847D15C543B; Wed, 19 Apr 2023 23:21:42 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] test-appliance: support a timestamp specifier which contains a timezone
Date:   Wed, 19 Apr 2023 23:20:56 -0400
Message-Id: <20230420032056.789979-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230420032056.789979-1-tytso@mit.edu>
References: <20230420032056.789979-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Commit 545315976e72 ("report: capture the time zone in the test report
timestamp") in the fstests upstream adds a timezone to the timestamp.
This is useful, but it breaks the strptime parsing of the timestamp.
It's not entirely clear that adding a timezone is legal.  According to
this schema[1] that it is a ISO 8061 date/time stamp where the
"Timezone may not be specified".  However in this schema[2], the
timestamp is just an optional string, and it says nothing about the
format of the timestamp.

[1] https://gist.github.com/jclosure/45d7005d120d90ba6430130356e4cd61#file-xunit-xsd-L140
[2] https://github.com/junit-team/junit5/blob/main/platform-tests/src/test/resources/jenkins-junit.xsd#L96

It's not entirely clear which schema is "official", but in the spirit
of the second part of Jon Postel's Robustness principal --- "be
liberal in what you accept" --- fix gen_results_summary.py to accept
an ISO 8061 timestamp with or without the timestamp.

It might be that in the spirit of "be conservative in what you send",
fstests upstream should use the moral equivalent of 'date -u +"%F %T" |
sed -e "s/ /T/"' instead of 'date -Iseconds', but this change will
work either way, as well as with both the older and newer versions of
fstests.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 .../usr/lib/python3/dist-packages/gen_results_summary.py  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py b/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py
index ecf5dc1a..44fb07d2 100644
--- a/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py
+++ b/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py
@@ -61,8 +61,12 @@ def parse_timestamp(timestamp):
     """Parse an ISO-8601-like timestamp as found in an xUnit file."""
     if timestamp == "":
         return 0
-    return time.mktime(datetime.strptime(timestamp,
-                                         '%Y-%m-%dT%H:%M:%S').timetuple())
+    for fmt in ('%Y-%m-%dT%H:%M:%S%z', '%Y-%m-%dT%H:%M:%S'):
+        try:
+            return time.mktime(datetime.strptime(timestamp, fmt).timetuple())
+        except ValueError:
+            pass
+    raise ValueError('no valid timestamp format found')
 
 def failed_tests(testsuite):
     """This iterator the failed tests from the testsuite."""
-- 
2.31.0


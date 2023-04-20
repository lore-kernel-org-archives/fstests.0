Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 860E9C77B72
	for <linux-fstests@archiver.kernel.org>; Thu, 20 Apr 2023 16:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjDTQWQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjDTQWJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 20 Apr 2023 12:22:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB75749EF
        for <fstests@vger.kernel.org>; Thu, 20 Apr 2023 09:22:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33KGLo0D022481
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682007712; bh=E0ptPMwZdwrOf6cjeiZCqopv//SU9Ed5IHm8B7eRAUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=G/8M0BSh0JrYfQV+dJUDe8lIt0TupGlL/7ZHsLQnInfUBpNwPLybmTtyGs9iy+fNo
         epeKEhPE0kEZpILLYS5STY6l89uuxF9CEQBldxfTeOPv48fce5/hi6R3LiwhP/CNaD
         8Qr6DoaERHYl87L7blJMfI5YZbmBks7wndK3P5uuFXSDWLhp5wMdrZ1riVllRMh4Fy
         jRRsySog23Jy+6yvBRlWxHXLRMj20Mi7Mf0KvHQkAF/pAtd7wdzEjDI4Jr2FnpvQ1J
         aQBnyZwhteTkeFbd5/onTZG/sti7i4WvY1uecK2iPd60MjxxN+ceGq+wg6vAZzjGyc
         6uil5v2lDmilw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 330FE15C5442; Thu, 20 Apr 2023 12:08:40 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/2] test-appliance: support a timestamp specifier which contains a timezone
Date:   Thu, 20 Apr 2023 12:08:37 -0400
Message-Id: <20230420160837.1083228-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230420160837.1083228-1-tytso@mit.edu>
References: <20230420160837.1083228-1-tytso@mit.edu>
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


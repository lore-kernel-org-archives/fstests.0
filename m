Received: from mx1.redhat.com ([209.132.183.28]:37322 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbbLBS2X (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 2 Dec 2015 13:28:23 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id D3FE9C0CC636
	for <fstests@vger.kernel.org>; Wed,  2 Dec 2015 18:28:23 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB2ISMta020226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Wed, 2 Dec 2015 13:28:23 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch] fstests: remove generic/042 from the 'auto' group
Date: Wed, 02 Dec 2015 13:28:22 -0500
Message-ID: <x49wpswogc9.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

This test fails 100% of the time for me on xfs and current git head, and
is not run for ext4 since ext4 does not support shutdown.  After talking
with bfoster, it isn't expected to succeed right now.  Since the auto
group is for tests that *are* expected to succeed, let's move this one
out.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/tests/generic/group b/tests/generic/group
index a33536e..4b70008 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -44,7 +44,7 @@
 039 metadata auto quick
 040 metadata auto quick
 041 metadata auto quick
-042 auto quick rw
+042 quick rw
 043 metadata log auto
 044 metadata log auto
 045 metadata log auto

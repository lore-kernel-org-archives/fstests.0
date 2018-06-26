Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750914AbeFZVIg (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Jun 2018 17:08:36 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH] xfstests: fix install target using sudo
Date: Tue, 26 Jun 2018 14:08:34 -0700
Message-Id: <20180626210834.24220-1-mcgrof@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
List-ID: <fstests@vger.kernel.org>

If you install with:

	sudo make install

Depending on the system, you may see /var/lib/xfstests/tests/ is empty.
This is because $(PWD) can expand to be empty on certain systems and so the
wildcard finds nothing.

PWD is only used on one target, the tests/*/ dir install target.

We can fix this by using $(CURDIR) however that does not suffice as we
are also using the $(wildcard) and that needs its own careful expansion.

This issue is observed on both Fedora and OpenSUSE, but not on Debian.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tests/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 2611b3b845f5..084135da0487 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -5,7 +5,8 @@
 TOPDIR = ..
 include $(TOPDIR)/include/builddefs
 
-TESTS_SUBDIRS = $(sort $(dir $(wildcard $(PWD)/$(TESTS_DIR)/[a-z]*/)))
+TEST_DIR = $(dir $(CURDIR)/$(TESTS_DIR))
+TESTS_SUBDIRS = $(sort $(dir $(wildcard $(TEST_DIR)/[a-z]*/)))
 
 include $(BUILDRULES)
 
-- 
2.16.3


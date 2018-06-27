Received: from mail.kernel.org ([198.145.29.99]:41816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934246AbeF0QD5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Jun 2018 12:03:57 -0400
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [PATCH v2] xfstests: fix install target using sudo
Date: Wed, 27 Jun 2018 09:03:55 -0700
Message-Id: <20180627160355.10348-1-mcgrof@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
List-ID: <fstests@vger.kernel.org>

If you install with:

	sudo make install

Depending on the system, you may see that /var/lib/xfstests/ installed
properly but /var/lib/xfstests/tests/ is empty and so your install
really is broken and not functional. Finding out what went wrong is
not obvious.

The issue is caused due to the fact that $(PWD) is used nad if sudo is used
this can be empty on some systems.

PWD is only used on one target on the xfstests build system, the
tests/*/ dir install target.

We can fix this by using $(CURDIR) instead.

This issue is observed on both Fedora and OpenSUSE, but not on Debian.

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 2611b3b845f5..11164e9ec130 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -5,7 +5,7 @@
 TOPDIR = ..
 include $(TOPDIR)/include/builddefs
 
-TESTS_SUBDIRS = $(sort $(dir $(wildcard $(PWD)/$(TESTS_DIR)/[a-z]*/)))
+TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))
 
 include $(BUILDRULES)
 
-- 
2.16.3


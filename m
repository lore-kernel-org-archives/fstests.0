Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727217AbeGSKqU (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 19 Jul 2018 06:46:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 483494062231
        for <fstests@vger.kernel.org>; Thu, 19 Jul 2018 10:03:57 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-108.pek2.redhat.com [10.72.12.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7E72026D6B
        for <fstests@vger.kernel.org>; Thu, 19 Jul 2018 10:03:54 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] Makefile: replace lowercase letters regex with POSIX character class
Date: Thu, 19 Jul 2018 18:03:49 +0800
Message-Id: <20180719100349.5968-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Latest glibc changed some rules of sorting and regexes, the usage
likes "[a-z]" maybe not only stand for lowcase letters a..z in
different locale. Similar issues include [A-Z], [0-9] and so on.

For example, in en_US.UTF-8 locale, [a-z] means aAbBcCdD...zZ,
it stands for both of uppercase and lowercase. Currently this
issue cause `make install` fails on system with new glibc.

So use POSIX character class to instead of [...] group, something
likes [:lower:], [:upper:], [:alpha:], [:alnum:], etc... are common.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

I found that there're two lines in common/config:
export LANG=C
export LC_ALL=C

That can make sure that all cases can use [a-z], [A-Z], [0-9] ...
as our expected. So we only need to fix this Makefile issue.
Due to I only find this one issue, so I'd like to use [:lower:].

If you prefer set locale in Makefile, please tell me.

Thanks,
Zorro

 tests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/Makefile b/tests/Makefile
index 11164e9e..8ce8f209 100644
--- a/tests/Makefile
+++ b/tests/Makefile
@@ -5,7 +5,7 @@
 TOPDIR = ..
 include $(TOPDIR)/include/builddefs
 
-TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[a-z]*/)))
+TESTS_SUBDIRS = $(sort $(dir $(wildcard $(CURDIR)/[[:lower:]]*/)))
 
 include $(BUILDRULES)
 
-- 
2.14.4


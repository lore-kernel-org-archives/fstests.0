Received: from mail-wm0-f67.google.com ([74.125.82.67]:52915 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751976AbdJLOyY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 Oct 2017 10:54:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id k4so14133556wmc.1
        for <fstests@vger.kernel.org>; Thu, 12 Oct 2017 07:54:23 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH v2 3/3] generic/036,208: whitelist [iomap_]dio_complete() WARNs
Date: Thu, 12 Oct 2017 16:54:04 +0200
Message-Id: <1507820044-2161-4-git-send-email-idryomov@gmail.com>
In-Reply-To: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
References: <1507820044-2161-1-git-send-email-idryomov@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Lukas Czerner <lczerner@redhat.com>
List-ID: <fstests@vger.kernel.org>

These tests appear to mix buffered and O_DIRECT I/O; easily triggered
on both xfs and ext4.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 tests/generic/036 | 2 ++
 tests/generic/208 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/036 b/tests/generic/036
index 0615dad45e37..27e9916bc13a 100755
--- a/tests/generic/036
+++ b/tests/generic/036
@@ -48,4 +48,6 @@ _require_test
 
 _run_aiodio aio-dio-fcntl-race
 
+_check_dmesg _filter_aiodio_dmesg
+
 exit $status
diff --git a/tests/generic/208 b/tests/generic/208
index f57e2bc76f8b..1768e4220e91 100755
--- a/tests/generic/208
+++ b/tests/generic/208
@@ -50,4 +50,6 @@ rm -f $seqres.full
 
 _run_aiodio aio-dio-invalidate-failure
 
+_check_dmesg _filter_aiodio_dmesg
+
 exit $status
-- 
2.4.3


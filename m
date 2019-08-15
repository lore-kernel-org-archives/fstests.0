Received: from mail-qk1-f173.google.com ([209.85.222.173]:36860 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733309AbfHOPAi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 15 Aug 2019 11:00:38 -0400
Received: by mail-qk1-f173.google.com with SMTP id d23so2122384qko.3
        for <fstests@vger.kernel.org>; Thu, 15 Aug 2019 08:00:37 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH 2/2] fstests: move generic/500 -> shared/001
Date: Thu, 15 Aug 2019 11:00:32 -0400
Message-Id: <20190815150033.15996-2-josef@toxicpanda.com>
In-Reply-To: <20190815150033.15996-1-josef@toxicpanda.com>
References: <20190815150033.15996-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

Now that generic/500 is not for all file systems, move it to shared.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 tests/generic/group                       | 1 -
 tests/{generic/500 => shared/001}         | 0
 tests/{generic/500.out => shared/001.out} | 0
 tests/shared/group                        | 1 +
 4 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/{generic/500 => shared/001} (100%)
 rename tests/{generic/500.out => shared/001.out} (100%)

diff --git a/tests/generic/group b/tests/generic/group
index 2e4a6f79..72241abc 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -502,7 +502,6 @@
 497 auto quick swap collapse
 498 auto quick log
 499 auto quick rw collapse zero
-500 auto thin trim
 501 auto quick clone log
 502 auto quick log
 503 auto quick dax punch collapse zero
diff --git a/tests/generic/500 b/tests/shared/001
similarity index 100%
rename from tests/generic/500
rename to tests/shared/001
diff --git a/tests/generic/500.out b/tests/shared/001.out
similarity index 100%
rename from tests/generic/500.out
rename to tests/shared/001.out
diff --git a/tests/shared/group b/tests/shared/group
index a8b926d8..c081eb93 100644
--- a/tests/shared/group
+++ b/tests/shared/group
@@ -3,6 +3,7 @@
 # - do not start group names with a digit
 # - comment line before each group is "new" description
 #
+001 auto thin trim
 002 auto metadata quick log
 032 mkfs auto quick
 298 auto trim
-- 
2.21.0

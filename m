Received: from mail-qt0-f170.google.com ([209.85.216.170]:33522 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752608AbeFZRIB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Jun 2018 13:08:01 -0400
Received: by mail-qt0-f170.google.com with SMTP id l10-v6so15837567qtj.0
        for <fstests@vger.kernel.org>; Tue, 26 Jun 2018 10:08:00 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id q5-v6sm909527qtq.66.2018.06.26.10.07.59
        for <fstests@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Jun 2018 10:07:59 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH] fstests: add SPDX license comments for src/log-writes/*
Date: Tue, 26 Jun 2018 13:07:58 -0400
Message-Id: <20180626170758.3348-1-josef@toxicpanda.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I apparently never bothered to put copyright or license info with this
code, just tag it as GPL 2 and I'll fix the upstream stuff as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 src/log-writes/log-writes.c | 1 +
 src/log-writes/log-writes.h | 1 +
 src/log-writes/replay-log.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/src/log-writes/log-writes.c b/src/log-writes/log-writes.c
index 5dc22c244cea..aa53473974d9 100644
--- a/src/log-writes/log-writes.c
+++ b/src/log-writes/log-writes.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <linux/fs.h>
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/src/log-writes/log-writes.h b/src/log-writes/log-writes.h
index 75fb8ac0bf79..b9f571ac3b23 100644
--- a/src/log-writes/log-writes.h
+++ b/src/log-writes/log-writes.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #ifndef _LOG_WRITES_H_
 #define _LOG_WRITES_H_
 
diff --git a/src/log-writes/replay-log.c b/src/log-writes/replay-log.c
index 8457937578d5..c16df40e5741 100644
--- a/src/log-writes/replay-log.c
+++ b/src/log-writes/replay-log.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
 #include <unistd.h>
 #include <getopt.h>
-- 
2.14.3


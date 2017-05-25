Received: from mail-pf0-f196.google.com ([209.85.192.196]:34307 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036627AbdEYT1G (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:27:06 -0400
Received: by mail-pf0-f196.google.com with SMTP id w69so41051608pfk.1
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:27:05 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 5/7] do-all, get-all: run with 'set -e'
Date: Thu, 25 May 2017 12:25:47 -0700
Message-Id: <20170525192549.138518-6-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

If one of the steps fails, we should not continue on.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 do-all  | 2 ++
 get-all | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/do-all b/do-all
index d4daad0..d6b8169 100755
--- a/do-all
+++ b/do-all
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+set -e
+
 if test -f config.custom ; then
 	. config.custom
 else
diff --git a/get-all b/get-all
index fa27229..bb1cd4c 100755
--- a/get-all
+++ b/get-all
@@ -1,5 +1,7 @@
 #!/bin/bash
 
+set -e
+
 if test -f config.custom ; then
 	. config.custom
 else
-- 
2.13.0.219.gdb65acc882-goog


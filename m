Received: from mail-wm0-f45.google.com ([74.125.82.45]:33111 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbcDKIFN (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2016 04:05:13 -0400
Received: by mail-wm0-f45.google.com with SMTP id f198so134269928wme.0
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2016 01:05:12 -0700 (PDT)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH] gitignore: add src/holetest
Date: Mon, 11 Apr 2016 11:05:06 +0300
Message-Id: <1460361906-7054-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omer Zilberberg <omzg@plexistor.com>
List-ID: <fstests@vger.kernel.org>

Recently added 450d833 (generic/338: Add mmap race test) added a new
binary, it should be added to .gitignore as well.

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index f9ea1fa..552d2a8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -60,6 +60,7 @@
 /src/getpagesize
 /src/godown
 /src/holes
+/src/holetest
 /src/itrash
 /src/locktest
 /src/loggen
-- 
2.5.5


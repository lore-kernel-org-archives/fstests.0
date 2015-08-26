Received: from nebula-exfe-02.nebula.fi ([83.145.198.164]:48936 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756321AbbHZJQY (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 26 Aug 2015 05:16:24 -0400
Message-ID: <1440580548.29614.6.camel@ari-macbook>
Subject: [PATCH 2/2] Add some missing symlinks and hardlinks requirements.
From: Ari Sundholm <ari@tuxera.com>
Date: Wed, 26 Aug 2015 12:15:48 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 tests/generic/067 |    1 +
 tests/generic/236 |    1 +
 tests/generic/294 |    1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/generic/067 b/tests/generic/067
index 7a4840b..8322ef8 100755
--- a/tests/generic/067
+++ b/tests/generic/067
@@ -52,6 +52,7 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs generic
 _supported_os Linux
+_require_test_symlinks
 _require_test
 _require_scratch
 _require_loop
diff --git a/tests/generic/236 b/tests/generic/236
index 12ea0bc..df0250f 100755
--- a/tests/generic/236
+++ b/tests/generic/236
@@ -43,6 +43,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fs generic
 # only Linux supports fallocate
 _supported_os Linux
+_require_test_hardlinks
 _require_test
 
 rm -f $TEST_DIR/ouch*
diff --git a/tests/generic/294 b/tests/generic/294
index 3fa6ba2..944b6a1 100755
--- a/tests/generic/294
+++ b/tests/generic/294
@@ -46,6 +46,7 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs generic
 _supported_os Linux
+_require_test_hardlinks
 _require_scratch
 
 rm -f $seqres.full
-- 
1.7.10.4




Received: from nebula-exfe-01.nebula.fi ([83.145.198.163]:43992 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751965AbbH1KZp (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 28 Aug 2015 06:25:45 -0400
Message-ID: <1440757504.29614.27.camel@ari-macbook>
Subject: [PATCH 2/2] Add a missing symlinks requirement.
From: Ari Sundholm <ari@tuxera.com>
Date: Fri, 28 Aug 2015 13:25:04 +0300
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
 1 file changed, 1 insertion(+)

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
-- 
1.7.10.4




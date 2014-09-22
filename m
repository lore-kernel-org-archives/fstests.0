Return-Path: <fstests-owner@vger.kernel.org>
Received: from nbl-ex10-fe01.nebula.fi ([188.117.32.121]:12036 "EHLO
	ex10.nebula.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753774AbaIVM1H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 22 Sep 2014 08:27:07 -0400
Message-ID: <1411388548.2869.18.camel@ari-macbook>
Subject: [PATCH 1/4] common/rc: dd(): Correctly redirect stderr to stdout.
From: Ari Sundholm <ari@tuxera.com>
Date: Mon, 22 Sep 2014 15:22:28 +0300
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Ari Sundholm <ari@tuxera.com>

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a5a0d29..88a9d5b 100644
--- a/common/rc
+++ b/common/rc
@@ -44,7 +44,7 @@ dd()
 {
    if [ "$HOSTOS" == "Linux" ]
    then	
-	command dd --help | grep noxfer > /dev/null 2>&1
+	command dd --help 2>&1 | grep noxfer >/dev/null
 	
 	if [ "$?" -eq 0 ]
 	    then
-- 
2.1.0




Received: from mx1.redhat.com ([209.132.183.28]:53552 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbbLDWsC (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 17:48:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id E8F124C508
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 22:48:01 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB4Mm1p2029029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 4 Dec 2015 17:48:01 -0500
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] common/punch: handle bmap output for unaligned extents
Message-ID: <56621820.5090902@redhat.com>
Date: Fri, 4 Dec 2015 16:48:00 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

xfs/242 fails if the mapping flags show unaligned extents;
fix up the regexp to allow this, we really only care about
the unwritten flag.

Signed-off-by: eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/punch b/common/punch
index be193d6..8e770f7 100644
--- a/common/punch
+++ b/common/punch
@@ -234,6 +234,11 @@ _filter_hole_fiemap()
 	_coalesce_extents
 }
 
+#     10000 Unwritten preallocated extent
+#     01000 Doesn't begin on stripe unit
+#     00100 Doesn't end   on stripe unit
+#     00010 Doesn't begin on stripe width
+#     00001 Doesn't end   on stripe width
 _filter_bmap()
 {
 	awk '
@@ -241,11 +246,11 @@ _filter_bmap()
 			print $1, $2, $3;
 			next;
 		}
-		$7 ~ /10000/ {
+		$7 ~ /1[01][01][01][01]/ {
 			print $1, $2, "unwritten";
 			next;
 		}
-		$7 ~ /00000/ {
+		$7 ~ /0[01][01][01][01]/ {
 			print $1, $2, "data"
 		}' |
 	_coalesce_extents


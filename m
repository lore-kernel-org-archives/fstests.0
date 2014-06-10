Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:39641 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932860AbaFJC6r (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 9 Jun 2014 22:58:47 -0400
Received: by mail-yh0-f54.google.com with SMTP id i57so1646164yha.41
        for <fstests@vger.kernel.org>; Mon, 09 Jun 2014 19:58:47 -0700 (PDT)
Received: from [192.168.0.129] (rrcs-97-79-21-178.se.biz.rr.com. [97.79.21.178])
        by mx.google.com with ESMTPSA id u5sm28492765yhg.25.2014.06.09.19.58.45
        for <fstests@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 19:58:46 -0700 (PDT)
Message-ID: <53967465.9050006@gmail.com>
Date: Mon, 09 Jun 2014 22:58:45 -0400
From: "Michael L. Semon" <mlsemon35@gmail.com>
MIME-Version: 1.0
Subject: [PATCH] xfstests: Enter JFS max ACL count into common/attr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Enter max ACL count into common/attr for JFS, with the purpose of
getting JFS to pass xfstests generic/026.

Signed-off-by: Michael L. Semon <mlsemon35@gmail.com>
---
 common/attr | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/attr b/common/attr
index 6fdcbf2..42a1a16 100644
--- a/common/attr
+++ b/common/attr
@@ -39,6 +39,9 @@ _acl_get_max()
 			echo 5461
 		fi
 		;;
+	jfs)
+		echo 8191
+		;;
 	*)
 		echo 0
 		;;
-- 
1.8.4


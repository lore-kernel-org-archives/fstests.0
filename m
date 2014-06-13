Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751986AbaFMVdl (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 13 Jun 2014 17:33:41 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5DLXeBK020055
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2014 17:33:40 -0400
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s5DLXde6014445
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 13 Jun 2014 17:33:40 -0400
Message-ID: <539B6E3A.4060008@redhat.com>
Date: Fri, 13 Jun 2014 16:33:46 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] generic/317,318: fail gracefully if userns not supported
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: xfstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/317 and generic/318 fail un-gracefully on older kernels
which don't support userns; fix that by running a simple test
as a prerequisite and fail gracefully if needed.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/generic/317 b/tests/generic/317
index e016a42..8919db2 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -56,6 +56,8 @@ _supported_os Linux
 [ -x $nsexec  ] || _notrun "$nsexec executable not found"
 [ -x $lstat64 ] || _notrun "$lstat64 executable not found"
 
+$nsexec -U true 2>/dev/null || _notrun "user namespaces not supported by this kernel"
+
 rm -f $seqres.full
 
 _require_scratch
diff --git a/tests/generic/318 b/tests/generic/318
index 0bfbba0..0212712 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -57,6 +57,8 @@ _supported_os Linux
 
 [ -x $nsexec ] || _notrun "$nsexec executable not found"
 
+$nsexec -U true 2>/dev/null || _notrun "user namespaces not supported by this kernel"
+
 rm -f $seqres.full
 
 _require_scratch


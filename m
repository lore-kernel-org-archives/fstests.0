Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:45261 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754063AbaFQCoH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 16 Jun 2014 22:44:07 -0400
Message-ID: <539FAB75.7000504@sandeen.net>
Date: Mon, 16 Jun 2014 21:44:05 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH V2] generic/317,318: fail gracefully if userns not supported
References: <539B6E3A.4060008@redhat.com>
In-Reply-To: <539B6E3A.4060008@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: xfstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/317 and generic/318 fail un-gracefully on older kernels
which don't support userns; fix that by running a simple test
as a prerequisite and fail gracefully if needed.

Roll that in with the test for executable presence, and make
a new _require_userns()

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

V2: _require_userns

diff --git a/common/rc b/common/rc
index f27ee53..97ac862 100644
--- a/common/rc
+++ b/common/rc
@@ -2115,6 +2115,12 @@ _require_relatime()
 	_scratch_unmount
 }
 
+_require_userns()
+{
+	[ -x src/nsexec ] || _notrun "src/nsexec executable not found"
+	src/nsexec -U true 2>/dev/null || _notrun "userns not supported by this kernel"
+}
+
 _create_loop_device()
 {
 	file=$1
diff --git a/tests/generic/317 b/tests/generic/317
index e016a42..efa37c7 100755
--- a/tests/generic/317
+++ b/tests/generic/317
@@ -53,7 +53,6 @@ _supported_fs generic
 # only Linux supports user namespace
 _supported_os Linux
 
-[ -x $nsexec  ] || _notrun "$nsexec executable not found"
 [ -x $lstat64 ] || _notrun "$lstat64 executable not found"
 
 rm -f $seqres.full
@@ -62,6 +61,7 @@ _require_scratch
 _need_to_be_root
 _require_user
 _require_ugid_map
+_require_userns
 qa_user_id=`grep $qa_user /etc/passwd |awk -F: '{print $3}'`
 
 _filter_output()
diff --git a/tests/generic/318 b/tests/generic/318
index 0bfbba0..8237434 100755
--- a/tests/generic/318
+++ b/tests/generic/318
@@ -55,8 +55,6 @@ _supported_fs generic
 # only Linux supports user namespace
 _supported_os Linux
 
-[ -x $nsexec ] || _notrun "$nsexec executable not found"
-
 rm -f $seqres.full
 
 _require_scratch
@@ -64,6 +62,7 @@ _need_to_be_root
 _acl_setup_ids
 _require_acls
 _require_ugid_map
+_require_userns
 ns_acl1=0
 ns_acl2=`expr $acl2 - $acl1`
 ns_acl3=`expr $acl3 - $acl1`


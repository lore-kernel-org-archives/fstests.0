Received: from mx1.redhat.com ([209.132.183.28]:32812 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752944AbbH1WqG (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 28 Aug 2015 18:46:06 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id C3DA7A465F
	for <fstests@vger.kernel.org>; Fri, 28 Aug 2015 22:46:05 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t7SMk46S020812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 28 Aug 2015 18:46:05 -0400
Message-ID: <55E0E4AC.5050607@redhat.com>
Date: Fri, 28 Aug 2015 17:46:04 -0500
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] properly quote strings tested with -n
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Per the Advanced Bash Scripting Guide:

"The -n test requires that the string be quoted within the test brackets.
Using an unquoted string with ! -z, or even just the unquoted string
alone within test bracket normally works, however, this is an unsafe
practice. Always quote a tested string."

And indeed:

$ unset FOOBAR
$ [ -n $FOOBAR ] || echo nope
$ [ -n "$FOOBAR" ] || echo nope
nope

Ran into this on a box w/o the attr program installed, and passed
_require_attrs.  Quoting the string fixes this; fix it there
and other occurrences in common/* as well.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/attr b/common/attr
index 48c81cc..cc9cfda 100644
--- a/common/attr
+++ b/common/attr
@@ -165,7 +165,7 @@ _filter_aces_notypes()
 
 _require_acls()
 {
-    [ -n $CHACL_PROG ] || _notrun "chacl command not found"
+    [ -n "$CHACL_PROG" ] || _notrun "chacl command not found"
 
     #
     # Test if chacl is able to list ACLs on the target filesystems.  On really
@@ -196,9 +196,9 @@ _list_acl()
 
 _require_attrs()
 {
-    [ -n $ATTR_PROG ] || _notrun "attr command not found"
-    [ -n $GETFATTR_PROG ] || _notrun "getfattr command not found"
-    [ -n $SETFATTR_PROG ] || _notrun "setfattr command not found"
+    [ -n "$ATTR_PROG" ] || _notrun "attr command not found"
+    [ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
+    [ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
 
     #
     # Test if chacl is able to write an attribute on the target filesystems.
diff --git a/common/quota b/common/quota
index 23be4f8..658b1c3 100644
--- a/common/quota
+++ b/common/quota
@@ -26,7 +26,7 @@
 #
 _require_quota()
 {
-    [ -n $QUOTA_PROG ] || _notrun "Quota user tools not installed"
+    [ -n "$QUOTA_PROG" ] || _notrun "Quota user tools not installed"
 
     case $FSTYP in
     ext2|ext3|ext4|ext4dev|reiserfs)
@@ -74,7 +74,7 @@ _require_xfs_quota()
     if [ "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_RTDEV" ]; then
 	_notrun "Quotas not supported on realtime scratch device"
     fi
-    [ -n $XFS_QUOTA_PROG ] || _notrun "XFS quota user tools not installed"
+    [ -n "$XFS_QUOTA_PROG" ] || _notrun "XFS quota user tools not installed"
 }
 
 #


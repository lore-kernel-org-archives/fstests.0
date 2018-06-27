Received: from mail.cn.fujitsu.com ([183.91.158.132]:4889 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933604AbeF0It2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 04:49:28 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 0B7924B43D3C
        for <fstests@vger.kernel.org>; Wed, 27 Jun 2018 16:49:19 +0800 (CST)
From: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
Subject: [PATCH 3/3] build: remove <attr/xattr.h> check
Date: Wed, 27 Jun 2018 16:49:13 +0800
Message-ID: <20180627084913.4730-4-lufq.fnst@cn.fujitsu.com>
In-Reply-To: <20180627084913.4730-1-lufq.fnst@cn.fujitsu.com>
References: <20180627084913.4730-1-lufq.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Since fsstress and src/t_immutable don't need attr/xattr.h, just remove
<attr/xattr.h> check.

Signed-off-by: Lu Fengqi <lufq.fnst@cn.fujitsu.com>
---
 configure.ac          |  1 -
 m4/package_attrdev.m4 | 11 -----------
 2 files changed, 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 57092f1c484b..63ea032dc564 100644
--- a/configure.ac
+++ b/configure.ac
@@ -51,7 +51,6 @@ AC_PACKAGE_NEED_XFSCTL_MACRO
 AC_PACKAGE_NEED_XFS_HANDLE_H
 
 AC_PACKAGE_NEED_ATTRLIST_LIBHANDLE
-AC_PACKAGE_NEED_ATTR_XATTR_H
 AC_PACKAGE_NEED_ATTRIBUTES_H
 AC_PACKAGE_WANT_ATTRLIST_LIBATTR
 AC_PACKAGE_NEED_GETXATTR_LIBATTR
diff --git a/m4/package_attrdev.m4 b/m4/package_attrdev.m4
index 12251ceb63c3..6bf21b1799e5 100644
--- a/m4/package_attrdev.m4
+++ b/m4/package_attrdev.m4
@@ -1,14 +1,3 @@
-AC_DEFUN([AC_PACKAGE_NEED_ATTR_XATTR_H],
-  [ AC_CHECK_HEADERS([attr/xattr.h])
-    if test "$ac_cv_header_attr_xattr_h" != "yes"; then
-        echo
-        echo 'FATAL ERROR: attr/xattr.h does not exist.'
-        echo 'Install the extended attributes (attr) development package.'
-        echo 'Alternatively, run "make install-dev" from the attr source.'
-        exit 1
-    fi
-  ])
-
 AC_DEFUN([AC_PACKAGE_NEED_ATTR_ERROR_H],
   [ AC_CHECK_HEADERS([attr/error_context.h])
     if test "$ac_cv_header_attr_error_context_h" != "yes"; then
-- 
2.18.0




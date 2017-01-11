Received: from mail-wj0-f193.google.com ([209.85.210.193]:33118 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755341AbdAKJAQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Jan 2017 04:00:16 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so89878700wjc.0
        for <fstests@vger.kernel.org>; Wed, 11 Jan 2017 01:00:16 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] Support xfstest -x group command line option
Date: Wed, 11 Jan 2017 11:00:03 +0200
Message-Id: <1484125203-12175-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Note that while kvm-xfstests -X <test> is NOT equivalent to
the check -X command line option, kvm-xfstests -x <group> is
exactly the same as check -x <group>.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 kvm-xfstests/util/parse_cli | 4 ++++
 1 file changed, 4 insertions(+)

Also via github pull request:
https://github.com/tytso/xfstests-bld/pull/3

diff --git a/kvm-xfstests/util/parse_cli b/kvm-xfstests/util/parse_cli
index b42c8ba..0956ebb 100644
--- a/kvm-xfstests/util/parse_cli
+++ b/kvm-xfstests/util/parse_cli
@@ -26,6 +26,7 @@ print_help ()
     fi
     echo "	-o opts		- Extra kernel command line options"
     echo "	-r ram		- Specify memory to be used in megabytes"
+    echo "	-x group	- Exclude group of tests from running"
     echo "	-X test		- Exclude test from running"
     echo "	--kernel file	- Boot the specified kernel"
     if test "$GCE_XFSTESTS" != "yes" ; then
@@ -155,6 +156,9 @@ while [ "$1" != "" ]; do
 	-g) shift
 	    FSTESTSET="$FSTESTSET,-g,$1"
 	    ;;
+	-x) shift
+	    FSTESTSET="$FSTESTSET,-x,$1"
+	    ;;
 	-h|--help|help)
 	    print_help
 	    ;;
-- 
2.7.4


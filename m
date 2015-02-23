Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36962 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752350AbbBWVna (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 23 Feb 2015 16:43:30 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t1NLhUpY022502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Mon, 23 Feb 2015 16:43:30 -0500
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t1NLhTub005843
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO)
	for <fstests@vger.kernel.org>; Mon, 23 Feb 2015 16:43:30 -0500
Message-ID: <54EB9F01.2020303@redhat.com>
Date: Mon, 23 Feb 2015 15:43:29 -0600
From: Eric Sandeen <sandeen@redhat.com>
MIME-Version: 1.0
Subject: [PATCH] btrfs/049 is a btrfs test, not generic
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

It's not much fun to run btrfs-specific tests on non-btrfs
filesystems.  ;)

> EXT4-fs (dm-12): Unrecognized mount option "inode_cache" or missing value

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/btrfs/049 b/tests/btrfs/049
index 3101d09..5b17a77 100755
--- a/tests/btrfs/049
+++ b/tests/btrfs/049
@@ -46,7 +46,7 @@ _cleanup()
 . ./common/dmflakey
 
 # real QA test starts here
-_supported_fs generic
+_supported_fs btrfs
 _supported_os Linux
 _need_to_be_root
 _require_scratch


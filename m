Received: from mail.kernel.org ([198.145.29.99]:58948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQWkc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 17 Apr 2019 18:40:32 -0400
From: Eric Biggers <ebiggers@kernel.org>
Subject: [xfstests-bld PATCH] test-appliance: add libzstd1 to backport-packages-stretch
Date: Wed, 17 Apr 2019 15:39:37 -0700
Message-Id: <20190417223937.31822-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Satya Tangirala <satyat@google.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The btrfs-progs package in stretch-backports recently started depending
on libzstd1, so add libzstd1 to the backport-packages-stretch file.
This fixes the following error when building test appliances:

    dpkg: dependency problems prevent configuration of btrfs-progs:
     btrfs-progs depends on libzstd1 (>= 1.3.8); however:
      Package libzstd1 is not installed.

    dpkg: error processing package btrfs-progs (--install):
     dependency problems - leaving unconfigured

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/backport-packages-stretch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kvm-xfstests/test-appliance/backport-packages-stretch b/kvm-xfstests/test-appliance/backport-packages-stretch
index a111945..621e34b 100644
--- a/kvm-xfstests/test-appliance/backport-packages-stretch
+++ b/kvm-xfstests/test-appliance/backport-packages-stretch
@@ -4,6 +4,7 @@ libcomerr2
 libcom-err2
 libext2fs2
 libss2
+libzstd1
 btrfs-progs
 f2fs-tools
 libf2fs5
-- 
2.21.0.392.gf8f6787159e-goog

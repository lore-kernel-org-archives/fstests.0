Received: from mail-pf0-f193.google.com ([209.85.192.193]:36388 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756442AbcLUSHh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 13:07:37 -0500
Received: by mail-pf0-f193.google.com with SMTP id c4so11235359pfb.3
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 10:07:37 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: include f2fs userspace tools in test appliances
Date: Wed, 21 Dec 2016 10:06:29 -0800
Message-Id: <1482343592-135031-3-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gce-xfstests-bld.sh | 1 +
 kvm-xfstests/test-appliance/xfstests-packages   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
index f041a95..c10645f 100644
--- a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
+++ b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
@@ -16,6 +16,7 @@ PACKAGES="bash-completion \
 	dump \
 	e3 \
 	ed \
+	f2fs-tools \
 	file \
 	gawk \
 	kexec-tools \
diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index 33b1f05..127897d 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -9,6 +9,7 @@ dbus
 dmsetup
 dump
 ed
+f2fs-tools
 file
 gawk
 joe-jupp
-- 
2.8.0.rc3.226.g39d4020


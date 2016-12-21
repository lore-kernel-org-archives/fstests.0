Received: from mail-pf0-f194.google.com ([209.85.192.194]:36391 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756471AbcLUSHo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 13:07:44 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so11235376pfb.3
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 10:07:43 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: include xz-utils in kvm-xfstests appliance
Date: Wed, 21 Dec 2016 10:06:30 -0800
Message-Id: <1482343592-135031-4-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

xz will be needed by one of the new encryption tests.  It was already
included in the gce-xfstests appliance, but it was missing from the
kvm-xfstests appliance.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/xfstests-packages | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index 127897d..2041b9a 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -28,3 +28,4 @@ systemd-sysv
 time
 uuid-runtime
 udev
+xz-utils
-- 
2.8.0.rc3.226.g39d4020


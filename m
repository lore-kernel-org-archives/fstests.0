Received: from mail-pg0-f68.google.com ([74.125.83.68]:33874 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756462AbcLUSHn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 13:07:43 -0500
Received: by mail-pg0-f68.google.com with SMTP id b1so17072993pgc.1
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 10:07:43 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: remove redundant listing of GCE images
Date: Wed, 21 Dec 2016 10:06:32 -0800
Message-Id: <1482343592-135031-6-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

When a GCE image is created, the same information about the new image
was being printed by both 'gcloud compute images create' and 'gcloud
compute images list'.  Fix this by removing the call to 'gcloud compute
images list'.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/test-appliance/gce-create-image | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kvm-xfstests/test-appliance/gce-create-image b/kvm-xfstests/test-appliance/gce-create-image
index 005cc8e..830dd5b 100755
--- a/kvm-xfstests/test-appliance/gce-create-image
+++ b/kvm-xfstests/test-appliance/gce-create-image
@@ -138,4 +138,3 @@ gcloud compute --project "$GCE_PROJECT" -q images create "$ROOT_FS-$DATECODE" \
 	--family "$ROOT_FS"
 gcloud compute --project "$GCE_PROJECT" -q disks delete "$BLD_DISK" \
 	--zone "$GCE_ZONE" >& /dev/null &
-gcloud compute --project "$GCE_PROJECT" -q images list --filter="family=$ROOT_FS"
-- 
2.8.0.rc3.226.g39d4020


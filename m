Received: from mail-pf0-f196.google.com ([209.85.192.196]:36604 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbdA3Vgm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 30 Jan 2017 16:36:42 -0500
Received: by mail-pf0-f196.google.com with SMTP id 19so24217428pfo.3
        for <fstests@vger.kernel.org>; Mon, 30 Jan 2017 13:36:42 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] gce-xfstests: include extra debian packages when building GCE image
Date: Mon, 30 Jan 2017 13:36:19 -0800
Message-Id: <20170130213619.14733-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Extra Debian packages in the kvm-xfstests/test-appliance/debs/ directory
were getting added to kvm-xfstests appliances but not to gce-xfstests
appliances.  Make them get added to gce-xfstests appliances as well, and
document this in gce-xfstests.md.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/gce-xfstests.md                   | 8 ++++++++
 kvm-xfstests/test-appliance/gce-create-image    | 3 +++
 kvm-xfstests/test-appliance/gce-xfstests-bld.sh | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/gce-xfstests.md b/Documentation/gce-xfstests.md
index becc23d..8985cef 100644
--- a/Documentation/gce-xfstests.md
+++ b/Documentation/gce-xfstests.md
@@ -313,6 +313,14 @@ create-image".  This will create a new GCE image with a name such as
 "xfstests-201608132226" where 201608132226 indicates when the image
 was created (in this case, August 13, 2016 at 22:26).
 
+As with kvm-xfstests, if you want to include any additional Debian
+packages, or you want to override the default Jessie packages with
+newer versions from jessie-backports, place them in the directory
+kvm-xfstests/test-appliance/debs.  See the [documentation for building
+kvm-xfstests appliances](building-rootfs.md) for more information.
+Note that gce-xfstests requires packages for the amd64 architecture;
+packages for other architectures will not be installed.
+
 This image will be created as part of an image family called xfstests.
 By default, when you start a test using gce-xfstests, the most
 recently created image in the xfstests image family will be used.
diff --git a/kvm-xfstests/test-appliance/gce-create-image b/kvm-xfstests/test-appliance/gce-create-image
index a901476..c0dfabe 100755
--- a/kvm-xfstests/test-appliance/gce-create-image
+++ b/kvm-xfstests/test-appliance/gce-create-image
@@ -104,6 +104,9 @@ then
 fi
 rm -f $t
 
+# Copy extra debian packages to GS bucket
+gsutil -m rsync -d -r debs/ gs://$GS_BUCKET/debs/
+
 gcloud compute --project "$GCE_PROJECT" -q instances delete "$BLD_INST" \
        --zone "$GCE_ZONE" 2> /dev/null
 gcloud compute --project "$GCE_PROJECT" -q disks delete "$BLD_DISK" 2> /dev/null
diff --git a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
index c10645f..563e818 100644
--- a/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
+++ b/kvm-xfstests/test-appliance/gce-xfstests-bld.sh
@@ -119,7 +119,8 @@ systemctl enable telnet-getty@ttyS1.service
 systemctl enable telnet-getty@ttyS2.service
 systemctl enable telnet-getty@ttyS3.service
 
-if gsutil -m cp gs://$BUCKET/*.deb /run
+# Install extra debian packages if any
+if gsutil -m cp gs://$BUCKET/debs/*.deb /run
 then
     dpkg -i --ignore-depends=e2fsprogs /run/*.deb
     rm -f /run/*.deb
-- 
2.11.0.483.g087da7b7c-goog


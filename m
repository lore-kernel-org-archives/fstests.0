Received: from mail-pg0-f67.google.com ([74.125.83.67]:34597 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752968AbcLUSHV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 21 Dec 2016 13:07:21 -0500
Received: by mail-pg0-f67.google.com with SMTP id b1so17072087pgc.1
        for <fstests@vger.kernel.org>; Wed, 21 Dec 2016 10:07:21 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] xfstests-bld: document how to add debian packages to GCE image
Date: Wed, 21 Dec 2016 10:06:28 -0800
Message-Id: <1482343592-135031-2-git-send-email-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/gce-xfstests.md | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/gce-xfstests.md b/Documentation/gce-xfstests.md
index becc23d..1b7fa3e 100644
--- a/Documentation/gce-xfstests.md
+++ b/Documentation/gce-xfstests.md
@@ -306,12 +306,14 @@ to be unpacked into a directory in /tmp instead.
 
 By default gce-xfstests uses the prebuilt image which is made
 available via the xfstests-cloud project.  However, if you want to
-build your own image, you must first build the xfstests tarball as
-described in the [instructions for building
-xfstests](building-xfstests.md).  Then run the command "gce-xfstests
-create-image".  This will create a new GCE image with a name such as
-"xfstests-201608132226" where 201608132226 indicates when the image
-was created (in this case, August 13, 2016 at 22:26).
+build your own image, you must first build a 64-bit (amd64) xfstests
+tarball as described in the [instructions for building
+xfstests](building-xfstests.md).  Then copy any additional Debian
+packages, for the amd64 architecture, you want to include in the GCE
+image into the root directory of GS_BUCKET.  Then run the command
+"gce-xfstests create-image".  This will create a new GCE image with a
+name such as "xfstests-201608132226" where 201608132226 indicates when
+the image was created (in this case, August 13, 2016 at 22:26).
 
 This image will be created as part of an image family called xfstests.
 By default, when you start a test using gce-xfstests, the most
-- 
2.8.0.rc3.226.g39d4020


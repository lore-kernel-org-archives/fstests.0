Received: from mail-pf0-f169.google.com ([209.85.192.169]:35857 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbcI3R1E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 30 Sep 2016 13:27:04 -0400
Received: by mail-pf0-f169.google.com with SMTP id q2so42234157pfj.3
        for <fstests@vger.kernel.org>; Fri, 30 Sep 2016 10:27:04 -0700 (PDT)
From: Eric Biggers <ebiggers@google.com>
Subject: [PATCH] [xfstests-bld] gce-do-setup: fix check for unset variables
Date: Fri, 30 Sep 2016 10:25:59 -0700
Message-Id: <1475256359-122421-1-git-send-email-ebiggers@google.com>
Sender: fstests-owner@vger.kernel.org
To: tytso@mit.edu
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 kvm-xfstests/util/gce-do-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kvm-xfstests/util/gce-do-setup b/kvm-xfstests/util/gce-do-setup
index 3fb782c..cd4cd6e 100755
--- a/kvm-xfstests/util/gce-do-setup
+++ b/kvm-xfstests/util/gce-do-setup
@@ -19,8 +19,8 @@ if ! type gcloud >& /dev/null ; then
    exit 1
 fi
 
-if test -z "$GS_BUCKET" -o -z "$GCE_PROJECT" -o -z "GCE_ZONE" \
-	-o -z "GCE_KERNEL"
+if test -z "$GS_BUCKET" -o -z "$GCE_PROJECT" -o -z "$GCE_ZONE" \
+	-o -z "$GCE_KERNEL"
 then
     echo -e "Please make sure the following configuration variables are set in"
     echo -e "~/.config/gce-xfstests or one of the other config files:"
-- 
2.8.0.rc3.226.g39d4020


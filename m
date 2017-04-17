Received: from mail-pg0-f68.google.com ([74.125.83.68]:35181 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbdDQT7F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 17 Apr 2017 15:59:05 -0400
Received: by mail-pg0-f68.google.com with SMTP id g2so29293170pge.2
        for <fstests@vger.kernel.org>; Mon, 17 Apr 2017 12:59:05 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] gce-xfstests: allow customizing creation of GCE firewall rules
Date: Mon, 17 Apr 2017 12:56:45 -0700
Message-Id: <20170417195645.74168-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Add a new config variable GCE_FIREWALL_RULES which can be overridden in
~/.config/gce-xfstests to change or disable creation of extra GCE
firewall rules like "allow-http".  This will be useful for people who
want to configure their firewall differently or are not using the
gce-xfstests web interface.

Also start creating the firewall rules synchronously and not hiding
errors.  This will be useful if someone enters incorrect syntax in
GCE_FIREWALL_RULES, causing creating a firewall rule to fail.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/gce-xfstests.md  | 12 ++++++++++++
 kvm-xfstests/config            |  4 ++++
 kvm-xfstests/util/gce-do-setup | 15 ++++++++++-----
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/Documentation/gce-xfstests.md b/Documentation/gce-xfstests.md
index 8985cef..6d053d1 100644
--- a/Documentation/gce-xfstests.md
+++ b/Documentation/gce-xfstests.md
@@ -157,6 +157,18 @@ configuration parameters in order to have reports e-mailed to you:
     control over the domain used by GCE_REPORT_EMAIL, you may need to
     choose a different sender address.
 
+Other optional parameters include:
+
+* GCE_FIREWALL_RULES
+  * List of firewall rules to add to the GCP project if not already
+    present.  By default a rule "allow-http" is created which makes
+    the gce-xfstests web interface accessible to anyone over the
+    Internet.  It may be useful to override this if you want to
+    implement more restrictive firewall rules or disable access to the
+    web interface entirely.  Note that existing firewall rules
+    associated with the GCP project will not be removed, and by
+    default there is a default-allow-ssh rule which allows SSH access.
+
 An example ~/.config/gce-xfstests might look like this:
 
         GS_BUCKET=tytso-xfstests
diff --git a/kvm-xfstests/config b/kvm-xfstests/config
index 4e7bb19..994dcd3 100644
--- a/kvm-xfstests/config
+++ b/kvm-xfstests/config
@@ -63,3 +63,7 @@ CONSOLE=" -serial mon:stdio"
 # GCE_PROJECT=tytso-xfstests-project
 # GCE_ZONE=us-central1-c
 # GCE_KERNEL=/u1/ext4-64/arch/x86/boot/bzImage
+
+# List of firewall rules to create.  By default the gce-xfstests web interface
+# is made available to everyone over the public Internet.
+GCE_FIREWALL_RULES=("allow-http --allow tcp:80 --target-tags http-server")
diff --git a/kvm-xfstests/util/gce-do-setup b/kvm-xfstests/util/gce-do-setup
index 386ea6d..80430de 100755
--- a/kvm-xfstests/util/gce-do-setup
+++ b/kvm-xfstests/util/gce-do-setup
@@ -119,9 +119,14 @@ if test -n "$GCE_REPORT_EMAIL" ; then
     fi
 fi
 
-if test -z "$(gcloud compute firewall-rules list allow-http | sed -e 1d)"
-then
-    gcloud compute --project "$GCE_PROJECT" firewall-rules create \
-	   allow-http --allow tcp:80 --target-tags http-server >& /dev/null &
-fi
+for rule in "${GCE_FIREWALL_RULES[@]}"; do
+    rule_name=$(echo $rule | cut -d' ' -f1)
+    if test -z "$(gcloud compute firewall-rules list $rule_name | sed -e 1d)"
+    then
+	echo "Creating $rule_name firewall rule..."
+	gcloud compute --project "$GCE_PROJECT" firewall-rules create $rule
+    fi
+done
+unset rule rule_name
+
 exit 0
-- 
2.12.2.762.g0e3151a226-goog


Received: from mail-pf0-f195.google.com ([209.85.192.195]:34295 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036612AbdEYT1E (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 May 2017 15:27:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so41051518pfk.1
        for <fstests@vger.kernel.org>; Thu, 25 May 2017 12:27:04 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 4/7] Makefile: always run get-all
Date: Thu, 25 May 2017 12:25:46 -0700
Message-Id: <20170525192549.138518-5-ebiggers3@gmail.com>
In-Reply-To: <20170525192549.138518-1-ebiggers3@gmail.com>
References: <20170525192549.138518-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

Run get-all as the first step of 'make all'.  We were previously running
get-all only if required repositories were missing.  But we may also
need to clone optional repositories or check out different commits in
already-cloned repositories.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Makefile | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Makefile b/Makefile
index f5e2245..6be3752 100644
--- a/Makefile
+++ b/Makefile
@@ -2,29 +2,30 @@
 # A simple makefile for xfstests-bld
 #
 
+REPOS =		fio \
+		quota \
+		stress-ng \
+		xfsprogs-dev \
+		xfstests-dev
+
 SUBDIRS =	acl \
 		android-compat \
 		attr \
 		dbench \
 		e2fsprogs-libs \
-		fio \
-		quota \
 		libaio \
 		misc \
 		popt \
-		stress-ng \
-		xfsprogs-dev \
-		xfstests-dev
+		$(REPOS)
 
 SCRIPTS =	android-xfstests.sh \
 		gce-xfstests.sh \
 		kvm-xfstests.sh
 
-all: xfsprogs-dev xfstests-dev fio quota $(SCRIPTS)
-	./build-all
 
-xfsprogs-dev xfstests-dev fio quota:
+all: $(SCRIPTS)
 	./get-all
+	./build-all
 
 $(SCRIPTS): %.sh: kvm-xfstests/%.in
 	sed -e "s;@DIR@;$$(pwd);" < $< > $@
@@ -43,7 +44,9 @@ kvm-xfstests/util/zerofree: kvm-xfstests/util/zerofree.c
 	cc -static -o $@ $< -lext2fs -lcom_err -lpthread
 
 realclean: clean
-	rm -rf xfsprogs-dev xfstests-dev fio quota *.ver
+	rm -rf $(REPOS) *.ver
 
 tarball:
 	./gen-tarball
+
+.PHONY: all clean realclean tarball
-- 
2.13.0.219.gdb65acc882-goog


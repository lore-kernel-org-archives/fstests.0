Received: from sandeen.net ([63.231.237.45]:60725 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757686AbcH3TM3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 30 Aug 2016 15:12:29 -0400
Received: from [10.0.0.4] (liberator [10.0.0.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 3191A170B5B
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2016 14:12:28 -0500 (CDT)
From: Eric Sandeen <sandeen@sandeen.net>
Subject: [PATCH] README: fix up dependency lists
Message-ID: <065a8b84-6d8c-f9c8-8b67-0084a3bfd2e7@sandeen.net>
Date: Tue, 30 Aug 2016 14:12:27 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

2 things: Make the dependency lines cut-and-paste-able with
line continuations, and fix up the Fedora deps a bit
(remove "awk" - should be "gawk" - and add a couple other
missing dependencies)

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/README b/README
index 3cac4b3..300bd28 100644
--- a/README
+++ b/README
@@ -6,15 +6,16 @@ Building Linux:
 	- cd into the xfstests directory
 	- install prerequisite packages
 	  For example, for Ubuntu:
-		"sudo apt-get install xfslibs-dev uuid-dev libtool-bin e2fsprogs
-		 automake gcc libuuid1 quota attr libattr1-dev make
-		 libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench
-		 uuid-runtime"
+		sudo apt-get install xfslibs-dev uuid-dev libtool-bin \ 
+		e2fsprogs automake gcc libuuid1 quota attr libattr1-dev make \
+		libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
+		uuid-runtime
 	  For Fedora, RHEL, or CentOS:
-		"yum install acl attr awk bc dbench dump e2fsprogs fio gawk
-		 indent lvm2 psmisc quota sed xfsdump xfsprogs
-		 libacl-devel libattr-devel libaio-devel libuuid-devel
-		 openssl-devel xfsprogs-devel btrfs-progs-devel"
+		yum install acl attr automake bc dbench dump e2fsprogs fio \
+		gawk gcc indent libtool lvm2 make psmisc quota sed \
+		xfsdump xfsprogs \
+		libacl-devel libattr-devel libaio-devel libuuid-devel \
+		openssl-devel xfsprogs-devel btrfs-progs-devel
 		(Older distributions may require xfsprogs-qa-devel as well.)
 		(Note that for RHEL and CentOS, you may need the EPEL repo.)
 	- run make


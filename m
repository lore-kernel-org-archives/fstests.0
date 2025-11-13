Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D5322157B
	for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034722; cv=none; b=VjMtoNoUdJp2r3mhlM6MEbb9UDMyuYqfA1tYcvQ/Vg7qABfidW0bspfLW+Sk8cjeaCz1BK1acdqsxQuEEF/UUiqWbrEq9NkBjNygh5z499Fn3Qeq/Kup/UCqbr4LtSZilAxBR7ht1N4MrFMiYQZc6P3HzCXRF/oTWxeMnv/q2us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034722; c=relaxed/simple;
	bh=YXJvfN1jxopK0p/AQ6GZzWk5pbDMiRMhHcy0zDwNn1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bOdKlwRrFF+e7lJEVkQK+TtADFMo/EwmGEdNckntWki6O2M8yg0yGPkdzjpqkn5hjQO1oH5sNvMr9mNDMFYoBBi8gcLR0qCRYnRACUYtMWRduD7/8fpkrgImcD7Of63sq9wrY+59d3qtwJzcCG4CdmDYPHYLCc3dBxeVZSyRCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCM8KV+/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lEiMLoxk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCM8KV+/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lEiMLoxk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBqzIIFLzKA6ktqbJ0neX3QGtNEe7qUDgzPZycedjg0=;
	b=MCM8KV+/CjdvIbNkVXLcCFPfM9XZLSvIO+cBfJ5MpsJ4c2u1PkDC1zTok1kxqT5f67ZXdf
	Q4Vpx73GI7albqWMwGX9r8DaNA9nZbe/+0oFkPcpjoVFgBRzXi+tcOAsIfVgSGJ+sWKdQg
	16LWC91X5jhxzpYfQbf66GGHlSFcGP0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-8GFt08eBM82led9g_x2LVg-1; Thu, 13 Nov 2025 06:51:58 -0500
X-MC-Unique: 8GFt08eBM82led9g_x2LVg-1
X-Mimecast-MFC-AGG-ID: 8GFt08eBM82led9g_x2LVg_1763034718
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ed6ff3de05so21748891cf.3
        for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 03:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763034717; x=1763639517; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBqzIIFLzKA6ktqbJ0neX3QGtNEe7qUDgzPZycedjg0=;
        b=lEiMLoxkgnGG0ZtGIFAdtflsV7KufT18g9fHQc2yy2azQRuRC73UXw4MvmqqMCcWE7
         JQwTwcTeqSEOo0KoUFJ7V36Nnco3OytpPiESMUZm3CiqGpRxkDh70eSFo8vjnLU1wWh9
         J1LX83D3rSBV+dVEgANhtN2+Z/F56Whmjo03zV5jufvCLQGz2JOlIB5lNi61Ee9PfKqX
         mX6jV68sOCUyB3diZ65LRPzOeAL0isTnuWmpVB2TgwYleprtPf3U4F0hT+3Lab61DhKk
         95hMxjf8ZzPnpeXGxlFrgzIuwS2nyDwW0rue0OIfvh3r8HKBPxJ0x3L9sYpUIkvflNK3
         b1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763034717; x=1763639517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBqzIIFLzKA6ktqbJ0neX3QGtNEe7qUDgzPZycedjg0=;
        b=U/v9L8Ow6I+fucWubdGvXFeUBXKKB3LBjgU3BkKkgmAc3wV4vnYmMm5CRUGDiK4LIr
         q2ErIRYlZDM0BeFkaqvZadkV82qYJoEgc2fBqpKm/FVZbECQfGZaUVhHI6Lz5AAyFJ+s
         w+9azQyoDRGkA7CwKFgYYJTn4zDQhESdfQXDVZna3OPZjmkLSldZScQ1+asZp5Rycg1o
         B8C4OK8+1gg5fhZjSSgqqZ8DiNYoh/vQ0Y/oKbLkfZIDT7OIxsZM8BcIyLyX8Y/buLan
         VlstCUJXw3zPrtD6c0fgqQyy5DFQykRfXI/k6vyiS1jN4/AsJor0Cqjjy37KBSl3Z+0B
         kXvQ==
X-Gm-Message-State: AOJu0YzM5Xqv01iENqhMENyQMJ8/cRrXQvTS3hl9hcbMWRKHLLZ3n2Yf
	Hd4iPnNJyxJ/AvfMeeLIw3eVgqVp5GqCtWBIT/d2VxpkHqVBBoU2oHIf/WxHoNkEes27jFSjeFC
	Kn3wiP+CNKloipDGh2B8pD1twaJ83TFRBYhF58JkE6Ms+qbIQWOLMQKv3jTrCLXBrerbs9ftQmK
	R5SX0pZz1XxpB6b85R8JRwXVMA7VEx3OZ7z1+SOajU4jvqzg==
X-Gm-Gg: ASbGncvgx/aqxHzJe4as/xZzTGT17jnru1TI+C8zJYw56pvoaDk2Adi2kHs0qN2Hu/P
	bnL64slGsjY/wBeipf7XRhuVx91Eg/W7a8+gFQOFBeNdyxyN7Gn09bpCPaztLMbtSK5pZ9zEYs2
	aty9Q7GC6Do0zI1xuG9Ju6ye6sc4J1jgJb4Up4PLVMvzZbVlslFZ7bCXyGbQ/d/XH03xf4iWQEd
	JUxlf911mnh+USi5Fcn7bfhB9GIvxiwE8JWN4S9g4qRwFgf0NO0mhU9CQcIoIqzdxKS6jLd+E2A
	6xaplFOHocGDO5gYHjjjI72eWDHyBCWfeaLPedNRQEKUBF+exgWHO7Jx84wShCL+HJKp54g=
X-Received: by 2002:a05:622a:1190:b0:4ed:ae38:6592 with SMTP id d75a77b69052e-4eddbe21298mr83740361cf.79.1763034716836;
        Thu, 13 Nov 2025 03:51:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZy3xtVVyojrWDpqj3k+OhLQrefqFLzZf3+c4yBDmyZf3Pg8m3FuqHWnk0GPaz+z1bPNxHhQ==
X-Received: by 2002:a05:622a:1190:b0:4ed:ae38:6592 with SMTP id d75a77b69052e-4eddbe21298mr83740141cf.79.1763034716272;
        Thu, 13 Nov 2025 03:51:56 -0800 (PST)
Received: from fedorakvm ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8828652d941sm10112246d6.30.2025.11.13.03.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:51:55 -0800 (PST)
From: Ravi Singh <ravising@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH v2 1/1] README: improve README formatting and clarity
Date: Thu, 13 Nov 2025 06:51:35 -0500
Message-ID: <20251113115135.609307-2-ravising@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113115135.609307-1-ravising@redhat.com>
References: <20251113115135.609307-1-ravising@redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Standardize shell command prompts with '#' for readability
- Correct minor typos
- Clarify instructions for running tests.

Signed-off-by: Ravi Singh <ravising@redhat.com>
---
 README | 70 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/README b/README
index 9e9afe3c..fd27812e 100644
--- a/README
+++ b/README
@@ -97,8 +97,8 @@ Ubuntu or Debian
 
 1. Make sure that package list is up-to-date and install all necessary packages:
 
-   $ sudo apt-get update
-   $ sudo apt-get install acl attr automake bc dbench dump e2fsprogs fio gawk \
+   # sudo apt-get update
+   # sudo apt-get install acl attr automake bc dbench dump e2fsprogs fio gawk \
         gcc git indent libacl1-dev libaio-dev libcap-dev libgdbm-dev libtool \
         libtool-bin liburing-dev libuuid1 lvm2 make psmisc python3 quota sed \
         uuid-dev uuid-runtime xfsprogs linux-headers-$(uname -r) sqlite3 \
@@ -106,7 +106,7 @@ Ubuntu or Debian
 
 2. Install packages for the filesystem(s) being tested:
 
-   $ sudo apt-get install exfatprogs f2fs-tools ocfs2-tools udftools xfsdump \
+   # sudo apt-get install exfatprogs f2fs-tools ocfs2-tools udftools xfsdump \
         xfslibs-dev
 
 Fedora
@@ -114,14 +114,14 @@ Fedora
 
 1. Install all necessary packages from standard repository:
 
-   $ sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
+   # sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
         gdbm-devel git indent kernel-devel libacl-devel libaio-devel \
         libcap-devel libtool liburing-devel libuuid-devel lvm2 make psmisc \
         python3 quota sed sqlite udftools  xfsprogs
 
 2. Install packages for the filesystem(s) being tested:
 
-    $ sudo yum install btrfs-progs exfatprogs f2fs-tools ocfs2-tools xfsdump \
+    # sudo yum install btrfs-progs exfatprogs f2fs-tools ocfs2-tools xfsdump \
         xfsprogs-devel
 
 RHEL or CentOS
@@ -133,7 +133,7 @@ RHEL or CentOS
 2. Install all necessary packages which are available from standard repository
    and EPEL:
 
-   $ sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
+   # sudo yum install acl attr automake bc dbench dump e2fsprogs fio gawk gcc \
         gdbm-devel git indent kernel-devel libacl-devel libaio-devel \
         libcap-devel libtool libuuid-devel lvm2 make psmisc python3 quota sed \
         sqlite udftools xfsprogs
@@ -148,10 +148,10 @@ RHEL or CentOS
 4. Install packages for the filesystem(s) being tested:
 
     For XFS install:
-     $ sudo yum install xfsdump xfsprogs-devel
+     # sudo yum install xfsdump xfsprogs-devel
 
     For exfat install:
-     $ sudo yum install exfatprogs
+     # sudo yum install exfatprogs
 
     For f2fs build and install:
      - see https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git/about/
@@ -164,25 +164,25 @@ SUSE Linux Enterprise or openSUSE
 
 1. Install all necessary packages from standard repositories:
 
-   $ sudo zypper install acct automake bc dbench duperemove dump fio gcc git \
+   # sudo zypper install acct automake bc dbench duperemove dump fio gcc git \
         indent libacl-devel libaio-devel libattr-devel libcap libcap-devel \
         libtool liburing-devel libuuid-devel lvm2 make quota sqlite3 xfsprogs
 
 2. Install packages for the filesystem(s) being tested:
 
     For btrfs install:
-     $ sudo zypper install btrfsprogs libbtrfs-devel
+     # sudo zypper install btrfsprogs libbtrfs-devel
 
     For XFS install:
-     $ sudo zypper install xfsdump xfsprogs-devel
+     # sudo zypper install xfsdump xfsprogs-devel
 
 Build and install test, libs and utils
 --------------------------------------
 
-$ git clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
-$ cd xfstests-dev
-$ make
-$ sudo make install
+# git clone git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
+# cd xfstests-dev
+# make
+# sudo make install
 
 Setup Environment
 -----------------
@@ -216,12 +216,14 @@ Setup Environment
 5. Copy local.config.example to local.config and edit as needed. The TEST_DEV
    and TEST_DIR are required.
 
+   # cp local.config.example local.config
+
 6. (optional) Create fsgqa test users and groups:
 
-   $ sudo useradd -m fsgqa
-   $ sudo useradd 123456-fsgqa
-   $ sudo useradd fsgqa2
-   $ sudo groupadd fsgqa
+   # sudo useradd -m fsgqa
+   # sudo useradd 123456-fsgqa
+   # sudo useradd fsgqa2
+   # sudo groupadd fsgqa
 
    The "123456-fsgqa" user creation step can be safely skipped if your system
    doesn't support names starting with digits, only a handful of tests require
@@ -251,7 +253,7 @@ For example, to run the tests with loopback partitions:
 
 The config for the setup above is:
 
-    $ cat local.config
+    # cat local.config
     export TEST_DEV=/dev/loop0
     export TEST_DIR=/mnt/test
     export SCRATCH_DEV=/dev/loop1
@@ -316,7 +318,7 @@ Tools specification:
       test, if the kernel supports kmemleak.
  - fsstress:
     - Set FSSTRESS_AVOID and/or FSX_AVOID, which contain options added to
-      the end of fsstresss and fsx invocations, respectively, in case you wish
+      the end of fsstress and fsx invocations, respectively, in case you wish
       to exclude certain operational modes from these tests.
  - core dumps:
     - Set COREDUMP_COMPRESSOR to a compression program to compress crash dumps.
@@ -378,25 +380,27 @@ ______________________
 
 Running tests:
 
-    - cd xfstests
+    - # cd xfstests-dev
     - By default the tests suite will run all the tests in the auto group. These
       are the tests that are expected to function correctly as regression tests,
       and it excludes tests that exercise conditions known to cause machine
       failures (i.e. the "dangerous" tests).
-    - ./check '*/001' '*/002' '*/003'
-    - ./check '*/06?'
-    - Groups of tests maybe ran by: ./check -g [group(s)]
+          # ./check
+    - Running specific tests:
+          # ./check '*/001' '*/002' '*/003'
+          # ./check '*/06?'
+    - Groups of tests maybe ran by: # ./check -g [group(s)]
       See the tests/*/group.list files after building xfstests to learn about
       each test's group memberships.
     - If you want to run all tests regardless of what group they are in
-      (including dangerous tests), use the "all" group: ./check -g all
-    - To randomize test order: ./check -r [test(s)]
+      (including dangerous tests), use the "all" group: # ./check -g all
+    - To randomize test order: # ./check -r [test(s)]
     - You can explicitly specify NFS/AFS/CIFS/OVERLAY, otherwise
       the filesystem type will be autodetected from $TEST_DEV:
-        - for running nfs tests: ./check -nfs [test(s)]
-        - for running afs tests: ./check -afs [test(s)]
-        - for running cifs/smb3 tests: ./check -cifs [test(s)]
-        - for overlay tests: ./check -overlay [test(s)]
+        - for running nfs tests: # ./check -nfs [test(s)]
+        - for running afs tests: # ./check -afs [test(s)]
+        - for running cifs/smb3 tests: # ./check -cifs [test(s)]
+        - for overlay tests: # ./check -overlay [test(s)]
           The TEST and SCRATCH partitions should be pre-formatted
           with another base fs, where the overlay dirs will be created
 
@@ -438,7 +442,7 @@ Test script environment:
 	    $TEST_DEV.
 
 	(b) mkfs a new XFS filesystem on $SCRATCH_DEV, and mount this
-	    on $SCRATCH_MNT. Call the the _require_scratch function
+	    on $SCRATCH_MNT. Call the _require_scratch function
             on startup if you require use of the scratch partition.
             _require_scratch does some checks on $SCRATCH_DEV &
             $SCRATCH_MNT and makes sure they're unmounted. You should
@@ -507,7 +511,7 @@ Test script environment:
 	initialise the test environment correctly, the the build infrastructure
 	also scans the test files for _begin_fstests invocations. It does this
 	to compile the group lists that are used to determine which tests to run
-	when `check` is executed. In other words, test files files must call
+	when `check` is executed. In other words, test files must call
 	_begin_fstest with their intended groups or they will not be run.
 
 	However, because the build infrastructure also uses _begin_fstests as
-- 
2.51.1


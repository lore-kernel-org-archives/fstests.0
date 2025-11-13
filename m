Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76308348893
	for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763034561; cv=none; b=DIWEAD+0EI7O7zVIvKwdhiQuJZCRfVH1PcdN+VwiyNp6CbrrSKHLK81j4/sZ70KdscbkDe8ZZuzc4fzJvTD//uoBefjwaz2jYUDGAfWhJ/GsAM9Fo6uHN0XOMuAPIDVzAv3BChEkxtTjRcDgDwRtr9EK1+AXGDIisQR4xXklY0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763034561; c=relaxed/simple;
	bh=YXJvfN1jxopK0p/AQ6GZzWk5pbDMiRMhHcy0zDwNn1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ben4lYRhuxFL1SeXQD0gAIp0OtpF/p7twbTkz5MpcqWtXQQ4X0lWANM/mPxSJCzr7q+2DYXpZc2zArlquFtkHnN1/VGkVzaAG9dhDRLtoE6QEmuLPEGunbKGheJ2s3zY56GMlFw/x0gC7Wc/HYAy74dbnS0NEWmfH+8x153uiOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P3RL1A5X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+yM+9x8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P3RL1A5X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+yM+9x8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763034558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RBqzIIFLzKA6ktqbJ0neX3QGtNEe7qUDgzPZycedjg0=;
	b=P3RL1A5X7I4CYVWUKlG/67CqpoZ7HooAA4Sa7Mu51wtKut15jILV/RFtKL/cWpVT3Yojzd
	ykDznIVaNbZjMWQ+Px3vx/8ExJEPMaTJsrJdSuBWXdQ+mBTvv5Z8Tvog+1j4rfsdYWOOMO
	JOnflSrw3JAawtXpdpw+bIRqj1+hQwk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-LIrM-pu2NMq5EoIlqt3a4A-1; Thu, 13 Nov 2025 06:49:17 -0500
X-MC-Unique: LIrM-pu2NMq5EoIlqt3a4A-1
X-Mimecast-MFC-AGG-ID: LIrM-pu2NMq5EoIlqt3a4A_1763034557
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b225760181so101393485a.2
        for <fstests@vger.kernel.org>; Thu, 13 Nov 2025 03:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763034556; x=1763639356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBqzIIFLzKA6ktqbJ0neX3QGtNEe7qUDgzPZycedjg0=;
        b=O+yM+9x8fYZgk6fORPc9r7JFsAE1FvKdvtUhgE2jeF6oVmKoKeROj0RIqtZe0pC+3K
         2pEcrRqtv1eaphsYRzFk4zbOvAP6YKINTQk31mETR0tnNvGSGc2B2AHUOlZKBymwbCYZ
         BC7xkrqmam4YHGa2FdBWNlkoSLvWpA15wP76UovNTF9o3MsRMXM40kRm3Hz2Wj7GrYiQ
         qVqxccnQ6MCbtBQAL8koCAaRGnHB+q6Dib8XPEfVfVL95PPpFob7Nld4w/sBVKPK/jt0
         JZUu9JxlngX1PLBkA68EfNXtBFgote7oCm6H4bX+zuK/2jbHSnziCKxi5RhKeJbdipMD
         I06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763034556; x=1763639356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RBqzIIFLzKA6ktqbJ0neX3QGtNEe7qUDgzPZycedjg0=;
        b=PmbhxrvpqvphXJeOlsKklU6pf+H+vzzt9FND1YyzRX8kva68ISq8hrCDluihZOgJiH
         sC/rry5ZZh8BsuTIlIL6g8MwNJNwQ7W39gNLCWG5Fjf1m21Up++pc/WiXCUblNSAf6o2
         HIrszXgC8/wN3ksFbI2+RvgPlggukWuz7AtR3xQLMVXNWPE9W2PS5FEgzWVGG0SQe4oH
         EJI62Ne2WrOGmu/ysAom1gVPP7yKfv5RLlQQIWBXTezt7zmK9QFdPRPQi8RAcDUh5Omh
         KvISXhGzqI2jGh7NY4Q9jGiAVSJoKRyJNRmOLrh8GN8J/5dpLPJjVGeEchw/D+JyoDv7
         9/Pg==
X-Gm-Message-State: AOJu0Yx+I+9iydqxEFsRsOtUtimTD5vOpk1Vb88hw70PE/evdSeJzOrI
	cy/lVQUCUiHTvrbuO18+Xsa4RkTeGr5KejaBAWMLs52QLBDLO+XX414pymlUZhXxX2W8+ZryoFV
	g9eCPk8pcf30qjRcjU92ENiMOs02Z8mh1+lgTKnAKek94a4juXd30sAYiOjPNeYROhYs///vr9N
	3ztpC60F2DmbCYtb9WpNkzg1nfsd9+xpUSDIBUetx16c8vtw==
X-Gm-Gg: ASbGnctdXD4JlJRJENQ9PjhJ44EjG4ViejLR8iaLrDHUSTceuwBo9+fb4ZjIOAig2SV
	dw8pzEkeq/fQm/bFLOf2XmQLPnWmzwRxTq3CFjBxOrdjVeRJrMZIjU3N+B2nx4v5M0P8bl96AyA
	yRjLEj63+/vUeC1s1fc1YU9sG/7bsxGh5Jt2Cr6+KZQ9YdkqtJlCUsNh9lSHs1NNs5ehWhV6/s9
	3rsjQa2WIKrM5GXcICJC8/68UR0kZ9Fn+oK1w1KzQZZyNVriVfMIcun7EqRH7dc8Gj8vea39ArI
	GrhEmKZuEN9CR8ZWnv/VCifEzEQ/pT9LgHtZqD+IAVdZamNzEDfz/z2le4FtzinHepVFjAg=
X-Received: by 2002:a05:620a:199b:b0:8b2:621b:fa4b with SMTP id af79cd13be357-8b29b8318a6mr874046485a.76.1763034555986;
        Thu, 13 Nov 2025 03:49:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFahQwMy4VrHTRCXehamQMEwpf0yJGuq7wu+G0k3TKybqgcaAUHYugm5YY2w/jxMziwvYWScg==
X-Received: by 2002:a05:620a:199b:b0:8b2:621b:fa4b with SMTP id af79cd13be357-8b29b8318a6mr874043985a.76.1763034555436;
        Thu, 13 Nov 2025 03:49:15 -0800 (PST)
Received: from fedorakvm ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2af044e3asm110330585a.41.2025.11.13.03.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 03:49:14 -0800 (PST)
From: Ravi Singh <ravising@redhat.com>
To: fstests@vger.kernel.org
Cc: djwong@kernel.org
Subject: [PATCH v2 1/1] README: improve README formatting and clarity
Date: Thu, 13 Nov 2025 06:48:53 -0500
Message-ID: <20251113114853.609289-2-ravising@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113114853.609289-1-ravising@redhat.com>
References: <20251112181859.GF196366@frogsfrogsfrogs>
 <20251113114853.609289-1-ravising@redhat.com>
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


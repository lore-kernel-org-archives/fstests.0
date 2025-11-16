Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566D0FBF6
	for <fstests@vger.kernel.org>; Sun, 16 Nov 2025 18:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763318763; cv=none; b=tg3DYIZOE6Ql/J0b25peezOMTEshofTwJ9kFyIg+CxCSZsk5xdvYjUYXOKH2iljCDMhjulfSSXTI28+FlaKaeqWqT1dKpnBWIpkrknTVeG/MiX82HZg/ikjtPkcEDBNBYSQ6h9f7dSg/9dA0pKl3jQcZSrjqYEPttQ0eGz4qMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763318763; c=relaxed/simple;
	bh=Bk9naF0zuJxMw7QWLGQQBSMUi717praaOhWlpDFru4I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iGjTRw9N5dffAhQDRkmlYGErCUrDpf+zNzsqTEgcCf0uxq49fIKU55+Fqrvh6s832hORWc3Q/zTtrqWG3tM4uUGngZX7XfeJMhEMx2cadY18wtc9R4S0CznomeaO8Wao9iGK4NZF51N0Japb8HvGNubSGznKArT/OrTxcw+iTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wxs6RjbA; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wxs6RjbA"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b735487129fso544287866b.0
        for <fstests@vger.kernel.org>; Sun, 16 Nov 2025 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763318759; x=1763923559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=O+eKWsDC01r+QK4yi2rlNZ5dZGdxG0CXzn//yheEVB8=;
        b=Wxs6RjbA/aqhnjVC0veE2HNgTwrFnRiX2ittW6w3V6nsKQ3xZqOrl1UAgFBJYJ7Cmw
         3r5lUkj/7S3Lo5PDRLaCj6jsgkxenm/qHAF/RvVkDFz+JdfoY8gRFXoeRShYi66t088I
         TEe3531ptZMVmZlbYD6mD+fe3O/FOTOR+ClLotw1roxs9N++mgHwWlj1J1+H9gdLNWTn
         Wtr2MnZQn/2l5hOh3XUEHvoXoqr00nrUGO/sdlDhtuyacQ/fgmvh+s+k0bh++nNyVnkY
         7COLSwz5zi4VJHkGkM/z7XW3WOQmdrBbRPt0x926cxOxZNufbeS7yhlh7V5I2envS+gF
         CbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763318759; x=1763923559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+eKWsDC01r+QK4yi2rlNZ5dZGdxG0CXzn//yheEVB8=;
        b=b9WZWaU0RhAN+jsSAV2qH8kvJd2bUiYqLGlstcpQGIYxor3Bx5k3n121Yvq+8sfL0+
         0X2UraEuxA/kva60YSm6UKqBFAOa0F+bwQkGmMucHfgrYkBo8nYBv34BepgrotA7LvCa
         6Bav1i8n7Mag2Ob+pvhh05vSz6EBt6YIh6hHON3fHHbwlEj4FwK609pC64NsumVyfVhd
         IVUkzmo/+f9dykIlJ/fWXvyNcD47l8LzpsIqO7rFgD60BOyYbbY4oDUBSE2MU0BV9Fm7
         T7G+4jS/7svZD5gvYzPB65/nWjAp0Xit1w+CnAuHR6izTfW30OtnqYC90df76peMxTtm
         1UTA==
X-Gm-Message-State: AOJu0Yw04UBw1vP1eMT5d1IVPhBOng4e3iOdRX4iB8hYz6Keu9zfOVSh
	RFtuByluSPz79LsJNHVLdjgTotfe3TfolmGrQ63mZc7W0Ta7K4Nq/GaNxoaRSg==
X-Gm-Gg: ASbGncvHmDy0Hwhx9IXuJqhuKyIaFWCsdCrl8cTLz7PJdJ2+ME6kGYGQ0djC+4mtJdB
	ekMSHVFSy1I7lrlQ7dxayYMGneOzNXmQD+5785IuW1SXnJ3DLW+TrMa0JGT/hvSl2Nb6FqO6pcy
	X84hyAzkle+Cr6KpKFxbyAskS/nlVcqBx4dzQo494zvNxZf9PYngMzLhX2IdRDzQgG8SE2ajCeM
	OpozKDxP+xiqGVmXCSF0UGU/p3kzVqvRxidJj5eKZPt8+UTdO2LnOLPS76eNeNHwXiG98s3iQ49
	dr/pW7lU5y53NHP4V/6RD18+E9AfasKYwjMGlNi46npmZ+ynM1c34tE4L6hRzAOlMuSKj4NTvgt
	Sg/VJakybyNOMbadVz1+X+CZltE0ek8jyVNUdG86rXdZTyo1itk0pvvrY+nkh9n34lHIzmOJQqG
	KuwLNT8UG7kPeDQtJilR21nVRQlBOZ6KAs4DrMOtsqmVMSQYq/aJXTqsI6dpuBOmoEnKUEeJdw8
	L/Vu5whaZClF8pU
X-Google-Smtp-Source: AGHT+IGD0RHm0+nhpu4+Y1khYHf2GSnbLVVzF4WQvhxM7cw50Qu4GZaUH0ObC5+TtBA86T+oFof+GA==
X-Received: by 2002:a17:907:7faa:b0:b73:88a2:91db with SMTP id a640c23a62f3a-b7388a2984dmr399012866b.19.1763318759106;
        Sun, 16 Nov 2025 10:45:59 -0800 (PST)
Received: from brikett (2a02-8388-180a-cd80-ae73-baa1-6de4-2169.cable.dynamic.v6.surfer.at. [2a02:8388:180a:cd80:ae73:baa1:6de4:2169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81275sm892777466b.13.2025.11.16.10.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 10:45:58 -0800 (PST)
From: Jakob Unterwurzacher <jakobunt@gmail.com>
To: fstests@vger.kernel.org,
	jakobunt@gmail.com
Subject: [PATCH] fstests: add fuse.gocryptfs support
Date: Sun, 16 Nov 2025 19:45:38 +0100
Message-ID: <20251116184545.3450048-1-jakobunt@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add instructions for testing gocryptfs, an encrypted overlay filesystem,
and a few small changes that were needed for gocryptfs compatibility:

1) _scratch_unmount and _test_unmount now unmount fuse filesystems
via mountpoint instead of via device. Unmounting via device fails when
the "device" is actually a directory on a different filesystem.
Unmounting via mountpoint always works.

2) Add subtype=passthrough_ll to the passthrough_ll mount options.
This makes passthrough_ll behave more like most other fuse filesystems
which do set a subtype. Example from my Fedora box:

	$ mount | grep -o "type fuse\\..* "
	type fuse.gvfsd-fuse
	type fuse.portal
	type fuse.gocryptfs
	type fuse.encfs
	type fuse.passthrough_ll

With this change, _check_mounted_on can match on $FSTYP$FUSE_SUBTYP
for passthrough_ll, which also works for gocryptfs and likely most
other fuse filesystems.

Results for passthrough_ll on top of tmpfs:

	Failures: generic/120 generic/125 generic/184 generic/294 generic/306 generic/317 generic/355
	generic/363 generic/426 generic/434 generic/452 generic/467 generic/477 generic/633 generic/647
	generic/653 generic/675 generic/683 generic/684 generic/729 generic/745 generic/751 generic/756
	generic/777
	Failed 24 of 769 tests

Results for gocryptfs on top of tmpfs:

	Failures: generic/020 generic/062 generic/093 generic/099 generic/103 generic/120 generic/125
	generic/184 generic/285 generic/294 generic/306 generic/317 generic/319 generic/426 generic/434
	generic/444 generic/452 generic/467 generic/471 generic/477 generic/633 generic/676 generic/683
	generic/688 generic/696 generic/697 generic/707 generic/756 generic/777
	Failed 29 of 769 tests

Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 README.fuse | 34 ++++++++++++++++++++++++++++++++--
 common/rc   | 11 ++++++++++-
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/README.fuse b/README.fuse
index 969dbd5d..df248681 100644
--- a/README.fuse
+++ b/README.fuse
@@ -1,3 +1,6 @@
+passthrough_ll
+==============
+
 Here are instructions for testing fuse using the passthrough_ll example
 filesystem provided in the libfuse source tree:
 
@@ -22,5 +25,32 @@ export SCRATCH_DEV=non2
 export SCRATCH_MNT=/mnt/scratch
 export FSTYP=fuse
 export FUSE_SUBTYP=.passthrough_ll
-export MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
-export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
+export MOUNT_OPTIONS="-osource=/home/test/scratch,subtype=passthrough_ll,allow_other,default_permissions"
+export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,subtype=passthrough_ll,allow_other,default_permissions"
+
+
+gocryptfs
+=========
+
+Here are the instructions for gocryptfs:
+
+git clone https://github.com/rfjakob/gocryptfs.git
+cd gocryptfs
+./build.bash
+cat << EOF | sudo tee /sbin/mount.fuse.gocryptfs
+#!/bin/bash
+exec $(pwd)/gocryptfs -q -allow_other -acl -extpass "echo test" "\$@"
+EOF
+sudo chmod +x /sbin/mount.fuse.gocryptfs
+mkdir -p /mnt/gocryptfs.test /mnt/gocryptfs.scratch /home/test/gocryptfs.test /home/test/gocryptfs.scratch
+gocryptfs -init -q -scryptn=10 -extpass "echo test" /home/test/gocryptfs.test
+gocryptfs -init -q -scryptn=10 -extpass "echo test" /home/test/gocryptfs.scratch
+
+Use the following local.config file:
+
+export TEST_DEV=/home/test/gocryptfs.test
+export TEST_DIR=/mnt/gocryptfs.test
+export SCRATCH_DEV=/home/test/gocryptfs.scratch
+export SCRATCH_MNT=/mnt/gocryptfs.scratch
+export FSTYP=fuse
+export FUSE_SUBTYP=.gocryptfs
diff --git a/common/rc b/common/rc
index 8fd7876a..da8be16e 100644
--- a/common/rc
+++ b/common/rc
@@ -512,6 +512,11 @@ _scratch_unmount()
 	tmpfs)
 		_unmount $SCRATCH_MNT
 		;;
+	fuse)
+		# The "source device" can be an arbitrary string for fuse filesystems
+		# and may not be unique. Unmount by mountpoint instead.
+		_unmount $SCRATCH_MNT
+		;;
 	*)
 		_unmount $SCRATCH_DEV
 		;;
@@ -703,6 +708,10 @@ _test_unmount()
 {
 	if [ "$FSTYP" == "overlay" ]; then
 		_overlay_test_unmount
+	elif [ "$FSTYP" == "fuse" ]; then
+		# The "source device" can be an arbitrary string for fuse filesystems
+		# and may not be unique. Unmount by mountpoint instead.
+		_unmount $TEST_DIR
 	else
 		_unmount $TEST_DEV
 	fi
@@ -5021,7 +5030,7 @@ init_rc()
 
 	# Sanity check that TEST partition is not mounted at another mount point
 	# or as another fs type
-	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP || _exit 1
+	_check_mounted_on TEST_DEV $TEST_DEV TEST_DIR $TEST_DIR $FSTYP$FUSE_SUBTYP || exit 1
 	if [ -n "$SCRATCH_DEV" ]; then
 		# Sanity check that SCRATCH partition is not mounted at another
 		# mount point, because it is about to be unmounted and formatted.
-- 
2.51.0


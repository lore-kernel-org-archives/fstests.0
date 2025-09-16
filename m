Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E254FC1D
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036707; cv=none; b=brGDREfvejo0OO9u+eKphCYOm2BcJP7/exZ3cTioh7NeBsy5of3V3HGwYHXvG4SHDSWVZBBqwK59yVaGm07amACelH0hxV4yF8QQHI35wa+F38o7TvsR1tqEKTgVauYqkIznm6DY5XJHECjjz4XzomqCcGBYXTKe60YSU31PETM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036707; c=relaxed/simple;
	bh=6cGoRgqBTV/c42zOb7k7wf4GFFDVT5Fk0XidZS+Y7us=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ra2dO/yQdMIJEf2eph2ePeUH7dPdFcDkXFH+UoP404YArpomUZcNNYjPHzMh92gkLYyU8czQobT4cTlxPXriEumj13+fabqJ8nMyjwC0Cd5CeHutbS+7FNnbIwL/6FdAftQEV2bcTb3kRiCjMI7eQbX0zo2vY56yookUh41hU1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0/QSIZr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0/QSIZr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-251fc032d1fso63044105ad.3
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758036705; x=1758641505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qYhxYJWi7ovE9j1ZiHbEDipveqYnL5H6A8Mtko2aec=;
        b=B0/QSIZrRf8m+M+PK1u82Y9/axx4YHpaX1lNip1BSERSOtX1HPy2nsVuQsH3wOtncZ
         PGqL1INK71unbCBqk8azbPhU6kYOzvx5/SZBwa6PSB497jYbHlK75uV1q/5UG7OBikcn
         GoxlGZfQmFh/ydaKeeJwZ/FpOTmkQ4c81iN14EXZNtlHa26g1g9RrdlS7s94F+eMy/1z
         8iOElN7059Oq3EXZ7vG4rUtfZjDQXEU31YH4IDknV+wWwuz+gOeHV/jZjvSMWLARKSlK
         d5MFFUT+VsZGWh+VFCtrNomDJnm7VTrH8cNUXOQvp68ECcSSljM67XvchPhOhYM3g6O8
         hsqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758036705; x=1758641505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qYhxYJWi7ovE9j1ZiHbEDipveqYnL5H6A8Mtko2aec=;
        b=qAvw82d+ej7vEHqFLxL0ZaCslpXSE8Qy3SBI1IVvF4hUTUw7Q9spzZyHs5fBmVMZei
         Vao9dexdOy4rBdpR49K2uTy0EEE1ayUDOwWedCRod5awPq/KDpJXDgR8P6+8fviBJdK0
         9pZlHt74/jf9ZeOMJRcxFuBJ4Zfy4Sc8KikkVUUPrB0s/cMt5c/BpJU4uYCp7GYMT6kN
         rX+O0WctiqfC63Afd78CbxVLCPhr2VYhOW51/MnsBXhNO8Rb54yjpCg9s0yJypuOCxaf
         lED6x9+M5/IrIq59xV6zbFVK0qiMO6q/SZxRGUrU+0a0Gi6zAYx/AiJ4aVmKPxb2ObLK
         xNlg==
X-Gm-Message-State: AOJu0YzC0XkM/0CWlN7/k3PDLn+UZXU5JaX9+tY8cuNnX3kBN0YAtxK4
	BMvL7J8hKhYntWc7QczktaxyNpWJ0+Tnmmf6FGAq4qOSe4cL2++jh6Oh6JDlMA==
X-Gm-Gg: ASbGncvAQtFh7K7z/vVw2GsgtYJ1iglX6UXEETPqqAp/fgEwZ2yu/BvIZD9LOBR3akb
	goZXH0gPm3If5HgyzJkVksiLSkAiGm1AFdWg/dETrfwbgWq/mPpW2uTkek4znoH649xTJ6neBxl
	Z+WLtEMOW3L99549HyrPE/+yJ70uTnhKaJWo7q62h0NTDNIFnf/UiQ2SumqK2UQ/bV7VWgfvsbY
	IoxEL70DDJus4GLDYkugulx3h44RoPQ+/Y5v1MVqhR91equ7OSPYWf9ymcYlaTu68QY6p/fg5PM
	GqGFhQVuAKq8CpjEBh2He54wQranDoD/sdSOo3JIRUZC8bZQdeLaIcxMBPIRpxwKTOvEnBMCMnv
	zTeexYqjLrGJIZkTxDUd1nSdPdmE=
X-Google-Smtp-Source: AGHT+IFEet7WcmSBHFD2TAtb4ifOdqw8ZsfHH+zH5StZNLwT+82WTXP9/k58yednAnSF4Stqpqj7gg==
X-Received: by 2002:a17:902:e951:b0:264:dc48:99bb with SMTP id d9443c01a7336-264dc489c1fmr119892575ad.38.1758036705340;
        Tue, 16 Sep 2025 08:31:45 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-262df893ec5sm92596345ad.46.2025.09.16.08.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:31:44 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	fdmanana@kernel.org,
	quwenruo.btrfs@gmx.com,
	zlang@kernel.org
Subject: [PATCH 4/4] btrfs/290: Make the test compatible with all supported block sizes
Date: Tue, 16 Sep 2025 15:30:12 +0000
Message-Id: <8081c6bcdc56ca2018e51e98e7d3086068f026b9.1758036285.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test fails with 64k block size with the following error:

     punch
     pread: Input/output error
     pread: Input/output error
    +ERROR: couldn't find extent 4096 for inode 261
     plug
    -pread: Input/output error
    -pread: Input/output error
    ...

The reason is that, some of the subtests are written with 4k blocksize
in mind. Fix the test by making the offsets and sizes to 64k so
that it becomes compatible/aligned with all supported block sizes.

Reported-by: Disha Goel <disgoel@linux.ibm.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/btrfs/290 | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tests/btrfs/290 b/tests/btrfs/290
index 04563dfe..fecec473 100755
--- a/tests/btrfs/290
+++ b/tests/btrfs/290
@@ -106,15 +106,15 @@ corrupt_reg_to_prealloc() {
 # corrupt a file by punching a hole
 corrupt_punch_hole() {
 	local f=$SCRATCH_MNT/punch
-	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f
 	local ino=$(get_ino $f)
 	# make a new extent in the middle, sync so the writes don't coalesce
 	$XFS_IO_PROG -c sync $SCRATCH_MNT
-	$XFS_IO_PROG -fc "pwrite -q -S 0x59 4096 4096" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x59 64k 64k" $f
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to 0, representing a hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr --value 0 \
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr --value 0 \
 								    $SCRATCH_DEV
 	_scratch_mount
 	validate $f
@@ -123,14 +123,14 @@ corrupt_punch_hole() {
 # plug hole
 corrupt_plug_hole() {
 	local f=$SCRATCH_MNT/plug
-	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f
 	local ino=$(get_ino $f)
-	$XFS_IO_PROG -fc "falloc 4k 4k" $f
+	$XFS_IO_PROG -fc "falloc 64k 64k" $f
 	_fsv_enable $f
 	_scratch_unmount
 	# change disk_bytenr to some value, plugging the hole
-	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 4096 -f disk_bytenr \
-						   --value 13639680 $SCRATCH_DEV
+	$BTRFS_CORRUPT_BLOCK_PROG -i $ino -x 65536 -f disk_bytenr \
+						   --value 218234880 $SCRATCH_DEV
 	_scratch_mount
 	validate $f
 }
@@ -166,7 +166,7 @@ corrupt_root_hash() {
 # corrupt the Merkle tree data itself
 corrupt_merkle_tree() {
 	local f=$SCRATCH_MNT/merkle
-	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 12288" $f
+	$XFS_IO_PROG -fc "pwrite -q -S 0x58 0 196608" $f
 	local ino=$(get_ino $f)
 	_fsv_enable $f
 	_scratch_unmount
-- 
2.34.1


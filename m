Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD07CA41
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683609; cv=none; b=rMmrbjLsk7oo+irghosnRE3xX2T0b31mS2zPX1VEfuOLMbVkVj+yZ7/5R3DZPWsUA/+sP/Zb8Jz0vULGtIVsLgyzaOm5FbWdHjvsjz+XesSgrizmwZNWPJDhZT3TemIjIyP0t+giWBPoBguvZHJoVVbUYGdNccbko35t7WU+m0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683609; c=relaxed/simple;
	bh=CI0DrwHIyVlhkcpoQcWRGebczictsjs6l8H2+NTpZu4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JwWfE9QPLGuTH+hnWXeqiq5Q1TXKDaLRwNVYUTJCgz24K7qmJPWzYHERVNZYRWUeDRFx7Ja4ImiXC3ApMEfJns7/HnRzfonhrsbnqhmG9eu4d5h9AR7U/jlJRqPCpYj6I2oPR2aH+VgfdPoxZQ8V1Ups5R+YeiHYmgyXO85ELas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=QnOIhYHi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="QnOIhYHi"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-724e113c821so4320830b3a.3
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 21:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683607; x=1733288407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4a3uqPBCa2xrPbVntVwBhqxfG2Z9aj8jm2PszE2m6k=;
        b=QnOIhYHiGwtoOBXKjElyCreuBgac30tFwHPDJreYnUoAfmvFERdYBCNFgPGlRYBxcx
         pPh2Jdh5VULYxrvfBdhw39xwT9CK2tl97M5Nm+Nf+tcBsp71o6w2F1dHIFKUWz4NKCQh
         l1zjZSvpT/Qsnupyh6W6A07OeCcoX+JRn27r9QLAzA2R4N70VGjnix3Mwi08BPQmFD32
         rjO8rVmTFjkucugKG72ogRouhCL3MzIVrjj+T/pCVjf02qVBW4Owj8jvYICVdCBX5Ddc
         KKTJSWc1FgEoRofkEgA7aJzx5Y145SabH4ArR4PWKnUapq4IWcWE5/cv5M3B9fvj+5yI
         ShAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683607; x=1733288407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4a3uqPBCa2xrPbVntVwBhqxfG2Z9aj8jm2PszE2m6k=;
        b=v4ZJonich2Q2DVsgHm0xRMgDtyQHwQxuaYv4a5K39I5itnVZnP/sOFD6+oyntb6AI4
         5fFrhdgPiyIBurD/YYKJp/2EP8ks25uR2vktl4LleEsLHkxrUmObgxiDQTUxF3GpWyla
         pjwpmax4sIiZRQxcYbJJ5o4BeoocvitDSqGmOJ5nFYfn0r5IANK+9OyGeyESm0FeInuB
         grfF9pVjlHSmMWNs3Vu5RZLRIdPOJz/oPMnv/u6x0zrZb1Xu+mKj/IcG6cl86HjBjwtd
         qIEFdmZ6lTI27FazdfJC2/uP5QY6eQnHXpIH920FmsKb6nXL+uubPKm2/TrjZBkQjih7
         o6aw==
X-Gm-Message-State: AOJu0YxHKzytgrUZmbASUEkcvlF6FQ45QJjraqQkyD1WBI6vcFp1XkCU
	8b5UgGTW7MLCqH7yvNR0v56fSdG5dCubBu5+IM5YmvEQzj5GV98gLH9s8Qcc+FftfLEIIQFs0Ex
	S
X-Gm-Gg: ASbGncsDbwxBMIkbIOMPvm/m+BIASgwnuEg2E2VrCiEAf9AY9Zcu8uPeVqp0l5b7c4U
	PfTxBkuu/CjOYZBA0Y2rudCNs8qRLlu0UDYupXru+t/ZYQGZgxi50zG+uqzbZ/oRTKQySpZjzE9
	IbF/73tg/C1C+/kEA5mdPWzGnUNnUf/3bcd9/yu/HxpU895sfpOeP8w9w/0du3o/qyXHedp7o7A
	3ovl589W4/WgCTH+sNzNL0JiwZ/PYk7XTZH2IFPQmx5SvGoi4iZ+Wuyv/1faknczq6d7sNigCEw
	NIq3Hf5JKCjIrg==
X-Google-Smtp-Source: AGHT+IH61l7pqSnePrBRLSCSfkrTKAsodVXTTOhg7029WtMcADO0E2pcGJIDXakmn4BIr2zuKv4LAg==
X-Received: by 2002:a05:6a00:230a:b0:724:f8d4:2b6e with SMTP id d2e1a72fcca58-72530012e07mr2462730b3a.4.1732683607099;
        Tue, 26 Nov 2024 21:00:07 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724e2393129sm9023370b3a.176.2024.11.26.21.00.06
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 21:00:06 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZVD-2CWP
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQfE-2mnJ
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 22/40] quota: system project quota files need to be shared
Date: Wed, 27 Nov 2024 15:51:52 +1100
Message-ID: <20241127045403.3665299-23-david@fromorbit.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241127045403.3665299-1-david@fromorbit.com>
References: <20241127045403.3665299-1-david@fromorbit.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Chinner <dchinner@redhat.com>

Tests that treat them as exclusively owned end up tripping over
other tests that do the same. Fix this by using append and filter
techniques to update the files, then using different project quota
ids for each test.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/quota      | 35 +++++++----------------------------
 tests/generic/603 |  8 +++++---
 tests/generic/691 |  6 ++++--
 3 files changed, 16 insertions(+), 33 deletions(-)

diff --git a/common/quota b/common/quota
index e87489192..8135b7c04 100644
--- a/common/quota
+++ b/common/quota
@@ -274,7 +274,7 @@ _choose_prid()
 
 _qmount()
 {
-    _scratch_unmount >/dev/null 2>&1
+    _scratch_unmount
     _try_scratch_mount || _fail "qmount failed"
     # xfs doesn't need these setups and quotacheck even fails on xfs
     # redirect the output to $seqres.full for debug purpose and ignore results
@@ -432,39 +432,18 @@ _create_project_quota()
 	mkdir $prjdir
 	chmod ugo+rwx $prjdir
 
-	if [ -f /etc/projects -a ! -f $tmp.projects.bk ];then
-		cat /etc/projects > $tmp.projects.bk
-		echo >/etc/projects
-	fi
-	if [ -f /etc/projid -a ! -f $tmp.projid.bk ];then
-		cat /etc/projid > $tmp.projid.bk
-		echo >/etc/projid
-	fi
-
-	cat >>/etc/projects <<EOF
-$id:$prjdir
-EOF
-	cat >>/etc/projid <<EOF
-$name:$id
-EOF
+	echo "$id:$prjdir" >> /etc/project
+	echo "$name:$id" >> /etc/projid
 	$XFS_IO_PROG -r -c "chproj $id" -c "chattr +P" $prjdir
 }
 
 # If you've called _create_project_quota, then use this function in _cleanup
 _restore_project_quota()
 {
-	if [ -f $tmp.projects.bk ];then
-		cat $tmp.projects.bk > /etc/projects && \
-			rm -f $tmp.projects.bk
-	else
-		rm -f /etc/projects
-	fi
-	if [ -f $tmp.projid.bk ];then
-		cat $tmp.projid.bk > /etc/projid && \
-			rm -f $tmp.projid.bk
-	else
-		rm -f /etc/projid
-	fi
+	local id=$1
+
+	sed -i "/^$id:/d" /etc/project
+	sed -i "/:$id$/d" /etc/projid
 }
 
 # make sure this script returns success
diff --git a/tests/generic/603 b/tests/generic/603
index 32dcaeb94..a84695831 100755
--- a/tests/generic/603
+++ b/tests/generic/603
@@ -10,10 +10,12 @@
 . ./common/preamble
 _begin_fstest auto quick quota
 
+projid=$seq
+
 # Override the default cleanup function.
 _cleanup()
 {
-	_restore_project_quota
+	_restore_project_quota $projid
 	cd /
 	rm -f $tmp.*
 }
@@ -122,8 +124,8 @@ _require_prjquota $SCRATCH_DEV
 BLOCK_SIZE=$(_get_file_block_size $SCRATCH_MNT)
 rm -rf $SCRATCH_MNT/t
 mkdir $SCRATCH_MNT/t
-$XFS_IO_PROG -r -c "chproj 100" -c "chattr +P" $SCRATCH_MNT/t
-_create_project_quota $SCRATCH_MNT/t 100 $qa_user
+$XFS_IO_PROG -r -c "chproj $projid" -c "chattr +P" $SCRATCH_MNT/t
+_create_project_quota $SCRATCH_MNT/t $projid $qa_user
 
 echo "### Set up different grace timers to each type of quota"
 UBGRACE=12
diff --git a/tests/generic/691 b/tests/generic/691
index 25ce92bc4..f33d6edf1 100755
--- a/tests/generic/691
+++ b/tests/generic/691
@@ -16,10 +16,12 @@
 . ./common/preamble
 _begin_fstest auto quota
 
+projid=$seq
+
 # Override the default cleanup function.
 _cleanup()
 {
-	_restore_project_quota
+	_restore_project_quota $projid
 	cd /
 	rm -r -f $tmp.*
 }
@@ -65,7 +67,7 @@ exercise()
 	fi
 	_qmount
 	if [ "$type" = "P" ];then
-		_create_project_quota $SCRATCH_MNT/t 100 $qa_user
+		_create_project_quota $SCRATCH_MNT/t $projid $qa_user
 		file=$SCRATCH_MNT/t/testfile
 	fi
 
-- 
2.45.2


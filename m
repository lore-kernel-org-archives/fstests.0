Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BF82D66
	for <fstests@vger.kernel.org>; Wed, 27 Nov 2024 04:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732683253; cv=none; b=oO/bVVjt7yh63TTqrep1eK+OTgsotSDGDC5RsaZPxrmXL05XmyCceEEcnWwhHfBvyXwEeXY2gGCg9jF5v72+yg9T5pR5yU3sGMurnnIXsfWrEGKqIVhtlDUGrayL4lUpRBCdEBlTeKmsFB8jubiw9B3rFrKqTOQZ2BSzrRJ27T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732683253; c=relaxed/simple;
	bh=68NkP28QFySiXfDBAT20X1lUvpZ+TBkmMG1em8hHh1Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nYG7vrKWGe5N2KG7zzavcutXX35WQJtdY+9uleDtXaysC1cF8r8Io5tMGxVfEYqCDLodPTA63B6MTd7X8W6F1CvtaAmrWQjLE0CSKtRKCLulIRw7XRf5S/lYYxptZjAdCI5esLvQarWwiNXTpdUobw0Yx9m47tB6aue4Rs5fwZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=lDjfS1XI; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="lDjfS1XI"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-724e7d5d5b2so4753694b3a.2
        for <fstests@vger.kernel.org>; Tue, 26 Nov 2024 20:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1732683251; x=1733288051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=olPX/8Lis4fpdUAhrxPcDPcOvQk9aHidQcfvBXL3oe4=;
        b=lDjfS1XIztQKPeXdZDMjy0vJrdlZNsAJGpj5YaZxLLAZw8bSdyuA69jN3iztfzygE6
         aRkyYF7wtxNoSMGdkhufAPTnmlHv/5bZSCdntkyXan3hAcOtKcO3jxALZ6bnkviiwn6f
         uM8KvQSMKod50AKo09y/mqxJgwcpGT9ldG/dRcVkdWzNV/Xm5d2CpZriEeVooEIw+RPh
         erRAL0mRNcvnEqHiPVoGH/tPvDvZtYjS0Coj70NUjdfDF5bpSe/N1qi13HADxtYYFh8P
         x+srJUvFy5+xv+HQi9OsWsbrGgUwCu5W2G1KlLvvRDo05BjqlSSqNKOhABEzc1RmM/Dd
         wYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732683251; x=1733288051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=olPX/8Lis4fpdUAhrxPcDPcOvQk9aHidQcfvBXL3oe4=;
        b=oPVK5V0BQoUbKZbJe9/3G389RGc3Om0BoXg964Xg5wKGgJxJ3JHca1QKWYFX6pHlXE
         3fzPMc+OcOBJV9ai0SFoGLKaaRD3iWE+R/fBQDuHKE/W1WV1W2P9TdxIcfxu1NpOO/Pn
         sPW0tEmNIFjfrAxomnO7Y5npW7eYzV2jJfK9wtf8gJpZN+nvizcCbrS+F3zaiQvAQnlW
         sVBWaDIzdRDtkbiUX48XaHWU3jpunNZc3NNhn/ZEZFy3loBawOcysEeXXEB+dUO5Fd+4
         TYeVX/MCMNAKOfaBUn7RNGCXgfmSt0NSWTlM6W9z8Z9XGNgPqJVYSx5Rv1B82ajTBm8Q
         un8Q==
X-Gm-Message-State: AOJu0Yy+oCjVuWwo+fxQ+YNYokZ8PdCPrf/JHPS9B2RVcKokVs6C1hp3
	RDsbXeBA0SoqkLEtSXCGo6OKHxPf+YvAYW4NFTZYMgQWXu9POvguKMuJ155oxw8IOewf/7+dEsy
	7
X-Gm-Gg: ASbGncunnCpT+h7ogK+6J80Ni7yxTrraXXlel2xrR4dA7kOe2RCORjEfl4lOFI9jKtK
	Ma7FU26ot2ECBD5+D+AT3Q3yp3P/d+IgbQnDnBjjH0/eQJrBrwzQw00clZpZFerGxcVlagFU0zP
	5hd/h3uhH4pnsQ1gsmR7eTpE+zjvG+qGyZfTs3/qxsuuKB2O53zBQO14KWg+orV63QAJ3PsCMoq
	kk1BQ/GzwXVjqwTDN8C4ztjhoKHawvY5MuSNFY/P2RP/zRAxWvOZ1pp2ApT5APvw/mzH3eKYWzu
	ww15bXGazFzoScKgqlnlsaG+
X-Google-Smtp-Source: AGHT+IEqkmVldW26EpEPMYAbquREs54RLidqG9A4NjE9Vm52g8s0Ghpo1wAmZClj2YRwkNh93X38xg==
X-Received: by 2002:a05:6a20:734a:b0:1d9:4837:ada2 with SMTP id adf61e73a8af0-1e0e0b7e3a4mr2634443637.35.1732683251603;
        Tue, 26 Nov 2024 20:54:11 -0800 (PST)
Received: from dread.disaster.area (pa49-180-121-96.pa.nsw.optusnet.com.au. [49.180.121.96])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724eb65d2adsm8221655b3a.159.2024.11.26.20.54.07
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 20:54:09 -0800 (PST)
Received: from [192.168.253.23] (helo=devoid.disaster.area)
	by dread.disaster.area with esmtp (Exim 4.98)
	(envelope-from <dave@fromorbit.com>)
	id 1tGA3x-00000003ZUi-11xw
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
Received: from dave by devoid.disaster.area with local (Exim 4.98)
	(envelope-from <dave@devoid.disaster.area>)
	id 1tGA3x-0000000FQeY-1Y5g
	for fstests@vger.kernel.org;
	Wed, 27 Nov 2024 15:54:05 +1100
From: Dave Chinner <david@fromorbit.com>
To: fstests@vger.kernel.org
Subject: [PATCH 14/40] fstests: xfs/227 is really slow
Date: Wed, 27 Nov 2024 15:51:44 +1100
Message-ID: <20241127045403.3665299-15-david@fromorbit.com>
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

The slowest test tto run on my test VMs is xfs/227:

...
xfs/227 826
...

It is doing nested iteration on created filesets that are explicitly
defined, so separate the inner loop filesets and run the outer loops
in parallel.

Also reduce the number of times we have to execute setfattr and
xfs_io to once per created file instead of once per xattr/extent
count per file.

The result is test runtime reduction of ~60%.

....
xfs/227 336
....

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 tests/xfs/227 | 57 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/tests/xfs/227 b/tests/xfs/227
index 2ad910cbd..7f8ee2dba 100755
--- a/tests/xfs/227
+++ b/tests/xfs/227
@@ -41,7 +41,7 @@ fragment_freespace()
 	# allocate inode space
 	mkdir -p $_dir
 	for i in `seq 0 1 1000`; do
-		touch $_file.$i
+		echo -n > $_file.$i
 	done
 	for i in `seq 0 63 1000`; do
 		mv $_file.$i $_dir
@@ -68,19 +68,23 @@ fragment_freespace()
 
 create_attrs()
 {
-	for foo in `seq 0 1 $1`; do
-		$SETFATTR_PROG -n user.$foo -v 0xbabe $2
-	done
+	( echo "# file: $2"
+	for i in `seq 0 1 $1`; do
+		echo "user.$foo=\"0xbabe\""
+	done ) > $tmp.$1.attrs
+	$SETFATTR_PROG --restore=$tmp.$1.attrs $2
 }
 
 create_data()
 {
-	size=`expr \( $1 + 1 \) \* 4096`
-	$XFS_IO_PROG -f -c "truncate $size" $2 > /dev/null 2>&1
-	for foo in `seq $1 -1 0`; do
-		let offset=$foo*4096
-		$XFS_IO_PROG -f -c "resvsp $offset 4096" $2 > /dev/null 2>&1
+	local blocks=$1
+	local cmd_str
+
+	for off in `seq $blocks -1 0`; do
+		cmd_str="-c \"resvsp $((off * 4096)) 4096\" $cmd_str"
 	done
+	$XFS_IO_PROG -f -c "truncate $((($blocks + 1) * 4096))" \
+			$cmd_str $2 >> seqres.full 2>&1
 }
 
 # create the designated file with a certain number of attributes and a certain
@@ -119,6 +123,27 @@ create_target_attr_last()
 	create_attrs $nattrs $target
 }
 
+do_fsr()
+{
+	local n=$1
+	local i=$2
+	local j
+
+	for j in `seq 5 1 20`; do
+		create_target_attr_first $i $j $targ.$i.$j >> $seqres.full 2>&1
+	done
+	xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
+	FSRXFSTEST=true xfs_fsr -d -v -C $n $targ.$i.* >> $seqres.full 2>&1
+	xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
+	for j in `seq 5 1 20`; do
+		create_target_attr_last $i $j $targ.$i.$j >> $seqres.full 2>&1
+	done
+	xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
+	FSRXFSTEST=true xfs_fsr -d -v -C $n $targ.$i.* >> $seqres.full 2>&1
+	xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
+}
+
+
 # use a small filesystem so we can control freespace easily
 _scratch_mkfs_sized $((50 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
@@ -154,19 +179,9 @@ targ=$SCRATCH_MNT/fsr_test_file.$$
 for n in `seq 4 1 12`; do
 	echo "*** n == $n ***" >> $seqres.full
 	for i in `seq 5 1 15`; do
-		for j in `seq 5 1 20`; do
-			create_target_attr_first $i $j $targ.$i.$j >> $seqres.full 2>&1
-		done
-		xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
-		FSRXFSTEST=true xfs_fsr -d -v -C $n $targ.$i.* >> $seqres.full 2>&1
-		xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
-		for j in `seq 5 1 20`; do
-			create_target_attr_last $i $j $targ.$i.$j >> $seqres.full 2>&1
-		done
-		xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
-		FSRXFSTEST=true xfs_fsr -d -v -C $n $targ.$i.* >> $seqres.full 2>&1
-		xfs_bmap -vp $targ.$i.* >> $seqres.full 2>&1
+		do_fsr $n $i &
 	done
+	wait
 done
 
 _scratch_unmount
-- 
2.45.2


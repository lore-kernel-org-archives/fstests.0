Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54830C624
	for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758035534; cv=none; b=mdSDYP4Q6nojl1KAOwmU3ZHKQlcgRxQg+nv234MQovaqTj+fuREJ+DVbPt5Zvm8sgK2TdI5v+xoV6pZx16SflgZ8wqsKQyBo6LOsdhNeAyhj23QS4bM8iFEVcZX+lP/r1u0bKFiJERMHtFgb2xJUCsyXaSx/IkpFA0rBhTfSwyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758035534; c=relaxed/simple;
	bh=QNOQY/QoUruGKT7ypIZYtMMPfGgcJ069JOiRiMkdHR0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r3X4w2rugjeboQsuF8JwsRDhAo9gOFAWTCuYYj10X8LQQcX83SwV3S3sjeMXFCQ6qdE/Pm9cIZZCX01Sazf2qgLdHKKUd2J59p89a3cKIUNdY6jTR/AhKjVEMqnG8Ru68DW8M85a06TL7x0KW+y5qZt1WUhq2jdPVpNXjxCuc1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2Gf1qyD; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2Gf1qyD"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso3755316a12.1
        for <fstests@vger.kernel.org>; Tue, 16 Sep 2025 08:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758035531; x=1758640331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHEXmWQs67WVJBtVdflBLkGM9FSswp6rWc/lP2Txhn4=;
        b=X2Gf1qyDsRYz7EWQXZFEb7zstWlP8NuvF1/lc/r6GIGpmGmlIENdfEnJRgq08DeHCu
         RTleEIBoCMgb7McrsKlnrzcmoqIk+JgYLHMJyii3dQ3eJwwqs1HIQi23AMKkXTkxJ3wk
         OlJ+RO4gBBkq/WzifGB04EcpH8swCjKfwndJZu+mB25Tny5ZA5ApRnW9wXTbCUE6zIcf
         FfGZQXDMceD+s3pmZEtTH85svbCNpGKgGY/4nzNfpqTPpRTmsS2KeoeH2hh+NUEdjR1i
         DohrEAuDgVzzEnUp08Gjogb4ucz4F45NNTY6TLIBvxYJyTOPU2wwLDedKGaxRJR6yBK5
         /FNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758035531; x=1758640331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHEXmWQs67WVJBtVdflBLkGM9FSswp6rWc/lP2Txhn4=;
        b=liBUTpfHU2smxuOpntb5lVtzYQ24MZGrOpgWvD59iHF6fOrT8sIHWV7339kFwDyD+G
         udnNrycGeI5LwEczUrnjiRpVepCA11RB9d8FyAwVC73g9hQQAkPUylXLtO+kgRExykeZ
         RQlws3Vsr3bcdpY4gvJpFZkYRYYA+PwdWn+ihMV7UlZUTvNTHoRuITuWrnPNoAh7uW+t
         JB0DGKrCBCQltcjHf+RTo1cvWwOapXxN3zqpcycO297ePbxUSmwC3ww1os8PxtfuEj5p
         0P9lwhxqbBi/fAtNgfaJRwH9kSSbK3Fw2YZ5l+y3FzemfjvnKr+m2QBXnpecUvz2CZ1S
         nhIA==
X-Gm-Message-State: AOJu0Yxp2RkUr7DsgCQgUD74K7fXBkaDAW1O9yvxhmWmlKZediQPvUMt
	SY1uL3nN8I93ilZZh3AmE8ShHqSw6Jef43OF4eELykvAPTsJcGVyFMNAUd26og==
X-Gm-Gg: ASbGncsf9GkQiDNSs2Y9fz3ciadMNGzPBX5g1pZMhJuWHgYix86Zwsh2jGOoWqAJsyi
	SfqzQSLxLwOhRZPdVn9aHhfFIkK04fhweOzOqQ+2eVQnP/xRhVm+Uwjmi9upGN/fmv44QFWdMj8
	chmt7/zhOvnV2MZ05CboC66Uf/1+g445EHVkCklIIgf4TfwFZ62d3Y7wtyxDmNCILi2K7ueB0Qv
	86iwyOvmXKi+iXULlvy51IhkRVfx9cTrmN9Cy3u6+q9SkHSNTLWmxlJCpvDff2QpHLsi+L0t6Tz
	u73+2tVUqd50lO1F4exktGNa1UxgwUetLIZzWy0TYhRK8nQJRyFoys4Qb1ANObCw/rRHB15nxUY
	8Qjsm2cTaxHkFsshLPv9KSZanQBE=
X-Google-Smtp-Source: AGHT+IE0aHLCIwFCjOzWYGSgOK3fd38DAW5ihNU5dtmAFUrfboWX1M4vhhNg0S+ZPX8LznZoU0h2Ww==
X-Received: by 2002:a17:903:2410:b0:24c:9a51:9a33 with SMTP id d9443c01a7336-25d24e9df3dmr189019435ad.22.1758035531500;
        Tue, 16 Sep 2025 08:12:11 -0700 (PDT)
Received: from citest-1.. ([49.207.211.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a750sm164780175ad.83.2025.09.16.08.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 08:12:11 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: nirjhar.roy.lists@gmail.com,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	bfoster@redhat.com,
	david@fromorbit.com,
	hsiangkao@linux.alibaba.com,
	zlang@kernel.org
Subject: [RFC 1/3] xfs/163: Update this test with multi AG shrink sub-tests
Date: Tue, 16 Sep 2025 15:11:30 +0000
Message-Id: <e924537069e2b8ec4744a2bdb05125a63f778ceb.1758035262.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
References: <cover.1758035262.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, that the support for removal of entire empty
AG has been added, add more sub-tests to validate
shrink sizes worth equal to or more than 1 AG along with
some out of bounds/invalid shrink sub-test cases.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/xfs/163     | 162 ++++++++++++++++++++++++++++++++++++----------
 tests/xfs/163.out |  23 +++++--
 2 files changed, 147 insertions(+), 38 deletions(-)

diff --git a/tests/xfs/163 b/tests/xfs/163
index 015a82cd..fb80065f 100755
--- a/tests/xfs/163
+++ b/tests/xfs/163
@@ -6,14 +6,46 @@
 #
 # XFS shrinkfs basic functionality test
 #
-# This test attempts to shrink with a small size (512K), half AG size and
-# an out-of-bound size (agsize + 1) to observe if it works as expected.
+# This test attempts to shrink the filesystem by various sizes and verifies
+# if it works as expected.
 #
 . ./common/preamble
 _begin_fstest auto quick growfs shrinkfs
 
 # Import common functions.
 . ./common/filter
+_require_scratch_xfs_shrink
+
+AGCOUNT=16
+FSSIZE=$((2 * 1024 * 1024 * 1024)) # 2G
+_require_scratch_size $((FSSIZE / 1024))
+
+reset()
+{
+	_scratch_unmount >> $seqres.full 2>&1
+	# agcount in an xfs filesystem >= 2
+	_scratch_mkfs -dsize="$FSSIZE" -dagcount="$AGCOUNT" 2>&1 | \
+		tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs >/dev/null
+	. $tmp.mkfs
+	tot_dblocks=$dblocks
+	oagcount=$agcount
+	_scratch_mount >> $seqres.full
+}
+
+# This functions converts a given number of fsblocks to AG count.
+_dblocks_to_ag()
+{
+	local blocks="$1"
+	local agdiv=$((blocks/agsize))
+	local agmod=$((blocks%agsize))
+	local agc
+	if [[ "$agmod" == 0 ]]; then
+		agc="$agdiv"
+	else
+		agc=$(( agdiv + 1 ))
+	fi
+	echo "$agc"
+}
 
 test_shrink()
 {
@@ -24,47 +56,111 @@ test_shrink()
 	_check_scratch_fs
 	_scratch_mount
 
-	# If we couldn't shrink the filesystem due to lack of space, we're
-	# done with this test.
-	[ $1 -ne $dblocks ] && \
-		grep -q 'No space left on device' $tmp.growfs && \
-		_notrun "Could not shrink due to lack of space"
 	cat $tmp.growfs >> $seqres.full
+	$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | \
+		_filter_mkfs 2>$tmp.xfsinfo >/dev/null
+	. $tmp.xfsinfo
+	[ $ret -eq 0 ]
+}
+
+# run_test <number of blocks to remove> <test name> <optional: error message>
+# If the test is expected to succeed, then there is no need to provide an error
+# message.
+run_test_shrink()
+{
+	local delta_blocks="$1"
+	local test_name="$2"
+	local error_message="$3"
 
-	$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _filter_mkfs 2>$tmp.growfs >/dev/null
-	. $tmp.growfs
-	[ $ret -eq 0 -a $1 -eq $dblocks ]
+	echo "$test_name"
+	reset
+	local tsize=$((tot_dblocks-delta_blocks))
+	local nagcount=`_dblocks_to_ag "$tsize"`
+	echo "delta = $delta_blocks newblocks = $tsize nagcount = $nagcount" \
+		>> $seqres.full
+	if [[ "$error_message" == "" ]]; then
+		# no error message means the test is expected to succeed
+		test_shrink "$tsize" || \
+			echo "Shrink $test_name failure"
+		# Verify the parameters
+		[[ "$dblocks" -ne "$tsize" ]] && \
+			echo "dblocks not changed properly after shrinking \"$test_name\"" \
+			&& 	echo "expected $tsize got $dblocks"
+		[[ "$agcount" -ne "$nagcount" ]] && \
+			echo "agcount not changed properly after shrinking \"$test_name\"" \
+			&& 	echo "expected $nagcount got $agcount"
+	else
+		test_shrink "$tsize" && \
+			echo "Shrink \"$test_name\" succeeded unexpectedly"
+		grep -q "$error_message" $tmp.growfs || \
+			echo "Error message missing - shrinking \"$test_name\" (expected: $error_message)"
+		# Verify the parameters
+		[[ "$dblocks" -ne "$tot_dblocks" ]] && \
+			echo "dblocks changed after shrink failure \"$test_name\"" && \
+			echo "expected $tot_dblocks got $dblocks"
+		[[ "$agcount" -ne "$oagcount" ]] && \
+			echo "agcount changed after shrink failure \"$test_name\"" && \
+			echo "expected $oagcount got $agcount"
+	fi
 }
 
-_require_scratch_xfs_shrink
+# This function, first shrinks the fs, then grows it. This is to make sure that
+# the fs is able to grow properly after a shrink has taken place.
+# Usage: run_test_shrink_grow <number of blocks to remove> <test name>
+run_test_shrink_grow()
+{
+	local delta_blocks="$1"
+	local test_name="$2"
+
+	echo "$test_name"
+	reset
+	local tsize=$((tot_dblocks-delta_blocks))
+	test_shrink "$tsize" || \
+		echo "$test_name failure"
+	# Now grow the fs
+	test_shrink "$tot_dblocks" || \
+		echo "$test_name failure"
+	# Verify the parameters
+	[[ "$dblocks" -ne "$tot_dblocks" ]] && \
+		echo "dblocks not changed properly after \"$test_name\"" \
+		&& 	echo "expected $tot_dblocks got $dblocks"
+	[[ "$agcount" -ne "$oagcount" ]] && \
+		echo "agcount not changed properly after \"$test_name\"" \
+		&& 	echo "expected $oagcount got $agcount"
+}
 
-echo "Format and mount"
+reset
 
-# agcount = 1 is forbidden on purpose, and need to ensure shrinking to
-# 2 AGs isn't feasible yet. So agcount = 3 is the minimum number now.
-_scratch_mkfs -dsize="$((900 * 1024 * 1024))" -dagcount=3 2>&1 | \
-	tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs >/dev/null
-. $tmp.mkfs
-t_dblocks=$dblocks
-_scratch_mount >> $seqres.full
+# Tests expected to pass
+# run_test_shrink <number of blocks to remove> <test name>
+echo "#Tests partial and multi-ag shrinking"
+run_test_shrink 1 "shrink by 1 block"
+run_test_shrink $((agsize/2)) "shrink by 0.5 AG"
+run_test_shrink $((agsize)) "shrink by 1 AG"
+run_test_shrink $((agsize*6)) "shrink by 6 AG"
+run_test_shrink $((agsize*3+agsize/2)) "shrink by 3.5 AG"
+echo
 
-echo "Shrink fs (small size)"
-test_shrink $((t_dblocks-512*1024/dbsize)) || \
-	echo "Shrink fs (small size) failure"
+# run_test_shrink_grow <number of blocks to remove> <test name>
+echo "#Tests partial and multi-ag shink followed by growfs"
+run_test_shrink_grow $((agsize/2)) "shrink by 0.5 AG -> grow by 0.5 AG"
+run_test_shrink_grow $((agsize*6)) "shrink by 6 AG -> grow by 6 AG"
+run_test_shrink_grow $((agsize*3+agsize/2)) "shrink by 3.5 AG -> grow by 3.5 AG"
+echo
 
-echo "Shrink fs (half AG)"
-test_shrink $((t_dblocks-agsize/2)) || \
-	echo "Shrink fs (half AG) failure"
+echo "#Test out of bounds ag shrink: Below tests are expected to fail"
+# Tests expected to fail
+# run_test_shrink_grow <number of blocks to remove> <test name> <error message>
+run_test_shrink "$(( (AGCOUNT - 1) * agsize ))" "shrink to 1 AG" "Invalid argument"
+run_test_shrink "$(( tot_dblocks - 1 ))" "shrink to 1 block" "Invalid argument"
 
-echo "Shrink fs (out-of-bound)"
-test_shrink $((t_dblocks-agsize-1)) && \
-	echo "Shrink fs (out-of-bound) failure"
-[ $dblocks -ne $((t_dblocks-agsize/2)) ] && \
-	echo "dblocks changed after shrinking failure"
+# XFS expects a minimum of XFS_MIN_AG_BLOCKS (64) per AG. If we are shrinking
+# the (new) tail AG below this threshold value, then the shrink op should fail.
+run_test_shrink "$(( agsize - 1 ))" "shrink tail AG to 1 block" "Invalid argument"
+run_test_shrink "$(( agsize * 2 - 1 ))" "shrink new tail AG to 1 block" "Invalid argument"
+echo
 
 $XFS_INFO_PROG $SCRATCH_MNT >> $seqres.full
-echo "*** done"
 
 # success, all done
-status=0
-exit
+_exit 0
diff --git a/tests/xfs/163.out b/tests/xfs/163.out
index bd66d4a9..4f15dc94 100644
--- a/tests/xfs/163.out
+++ b/tests/xfs/163.out
@@ -1,6 +1,19 @@
 QA output created by 163
-Format and mount
-Shrink fs (small size)
-Shrink fs (half AG)
-Shrink fs (out-of-bound)
-*** done
+#Tests partial and multi-ag shrinking
+shrink by 1 block
+shrink by 0.5 AG
+shrink by 1 AG
+shrink by 6 AG
+shrink by 3.5 AG
+
+#Tests partial and multi-ag shink followed by growfs
+shrink by 0.5 AG -> grow by 0.5 AG
+shrink by 6 AG -> grow by 6 AG
+shrink by 3.5 AG -> grow by 3.5 AG
+
+#Test out of bounds ag shrink: Below tests are expected to fail
+shrink to 1 AG
+shrink to 1 block
+shrink tail AG to 1 block
+shrink new tail AG to 1 block
+
-- 
2.34.1


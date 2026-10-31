Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793484991;
	b=aPaR1kvdpZsP7ZXDDn6tquhMJigxXSsWn0oA/KdbvIaBSiH+PnkusKWxAlYZqqTDR0AW
	 7KF9WXELj/Qi6Jci5xtdm6E/+cZmQc+NkcGj5hT8TBQbq/HQUqMz3GJiztf974gJ2nne7
	 pS1P/+dJOqahJFWOq6cTXlse1PBN3RwhFmghFO6WJ1yxy6CuYd4cS/bNnK3Xw8dWe09kV
	 bHYzQJRFSUV8+vPdNOn7eviZ+LB2OcW6NDs601f8hI9uEmMSaU6QCGcsyoA7sRmjYICcB
	 zZ5Md8aGod0JMFsShTLZ48CVC1uUgwtVUuwy5tvgYpNLfAYybXGdI8vqz/CySPbrYsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793484991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cjIPJURKq1ZAyaHb+Ric6lew/ofviOmHezHw+9sI8qM=;
	b=tox8Hxf6MdBdUIP+0VGxQndQtvBxVIijnFf0yHFRQk6gDryXkAvKb8FT2ZJDv6Z1Vk79
	 XJtZWWemI6y1XMpNEvLdWreHmPuK/Y2OehHROkUHWwj61F0X9gohLYHZWw0LxL26sXH9x
	 gzTkPN7biSGE4A5ieMCfI/dK8mC1fG3tRF42gH1vw4fdsi4/esF6itnvuFPLHFTXw1MQI
	 HuewpNW59G/lsqzGFHhEhizBgZP+iq3kEjKhh4+J8mH5FDI/aNfkqiZk6psiTUlxKr62c
	 UukPYXtJ5Hr0Bllug7KkXam1ZYZL2fdYLiY0eh9eNpmLA7uAq67O8ez8S89POuC7EQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AYr0c1Jl;
	arc=none smtp.remote-ip=74.125.229.7
Received: from mail-dy2-f7.google.com (mail-dy2-f7.google.com [74.125.229.7])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E6606A31F
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 22:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C5E6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AYr0c1Jl
Received: by mail-dy2-f7.google.com with SMTP id 5a478bee46e88-36758ba1f01so895549eec.1
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 15:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793484991; x=1794089791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cjIPJURKq1ZAyaHb+Ric6lew/ofviOmHezHw+9sI8qM=;
        b=AYr0c1JlIqFd3Hi+tHy7rV+yx+tE3quDXNOycVcixSw416S/ZREMpbRG1HJMvkKmlN
         8UJaIjfq0E0h1LSQKIaQd+gkede62yufc0LnSoEXKEv5wOthf4x+bwgXk8QoUPWJr2+o
         rvdNORe3YntHm+BEBgmsypyeiR7QBbsoaScQx9laOdYRnWJY/Qk9Gma2CXhF7+G0p3Pk
         SOWfXMrcY33lQd1jecPGUaIST/xZj55Bt0DOgqe8sUTFooASDJBxhCqXXxep9D3xMqtY
         RYdxItxhQOoW/InvkWMnmLwQSZ+B9t+x8Kn5xmgG2eTYU111bPsqYd79hQN+5PVfCcuC
         /xxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793484991; x=1794089791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cjIPJURKq1ZAyaHb+Ric6lew/ofviOmHezHw+9sI8qM=;
        b=tP8Cp0AxyfYGRDmoqjvyzchz/yQcoiwsI9RvwlN3CWZZB/a5mC14pKC1kkitou2pAY
         sGUdXy4xsgtsCv0Ou504oPS2AjTQEOxVjhKM9+drN0UIOSFIQj3qUAO9qtjUTw1HKQqL
         s8KPxEZ8beRtQTGluVQUDS04lmJneSoZ7PD3/hlLC6JC48pver9Qc5YgXPuOStORBBHn
         tr6dw0PMUWVz/QmA55w1Yny4KjoWj8DvHUug3eCvZFHSF34ZQT76Bm/ut1T2/phW2dL9
         G1OLsUWyEudo8Bsvvf8VLSaiVQD0UDTJOJn0tBMKWpGJZg+fhAXh+NblnbwNA+VMms4c
         +CEA==
X-Gm-Message-State: AFq9FYIJuj4HvarEui+NmGwrcvIQPDMRQOx9fAdRHKwB29cG/Etp3G+3
	2SQD9hc7OJj8ODSLu8twiOF7w2Rmi7XcZbE2vXZjKHWnb71cIr2YJo/HTpvV7wfGPfs=
X-Gm-Gg: AYBFou1Wrx4pY0rILL9KzDyFaO3eeMZZS14LABsOGK6nxwUX+ww8NAKp+72ep8WOC08
	HmAhI6NCVP2ZgNqaw8ObJdMuEUGq7TZ6mdPFARJBUYqCIGgd6KKzZgsUudm4BsngLm86WMAfZqG
	hNiIkCgxRZSfIUejmHAFe/yL0EyhdAIFwJL2dw3/q3kAwIJMAghoRION+0DU6Ky9tRq0vC6fRL9
	Iq+Eq9xEfDR/TuGrOtR7pgrSBWkd/3CYtacEKb8oio+qkqFAY4aCcJXtBKGbr3JBqr+Ic4ZILcR
	H+M50myMO7w14Tv8ttcxm+8dVsn+BCK75lLqSCEvOgZMKEYqdtCfKo+nSRpNaDWI3M0+XyR0Dnm
	uw+OgIeMLR+bdIsDRKxhdUMLy+tQxv90vkeeeHmOTufhQO/cAFletJwTyInnM/6eUHyVG5Wu3Vt
	twG/8w4sLRWKV0m9oa6xvktilJqkrOlMlutv16XzfQStsMc8JI4XX5JwMvLrV4r4312VONj1mNd
	egcc0y4+Z+YdJRu13rzgu4T+fLMaLVvzMuMvNNvgRNSpWmgOCT+XSbJSrv/IpJ0SDjiMLg9rVWY
	e453pGL7foNf5DkcddGdNO/6jMjLBYm9PGPLdKqYIohzaPUuQSDq4GrZ
X-Received: by 2002:a05:7301:1a15:b0:369:a113:756f with SMTP id 5a478bee46e88-36a423f980emr8430299eec.34.1793484990505;
        Sat, 31 Oct 2026 15:16:30 -0700 (PDT)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42a61a0csm24037242eec.22.2026.10.31.15.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 15:16:30 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	amir73il@gmail.com,
	linux-unionfs@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH v2 1/2] generic: test overlayfs casefold flag changes
Date: Sat, 31 Oct 2026 22:16:17 +0000
Message-ID: <20261031221618.153-2-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261031221618.153-1-dennylin0707@gmail.com>
References: <20261031221618.153-1-dennylin0707@gmail.com>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changing the casefold flag of an overlay directory can leave its upper
and the mount with different casefold states and break lookups.

Check that chattr +F/-F requests which would change that state fail with
EOPNOTSUPP, preserve the casefold flag and leave files accessible. Cover
lower-only directories with and without contents and the overlay root,
with both casefold-enabled and casefold-disabled layers. Keep no-change
requests as successful controls.

This covers "ovl: do not let chattr change the casefold flag" from the
casefold fixes series linked below.

The test also reads regular files on a casefolded overlay. This needs the
separate "ovl: check the casefold flag of directories only" fix, included
in the tested overlayfs ovl-fixes baseline at 1d27da7de3f7.

Link: https://lore.kernel.org/linux-unionfs/20261030113201.2921633-1-amir73il@gmail.com/
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/generic/998     |  147 ++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/998.out |    3 +++
 2 files changed, 150 insertions(+)

diff --git a/tests/generic/998 b/tests/generic/998
new file mode 100755
index 0000000..26a4a19
--- /dev/null
+++ b/tests/generic/998
@@ -0,0 +1,147 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Hungyu Lin.  All Rights Reserved.
+#
+# FS QA Test 998
+#
+# Check that rejected casefold changes leave overlay directory casefold
+# flags unchanged and existing files accessible.
+#
+. ./common/preamble
+_begin_fstest auto quick ioctl casefold
+
+_cleanup()
+{
+	cd /
+	[ -n "$merge" ] && _unmount "$merge" 2>/dev/null
+	rm -f $tmp.*
+}
+
+. ./common/filter
+. ./common/casefold
+
+_exclude_fs overlay
+_require_extra_fs overlay
+_require_scratch
+_require_scratch_casefold
+_fixed_by_kernel_commit xxxxxxxxxxxx "ovl: do not let chattr change the casefold flag"
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"ovl: check the casefold flag of directories only"
+
+check_casefold()
+{
+	local path=$1
+	local expected=$2
+	local expected_state=disabled
+	local flags
+	local actual=0
+
+	[ "$expected" -eq 1 ] && expected_state=enabled
+	flags=$($LSATTR_PROG -d "$path" 2> $tmp.err) || {
+		cat $tmp.err >> $seqres.full
+		_fail "cannot read flags on $path"
+	}
+	flags=${flags%% *}
+	echo "lsattr $path: $flags" >> $seqres.full
+	[[ "$flags" == *F* ]] && actual=1
+	[ "$actual" -eq "$expected" ] || \
+		_fail "$path: expected casefold $expected_state, got flags $flags"
+}
+
+reject_casefold_change()
+{
+	local change=$1
+	local path=$2
+	local ret
+
+	$CHATTR_PROG "$change" "$path" > $tmp.err 2>&1
+	ret=$?
+	echo "chattr $change $path: exit $ret" >> $seqres.full
+	cat $tmp.err >> $seqres.full
+	[ "$ret" -ne 0 ] || \
+		_fail "chattr $change $path succeeded, expected EOPNOTSUPP"
+	# Check the SETFLAGS error, rather than accepting any chattr failure.
+	grep -Fq \
+		-e "Operation not supported while setting flags on $path" \
+		-e "Not supported while setting flags on $path" \
+		$tmp.err || \
+		_fail "chattr $change $path: expected EOPNOTSUPP, got exit $ret: $(cat $tmp.err)"
+}
+
+test_casefold()
+{
+	local folded=$1
+
+	root=$SCRATCH_MNT/ovl-$folded
+	lower=$root/lower
+	upper=$root/upper
+	work=$root/work
+	merge=$root/merge
+	mkdir "$root" || _fail "cannot create $root"
+	if [ "$folded" -eq 1 ]; then
+		_casefold_set_attr "$root" >> $seqres.full 2>&1 || \
+			_notrun "cannot enable casefold on the scratch filesystem"
+		change=-F
+		same=+F
+	else
+		change=+F
+		same=-F
+	fi
+	mkdir "$lower" "$upper" "$work" "$merge" || \
+		_fail "cannot create overlay directories"
+	mkdir "$lower/empty" "$lower/dir" || \
+		_fail "cannot create lower directories"
+	cp $tmp.data "$lower/dir/file" || _fail "cannot create lower file"
+	cp $tmp.data "$lower/file" || _fail "cannot create lower file"
+
+	if [ "$folded" -eq 1 ]; then
+		_mount -t overlay overlay "$merge" \
+			-o lowerdir="$lower",upperdir="$upper",workdir="$work" \
+			>> $seqres.full 2>&1 || \
+			_notrun "overlayfs does not support casefold enabled layers"
+	else
+		_mount -t overlay overlay "$merge" \
+			-o lowerdir="$lower",upperdir="$upper",workdir="$work" \
+			>> $seqres.full 2>&1 || _fail "cannot mount overlay"
+	fi
+
+	# A lower-only directory would be copied up as an empty upper directory,
+	# even when its merged view contains files. The upper root is also empty.
+	for path in "$merge/empty" "$merge/dir" "$merge"; do
+		check_casefold "$path" "$folded"
+		reject_casefold_change "$change" "$path"
+		check_casefold "$path" "$folded"
+		cmp $tmp.data "$merge/file" >> $seqres.full 2>&1 || \
+			_fail "$merge/file: not readable with expected contents after chattr $change $path"
+		cmp $tmp.data "$merge/dir/file" >> $seqres.full 2>&1 || \
+			_fail "$merge/dir/file: not readable with expected contents after chattr $change $path"
+	done
+
+	# chattr still issues SETFLAGS for a no-change request.
+	for path in "$merge/empty" "$merge/dir" "$merge"; do
+		echo "chattr $same $path" >> $seqres.full
+		$CHATTR_PROG "$same" "$path" >> $seqres.full 2>&1 || \
+			_fail "chattr $same $path: expected success for unchanged casefold state, got exit $?"
+		check_casefold "$path" "$folded"
+	done
+	_unmount "$merge" || _fail "cannot unmount overlay"
+	merge=
+	cmp $tmp.data "$lower/file" >> $seqres.full 2>&1 || \
+		_fail "$lower/file: not readable with expected contents"
+	cmp $tmp.data "$lower/dir/file" >> $seqres.full 2>&1 || \
+		_fail "$lower/dir/file: not readable with expected contents"
+}
+
+_scratch_mkfs_casefold >> $seqres.full 2>&1 || \
+	_fail "cannot format the casefold scratch filesystem"
+_scratch_mount_casefold || _fail "cannot mount the casefold scratch filesystem"
+printf 'sentinel\n' > $tmp.data
+
+# Try the enabled mount first so kernels without overlay casefold support
+# skip before reaching the actual attribute-change checks.
+echo "Casefold enabled" | tee -a $seqres.full
+test_casefold 1
+echo "Casefold disabled" | tee -a $seqres.full
+test_casefold 0
+
+_exit 0
diff --git a/tests/generic/998.out b/tests/generic/998.out
new file mode 100644
index 0000000..9f5c8b0
--- /dev/null
+++ b/tests/generic/998.out
@@ -0,0 +1,3 @@
+QA output created by 998
+Casefold enabled
+Casefold disabled

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231618;
	b=MTEQslC2y3puSwJahsqE+zlUMIGkrwQrIPnm3F3fD3njHurioKZaY1alfXVfrZ79dXE8
	 h57W4fhl9PU9Bb1YKweT2Ojbi938XK64jmJ0p9YZu+CfRtveZmlDCMm1oIsD+uQVs5Zxi
	 2mXQaPaksasJMWkhMb5XRrz0faEfhbP5TC9suTEqr1eEKEW9R8a74GxW27oJfcjAWWmp7
	 75PtY6WCz+chppjwjRfKIkcQ2H9uFMcdcTSTDIo9Cm2R5NgxnmyVLHvHgB60HA5IFG/a3
	 zjz2vHKfNxutNhFh+EQPhCBiN4su/BT1LIuzOlqeTD6jQgXcrq4l4crXVJl+aECx1sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231618;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aKetiHcnog3B9WA9mrg1F5tofSTonOtUz70J7M4ejuo=;
	b=AFgJA3RVBkcJ83rJRkQoW/nDC4Ccp5BgY/THRUtFpQr8W8HnAfejOx8nzEiPk1RDbzgv
	 FiVVvMGq68R44ImcLrCC2mKj/ftI1eunyffGLZJB8iwlqW9qMitMNvg79GpItWOtbB8pE
	 WhnxYVPp9v7MQhUmeWy9HPm4XkdT3c3KL0lw/KUOL4wq+fqPoxeUyLayEYCnwJfTlgE0G
	 9ibXV083bDk4Ra3pACWFwOFa9ebi14qaWjlcaoptOsE8Pa42iMqoBDLTsDy5n80nKKrXg
	 UPI8uvu9ExnG2Nvbc/0qPT5GtIP3iYSKhfQNavW/4GB9R7cYF7Ng7DpjN/cpX1kaQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=scrivano.org;
	spf=pass smtp.mailfrom=scrivano.org;
	dkim=pass header.d=scrivano.org header.i=@scrivano.org header.a=rsa-sha256 header.s=fm3 header.b=9DO21bdg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QN5SNZ0p;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32E2606A322
	for <fstests@vger.kernel.org>; Mon,  9 Nov 2026 13:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B32E2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=scrivano.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=scrivano.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=scrivano.org header.i=@scrivano.org header.a=rsa-sha256 header.s=fm3 header.b=9DO21bdg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QN5SNZ0p
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C55717A0152
	for <fstests@vger.kernel.org>; Mon,  9 Nov 2026 08:40:16 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 09 Nov 2026 08:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=scrivano.org; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1794231616; x=1794318016; bh=aKetiHcnog3B9WA9mrg1F
	5tofSTonOtUz70J7M4ejuo=; b=9DO21bdgjssYKPoKun95M6MqYp9yXOj9e/esk
	h4J0qql+bBdKGzbsQsQbhdn/KNATtDZuHI1tXcBz130XH9JTkwKGQ/UUPL8K4eGv
	0cydkKLDgB7w/lfFnIYzrNs2H5CucvQRyVeLFlnEHLpM1Z1uj5npUxAGyyI84e26
	Iw6wXcTpw4oSJZ1NpmJyvf5ZxJc8z7q3pz3+9YijDCv+BTnUyjdaa7AHn8Pxrr38
	T24pt5lVa07zHwimBCp8O7jTyslvH8ZTESuoQMFNygcU/iJgCznSbu3Ma3hMCET2
	pTKTFSmD57F4AT3Ik0DIYVHLFVrUaf8kgKPq1srOudgHaNbbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794231616; x=1794318016; bh=aKetiHcnog3B9WA9mrg1F5tofSTonOtUz70
	J7M4ejuo=; b=QN5SNZ0paup9CgdXiwctM/yEp/cZ6MbTn3WRhMgg9GcS7HdUzSq
	2LLabVQmcEbFygX1V3BFaxt4aFnuQp3kmpCdluZGqwniM5toNE8PNaLtYKXDkDUZ
	xy6DDbFZCSFcFDxL2qEjcfvjRwL0j08Vk77RqwdX7/Neryt60Dy2JOP6GbkYvmDG
	E3SzGUBQw6G115qNSXU9Qh61FqltseuJTJVsvXGU7JagSPtLZJs4wsecZIwDjgLT
	qIrr1ikidUh1yCGc9XBhbNSHdlQp0UqCuM7lsgFJ29JZF6/vSwLXTN2KibiXJnvs
	rYUVdy+CD5qhwgXLIQZo1Ud//amdpSUaxRw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=scrivano.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794231616; d=scrivano.org;
	mf=PGdpdXNlcHBlQHNjcml2YW5vLm9yZz4=;
	rt=PGZzdGVzdHNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm3:rsa-sha256:5FcLxwhuEeURrDYLuvfFajYPST/DjcGLRwGPoT8I5YhMbGh
	otj3qPiFgzr+Kg8blERzIBfPm6UOL4MJ4RA26R9niONc+k/RwepjCcUCOonMcMUF
	UHT2jkFDnJ/0Ldry9d9v3poBT+AEcW6lX3gRjesOJLoSfXKuqnDGgmxWSIoexK9j
	3i2Cc/7MS5sChYxUHh5OUJsjICW8zYqEw5LTgAqLx66qZO7+5nL5Us+puFKLsMf1
	UeC/7qSiJ4MRs9CimRV+gFfS/kkXY2+cTNgaBZXevaUm/wqzwYGUAJKSrmbC0mwm
	E61Mrm9ryPCag/yvu7M31kzDHQUCJRT/jMyOygw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:EJCqjbDEcmgS6XE4/SBQkRr6oOc/6rUOO8jOT2UwAoM=:qm0I0R+eTEKBh4VT69skFDjmrx6oGWaiaikGCrFun0o=;
X-ME-Sender: <xms:QM3xasDGHsyELqu1LqhKC8utBtFcvbA5m8rX1m44hkmbZ-sbHsBjQQ>
    <xme:QM3xasUtyyHqjWEqAWoOrPmkb6s3WyMgOXsWSS_k6_U3e2eZGsDdbN9-MOQlyqepg
    OX3hxlcgpeWvZt9dgUG1tQgZU_gXV3JV36n9OEjrMXkMkhxY8xfpNc>
X-ME-Received: <xmr:QM3xaqCwfqOcym5zsqBlA1bPVGKlb2BKR8ee8PPn5f5xn_Z9rU8ZQ9ocIhO7Uuz5Ahy7-0IM0Q1N0a9HT7maJpRGZa5p>
X-ME-Proxy-Cause: dmFkZTFRcHo5bCTJ8Ol/cST86/4UxScEFzhRY6sHF/G7EcP5isXRDAZM0tyBtrX2gAhUSa
    ZFf9ZnlFx/vwV+mgGI01AyOPEiegimnPpaoNT8c2WgXBAI5HGYhTbj1bjgAr8Mfi7qtHCq
    8dXRyCawYvv1nAYtzU2K927TF6JZZx/Y0Nib+gF44nOQhiQRSxfAkBBM2NEwu5+tygN/FM
    7/kGmNpllw/HEJm0B7M5W2VTBsHId1tBZyNrv58UABgSNCsIXPMOzPJ2XS4oQvA1G/9760
    zrEEnIgHjPCnrjdvtpWe2HcnJokpbntlJybc5g4JLVdDDbnzGc4Z+r1zxCECYlsPUvC2PX
    OYPaUXKImxdbifNnCYaDkcXzJVQ61ceCcVsmcnxlSLvK4ZCaDG1YkAwG0lo2AKGgJGqbrS
    IWPNmB/0ulMLNyQIJptSuDGRTtvgFpXWpOcHkpwUTIwyVDOqO3FNmvY5eXjCWMXB/g37As
    /DQq/9pmVpe8NZcB6wwbfGBscFaNv7CKJWLcps0NFOHX9pb2kXeTtkHmrw7QINgNjfeOM7
    V4CNF0ibmRZ2k6H/4Npx2CDaeVgzrsbVCL4frTy76Hf+9XnQ0qgoZHgy4RZWBQglibKs28
    8OK6jPRXK3slHkzALJZghLI4T2GGXiP1/XdQSLpYitAif2r1NxxRkF15IoWw
X-ME-Proxy: <xmx:QM3xav9Bt1GCEYfmPzyt4jCPaa4qSTMDECixfGksULs4eQw5ATSR0Q>
    <xmx:QM3xahFHUfFqs4RdNHUtX8pJmdKBOWzFiqgTZ_ewPflk_HV5bs3hcw>
    <xmx:QM3xatNuTSJU64d6WdoyY-e5h9wS6u2Zqr5CimZMpcdLlEICvJB6ZA>
    <xmx:QM3xardUIPSxLthVBOtnwjCBWLszP01xvSsd-OGIgdUq5qOO_bNy-g>
    <xmx:QM3xavZ-DcIl3bIFBui3h4bK6gCCkOsJxfDcpotdKytbrKBYi-pzoIdA>
Feedback-ID: i8e6e4897:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 08:40:15 -0500 (EST)
From: Giuseppe Scrivano <giuseppe@scrivano.org>
To: fstests@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org,
	amir73il@gmail.com
Subject: [PATCH fstests v2] overlay: add a test for redirect_dir=followdata
Date: Mon,  9 Nov 2026 14:38:28 +0100
Message-ID: <20261109134006.2555438-1-giuseppe@scrivano.org>
X-Mailer: git-send-email 2.56.0
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

Test that data-only layers select redirect_dir=followdata, which follows
redirects from lower to lowerdata from any lower layer, with userxattr
and trusted xattrs, and that redirect_dir=nofollow is refused with
data-only layers.

Also test following an absolute redirect past a lower layer that has the
parent directory of the target, which failed with EIO before the fix
"ovl: do not always clear absolute_redirect".

Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 common/overlay        |  15 +++++
 tests/overlay/090     | 149 ++++++++++++++++++++++++++++++++++++++++++
 tests/overlay/090.out |  43 ++++++++++++
 3 files changed, 207 insertions(+)
 create mode 100755 tests/overlay/090
 create mode 100644 tests/overlay/090.out

diff --git a/common/overlay b/common/overlay
index 8e89d6e4..382960c3 100644
--- a/common/overlay
+++ b/common/overlay
@@ -286,6 +286,21 @@ _require_scratch_overlay_datadir_without_metacopy()
 
 }
 
+# Check kernel support for the "redirect_dir=followdata" mount option
+_require_scratch_overlay_redirect_followdata()
+{
+	local lowerdir="$OVL_BASE_SCRATCH_MNT/$OVL_UPPER"
+	local datadir="$OVL_BASE_SCRATCH_MNT/$OVL_LOWER"
+
+	_scratch_mkfs > /dev/null 2>&1
+	_overlay_scratch_mount_opts \
+		-o"lowerdir+=$lowerdir,datadir+=$datadir" \
+		-o"userxattr,redirect_dir=followdata" > /dev/null 2>&1 || \
+		_notrun "overlay redirect_dir=followdata not supported on ${SCRATCH_DEV}"
+
+	_scratch_unmount
+}
+
 
 # Helper function to check underlying dirs of overlay filesystem
 _overlay_fsck_dirs()
diff --git a/tests/overlay/090 b/tests/overlay/090
new file mode 100755
index 00000000..6eeeacdf
--- /dev/null
+++ b/tests/overlay/090
@@ -0,0 +1,149 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Giuseppe Scrivano.  All Rights Reserved.
+#
+# FS QA Test 090
+#
+# Test the redirect_dir=followdata mount option.
+#
+# Data-only layers select redirect_dir=followdata, which follows redirects
+# from any lower layer to a data-only layer, and cannot be used with
+# redirect_dir=nofollow.
+#
+# Also test following an absolute redirect past a lower layer that has the
+# parent directory of the redirect target, with metacopy=on.
+#
+. ./common/preamble
+_begin_fstest auto quick metacopy redirect attr
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# We use non-default scratch underlying overlay dirs, we need to check
+# them explicitly after test.
+_require_scratch_nocheck
+_require_attrs user
+_require_attrs trusted
+_require_scratch_overlay_redirect_followdata
+_require_scratch_overlay_features redirect_dir metacopy
+_require_scratch_overlay_lowerdata_layers
+
+data=$OVL_BASE_SCRATCH_MNT/data
+l1=$OVL_BASE_SCRATCH_MNT/lower1
+l2=$OVL_BASE_SCRATCH_MNT/lower2
+l3=$OVL_BASE_SCRATCH_MNT/lower3
+upper=$OVL_BASE_SCRATCH_MNT/upper
+work=$OVL_BASE_SCRATCH_MNT/work
+layers="$l3:$l2:$l1::$data"
+
+# Make a metacopy file <file> with the redirect <redirect>, for both
+# userxattr and trusted xattr mounts
+make_stub()
+{
+	local file=$1 redirect=$2 x
+
+	touch $file
+	for x in user.overlay. ${OVL_XATTR_METACOPY%metacopy}; do
+		$SETFATTR_PROG -n ${x}metacopy $file
+		$SETFATTR_PROG -n ${x}redirect -v $redirect $file
+	done
+	truncate -s 4 $file
+}
+
+# Mount the layers $layers with the options <opts>, print redirect_dir=followdata
+# if the mount shows it and <opts> has userxattr or redirect_dir (otherwise it
+# depends on the kernel config), and the content of each of the following files,
+# or the error reading it
+check()
+{
+	local opts=$1 f
+
+	shift
+	echo "== $opts"
+	_overlay_scratch_mount_dirs "$layers" $upper $work -o $opts
+	case $opts in
+	*userxattr*|*redirect_dir=*)
+		_fs_options $OVL_BASE_SCRATCH_MNT | grep -o redirect_dir=followdata
+		;;
+	esac
+	for f; do
+		echo "$f: $(cat $SCRATCH_MNT/$f 2>&1 | sed 's/^cat: .*: //')"
+	done
+	_unmount $SCRATCH_MNT
+}
+
+# Mounting the layers $layers with the options <opts> must fail
+check_fail()
+{
+	local opts=$1
+
+	echo "== $opts"
+	_overlay_scratch_mount_dirs "$layers" $upper $work -o $opts \
+		>> $seqres.full 2>&1 && echo "mount succeeded" && \
+		_unmount $SCRATCH_MNT
+}
+
+_scratch_mkfs
+mkdir -p $data/base $l1/base $l2/base $l3 $upper $work
+echo -n "data" > $data/base/file
+
+make_stub $l1/s1 /base/file
+make_stub $l2/s2 /base/file
+make_stub $l3/s3 /base/file
+# The redirect target in a lower layer below s3, which is not looked up
+echo -n "lowr" > $l2/base/file
+# Redirects that are not followed: relative, directory, upper
+echo -n "lowr" > $l2/reltarget
+make_stub $l3/rel reltarget
+mkdir $l3/dir
+$SETFATTR_PROG -n user.overlay.redirect -v /base $l3/dir
+$SETFATTR_PROG -n $OVL_XATTR_REDIRECT -v /base $l3/dir
+make_stub $upper/up /base/file
+
+# followdata is selected by default with userxattr and a data-only layer
+check userxattr s1 s2 s3
+check userxattr,redirect_dir=followdata s1 s2 s3 rel dir up
+# a data-only layer cannot be used without following redirects
+check_fail userxattr,redirect_dir=nofollow
+check_fail userxattr,redirect_dir=off
+echo -n "no data-only layer "
+layers="$l3:$l2:$l1" check userxattr
+
+check metacopy=off s1 s2 s3
+check redirect_dir=followdata s1 s2 s3 rel dir up
+check redirect_dir=follow,metacopy=off s1 s2 s3
+check redirect_dir=on,metacopy=off s1 s2 s3
+check_fail redirect_dir=nofollow
+echo -n "no data-only layer "
+layers="$l3:$l2:$l1" check redirect_dir=nofollow
+
+# An explicit option requires a data-only layer and conflicts with metacopy=on
+_overlay_scratch_mount_dirs "$l3:$l2:$l1" $upper $work \
+	-o userxattr,redirect_dir=followdata >> $seqres.full 2>&1 && \
+	echo "mount redirect_dir=followdata without a data-only layer succeeded"
+_overlay_scratch_mount_dirs "$layers" $upper $work \
+	-o redirect_dir=followdata,metacopy=on >> $seqres.full 2>&1 && \
+	echo "mount with redirect_dir=followdata,metacopy=on succeeded"
+
+# The directory "/base" in a lower layer without a redirect must not make the
+# lookup forget that the redirect of the metacopy file is absolute.
+echo "== metacopy=on,redirect_dir=follow"
+_scratch_mkfs
+mkdir -p $data/base $l1 $l2
+echo -n "data" > $data/base/file
+touch $l1/file
+$SETFATTR_PROG -n $OVL_XATTR_METACOPY $l1/file
+$SETFATTR_PROG -n $OVL_XATTR_REDIRECT -v /base/file $l1/file
+truncate -s 4 $l1/file
+for f in "" base base/file; do
+	[ "$f" = base ] && mkdir $l2/base
+	[ "$f" = base/file ] && echo -n "lowr" > $l2/base/file
+	_overlay_scratch_mount_dirs "$l1:$l2::$data" - - \
+		-o ro,redirect_dir=follow,metacopy=on
+	echo "lower2 /$f: $(cat $SCRATCH_MNT/file 2>&1 | sed 's/^cat: .*: //')"
+	_unmount $SCRATCH_MNT
+done
+
+# success, all done
+_exit 0
diff --git a/tests/overlay/090.out b/tests/overlay/090.out
new file mode 100644
index 00000000..c2f576e2
--- /dev/null
+++ b/tests/overlay/090.out
@@ -0,0 +1,43 @@
+QA output created by 090
+== userxattr
+redirect_dir=followdata
+s1: data
+s2: data
+s3: data
+== userxattr,redirect_dir=followdata
+redirect_dir=followdata
+s1: data
+s2: data
+s3: data
+rel: Operation not permitted
+dir: Operation not permitted
+up: Operation not permitted
+== userxattr,redirect_dir=nofollow
+== userxattr,redirect_dir=off
+no data-only layer == userxattr
+== metacopy=off
+s1: data
+s2: data
+s3: data
+== redirect_dir=followdata
+redirect_dir=followdata
+s1: data
+s2: data
+s3: data
+rel: Operation not permitted
+dir: Operation not permitted
+up: Operation not permitted
+== redirect_dir=follow,metacopy=off
+s1: data
+s2: data
+s3: data
+== redirect_dir=on,metacopy=off
+s1: data
+s2: data
+s3: data
+== redirect_dir=nofollow
+no data-only layer == redirect_dir=nofollow
+== metacopy=on,redirect_dir=follow
+lower2 /: data
+lower2 /base: data
+lower2 /base/file: lowr
-- 
2.56.0


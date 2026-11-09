Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794225008;
	b=c7M+QhGhF0uiJ6lMqg/ikugvsPwR9BGFU8wqyBm4e6ffiCM/izymIuvQdVnL3l8/UIda
	 pFj62tTJL5g7gCDebT7+xZ9IEZp5WoYaYhYmOCgur5C13VL6YMUG3MJePjFyiLsjzF8h9
	 AAiZuwDmZoPjhWsHJ0sCA54x09tbvjdRIflttyoeFO5zyxBs9GDXVeB97/H7FlMB0ex39
	 CUWk0zPRxv8EahuckYqEsb13IiXGQmvvFRdpCJ8hE5z0EucxCLndJxJ4XziEEcSJYGf2c
	 hzG4O9QqWMbJsP4CkcBUqWJnTje1ZT3+luKRCbFsmO2lnBXOE4/HvZj3VkmxaIITPkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225008;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=dUXJbPkbPQbxqnKJ8y0qnmrfPGLpFP/HxY2nsE4CeoY=;
	b=M+qo+EjKYmFyXcAqJCmbkOxo7ikK9oJHjP4tZtAnPun+N5Zb/bGVUPnPxHXfeyogQiCG
	 GjJ7XCwzqnyc3FcP/8Vi1mTPjA2rnnHfvjLZoFPKkJT8tBIPOEAr9xRiiIYUpOfg7S15Q
	 uyoyI41N4pjKACs/o71QdMlfxmlOPNkZrbYKOPD6qlc1p0WCDlp1gCE1E5dWt/wFU3itG
	 yOBFcg5CwQ7wVvPZkmMrfqDT3fYRGVPIYZ5YN4ORldTCowG2tEoIRJYAwYHsV/b2STy3A
	 /XN6IOOpMulizaN3+bFfudaiikx5s1KBqeDjpdOV4pkiEuCDmv4SDROeJhLBoaMNHKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ly7TFV1W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.44
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAC0606A334
	for <fstests@vger.kernel.org>; Mon,  9 Nov 2026 11:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CAC0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ly7TFV1W
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b566cf56c1so949831a12.2
        for <fstests@vger.kernel.org>; Mon, 09 Nov 2026 03:50:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794225007; cv=none;
        d=google.com; s=arc-20260327;
        b=UupY8wCxvSg0UEskOHYCOcDjwTjl5x3k60YGdmRmICoXoueKo1ANQYe/CFtxg7HN3f
         17nNzTypZDMzI1vk4igATBLA3YSKbjlmMAsuqjbQ81b840ht0OZw6hCeFScFt2BRZGrG
         cpvIqXafw1/sRXIHh9UDj7UQfpwuQiQdEERBJr1YNDCOYLBhvWPMkYGpxfouUQbkuPgf
         hxPR0ShT5cM+JEDcWIeGfhkJV3vDVaF65Iu844ctUMOBIKw7jQzfFz3BsWx9AedZzgt6
         0UdahVexl0i27fjdms39YSGBAAMqHy1JdZEsaNDUykUMztgQijPECoXTpEXkzJuhX+a1
         Kb4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dUXJbPkbPQbxqnKJ8y0qnmrfPGLpFP/HxY2nsE4CeoY=;
        fh=KwMEtdkmyVjNwGs2Qh1Hxc3ZiVL7IU7E5hZcRIv0Vmg=;
        b=dXAt5tNjp1flB2u6byPFE2B2c09hSKY2RWzyH0hYhWTrBRdk+Dz926nDo6uTHqb4XG
         sAL3QsM7R+p7uyIvrG7FijgOSLDT7FCLSzNSD71KEi2lOGV4ZjPLmpjI/HOQ7xyf9EcP
         BgctrPNMRTZjamPKPF7BLZoVFbT+K4+1eRqGsXhLJuex4UeUJLmlxUTSPwNtcYK/uYYu
         tczoshAvcgYf1aTqLXAxuGabnMkITIND2GVwJBrysxTBDrwthVue1stlKnBiSeVLbpr6
         AlL7rijkV/H1op1DzQ1grxOLtwXMR4bvRQcJjZR3j7Q8U45tNivmwr55MDOJeBlK5JbJ
         afMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794225007; x=1794829807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dUXJbPkbPQbxqnKJ8y0qnmrfPGLpFP/HxY2nsE4CeoY=;
        b=Ly7TFV1WCO4oStUtHoBcWLJYrwr5cwsv6OZDWPQ/yHoZ4m69aYMO/Ue2yamef+l68v
         JTsFpIVVmYYC+Ii7s1+Qc/97yINgfv4wMSKE8zDOyZwQDzWgNGunn1+AaWq7w1xs0Tac
         nSGEr1sf6Um8WPwFX6yUref5SYpO/2hRI9sDuVZ7ryZAWqxwPfElBoVrDtUD671eOlwE
         Ov0NXQE7FH/jghjZwrG0y2WoHz1vtj7KESXRMOuuoax7lo6zN1fSpzxFFuZLUQbOUBLh
         Ie//IsDMhfsi+Fr8jKdo2DKW5ljuV2J2fzzl4WiNsBlL1DmHBa3rbfzV2X/QNQIKC9Kg
         /HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794225007; x=1794829807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dUXJbPkbPQbxqnKJ8y0qnmrfPGLpFP/HxY2nsE4CeoY=;
        b=G7sxLgE7z18tm2fTkfUMh2m4ggaw3/mChOpghmtGtppe3TrmLLxKtM81zDebA3OGBy
         8qGyKaoV5PGW4JCZwbbGOR4yO3MOWx0JvMl5LWJIxi/wnKeJw9Ov37phjLcMn3gQvKUa
         X9ZHZ66akpzpyDalB9ZQ6feVhHb5Ik5nve//wkhx/XNEMPXx1Z13m3lcN+XD0h4+Gxo3
         TfgVQ++tYmHxnzQ6Wu1JesCAfvTv0d0psGIpuT3En6RXDKXkGQpJUM9YSYuVyY03sg+g
         U3aQju3HEwIlf7krmX0C+gRLSJvCM7YZI2FExuYNQtP34D/7Yk8dgovntvnoLURXYVcs
         Xcjg==
X-Gm-Message-State: APuU4Z++gse/nioTO+YgVAUQJfdZJRLbg1oS+FoMPs8L4vn+4DTSbfbR
	mfKHNUWadYkvECFkxwW0UI7tlybdnnavVmC0e5F2++Ec0+CHAlpvtiAYwGfKc6mG1v5inKM0nFP
	8xoFzv3N4JCt4odAK3+Orq6ilY5GgIUGkmNK2Kyo=
X-Gm-Gg: AYBFou2ayPJtj6LmHteDb1jVfZofcfIdiJuCZz5sBf5lx/RXbnIDTRUJmITuw/p17/G
	XbEnlyySEbup+qdswq8EY8aaQk7agkOOGKwv/uTior6KXPlnkRUpxtSzlsok17/kf2e7cxzx8MA
	36/G8x/usgPv3YP7vtMOdS3RvqgMvMJ4QdR4OMB7DjGHaA8/ke9PSMVS2waghn5t4wrgsmr+Cll
	4FFtBJGMvvV5NehBshourB5BGa8wb16uhb8HiakyJRCHMmje2/4vhjbrvgqKh1KYO2MCQODiUOd
	f0czSC5qm7JWeXAYjE1uaW3ZjxpFxk34ii089R99/bP+9YeXwtDkzNskLvFsUZtykOgxnGCDfdc
	tyE2EhEnl8a+C0y56E7ZAMHw/BJqfwNSlQzOEcD6T3IFeADAqnhWeKO7GTIktP04/xF67raQHKO
	J1LIZr0U50sMvDK1o=
X-Received: by 2002:a05:6402:2116:b0:6b5:911a:f4be with SMTP id
 4fb4d7f45d1cf-6b7223f91e1mr2252630a12.13.1794225006497; Mon, 09 Nov 2026
 03:50:06 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107213943.1765902-1-giuseppe@scrivano.org>
In-Reply-To: <20261107213943.1765902-1-giuseppe@scrivano.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 9 Nov 2026 12:49:54 +0100
X-Gm-Features: AclHuK_-gij5Sey83fEjiKFLIVqziqeoiL41T17fc3I4PhkdpIK24T1LXyLPRTU
Message-ID: <CAOQ4uxicSe4Fk2twHoQUKQNz5BNGiDDnz-b-kVBON__M7rwUMw@mail.gmail.com>
Subject: Re: [PATCH fstests] overlay: add a test for redirect_dir=followdata
To: Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 10:39=E2=80=AFPM Giuseppe Scrivano <giuseppe@scrivan=
o.org> wrote:
>
> Test that data-only layers select redirect_dir=3Dfollowdata, which follow=
s
> redirects from lower to lowerdata from any lower layer, with userxattr
> and trusted xattrs, and that redirect_dir=3Dnofollow is refused with
> data-only layers.
>
> Also test following an absolute redirect past a lower layer that has the
> parent directory of the target, which failed with EIO before the fix
> "ovl: do not always clear absolute_redirect".
>
> Signed-off-by: Giuseppe Scrivano <giuseppe@scrivano.org>

Very nice!

Apart from some nits below feel free to add

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  common/overlay        |  15 ++++
>  tests/overlay/090     | 158 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/090.out |  49 +++++++++++++
>  3 files changed, 222 insertions(+)
>  create mode 100755 tests/overlay/090
>  create mode 100644 tests/overlay/090.out
>
> diff --git a/common/overlay b/common/overlay
> index 8e89d6e4..382960c3 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -286,6 +286,21 @@ _require_scratch_overlay_datadir_without_metacopy()
>
>  }
>
> +# Check kernel support for the "redirect_dir=3Dfollowdata" mount option
> +_require_scratch_overlay_redirect_followdata()
> +{
> +       local lowerdir=3D"$OVL_BASE_SCRATCH_MNT/$OVL_UPPER"
> +       local datadir=3D"$OVL_BASE_SCRATCH_MNT/$OVL_LOWER"
> +
> +       _scratch_mkfs > /dev/null 2>&1
> +       _overlay_scratch_mount_opts \
> +               -o"lowerdir+=3D$lowerdir,datadir+=3D$datadir" \
> +               -o"userxattr,redirect_dir=3Dfollowdata" > /dev/null 2>&1 =
|| \
> +               _notrun "overlay redirect_dir=3Dfollowdata not supported =
on ${SCRATCH_DEV}"
> +
> +       _scratch_unmount
> +}
> +
>
>  # Helper function to check underlying dirs of overlay filesystem
>  _overlay_fsck_dirs()
> diff --git a/tests/overlay/090 b/tests/overlay/090
> new file mode 100755
> index 00000000..18e3d1f5
> --- /dev/null
> +++ b/tests/overlay/090
> @@ -0,0 +1,158 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Giuseppe Scrivano.  All Rights Reserved.
> +#
> +# FS QA Test 090
> +#
> +# Test the redirect_dir=3Dfollowdata mount option.
> +#
> +# Data-only layers select redirect_dir=3Dfollowdata, which follows redir=
ects
> +# from any lower layer to a data-only layer, and cannot be used with
> +# redirect_dir=3Dnofollow.
> +#
> +# Also test following an absolute redirect past a lower layer that has t=
he
> +# parent directory of the redirect target, with metacopy=3Don.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick metacopy redirect verity attr

pls remove verity

> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +. ./common/verity

pls remove verity

> +
> +# We use non-default scratch underlying overlay dirs, we need to check
> +# them explicitly after test.
> +_require_scratch_nocheck
> +_require_attrs user
> +_require_attrs trusted
> +_require_scratch_overlay_redirect_followdata
> +_require_scratch_overlay_verity

Please remove verity requirement and the single verity test case
It is not worth the test coverage lost by not running on most base fs
and the followdata code changes are mostly orthogonal to verity anyway.

> +_require_scratch_overlay_features redirect_dir metacopy
> +_require_scratch_overlay_lowerdata_layers
> +
> +data=3D$OVL_BASE_SCRATCH_MNT/data
> +l1=3D$OVL_BASE_SCRATCH_MNT/lower1
> +l2=3D$OVL_BASE_SCRATCH_MNT/lower2
> +l3=3D$OVL_BASE_SCRATCH_MNT/lower3
> +upper=3D$OVL_BASE_SCRATCH_MNT/upper
> +work=3D$OVL_BASE_SCRATCH_MNT/work
> +layers=3D"$l3:$l2:$l1::$data"
> +
> +# Make a metacopy file <file> with the redirect <redirect> and the optio=
nal
> +# metacopy xattr value <metacopy> (default: no fs-verity digest), for bo=
th
> +# userxattr and trusted xattr mounts
> +make_stub()
> +{
> +       local file=3D$1 redirect=3D$2 metacopy=3D$3 x
> +
> +       touch $file
> +       for x in user.overlay. ${OVL_XATTR_METACOPY%metacopy}; do
> +               $SETFATTR_PROG -n ${x}metacopy ${metacopy:+-v $metacopy} =
$file
> +               $SETFATTR_PROG -n ${x}redirect -v $redirect $file
> +       done
> +       truncate -s 4 $file
> +}
> +
> +# Mount the layers $layers with the options <opts>, print redirect_dir=
=3Dfollowdata
> +# if the mount shows it and <opts> has userxattr or redirect_dir (otherw=
ise it
> +# depends on the kernel config), and the content of each of the followin=
g files,
> +# or the error reading it
> +check()
> +{
> +       local opts=3D$1 f
> +
> +       shift
> +       echo "=3D=3D $opts"
> +       _overlay_scratch_mount_dirs "$layers" $upper $work -o $opts
> +       case $opts in
> +       *userxattr*|*redirect_dir=3D*)
> +               _fs_options $OVL_BASE_SCRATCH_MNT | grep -o redirect_dir=
=3Dfollowdata
> +               ;;
> +       esac
> +       for f; do
> +               echo "$f: $(cat $SCRATCH_MNT/$f 2>&1 | sed 's/^cat: .*: /=
/')"
> +       done
> +       _unmount $SCRATCH_MNT
> +}
> +
> +# Mounting the layers $layers with the options <opts> must fail
> +check_fail()
> +{
> +       local opts=3D$1
> +
> +       echo "=3D=3D $opts"
> +       _overlay_scratch_mount_dirs "$layers" $upper $work -o $opts \
> +               >> $seqres.full 2>&1 && echo "mount succeeded" && \
> +               _unmount $SCRATCH_MNT
> +}
> +
> +_scratch_mkfs
> +mkdir -p $data/base $l1/base $l2/base $l3 $upper $work
> +echo -n "data" > $data/base/file
> +_fsv_enable $data/base/file
> +digest=3D$(_fsv_measure $data/base/file)

pls remove verity

> +
> +make_stub $l1/s1 /base/file
> +make_stub $l2/s2 /base/file
> +make_stub $l3/s3 /base/file
> +# The redirect target in a lower layer below s3, which is not looked up
> +echo -n "lowr" > $l2/base/file
> +# Redirects that are not followed: relative, directory, upper
> +echo -n "lowr" > $l2/reltarget
> +make_stub $l3/rel reltarget
> +mkdir $l3/dir
> +$SETFATTR_PROG -n user.overlay.redirect -v /base $l3/dir
> +$SETFATTR_PROG -n $OVL_XATTR_REDIRECT -v /base $l3/dir
> +make_stub $upper/up /base/file
> +# fs-verity digest of a metacopy file in a middle layer: right and wrong
> +make_stub $l2/vok /base/file 0x00240001${digest#sha256:}
> +make_stub $l2/vbad /base/file "0x00240001$(printf '%064d' 0)"

pls remove verity

> +
> +# followdata is selected by default with userxattr and a data-only layer
> +check userxattr s1 s2 s3
> +check userxattr,redirect_dir=3Dfollowdata s1 s2 s3 rel dir up
> +# a data-only layer cannot be used without following redirects
> +check_fail userxattr,redirect_dir=3Dnofollow
> +check_fail userxattr,redirect_dir=3Doff
> +echo "(no data-only layer)"

Suggest echo -n "no data-only layer "
will make the expected output more clear as part of the test case title

> +layers=3D"$l3:$l2:$l1" check userxattr
> +check userxattr,redirect_dir=3Dfollowdata,verity=3Drequire vok vbad

pls remove verity

> +
> +check metacopy=3Doff s1 s2 s3
> +check redirect_dir=3Dfollowdata s1 s2 s3 rel dir up
> +check redirect_dir=3Dfollow,metacopy=3Doff s1 s2 s3
> +check redirect_dir=3Don,metacopy=3Doff s1 s2 s3
> +check_fail redirect_dir=3Dnofollow
> +echo "(no data-only layer)"

Suggest echo -n "no data-only layer "

> +layers=3D"$l3:$l2:$l1" check redirect_dir=3Dnofollow
> +
> +# An explicit option requires a data-only layer and conflicts with metac=
opy=3Don
> +_overlay_scratch_mount_dirs "$l3:$l2:$l1" $upper $work \
> +       -o userxattr,redirect_dir=3Dfollowdata >> $seqres.full 2>&1 && \
> +       echo "mount without a data-only layer succeeded"

"mount redirect_dir=3Dfollowdata without a data-only layer succeeded"

> +_overlay_scratch_mount_dirs "$layers" $upper $work \
> +       -o redirect_dir=3Dfollowdata,metacopy=3Don >> $seqres.full 2>&1 &=
& \
> +       echo "mount with metacopy=3Don succeeded"
> +

"mount with edirect_dir=3Dfollowdata,metacopy=3Don succeeded"

Thanks!
Amir.

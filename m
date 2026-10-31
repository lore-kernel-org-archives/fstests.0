Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793454402;
	b=EkC6tVe/wbjGtA6oSYZbPtHFqzZshGFqDkr3mLI+xk/ktHDGHxObuzTz+QUOAt9xgqTE
	 F7I/G4nPG56+i8CamgX/XyLP/Vt4/+ckQS2fdGqRSqpYyjh7C114S4h4/JS6FL437e4Mo
	 9GUkXqhCOymQOaiDfzgMNSuGSgVEVyM0MhhCFhowxjyftJyzJcmAVZH1zgJhxmjplw/T4
	 gxQ4j/zJVCAkeLIogCXdjcTuTiw2zC4hXY5aCMrBxw4QTkuareM43wTsZI6f6i1GuVwC2
	 X9WmTuQy0pjZhY26v6Fe0OYVZbk3UCxnmgc05rweqdx5YQ53rAWqGHbp5X14ZBhA8Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793454402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=X5EX68t3lgYy8aL32JMDhHXSm9kwVR4Q2e7Y7dDt2Z4=;
	b=txbM0YH/jczyju4X0LinLKsE1Aqg7fix5M7eLJvgIdk8YTdAoRfvBA2DCbAAqQpZQmFF
	 3T6UtxKAq2cV0q+f/tM+of8B0QWgiLrUHDOMDGjHhd4KrToiRJgD5lfrMu9XRCgDtory7
	 WpJNgChA/+mQd4A9o8uHpuu8D+4g8zCmeBFO4kTL/oCND/ZbX9Wj0zN28Y6SCjqp9rX4S
	 3u3BajtssCJRN0BAq9Q6L50hZAGUKBuw8NDf2x4JgJbr77g9sAbYe6AtgXQ6gt9nez+Sr
	 V/Oht34BAreKN0Q2KxnpPaR87cpKvSHBOl7eCMqGYnEfIFESy/xQYRZyWpfbUvxnSYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xw4wl5v;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D5F606A31D
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 13:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92D5F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0xw4wl5v
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1f31c63ebso4334013a12.0
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 06:46:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793454400; cv=none;
        d=google.com; s=arc-20260327;
        b=Eq+zUpVkwiw46KEXeAjiCUL8l6Ik86+x+6jlZb2vaSi2CceJRb4p+A4tZGl/PosmRk
         OAhzPydKtcYJaxNdKccQK2NXsM7NB+yJjmRGxVHCslPLMbME21u5A5H4t9kItEw+qzbl
         SCIy3g/KQM8eyDS/nF39ktN1b1X1ttRgku9lgTjtRUXUW4n9xBaBGtYKhUQenDJYWGZe
         jHeNNdDiYkTR9ZiN+muuzk54vw8Fvg7vZ/JDddwFJMgV7SbLb8ls5CVY0RlchgKX5XRK
         hnIipNyXy8RO4dFUnl+2jZ+mONFAj4kXkaLSGDr3/SFj1SeZyJPNoXRuznQnxnh2wuYI
         qWXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=X5EX68t3lgYy8aL32JMDhHXSm9kwVR4Q2e7Y7dDt2Z4=;
        fh=ofQe/fd0s1IdeVF54uID+f/cdtEddT48gEwYKZNYpCA=;
        b=IFlgP+V8+oVha0XMhASistJ91IoqxQ3Unyed+7UrrFCJr5BM/4+7XZbSRzOUAoYBx9
         ixmLEB+7rD5B8N30xIZPnaLifx32OB7WJxDE//n6B/YI34nNSBcP1qLosXLJyV+zK63Q
         WfpWI02gwZ+1asA6tsQ3DyYj8DoBihZfooG1Hq1/7T4gB+fQBt2qZ3xfLkwKLaJ6xeR4
         tJCFAAwWtzSNEjh6xKwrpnaAA3U3pHJWYOqATDKjTa2RN2beFJ8wNNAI9B7nrK+r8GjP
         yI6sT6vpmi9woku3dKQyJ0MHhcwOU7rJnunJ3m6HDGA0T5i4LOI+nGJ9+O+jMUy5Gz1C
         W8oA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793454400; x=1794059200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X5EX68t3lgYy8aL32JMDhHXSm9kwVR4Q2e7Y7dDt2Z4=;
        b=0xw4wl5vmtevFyuJumDu4WS7jSqr8jITFirLgy91vr1k/xWKlMSNFIu0fO6FkkgPpQ
         sI9rB2NGsZfVQ8qQy06uM1jx4Ma3HEmWfoeP1KaPOOFTIjT3oMC3vBisq6nzByE0zW+e
         oWrTfA7ylwPSPc2A6k4VWfeMqIiXKZ/c7UtpK16fIKfYkYZ5a8I2mqWm3e6dlfdgd/yn
         3CVwZCqXSG2y1GjzAdSh9AMDAfFifCsn3V4gFgjRcSJWS3d1cIkBgNERX0uWfc1CEDLX
         2HKr9WN7qLZkCOqFTq95SGfvO8If12IbNA0/zkUR9uQenSNdZtQ8TEWe3UefGteZm691
         zKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793454400; x=1794059200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X5EX68t3lgYy8aL32JMDhHXSm9kwVR4Q2e7Y7dDt2Z4=;
        b=ryncvBF5m0SoiTIny+7qpsPVBKmphrcecI0VRcpZbTx/jIXyl2xQ2Wvfy2NZDR//aT
         A2/CZreoeLtj4u6tuegvbbMaPSDJ0u/apcHibWVIoQuhaus2YxkUMF/s+EnQv8a1DiCw
         QExQlmI1A5C3t90DD0yQVolU7g8r2Cn9UmZhATUQ6kkp1eDi3tl2k0Mz99/Pm8Bdq52z
         jPUnKxLGlBkvQY/brC8djgI4Z1nRMhG4bG5yfETvZHNVAO9ET08C5wVV51rLmBuxce03
         HlotPgZKtuF57inlQFx3xrr23kEdkXtcBt9ICBwg5sAZhJnyNTaIoNtTXKRBN62Invht
         Jeqw==
X-Gm-Message-State: AFq9FYKT/ST2ohK9yI+LjzgeiiJ2Pf1LHSa1a6ZonmOhOd7TJkahAsMG
	v0vEQKq8vt/lufyqv1joZYEjRC+/Lx4t9Qwr+QCrZBxQUM+8JMovNBHHUBuAfqobonZbHRVDG8J
	M4Nhsg/QXFoTitg9JF/BgqR6PFwBVAQ4=
X-Gm-Gg: AYBFou066U8w6Dyl8aUNhBCudVmBsXz13H3pWBEQLBb+YHoOMX/NCEltixitODHuFNN
	buryaWOiiruvFShxJIfYe9RSwKlOlQIZ8gAZlBaSGsAoCWJPAS8DzzG7bRzJUXwm1UJB2k9FT5H
	6gdXMuchXpzZ8ToDZmP7iL9sHyOa/19yT9Jn9RQsdJUGv9Pm9Z8sMmkBKcLTPg5lkb4fSjtjyNa
	KtSeweus6uB0nYvZNQT6p48TCoKGCywn9agmaX9eSQE3p/hHZP8cAux8cvPgu0nVvnnDkInfAVD
	Gc52c7H5ucF79ZSusEsEUMTB/AzUA6rKdPXQURnFq7reJVe3Rd/KqbjAO+PcB6ZJ6ssGmD5WKul
	/Y5POVVl83wr0nqK40E3XcLomYhzbeZo7Ke2VtOPpX0gO1rG4edIJ7Ceiu8kVkZCuRu3H3R4=
X-Received: by 2002:a17:907:3fa0:b0:c40:2439:4d9a with SMTP id
 a640c23a62f3a-c49d14c4200mr743929466b.28.1793454399554; Sat, 31 Oct 2026
 06:46:39 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031091948.18985-1-dennylin0707@gmail.com> <20261031091948.18985-3-dennylin0707@gmail.com>
In-Reply-To: <20261031091948.18985-3-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 31 Oct 2026 14:46:27 +0100
X-Gm-Features: AclHuK9CU61B28gN3TBdlDnr1TSsP2sHMWfgmMCXuayAsYQLlNs6pLnarmAC-8k
Message-ID: <CAOQ4uxh-EADpfSTdAzQLA7jMKk0v=r0Un_P1ycDqX7FZMF82ig@mail.gmail.com>
Subject: Re: [PATCH 2/2] generic: test whiteouts on casefolded overlay layers
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 10:20=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com=
> wrote:
>
> Whiteout creation in casefolded directories can fail when removing
> names that exist in a lower layer.
>
> Exercise unlink and rmdir for lower-only names, a copied-up file and a
> merged directory, including lookups with different ASCII case. Also
> recursively remove a populated lower directory. Check that removed names
> stay hidden after recreation and a mount cycle, while the surviving file
> and the lower layer remain unchanged.
>
> This covers "ovl: fix whiteout creation in casefolded directories" from
> the casefold fixes series linked below.
>
> Regular-file lookup and copy-up also need the separate "ovl: check the
> casefold flag of directories only" fix, included in the tested overlayfs
> ovl-fixes baseline at 1d27da7de3f7.
>
> Link: https://lore.kernel.org/linux-unionfs/20261030113201.2921633-1-amir=
73il@gmail.com/
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Thank you for following up on this

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  tests/generic/999     |  148 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/generic/999.out |    2 +
>  2 files changed, 150 insertions(+)
>
> diff --git a/tests/generic/999 b/tests/generic/999
> new file mode 100755
> index 0000000..75e13b5
> --- /dev/null
> +++ b/tests/generic/999
> @@ -0,0 +1,148 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Hungyu Lin.  All Rights Reserved.
> +#
> +# FS QA Test 999
> +#
> +# Check removal of files and directories from casefolded overlay layers,
> +# including copied-up files, merged directories and recursive removal.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick dir casefold
> +
> +_cleanup()
> +{
> +       cd /
> +       [ -n "$merge" ] && _unmount "$merge" 2>/dev/null
> +       rm -f $tmp.*
> +}
> +
> +. ./common/filter
> +. ./common/casefold
> +
> +_exclude_fs overlay
> +_require_extra_fs overlay
> +_require_scratch
> +_require_scratch_casefold
> +_fixed_by_kernel_commit xxxxxxxxxxxx "ovl: fix whiteout creation in case=
folded directories"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "ovl: check the casefold flag of directories only"
> +
> +mount_overlay()
> +{
> +       _mount -t overlay overlay "$merge" \
> +               -o lowerdir=3D"$lower",upperdir=3D"$upper",workdir=3D"$wo=
rk"
> +}
> +
> +check_absent()
> +{
> +       local name=3D$1
> +       local ret
> +
> +       stat "$merge/$name" > $tmp.stat 2>&1
> +       ret=3D$?
> +       echo "stat $merge/$name: exit $ret" >> $seqres.full
> +       cat $tmp.stat >> $seqres.full
> +       [ "$ret" -ne 0 ] || _fail "$name: expected ENOENT, stat succeeded=
"
> +       grep -q ': No such file or directory$' $tmp.stat || \
> +               _fail "$name: expected ENOENT, got $(cat $tmp.stat)"
> +}
> +
> +check_view()
> +{
> +       local phase=3D$1
> +       local name
> +
> +       echo "Checking merged view $phase" >> $seqres.full
> +       for name in lowerfile anotherfile copyfile lowerdir mergeddir tre=
e upperonly; do
> +               check_absent "$name"
> +               check_absent "$(printf '%s' "$name" | tr a-z A-Z)"
> +       done
> +       cmp $tmp.data "$merge/keep" >> $seqres.full 2>&1 || \
> +               _fail "$merge/keep: not readable with expected contents $=
phase"
> +       ls -1 "$merge" > $tmp.names || _fail "cannot list $merge $phase"
> +       printf 'keep\n' > $tmp.expected
> +       diff -u $tmp.expected $tmp.names >> $seqres.full 2>&1 || \
> +               _fail "$merge: expected only keep $phase (directory listi=
ng in $seqres.full)"
> +}
> +
> +_scratch_mkfs_casefold >> $seqres.full 2>&1 || \
> +       _fail "cannot format the casefold scratch filesystem"
> +_scratch_mount_casefold || _fail "cannot mount the casefold scratch file=
system"
> +root=3D$SCRATCH_MNT/ovl
> +lower=3D$root/lower
> +upper=3D$root/upper
> +work=3D$root/work
> +merge=3D$root/merge
> +mkdir "$root" || _fail "cannot create $root"
> +_casefold_set_attr "$root" >> $seqres.full 2>&1 || \
> +       _notrun "cannot enable casefold on the scratch filesystem"
> +mkdir "$lower" "$upper" "$work" "$merge" || \
> +       _fail "cannot create overlay directories"
> +
> +printf 'lower data\n' > $tmp.data
> +printf 'upper data\n' > $tmp.upper
> +for name in lowerfile anotherfile copyfile keep; do
> +       cp $tmp.data "$lower/$name" || _fail "cannot create lower $name"
> +done
> +mkdir "$lower/lowerdir" "$lower/mergeddir" "$lower/tree" "$upper/mergedd=
ir" || \
> +       _fail "cannot prepare lower and merged directories"
> +for name in one two; do
> +       cp $tmp.data "$lower/tree/$name" || _fail "cannot create lower tr=
ee/$name"
> +done
> +cp $tmp.upper "$upper/upperonly" || _fail "cannot create upper-only file=
"
> +mount_overlay >> $seqres.full 2>&1 || \
> +       _notrun "overlayfs does not support casefold enabled layers"
> +
> +# Copy up through the overlay, without changing the backing layers direc=
tly.
> +cat $tmp.upper > "$merge/copyfile" || _fail "copy-up write failed"
> +cmp $tmp.upper "$upper/copyfile" >> $seqres.full 2>&1 || \
> +       _fail "copyfile was not copied up with the expected data"
> +
> +# The first removal is a control that does not need a lower whiteout.
> +rm "$merge/upperonly" || \
> +       _fail "cannot remove upper-only file"
> +rm "$merge/lowerfile" || \
> +       _fail "cannot remove lower-only file"
> +rm "$merge/ANOTHERFILE" || \
> +       _fail "cannot remove another lower-only file using different case=
"
> +rm "$merge/COPYFILE" || \
> +       _fail "cannot remove copied-up file using different case"
> +rmdir "$merge/LOWERDIR" || \
> +       _fail "cannot remove lower-only directory using different case"
> +rmdir "$merge/mergeddir" || \
> +       _fail "cannot remove merged directory"
> +# Removing the children leaves whiteouts in the copied-up directory.
> +rm -r "$merge/TREE" || _fail "cannot recursively remove lower directory"
> +check_view "after removal"
> +
> +cat $tmp.upper > "$merge/LOWERFILE" || _fail "cannot recreate removed na=
me"
> +cmp $tmp.upper "$merge/lowerfile" >> $seqres.full 2>&1 || \
> +       _fail "recreated name is not accessible with different case"
> +rm "$merge/lowerfile" || \
> +       _fail "cannot remove recreated name"
> +check_view "after recreating and removing a name"
> +
> +_unmount "$merge" || _fail "cannot unmount overlay"
> +mount_overlay >> $seqres.full 2>&1 || _fail "cannot remount overlay"
> +check_view "after remount"
> +_unmount "$merge" || _fail "cannot unmount overlay"
> +merge=3D
> +
> +for name in lowerfile anotherfile copyfile keep; do
> +       cmp $tmp.data "$lower/$name" >> $seqres.full 2>&1 || \
> +               _fail "$lower/$name: not readable with expected contents"
> +done
> +for name in lowerdir mergeddir tree; do
> +       [ -d "$lower/$name" ] || {
> +               stat "$lower/$name" >> $seqres.full 2>&1
> +               _fail "$lower/$name: expected the lower directory to rema=
in"
> +       }
> +done
> +for name in one two; do
> +       cmp $tmp.data "$lower/tree/$name" >> $seqres.full 2>&1 || \
> +               _fail "$lower/tree/$name: not readable with expected cont=
ents"
> +done
> +
> +echo "Silence is golden"
> +_exit 0
> diff --git a/tests/generic/999.out b/tests/generic/999.out
> new file mode 100644
> index 0000000..3b276ca
> --- /dev/null
> +++ b/tests/generic/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Silence is golden

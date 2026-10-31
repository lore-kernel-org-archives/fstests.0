Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793449430;
	b=DcDm8iH8sVUdMfAXGVEepknWIBqwvxzuT7O/O2CdSanQDFSLnC0uQSBxfStnHZAlTaRl
	 RyR15lrSaRyy6zxkgElet7CBasY8e+yFg9A6vCDjS4EJvMR31KnjpaCt5PWQnldXj+FIC
	 iqFHlKM5p2dDOFk5xjpuwIMf8rwNFKC9MXghx/pCT5FpolMYt8qFMawkXHeBm5EUgvi29
	 ogL4rkJatRpl39qNf4dZQ0bRtIHd0ev7Oeksr9T/gZ39+8YMxTxNw0PywveKV5GDu/0nY
	 KiTLhW6kTNY0Zlam/uIC59IanT/8BGFYx1BG4d6NoNJdkCTTtG24QlPs0TDkVnWUSIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793449430;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=xc+W9C2N2Cz5sOWrV8mXB56AaItNhsL2cZ/2BcY0thw=;
	b=dKUWP9+4wZt2/hRdfgp/YqRH3lql4zEvdSWmRwI/G7zXD9HCxR+LHAn1k32sAMMsMqwK
	 OqcvbH5Qk/g8oT7Bk8RKFaoQVoyY2eyUi9IaiFHoJA4xYdH2VZE4+14y/kfFrnXtAsrPn
	 OnRNRpDYtj2DPXSbLyebTjePUbN7VmJy0GpklhR7xu8zzDAMvCRGz1k+YTfjymWVtNnbE
	 5A9nUBKO7J3s5Kqz379euTDpFp+7zSkKR22g3d+Rbsw7LsDz9MgZnhW/cNtPhiiYl1sQo
	 A1cK5meQJMGUAZ5ENmyvvpTKuu91iVAdxB6E2mTb3TbYCPmymoFwxa6znGUG5MRh+Ug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JaKiD1EB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.51
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBE606A31C
	for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 12:23:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35BBE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JaKiD1EB
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c40e02b2ebaso262087766b.1
        for <fstests@vger.kernel.org>; Sat, 31 Oct 2026 05:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793449428; cv=none;
        d=google.com; s=arc-20260327;
        b=dwH6h9HPWxlU6cQ5ZtJ/7dgONojv2AigZS+JyAa7fVrrlkt6wtrhDJP3+hYlKwTFEO
         B91Wptyo5RL7Wa7kxEpADByBTOU0Z8p53ZPmtoKnI7Z9rGKPFo9F/WHMRn7zth7gfJ7y
         p2hCvdfCn0VDcbSeWOq8rI9gLEsVwag2B1V+CtqNBXeoj/kpDboJPpGt3+dKjWwYWSle
         N245WOZJ1dorDjaPW44Rcg7p1xAY9tb81frduElcdFbZAQZ+2Xhkk5K35f4XkbVJia6J
         H2KYzSFHoGpuuDB9qGdnXOPMWgwpjJ1FFkdrlY0/j/w2HOD2TMuYfDytSBZHydKHeYAM
         cKfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xc+W9C2N2Cz5sOWrV8mXB56AaItNhsL2cZ/2BcY0thw=;
        fh=ofQe/fd0s1IdeVF54uID+f/cdtEddT48gEwYKZNYpCA=;
        b=fWtl/1bHYmBOKJi1INSdinb0TRk1L8IXCRYEw2uBhZe0IoHJc266fhTtjAW8GYJMrU
         0p0HaGdlHCpfh+uI7Cw+GEEiligzsKyhqA4Xd0YS6JHWM58BWO5F67PIPEiF3/ookBwC
         1MXrwf+Ik7CsnAXQNmW8nNZ7rjpoyCYH+AQu+ywXLVKIzDb0vBFmIsp5hkKUlE37eHMn
         /q1uzZoq8t7+KXzURurT58wITfq4v0R51KDuzCoHepoZeYj18LYYj18P3k7jj1DE9NaN
         3JDki1GwUm7C4E4MLDJkxpbvl+ov+kzhkttut5PvuPJdIhMevm6Dve69pLXEynWfRxGl
         2RAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793449428; x=1794054228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xc+W9C2N2Cz5sOWrV8mXB56AaItNhsL2cZ/2BcY0thw=;
        b=JaKiD1EBzWA7UtY6SmVbh6hpA5m2P0AZWKIiDNDltst4aYgY+WhbwJ68A3EqCQEGEc
         Xg01PyBSqWuzijrq0qcD0EBewTrmrZdqDBROa66gy73jJIfElvhBt36TlAtav0mI9W5U
         AQSEQNTbCz2Q5HK2/oTHE1nMkzBeoVaW/ELWP/4CUArWGa+2Z3oH0LhTj5yOKnkuN7pw
         +2ECyVxY1V0LiQEToUHahevT5igRhR2jiDxkp/XcFImX+ZcPowRZkXsDa4/izBcKuIh+
         TFWpMwoZPj6NcxqVSYNQrgfDnkdkkSuaIomGOd3RzyrpGVJtxMPC+mh3XlYb9YR1K6U9
         QklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793449428; x=1794054228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xc+W9C2N2Cz5sOWrV8mXB56AaItNhsL2cZ/2BcY0thw=;
        b=g502sLq1dP9rw6b2CaJtf7Fa2mHl0r7jCl97BU3qf3VmjxdcrL2uytXUZr+G4R5FP2
         z7205d2rfBceYACAQCsuOrh0PiRHEcG1cVasZBc2HjApr70Dy6hicahiYBTg5fK/USl0
         w5/GCV/lE9edXtRio9qf9DLb6Bo9rEH+hVGhyDC3vF8LBIWBfLb/LZtUzTaRoxptPtGp
         UlM3pK5PWgrw/9AoyJcK1jNOP/0b9bK7qa6uqdQewADpzJoR3kzZ0mQoUV9NrwTGG8mU
         Nj67CWemISj6CDOkLG4NN8aAA7BupEU0n7AaguLoeOslRU5iPYgdEnMbtiLDXcbRa72Y
         d0iA==
X-Gm-Message-State: AFq9FYKHmMfL0+J7vhd3TvTEFpEEiQP33Gmk14G+OHSKlLoF9qB5bH+w
	khssQKQ8dY8lnbPinXEUqgrphniwdbw+8FjUad+9xKJ2aOgwaeGWOKlKe7PXG5ZfdyPPYHiCceM
	ooP6xvhBwfxvAmHGC3fwCmxOauu/sjeQ=
X-Gm-Gg: AYBFou17iaoDOqn2lsEB66ZZ7HtL8KeyEOTStTJ9Ya+CpnmGRdrdzJ/VcRQ/Y7+YdCR
	Rp8QKd6PsKF03dE/MoRG0sXrXxwrTqCkE1s1ZG/aP1eXXjn/fDusKy8ztjDGsjqq3FrDKlZgN8+
	GtS2a3e69f3dZUfv7eB0X7bAuQABP+XR/tuoY3nEDK0hEyoti2cxjALppThhLaOVrY9bk/0VKL4
	qGAbzd8wgyq5YwDc26bvHLgqu6n8fFw1w6w6yNgyN+aat1nk34mwvJmerZo5oVV2UroA2yXraXz
	5MiuaQyJ9PnQUAuEtIoHwlr+DDBgYrLBU/6tWF/B+jToUOph/a1P/4+U5FeEtpYfqW5hdc8XnpB
	3pFMaZEqEez+CBkqX/8nNlp4DbCyePoqZMXM/RIgIdRMjqPgIxo/PsJwUKg31Py3IhNnzYc35GV
	fr5XGOIIKReqSZ3k8=
X-Received: by 2002:a17:907:1b0e:b0:c46:a5bb:5740 with SMTP id
 a640c23a62f3a-c4ca7935979mr448541666b.5.1793449428318; Sat, 31 Oct 2026
 05:23:48 -0700 (PDT)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031091948.18985-1-dennylin0707@gmail.com> <20261031091948.18985-2-dennylin0707@gmail.com>
In-Reply-To: <20261031091948.18985-2-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 31 Oct 2026 13:23:37 +0100
X-Gm-Features: AclHuK__LtotiFojWB714--jA3XQiydxuakQgzbmQ6HuLZAwNgGMzd9zewIiB9o
Message-ID: <CAOQ4uxiT0A8fCrxdrAyR1E4+pxr5YOt5M_ZkW65cfO1y3BsWbg@mail.gmail.com>
Subject: Re: [PATCH 1/2] generic: test overlayfs casefold flag changes
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: fstests@vger.kernel.org, zlang@kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 10:20=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com=
> wrote:
>
> Changing the casefold flag of an overlay directory can leave its upper
> and the mount with different casefold states and break lookups.
>
> Check that chattr +F/-F requests which would change that state fail with
> EOPNOTSUPP, preserve the casefold flag and leave files accessible. Cover
> lower-only directories with and without contents and the overlay root,
> with both casefold-enabled and casefold-disabled layers. Keep no-change
> requests as successful controls.
>
> This covers "ovl: do not let chattr change the casefold flag" from the
> casefold fixes series linked below.
>
> The test also reads regular files on a casefolded overlay. This needs the
> separate "ovl: check the casefold flag of directories only" fix, included
> in the tested overlayfs ovl-fixes baseline at 1d27da7de3f7.
>
> Link: https://lore.kernel.org/linux-unionfs/20261030113201.2921633-1-amir=
73il@gmail.com/
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  tests/generic/998     |  142 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  tests/generic/998.out |    3 +
>  2 files changed, 145 insertions(+)
>
> diff --git a/tests/generic/998 b/tests/generic/998
> new file mode 100755
> index 0000000..f9ff789
> --- /dev/null
> +++ b/tests/generic/998
> @@ -0,0 +1,142 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Hungyu Lin.  All Rights Reserved.
> +#
> +# FS QA Test 998
> +#
> +# Check that rejected casefold changes leave overlay directory casefold
> +# flags unchanged and existing files accessible.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick ioctl casefold
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
> +_fixed_by_kernel_commit xxxxxxxxxxxx "ovl: do not let chattr change the =
casefold flag"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +       "ovl: check the casefold flag of directories only"
> +
> +check_casefold()
> +{
> +       local path=3D$1
> +       local expected=3D$2
> +       local expected_state=3Ddisabled
> +       local flags
> +       local actual=3D0
> +
> +       [ "$expected" -eq 1 ] && expected_state=3Denabled
> +       flags=3D$($LSATTR_PROG -d "$path" 2> $tmp.err) || {
> +               cat $tmp.err >> $seqres.full
> +               _fail "cannot read flags on $path"
> +       }
> +       flags=3D${flags%% *}
> +       echo "lsattr $path: $flags" >> $seqres.full
> +       [[ "$flags" =3D=3D *F* ]] && actual=3D1
> +       [ "$actual" -eq "$expected" ] || \
> +               _fail "$path: expected casefold $expected_state, got flag=
s $flags"
> +}
> +
> +reject_casefold_change()
> +{
> +       local change=3D$1
> +       local path=3D$2
> +       local ret
> +
> +       $CHATTR_PROG "$change" "$path" > $tmp.err 2>&1
> +       ret=3D$?
> +       echo "chattr $change $path: exit $ret" >> $seqres.full
> +       cat $tmp.err >> $seqres.full
> +       [ "$ret" -ne 0 ] || \
> +               _fail "chattr $change $path succeeded, expected EOPNOTSUP=
P"
> +       # Check the SETFLAGS error, rather than accepting any chattr fail=
ure.
> +       grep -Fq \
> +               -e "Operation not supported while setting flags on $path"=
 \
> +               -e "Not supported while setting flags on $path" \
> +               $tmp.err || \
> +               _fail "chattr $change $path: expected EOPNOTSUPP, got exi=
t $ret: $(cat $tmp.err)"
> +}
> +
> +_scratch_mkfs_casefold >> $seqres.full 2>&1 || \
> +       _fail "cannot format the casefold scratch filesystem"
> +_scratch_mount_casefold || _fail "cannot mount the casefold scratch file=
system"
> +printf 'sentinel\n' > $tmp.data
> +
> +# Try the enabled mount first so kernels without overlay casefold suppor=
t
> +# skip before reaching the actual attribute-change checks.
> +for folded in 1 0; do

Nit: I would use:

test_casefold()
{
       local folded=3D$1

> +       root=3D$SCRATCH_MNT/ovl-$folded
> +       lower=3D$root/lower
> +       upper=3D$root/upper
> +       work=3D$root/work
> +       merge=3D$root/merge
> +       mkdir "$root" || _fail "cannot create $root"
> +       if [ "$folded" -eq 1 ]; then
> +               _casefold_set_attr "$root" >> $seqres.full 2>&1 || \
> +                       _notrun "cannot enable casefold on the scratch fi=
lesystem"
> +               change=3D-F
> +               same=3D+F
> +               casefold_state=3Denabled
> +       else
> +               change=3D+F
> +               same=3D-F
> +               casefold_state=3Ddisabled
> +       fi
> +       mkdir "$lower" "$upper" "$work" "$merge" || \
> +               _fail "cannot create overlay directories"
> +       mkdir "$lower/empty" "$lower/dir" || \
> +               _fail "cannot create lower directories"
> +       cp $tmp.data "$lower/dir/file" || _fail "cannot create lower file=
"
> +       cp $tmp.data "$lower/file" || _fail "cannot create lower file"
> +
> +       if [ "$folded" -eq 1 ]; then
> +               _mount -t overlay overlay "$merge" \
> +                       -o lowerdir=3D"$lower",upperdir=3D"$upper",workdi=
r=3D"$work" \
> +                       >> $seqres.full 2>&1 || \
> +                       _notrun "overlayfs does not support casefold enab=
led layers"
> +       else
> +               _mount -t overlay overlay "$merge" \
> +                       -o lowerdir=3D"$lower",upperdir=3D"$upper",workdi=
r=3D"$work" \
> +                       >> $seqres.full 2>&1 || _fail "cannot mount overl=
ay"
> +       fi
> +
> +       echo "Casefold $casefold_state" | tee -a $seqres.full
> +       # A lower-only directory would be copied up as an empty upper dir=
ectory,
> +       # even when its merged view contains files. The upper root is als=
o empty.
> +       for path in "$merge/empty" "$merge/dir" "$merge"; do
> +               check_casefold "$path" "$folded"
> +               reject_casefold_change "$change" "$path"
> +               check_casefold "$path" "$folded"
> +               cmp $tmp.data "$merge/file" >> $seqres.full 2>&1 || \
> +                       _fail "$merge/file: not readable with expected co=
ntents after chattr $change $path"
> +               cmp $tmp.data "$merge/dir/file" >> $seqres.full 2>&1 || \
> +                       _fail "$merge/dir/file: not readable with expecte=
d contents after chattr $change $path"
> +       done
> +
> +       # chattr still issues SETFLAGS for a no-change request.
> +       for path in "$merge/empty" "$merge/dir" "$merge"; do
> +               echo "chattr $same $path" >> $seqres.full
> +               $CHATTR_PROG "$same" "$path" >> $seqres.full 2>&1 || \
> +                       _fail "chattr $same $path: expected success for u=
nchanged casefold state, got exit $?"
> +               check_casefold "$path" "$folded"
> +       done
> +       _unmount "$merge" || _fail "cannot unmount overlay"
> +       merge=3D
> +       cmp $tmp.data "$lower/file" >> $seqres.full 2>&1 || \
> +               _fail "$lower/file: not readable with expected contents"
> +       cmp $tmp.data "$lower/dir/file" >> $seqres.full 2>&1 || \
> +               _fail "$lower/dir/file: not readable with expected conten=
ts"
> +done
> +

And then the test body would look more explicit:

echo "Casefold enabled" | tee -a $seqres.full
test_casefold 1
echo "Casefold disabled" | tee -a $seqres.full
test casefold 0

Other than that feel free to add:

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks,
Amir.

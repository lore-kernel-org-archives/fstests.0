Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794311041;
	b=3jN4ieD/xNlbrs/WBVGb3hc5ssKEr2GjkrfAPfjJXoT0wIX8dlVRPZwmH4pSmOGWyfs3
	 hxRvJATaFNa6DqJF/GVKC9MlZi6+Rw9Kc5PknpOMFDoeOLushlp9u6Tt1bh4pxG0meteG
	 zkoT3h6BUOQELWrYFtiiphVfAtjc3nzRNYSdHNJMEhD3LSgmsa7mRDqR6JBqLffRN1cIG
	 wS9vzSR+Nj6VcAew43sGG0aiUhBunkHm8bgexjzojsVmJ4LnY0ntpQY0VMRBhtFU4dAn2
	 w4AAw4G78h3SgG9ZAGQ6ZJk835xq+AH04NEx04kodggT7yY+4f1DCWwFcnCbOLlWSog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ltg+x0X+LlbcZOABDUfKsmYtQ03QvNby35VFqDT6x7M=;
	b=lydMm2WH86b4K8RVRheQ7I/IMiEvUolpAeoYxtMYVCS9HYDSy/5Ji9fiA6LRAo5/GDi5
	 7PhXLiIsTEGXq3hHUSDK8r3718keGW7bCRN9sLQ3FzFDE4/gZ2rYJz5gSkig4m1eptd0e
	 RGcQcbz5WoxUjwExQcyNteGtIxMhhjvlDm58PF1pjSIJj9uFl2+7CRsaLRr0iKBJLefG3
	 jmZ66KPmIn4PxiYvfFZanoEDKV4C3DH1QloV7LCXMsYgWlizSHvVPp3EqpMxgvHa+Wp0Y
	 pFcXB6EzT9yKWM5l0ceGOJXqUeHk5J3UQIyk2Fy3LL4vaEK9v6YD7jmnnxgQl4tLsMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJp5P4Nd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C80606A31C
	for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 11:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90C80606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DJp5P4Nd
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b750e40ce2so1331742a12.0
        for <fstests@vger.kernel.org>; Tue, 10 Nov 2026 03:44:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794311039; cv=none;
        d=google.com; s=arc-20260327;
        b=ODvfXWG+8uKnqGeMdfcEideVmWCUqYbt2ihEcAlMMckcLpx0TmgWiWVguDz+Wz8Vg6
         B2Jw2gk2KXK+3qT0huIWgOuWlU882Hg185c87vhKQzdwrR0usk/FnS7/VDqe/XycveFd
         zyN6q1yz2Q7ZmkRMBG++t75PMed4rKBla/bNSUYz2pJz+5cIpfraxgOG3o/7ZfcJlnkH
         PbO+Jv9Me/8D0ot8KyYWB7VCWmxkTKXmtfM9Tf2Ud/DquPWJnabfUQNBbQ73iMubIB4U
         Q5jNdl9Sdxcj6xPdrEknOtuBUpcAUxR7ChsApfu/yvWS28mywit7rAi1BXDFf2ywPsFL
         dVcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ltg+x0X+LlbcZOABDUfKsmYtQ03QvNby35VFqDT6x7M=;
        fh=KwMEtdkmyVjNwGs2Qh1Hxc3ZiVL7IU7E5hZcRIv0Vmg=;
        b=LIdFXdGfSUHF4YE4LLP1WN0MEE3h3DwAuAYmZYtlEsGC96D1qY4+pvSAMkaeiZKzdT
         k+Lp7sgX/pevnnMpVu7zXYt6zFsqDVKRPJAHHVoxIEUFXBYOmFSQ72tECmZk2sG8Y5SA
         cmISH7v7yQ6i9GTYRjlGyggfwPCcR7tLlorzMI1iP62XDqvHsWnLgNQwFmVe9/edo3MT
         hmlXQhi0/Fvt1GEeJdDcWepns1dUbS3PWq4Ya5SJwvhsmfx1Nzf+Q/XwYOIrU8SZW18B
         LKZ32Cl5ncIypW7+GmRJv76WVB/HmEexNUvze2IvaPxwWgntLHtUbNlV7p9TDGiawJ/b
         c/Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794311039; x=1794915839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ltg+x0X+LlbcZOABDUfKsmYtQ03QvNby35VFqDT6x7M=;
        b=DJp5P4Ndna//ls8P9IE4ia788WFhGOw7IZeXwNs1wqk8gHhHxHnmutI7aPyQDX5JLC
         Io/RQXm7Cija9gTmmimusQqfBVAJE7CbP693E7juUZeMK43CHUUM38TvnYsOsa2M2B9q
         vtO+2BLhUmprkvZiBDAXBZmpqQNQYprg+FuCt2X20vK7EK4xm+uN5SY8jR9+Y43DsDax
         fapPMOM3pMigABM5Zg4H6Oj+DUsWZEUJwW5I3eiH1+H2IjXEjDlFUvbnnCweqTEPuKBx
         g0a4CpvU9Uey071dsHKbP1On4IDVIUSUxDYEJC4HxNIpbJpM6IYR47VE6lxzRo90Rj5d
         5Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794311039; x=1794915839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ltg+x0X+LlbcZOABDUfKsmYtQ03QvNby35VFqDT6x7M=;
        b=x3r8EsiHuOEkywEcNLu4eR63t09c2LwQ50IN2+7PXkMS+85iPbNHNLg7VW55fy4gyv
         YFlgJRukvk+yrVmwJwWScv278mPhD+Ip2zysi2+KkU/fY/A9VPR7odKUy96tUGkN3vh7
         K17jRxj4QzeRQ5Q+XRRE4O0T/Kba73IPSQ5eps/1p3+BzRqfd1ofy6OiaBpjMlo6+squ
         1s+MdHjgC3FMiEn9b5mm30xVHMrBvmE+On7KUzedvxaGJwovzybrI1FruW9mrRmriWCZ
         skUIySoNQ/4CxnSp/FIE3or/pNpG5mzXp/q+IOtS8DcPsOzVHj8txiAgCLO+DHTT/0qo
         iaqw==
X-Gm-Message-State: APuU4Z8JArnB5fyuObxFadIfX4e7gqK57X2WezUmwFEFvzxTLoLAJr7A
	iiXb6CG3VYNuELtutxUQSN/HMkLnoUNWOWTPV4auwtQswqSWy3GARlAlxQC8bZkwERvmV/DsRWq
	W8D79Cp9L0dCV31Uln2/LP12QBgZWS94UriiQnJ4=
X-Gm-Gg: AYBFou03QMGDmXY/AzJp7ArbVGzwnrfhY6E8w9dmj/iJ/vpRjlsAFweBmBcNjaMk+8n
	USiOAXhqlIwV8+xnBygGSab/E2LWvogEUR9PzHnXg5V8jGNqsbfUIlHo1wmvJzZxyBZaS++FGJe
	4mN7PqEGhaXiViKNbvsoeubMRKKyrh+/7QRgp5mpyuvT1w3dFnELQO4oBLjRHTk318/YEOQsg3A
	6VEVGNSkUuL4JtvZz3onxgWVF1BMkf37TfgA5KFV2usJllmLHmqGgPPTxfUqjyVIwp5G8Aq+Yo4
	J+UMOKnGE/OQk7mnCRByyS99PBEhkFCk0INRSlpXvButrNYz2W+ma50FDzZx/zJEEiPVbIhBOuy
	8MCCHdPMdENQsc+CoWfupvJjLpUtB1MmMzQIawdWF1pelvVRtFUUBIdRL0lF+6+ic7zuxvg==
X-Received: by 2002:a05:6402:404:b0:6aa:f809:ef44 with SMTP id
 4fb4d7f45d1cf-6b756add5a1mr1531706a12.19.1794311038470; Tue, 10 Nov 2026
 03:43:58 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109134006.2555438-1-giuseppe@scrivano.org>
In-Reply-To: <20261109134006.2555438-1-giuseppe@scrivano.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 10 Nov 2026 12:43:47 +0100
X-Gm-Features: AclHuK-uwZQgR5BkyA3G1Zx0UPQjshXRjgEZUhOUNlPs25fiTjBQKWPqoE85aik
Message-ID: <CAOQ4uxjsNEyB0H8CqGp9En1bFCH92bYAu8UJ8SovXUeaG=z-DA@mail.gmail.com>
Subject: Re: [PATCH fstests v2] overlay: add a test for redirect_dir=followdata
To: Giuseppe Scrivano <giuseppe@scrivano.org>
Cc: fstests@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 2:40=E2=80=AFPM Giuseppe Scrivano <giuseppe@scrivano=
.org> wrote:
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
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  common/overlay        |  15 +++++
>  tests/overlay/090     | 149 ++++++++++++++++++++++++++++++++++++++++++
>  tests/overlay/090.out |  43 ++++++++++++
>  3 files changed, 207 insertions(+)
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
> index 00000000..6eeeacdf
> --- /dev/null
> +++ b/tests/overlay/090
> @@ -0,0 +1,149 @@
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
> +_begin_fstest auto quick metacopy redirect attr
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/attr
> +
> +# We use non-default scratch underlying overlay dirs, we need to check
> +# them explicitly after test.
> +_require_scratch_nocheck
> +_require_attrs user
> +_require_attrs trusted
> +_require_scratch_overlay_redirect_followdata
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
> +# Make a metacopy file <file> with the redirect <redirect>, for both
> +# userxattr and trusted xattr mounts
> +make_stub()
> +{
> +       local file=3D$1 redirect=3D$2 x
> +
> +       touch $file
> +       for x in user.overlay. ${OVL_XATTR_METACOPY%metacopy}; do
> +               $SETFATTR_PROG -n ${x}metacopy $file
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
> +
> +# followdata is selected by default with userxattr and a data-only layer
> +check userxattr s1 s2 s3
> +check userxattr,redirect_dir=3Dfollowdata s1 s2 s3 rel dir up
> +# a data-only layer cannot be used without following redirects
> +check_fail userxattr,redirect_dir=3Dnofollow
> +check_fail userxattr,redirect_dir=3Doff

The test looks good but this expectation of failure is problematic.

First of all the test would fail with redirect_always_follow=3DN
because that makes redirect_dir=3Doff =3D> followdata

But I also think that redirect_dir=3Doff should not fail with
redirect_always_follow=3DY.

I will explain with the documentation.
You documentation v2 patch says:

:A data-only layer selects "redirect_dir=3Dfollowdata", unless
"redirect_dir=3Dfollow"
:or "redirect_dir=3Don" is in effect.

So it implies redirect_dir=3Doff =3D> followdata

All that redirect_dir=3Doff really means is "don't create redirects".

I amended the document as follows to clarify that:

- "redirect_dir=3Don":
    Redirects are created and followed.
- "redirect_dir=3Dfollow":
    Redirects are not created, but followed.
- "redirect_dir=3Dfollowdata":
    Redirects are not created.
    Only redirects from lower to lowerdata are followed.
- "redirect_dir=3Dnofollow":
    Redirects are not created and not followed.
- "redirect_dir=3Doff":
    Redirects are not created.
    Which redirects are followed depends on "redirect_always_follow" in the
    kernel/module config, on data-only lower layers and on the "userxattr"
    mount option.

Made this off =3D> followdata change in the code and pushed to ovl-fixes:

-static int ovl_redirect_follow_mode(size_t nr_data)
+int ovl_redirect_follow_mode(bool follow_lower, size_t nr_data)
 {
-       return ovl_redirect_always_follow ? OVL_REDIRECT_FOLLOW :
-                                           ovl_redirect_nofollow_mode(nr_d=
ata);
+       if (ovl_redirect_always_follow && follow_lower)
+               return OVL_REDIRECT_FOLLOW;
+
+       /* Data-only layers cannot be used without following redirects
to them */
+       return nr_data ? OVL_REDIRECT_FOLLOWDATA : OVL_REDIRECT_NOFOLLOW;
 }

 /*
@@ -137,7 +140,7 @@ static int ovl_redirect_follow_mode(size_t nr_data)
 static int ovl_redirect_mode_def(void)
 {
        return ovl_redirect_dir_def ? OVL_REDIRECT_ON :
-                                     ovl_redirect_follow_mode(0);
+                                     ovl_redirect_follow_mode(true, 0);
 }

 static const struct constant_table ovl_parameter_verity[] =3D {
@@ -896,6 +899,9 @@ int ovl_fs_params_verify(const struct ovl_fs_context *c=
tx,
        struct ovl_opt_set set =3D ctx->set;
        /* The requested redirect_dir=3D, for reporting conflicts with it *=
/
        int redirect_opt =3D config->redirect_mode;
+       /* The redirect follow mode for redirect_dir=3Doff and for the defa=
ult */
+       int follow_mode =3D ovl_redirect_follow_mode(!config->userxattr,
+                                                  ctx->nr_data);

        /* Workdir/index are useless in non-upper mount */
        if (!config->upperdir) {
@@ -922,9 +928,12 @@ int ovl_fs_params_verify(const struct ovl_fs_context *=
ctx,
                config->uuid =3D OVL_UUID_NULL;
        }

-       /* Resolve redirect_dir=3Doff to the default redirect follow mode *=
/
+       /*
+        * Resolve redirect_dir=3Doff to the default redirect follow mode.
+        * With userxattr, redirects are not followed to lower by default.
+        */
        if (config->redirect_mode =3D=3D OVL_REDIRECT_OFF)
-               config->redirect_mode =3D ovl_redirect_follow_mode(ctx->nr_=
data);
+               config->redirect_mode =3D follow_mode;

        /*
         * This is to make the logic below simpler.  It doesn't make any ot=
her
@@ -1038,7 +1047,7 @@ int ovl_fs_params_verify(const struct ovl_fs_context =
*ctx,
                 * userxattr.
                 */
                if (!set.redirect)
-                       config->redirect_mode =3D
ovl_redirect_nofollow_mode(ctx->nr_data);
+                       config->redirect_mode =3D follow_mode;
                config->metacopy =3D false;
        }


Please amend the test and test with the latest ovl-fixes:
d0d57557b76de ovl: follow lower to lowerdata redirects from any lower layer

Thanks,
Amir.

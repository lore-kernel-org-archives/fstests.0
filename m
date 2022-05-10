Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC6DC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 10 May 2022 12:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiEJMQy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 10 May 2022 08:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbiEJMQx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 May 2022 08:16:53 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191AB4C430
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 05:12:56 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k8so7864759qki.8
        for <fstests@vger.kernel.org>; Tue, 10 May 2022 05:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8sE/eRgKpe8j3i7oj45wpGRscrPdXqcCkPkOVJ7gCi0=;
        b=GF0jV/hisXTmMWzqT9ADL00QjmDW2hVOhFlHsZASwJ/ccUvk3QvuxFHcRvv8msNuXw
         sEsvu3eHtHRyTOG5QD4ihc7CppMlAPcx/vZ6kjLZ5ixojKL1xNyVjBWgtQMdCoJe+BCE
         TOXB9atn1mQcVelHcvLCMr0DJqKgVVxmIoGZe2d7CCQ9Q7FRgsNIRBTIyA3a4NgReg19
         IF98xnCBfcELB1m5lpfEzWYwUvviN3Gjq7tkhof1xsy3aET+Mpsnk9/QAK1fcb82H6aA
         u+E+qmFUxLTW/QVFSxV4LEIwzNXkCzt5qehBQAEwESr+IC8XF/j32gQ9TMaByATBgHqS
         Bp8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8sE/eRgKpe8j3i7oj45wpGRscrPdXqcCkPkOVJ7gCi0=;
        b=pqthNp45rxDyChSAAT7qyEcEo1caI0id453SLhms8yNGemcACbq4aKPlko/dpljGwt
         dFxC5xR+BY8NAFvnWZoj7kYV5/fipqE3w/36bho+yUi+MlbDSRDH4VTMEIJA89n9pJCR
         4vjbSYDWMbZmzUApxi8aVz+eR3+33sPHefNUVobd/QbVw0aP+Z9DS/uktSNiCfSP5WLo
         PcoZkCQRNmmHtKKbKs4pkvOYyVgiSbyY/LUTSHsnzptV3lrnZv2q1sb1yT6WZt01X/o0
         DyIlx6oeDJaxZiHib9QecdnmxGx2UjphQFqtKVq7LV5EtQLBfmK4/uHjYA8xDowl/NoE
         lECg==
X-Gm-Message-State: AOAM5322XX4Inzxw4jgNVNsWmASGj/zyYNdtnOcxf3MMYeuxHjpXL1oc
        9JzkXE8S2/dwjDKXNpLNqWcmNqDQWrr9tuzends=
X-Google-Smtp-Source: ABdhPJzbnle4amPBINJQxx+/lNJctwyXXfw0B7q0FBHxWMcrXcsd5ST91yriFx3GAVmKethjDvcJpQSbq2Iz4hPrC2c=
X-Received: by 2002:a37:9cd8:0:b0:69f:b618:c7ab with SMTP id
 f207-20020a379cd8000000b0069fb618c7abmr15560446qke.722.1652184775193; Tue, 10
 May 2022 05:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220510020434.2561224-1-libaokun1@huawei.com>
 <CAOQ4uxhTzqvuD5=5c4O_fhzV9CrHSpipegjUiETgCbNTkdvpvA@mail.gmail.com> <1aa6663e-1c1d-3659-231d-29c6d4e448c9@huawei.com>
In-Reply-To: <1aa6663e-1c1d-3659-231d-29c6d4e448c9@huawei.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 May 2022 15:12:43 +0300
Message-ID: <CAOQ4uxi+gZYmSwChrjLMcQ8nFGM38re7h5+LWByV5A24UxV0eA@mail.gmail.com>
Subject: Re: [RFC v3] common: xfstests support overlay+tmpfs
To:     "libaokun (A)" <libaokun1@huawei.com>
Cc:     fstests <fstests@vger.kernel.org>, Zorro Lang <zlang@redhat.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 10, 2022 at 3:05 PM libaokun (A) <libaokun1@huawei.com> wrote:
>
> =E5=9C=A8 2022/5/10 15:51, Amir Goldstein =E5=86=99=E9=81=93:
> > On Tue, May 10, 2022 at 4:50 AM Baokun Li <libaokun1@huawei.com> wrote:
> >> The local.config of overlay+tmpfs is as follows:
> >> ```local.config.example
> >> export FSTYP=3Dtmpfs
> >> export TEST_DEV=3Dtmpfs_test
> >> export TEST_DIR=3D/tmp/test
> >> export SCRATCH_DEV=3Dtmpfs_scratch
> >> export SCRATCH_MNT=3D/tmp/scratch
> >> ```
> >>
> >> Run `./check -overlay tests` to execute test case on overlay+tmpfs.
> >>
> >> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> >> ---
> >> V1->V2:
> >>          Fix the bug in version V1 and fix the issue in cycle_mount.
> >> V2->V3:
> >>          Merge two patches into one completed patch.
> >>
> >> V1: https://patchwork.kernel.org/project/fstests/patch/20220424063751.=
1067376-1-libaokun1@huawei.com/
> >> V2: https://patchwork.kernel.org/project/fstests/cover/20220507094524.=
949615-1-libaokun1@huawei.com/
> >>
> >>   common/config  | 12 ++++++------
> >>   common/overlay |  2 +-
> >>   common/rc      | 31 ++++++++++++++++++++++++-------
> >>   3 files changed, 31 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/common/config b/common/config
> >> index 1033b890..d5953176 100644
> >> --- a/common/config
> >> +++ b/common/config
> >> @@ -610,15 +610,15 @@ _overlay_config_override()
> >>          [ ! -d "$TEST_DEV" ] || export OVL_BASE_TEST_DIR=3D"$TEST_DEV=
"
> >>          [ ! -d "$SCRATCH_DEV" ] || export OVL_BASE_SCRATCH_MNT=3D"$SC=
RATCH_DEV"
> >>
> >> +       # Config file may specify base fs type, but we obay -overlay f=
lag
> >> +       [ "$FSTYP" =3D=3D overlay ] || export OVL_BASE_FSTYP=3D"$FSTYP=
"
> >> +       export FSTYP=3Doverlay
> >> +
> >>          # 2. SCRATCH/TEST_DEV point to the base fs partitions.  In th=
is case,
> >>          #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to th=
e values
> >>          #    of the configured base fs and SCRATCH/TEST_DEV vars are =
set to the
> >>          #    overlayfs base and mount dirs inside base fs mount.
> >> -       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> >> -
> >> -       # Config file may specify base fs type, but we obay -overlay f=
lag
> >> -       [ "$FSTYP" =3D=3D overlay ] || export OVL_BASE_FSTYP=3D"$FSTYP=
"
> >> -       export FSTYP=3Doverlay
> >> +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$OVL_BASE_FSTYP=
" =3D=3D tmpfs ] || return 0
> >>
> >>          # Store original base fs vars
> >>          export OVL_BASE_TEST_DEV=3D"$TEST_DEV"
> >> @@ -634,7 +634,7 @@ _overlay_config_override()
> >>          export TEST_DIR=3D"$OVL_BASE_TEST_DIR/$OVL_MNT"
> >>          export MOUNT_OPTIONS=3D"$OVERLAY_MOUNT_OPTIONS"
> >>
> >> -       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> >> +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE=
_FSTYP" =3D=3D tmpfs ] || return 0
> >>
> >>          # Store original base fs vars
> >>          export OVL_BASE_SCRATCH_DEV=3D"$SCRATCH_DEV"
> >> diff --git a/common/overlay b/common/overlay
> >> index fff67ba1..c4e7ee58 100644
> >> --- a/common/overlay
> >> +++ b/common/overlay
> >> @@ -81,7 +81,7 @@ _overlay_base_mount()
> >>                  return 1
> >>          fi
> >>
> >> -       _mount $* $dev $mnt
> >> +       _mount -t $OVL_BASE_FSTYP $* $dev $mnt
> >>          _idmapped_mount $dev $mnt
> >>   }
> >>
> >> diff --git a/common/rc b/common/rc
> >> index 553ae350..ca465438 100644
> >> --- a/common/rc
> >> +++ b/common/rc
> >> @@ -410,10 +410,19 @@ _scratch_cycle_mount()
> >>   {
> >>       local opts=3D"$1"
> >>
> >> -    if [ "$FSTYP" =3D tmpfs ]; then
> >> -       _scratch_remount "$opts"
> >> -       return
> >> -    fi
> >> +       case "$FSTYP" in
> >> +       tmpfs)
> >> +               _scratch_remount "$opts"
> >> +               return
> >> +               ;;
> >> +       overlay)
> >> +               if [ "$OVL_BASE_FSTYP" =3D tmpfs ]; then
> >> +                       _scratch_remount "$opts"
> >
> > That doesn't look right.
> > _scrtach_cycle_mount is important for several overlay tests and there
> > is no reason to
> > skip it if base fs is tmpfs.
> > What you need to do is cycle mount the overlay without cycle mounting
> > the base fs.
> > You could do something like this:
> >
> >    local unmounted
> > ...
> >
> >    overlay)
> >                 if [ "$OVL_BASE_FSTYP" =3D tmpfs ]; then
> >                           $UMOUNT_PROG $SCRATCH_MNT
> >                           unmounted=3Dtrue
> >                 fi
> >                 ;;
> >     esac
> > ...
> >      [ "$unmounted" =3D true ] || _scratch_unmount
> >      _try_scratch_mount "$opts" || _fail "cycle mount failed"
> > }
> >
> > There are some overlay tests that open code this pattern like overlay/0=
77:
> >
> > # Remove the lower directory and mount overlay again to create
> > # a "former merge dir"
> > $UMOUNT_PROG $SCRATCH_MNT
> > rm -rf $lowerdir/former
> > _scratch_mount
> >
> > So _scratch_mount is expected to work just fine when base fs is already=
 mounted
> > assuming that _check_mounted_on works correctly with tmpfs.
> >
> > Thanks,
> > Amir.
> > .
>
> Thank you very much for your advice.
>
> I will send a patch V4 with the changes suggested by you.

To state the obvious that I did not say, please do the same with
_test_cycle_mount

Thanks,
Amir.

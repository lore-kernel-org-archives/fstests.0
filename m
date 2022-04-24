Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA202C433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 24 Apr 2022 13:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbiDXN1J (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 24 Apr 2022 09:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiDXN1I (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 24 Apr 2022 09:27:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19C4333E2E
        for <fstests@vger.kernel.org>; Sun, 24 Apr 2022 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650806646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=K8v4V+Arzn8rvUthj4KiLuYND9pEP9iIuTUEP6I/o4g=;
        b=EjvOpqiG7yjfxMuUya4TQcVo8vlN57qKB+bn9DMhtPchOfM70aNbLAVnya41LeCQ38a6bh
        gTrylH+2cVMNpH0ZAsF4OpZGpqtSATcA7oMWNwkv9Dg9j/Yeqv4QQQXesf//bqlcGBN/Rf
        Dpbld64+WfOgGwa4D7qJe60Wzu/Q2cw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-6GZ02t2XNV2ir8TNFUw9CA-1; Sun, 24 Apr 2022 09:24:05 -0400
X-MC-Unique: 6GZ02t2XNV2ir8TNFUw9CA-1
Received: by mail-qk1-f197.google.com with SMTP id q5-20020a05620a0d8500b004738c1b48beso8341043qkl.7
        for <fstests@vger.kernel.org>; Sun, 24 Apr 2022 06:24:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=K8v4V+Arzn8rvUthj4KiLuYND9pEP9iIuTUEP6I/o4g=;
        b=JtRAlJyIUwYNxph4898mOihPyM/pFn4frsyeTN18fxPYdXnUsU3e/CkpFxn3eTZBhG
         UO/KYTqYyLHb4/iQQvrZUHG78HWW9nyrLJ1zw1ioyuXLaqLLFWxH+eK4gKi+r0Z+MiRC
         KlqcH7H13YATtrkPcq0UF2cPuYYyZdNLlD4AL9aaNatk0KbwanE2Bsx26CgIKbq1xShm
         eTYDcdfXRMSi6O/jvREvwgebyXxTv5UI9E4YLGi1LA8QxBcdpOuS12I3NHX/CdW3+pH5
         TZcvcafV0xG0V2cU0C3UBsy3uoOizgRCa+PIbSXElkF1VlRXeDA01d22xhFmIg7+7kAE
         E15Q==
X-Gm-Message-State: AOAM532/jczGx7tDZGlZxbY2EoBjznl9WHmvPSStblTKQ2TQyCydqqkA
        zmVT94nu9ziz1++KqBv09inBV154xAh4JN0dhLSaa+j5bxZo1mtHLTEmoHpy4jwkDZQdc7OxxSr
        5vynJTkXgkbDEigdHh0o0e+ho7DBT7f1k9L97UxjANbo2itJ6AukZ57aCJ1MFFCPtkw==
X-Received: by 2002:ac8:7c51:0:b0:2f1:f3d5:4157 with SMTP id o17-20020ac87c51000000b002f1f3d54157mr9282529qtv.562.1650806644139;
        Sun, 24 Apr 2022 06:24:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVb24Wu7lTYKK9uzjC+fSK1/zsVzZlFaVgAM1U0JjsauyrhpBLoMH5WfbImXBkUD+WNMAXHA==
X-Received: by 2002:ac8:7c51:0:b0:2f1:f3d5:4157 with SMTP id o17-20020ac87c51000000b002f1f3d54157mr9282511qtv.562.1650806643793;
        Sun, 24 Apr 2022 06:24:03 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d13-20020a37c40d000000b0069ebc29ddc1sm3474730qki.136.2022.04.24.06.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 06:24:03 -0700 (PDT)
Date:   Sun, 24 Apr 2022 21:23:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>, linux-xfs@vger.kernel.org
Subject: Re: [RFC] common: overlay support tmpfs
Message-ID: <20220424132357.m4nxrmbgu2r6ljo4@zlang-mailbox>
Mail-Followup-To: fstests <fstests@vger.kernel.org>,
        Eryu Guan <guaneryu@gmail.com>, Amir Goldstein <amir73il@gmail.com>,
        linux-xfs@vger.kernel.org
References: <20220424063751.1067376-1-libaokun1@huawei.com>
 <CAOQ4uxgEXEgZ-uAYgiJi1sxX9Zzmg25NewBRiRQR6D8z+qOXHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgEXEgZ-uAYgiJi1sxX9Zzmg25NewBRiRQR6D8z+qOXHA@mail.gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Apr 24, 2022 at 03:02:03PM +0300, Amir Goldstein wrote:
> On Sun, Apr 24, 2022 at 2:21 PM Baokun Li <libaokun1@huawei.com> wrote:
> >
> > xfstests support overlay+tmpfs
> 
> Thanks for this improvement.
> Can you please share the results of ./check -overlay -g auto ?
> 
> How many tests ran? notran? failed?
> 
> Best if you have those numbers compared to
> overlay+(already supported base fs)
> 
> 
> >
> > ```local.config.example
> > export FSTYP=tmpfs
> > export TEST_DEV=tmpfs_test
> > export TEST_DIR=/tmp/test
> > export TEST_FS_MOUNT_OPTS="-t tmpfs"
> > export SCRATCH_DEV=tmpfs_scratch
> > export SCRATCH_MNT=/tmp/scratch
> > export MOUNT_OPTIONS="-t tmpfs"
> 
> These mount options for tmpfs are very awkward.
> Please fix _overlay_base_mount to use -t $OVL_BASE_FSTYP
> like _test_mount() and _try_scratch_mount() do
> 
> 
> > ```
> > Run `./check -overlay tests` to execute test case on overlay+tmpfs.
> >
> > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > ---
> >  common/config | 4 ++--
> >  common/rc     | 7 ++++++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/common/config b/common/config
> > index 1033b890..3dc047e8 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -614,7 +614,7 @@ _overlay_config_override()
> >         #    the new OVL_BASE_SCRATCH/TEST_DEV/MNT vars are set to the values
> >         #    of the configured base fs and SCRATCH/TEST_DEV vars are set to the
> >         #    overlayfs base and mount dirs inside base fs mount.
> > -       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || return 0
> > +       [ -b "$TEST_DEV" ] || [ -c "$TEST_DEV" ] || [ "$FSTYP" == tmpfs ] || return 0
> >
> >         # Config file may specify base fs type, but we obay -overlay flag
> >         [ "$FSTYP" == overlay ] || export OVL_BASE_FSTYP="$FSTYP"
> 
> Please move the setting of OVL_BASE_FSTYP to the top of the function and use
> [ "$OVL_BASE_FSTYP" == tmpfs ] consistently.

Actually I'm wondering if we can bring in a parameter to clarify that xfstests need to
build uplying fs base on a underlying fs, don't depend on the "[ -b "$TEST_DEV" ] ||
[ -c "$TEST_DEV" ] || [ "$FSTYP" == tmpfs ]" things. Due to:
1) overlayfs might not only base on localfs, it can over NFS or something likes it. (right?)
   If so, how many judgements we need to add at here?
2) If xfstests can help overlayfs, that means it can help to build other fs (e.g. nfs, cifs,
   ceph, etc) from an underlying fs in one day.

So how about bring in a parameter, maybe USE_UNDERLYING_FS=yes/no(default), or use "BASE_FSTYP"
directly, e.g.
export USE_UNDERLYING_FS=yes
export FSTYP=tmpfs
....
if [ "USE_UNDERLYING_FS" = "yes" ];then build uplying fs from $FSTYP

Or:
export BASE_FSTYP=xfs (BASE_FSTYP=$FSTYP if BASE_FSTYP is empty)
export FSTYP=overlay
export TEST_DEV=/dev/sdb1
export TEST_DIR=/mnt/test
export BASE_MOUNT_OPTIONS=...
export MOUNT_OPTIONS=...
...
if [ "$BASE_FSTYP" != "$FSTYP" ];then build $FSTYP from $BASE_FSTYP

The 2nd method might be complex, and will affect current code logic much. The 1st one is
simple. This idea just flashed my mind, I haven't thought too much. If others feel this
idea is good too, I can try to implement.

Thanks,
Zorro


> 
> > @@ -634,7 +634,7 @@ _overlay_config_override()
> >         export TEST_DIR="$OVL_BASE_TEST_DIR/$OVL_MNT"
> >         export MOUNT_OPTIONS="$OVERLAY_MOUNT_OPTIONS"
> >
> > -       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || return 0
> > +       [ -b "$SCRATCH_DEV" ] || [ -c "$SCRATCH_DEV" ] || [ "$OVL_BASE_FSTYP" == tmpfs ] || return 0
> >
> >         # Store original base fs vars
> >         export OVL_BASE_SCRATCH_DEV="$SCRATCH_DEV"
> > diff --git a/common/rc b/common/rc
> > index 553ae350..12498189 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -834,13 +834,18 @@ _scratch_mkfs()
> >         local mkfs_status
> >
> >         case $FSTYP in
> > -       nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
> > +       nfs*|cifs|ceph|glusterfs|pvfs2|9p|virtiofs)
> >                 # unable to re-create this fstyp, just remove all files in
> >                 # $SCRATCH_MNT to avoid EEXIST caused by the leftover files
> >                 # created in previous runs
> >                 _scratch_cleanup_files
> >                 return $?
> >                 ;;
> > +       overlay)
> > +               [ ! "$OVL_BASE_FSTYP" == tmpfs ] || return 0
> > +               _scratch_cleanup_files
> > +               return $?
> > +               ;;
> 
> Why? What's the problem with cleaning the ovl-* layers on tmpfs?
> 
> 
> Thanks,
> Amir.
> 


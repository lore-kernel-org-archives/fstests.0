Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE2FC433F5
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Sep 2021 07:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEB160F93
	for <linux-fstests@archiver.kernel.org>; Sun, 19 Sep 2021 07:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhISHTc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 19 Sep 2021 03:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232832AbhISHTa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 19 Sep 2021 03:19:30 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8DC061574
        for <fstests@vger.kernel.org>; Sun, 19 Sep 2021 00:18:06 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 6so20340775oiy.8
        for <fstests@vger.kernel.org>; Sun, 19 Sep 2021 00:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ul1CFC5mSqJCSCt5ThlKehdpuyFzcM9RjNVreH2eZ1U=;
        b=dWJ193V6XIVvsm/H0gE9d/520kga2TglsFzVmsiZwHkhSnm4KwvOVTS+rgwS7CTEBV
         ZQIcksCyI3NoOSrlHAj81RbtoBY7MzX5wvi0VMV3vkOsaJL2ZHYg5rajcw0fCWOpx/Py
         Vgp6CvPUeEf1AMfqsJkUQJ6/oGuDRLNDXwI3E9Vv0F/6TKNnOPwjiTubKn0w2BRuVxa3
         u46RY9MbI5T9JlJn9u0TcuJ7MbXq6s4Zf+jF/bZTiE1APCoMJJZ96/zcFXk1w47U8bmR
         HuJHKeAlKh9D0ATbgx4dpYXO9OiSTU4/97vINVQpGY8cWlP3TssYbTvje4J2GPR4tegt
         4fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ul1CFC5mSqJCSCt5ThlKehdpuyFzcM9RjNVreH2eZ1U=;
        b=NFsraZeY8Haz+PndIDBRiZolZmz5o8u+Pz1I3qMeCw6ZKoFw/0847WQvojLhHcwWW0
         Amh9+YdMllhzFvgHyiy/BQD0aGM3haUG95oee1XLG7lgFAgoU4s+GiFYf1+26kSJGP0b
         Wfigiu1N1sGZtmfXpzqzZKSmAm4VhmNwPdbt1/yetqNUAQhTfBlIDG9YRaKiEtopBPA3
         oMFg5l3KJNr3LXSMED9e+NqXvdH8t03LEiblrrerEu7v0W/cQhuhkSm408ueuBd+bnda
         DEDaIHebbaCFNNi0oLD2jsKADgfbWNy17QqHwwhrMKIRCtmHSTUagEBsgOr/UeHmtjX2
         z5+A==
X-Gm-Message-State: AOAM530tSGcugw8izTK73OcXFtv8ZNm3xYd0/zYt7zJB5FKZC3hCteBj
        smP2SPCjD46ekf7Rg7Y64Fe6jMjffzLB2dNQhVzD4EJ+TKQ=
X-Google-Smtp-Source: ABdhPJzfqFaq6oHis+KdEW+eOcQvr+EDi2Cs+oU0W/CivQOVvGtmThVjYhTOVLFMpK6Ybg1cF65XvZwMRQWTrmnYi+E=
X-Received: by 2002:a05:6808:1525:: with SMTP id u37mr18887506oiw.33.1632035879340;
 Sun, 19 Sep 2021 00:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210812045950.3190-1-bhumit.attarde01@gmail.com> <YRkg5GrK0XnD1fZZ@desktop>
In-Reply-To: <YRkg5GrK0XnD1fZZ@desktop>
From:   Bhumit Attarde <bhumitattarde01@gmail.com>
Date:   Sun, 19 Sep 2021 12:47:48 +0530
Message-ID: <CANb_4Ap9FUjLGxTQjtBn5LNdEzScV63tC-0G-=_3K0QO6pj+9A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Added FUSE support
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Apologies for the delayed response, too many things going on.

> I think we could set different 'dev' for TEST_DEV and SCRATCH_DEV, e.g.
>
> TEST_DEV=fuse_test
> SCRATCH_DEV=fuse_scratch
>
> And the "This check doesn't apply to FUSE since both mounts have the
> same device" check could be removed.

We did actually try setting different `dev` for TEST_DEV and
SCRATCH_DEV, but it doesn't work for certain FUSE applications like
KIO-FUSE, which is also the reason FUSE check is added (XFSTESTS
complaints that the device is already mounted and aborts). An
application like KIO-FUSE has the same dev name (`kio-fuse`) for all
FUSE mounts and deliberately setting different dev names not only
doesn't work at all but, in my opinion, also feels a little hacky.

> Set MOUNT_OPTIONS should be fine here.
>
> And we should set "subtype" in options as well, i.e.
>
> MOUNT_OPTIONS="-o source=/home/test/scratch,allow_other, default_permissions,subtype=passthrough_ll"
>
> Otherwise the filesystem type printed by mount of a passthrough_ll mount
> is only "fuse" and doesn't contain the subtype, and _check_mounted_on()
> will fail the check.
>
> Should do the same to _test_mount().

Will make these changes.

> Update DF_PROG definition instead, so all callers of $DF_PROG would
> print fuse mounts correctly.

This for some reason is not producing the same results for us, will
look into this more.

Best,
Bhumit Attarde


On Sun, 15 Aug 2021 at 19:43, Eryu Guan <guan@eryu.me> wrote:
>
> On Thu, Aug 12, 2021 at 10:29:50AM +0530, Bhumit Attarde wrote:
> > This allows any FUSE filesystem that can mounted like
> > `mount -t fuse.$FUSE_SUBTYP`
> > to be tested using XFSTESTS.
> >
> > This patch is an improvment on the patch originally submitted by Miklos
> > Szeredi.
> >
> > Signed-off-by: Bhumit Attarde <bhumit.attarde01@gmail.com>
> > ---
> >  README.fuse   | 29 +++++++++++++++++++++++++++++
> >  check         |  2 ++
> >  common/attr   |  4 ++--
> >  common/config | 10 ++++++++--
> >  common/rc     | 31 +++++++++++++++++++++++--------
> >  5 files changed, 64 insertions(+), 12 deletions(-)
> >  create mode 100644 README.fuse
> >
> > diff --git a/README.fuse b/README.fuse
> > new file mode 100644
> > index 00000000..839db5dd
> > --- /dev/null
> > +++ b/README.fuse
> > @@ -0,0 +1,29 @@
> > +Make sure you've followed instructions from the principal README.
> > +Instructions to test FUSE using the passthrough_ll example filesystem provided in the libfuse source tree:
> > +
> > +git clone git://github.com/libfuse/libfuse.git
> > +cd libfuse
> > +meson build
> > +cd build
> > +ninja
> > +cp example/passthrough_ll /usr/bin
> > +cd
> > +cat << 'EOF' > /sbin/mount.fuse.passthrough_ll
> > +#!/bin/bash
> > +ulimit -n 1048576
> > +exec /usr/bin/passthrough_ll -ofsname="$@"
> > +EOF
> > +chmod +x /sbin/mount.fuse.passthrough_ll
> > +mkdir -p /mnt/test /mnt/scratch /home/test/test /home/test/scratch
> > +
> > +
> > +Use the following config file:
> > +
> > +export TEST_DEV=passthrough_ll
> > +export TEST_DIR=/mnt/test
> > +export SCRATCH_DEV=passthrough_ll
>
> I think we could set different 'dev' for TEST_DEV and SCRATCH_DEV, e.g.
>
> TEST_DEV=fuse_test
> SCRATCH_DEV=fuse_scratch
>
> And the "This check doesn't apply to FUSE since both mounts have the
> same device" check could be removed.
>
> > +export SCRATCH_MNT=/mnt/scratch
> > +export FSTYP=fuse
> > +export FUSE_SUBTYP=.passthrough_ll
> > +export FUSE_MOUNT_OPTIONS="-osource=/home/test/scratch,allow_other,default_permissions"
>
> Set MOUNT_OPTIONS should be fine here.
>
> And we should set "subtype" in options as well, i.e.
>
> MOUNT_OPTIONS="-o source=/home/test/scratch,allow_other, default_permissions,subtype=passthrough_ll"
>
> Otherwise the filesystem type printed by mount of a passthrough_ll mount
> is only "fuse" and doesn't contain the subtype, and _check_mounted_on()
> will fail the check.
>
> > +export TEST_FS_MOUNT_OPTS="-osource=/home/test/test,allow_other,default_permissions"
> > diff --git a/check b/check
> > index a0863121..bae9fddd 100755
> > --- a/check
> > +++ b/check
> > @@ -59,6 +59,7 @@ check options
> >      -glusterfs               test GlusterFS
> >      -cifs            test CIFS
> >      -9p                      test 9p
> > +    -fuse            test fuse
> >      -virtiofs                test virtiofs
> >      -overlay         test overlay
> >      -pvfs2           test PVFS2
> > @@ -281,6 +282,7 @@ while [ $# -gt 0 ]; do
> >       -glusterfs)     FSTYP=glusterfs ;;
> >       -cifs)          FSTYP=cifs ;;
> >       -9p)            FSTYP=9p ;;
> > +     -fuse)          FSTYP=fuse ;;
> >       -virtiofs)      FSTYP=virtiofs ;;
> >       -overlay)       FSTYP=overlay; export OVERLAY=true ;;
> >       -pvfs2)         FSTYP=pvfs2 ;;
> > diff --git a/common/attr b/common/attr
> > index 35682d7c..f3342d25 100644
> > --- a/common/attr
> > +++ b/common/attr
> > @@ -253,7 +253,7 @@ _getfattr()
> >
> >  # set maximum total attr space based on fs type
> >  case "$FSTYP" in
> > -xfs|udf|pvfs2|9p|ceph|nfs)
> > +xfs|udf|pvfs2|9p|ceph|nfs|fuse)
> >       MAX_ATTRS=1000
> >       ;;
> >  ext2|ext3|ext4)
> > @@ -312,7 +312,7 @@ xfs|udf|btrfs)
> >  pvfs2)
> >       MAX_ATTRVAL_SIZE=8192
> >       ;;
> > -9p|ceph|nfs)
> > +9p|ceph|nfs|fuse)
> >       MAX_ATTRVAL_SIZE=65536
> >       ;;
> >  bcachefs)
> > diff --git a/common/config b/common/config
> > index 005fd50a..8203492d 100644
> > --- a/common/config
> > +++ b/common/config
> > @@ -305,6 +305,9 @@ _mount_opts()
> >       9p)
> >               export MOUNT_OPTIONS=$PLAN9_MOUNT_OPTIONS
> >               ;;
> > +     fuse)
> > +             export MOUNT_OPTIONS=$FUSE_MOUNT_OPTIONS
> > +             ;;
> >       xfs)
> >               export MOUNT_OPTIONS=$XFS_MOUNT_OPTIONS
> >               ;;
> > @@ -363,6 +366,9 @@ _test_mount_opts()
> >       9p)
> >               export TEST_FS_MOUNT_OPTS=$PLAN9_MOUNT_OPTIONS
> >               ;;
> > +     fuse)
> > +             export TEST_FS_MOUNT_OPTS=$FUSE_MOUNT_OPTIONS
> > +             ;;
> >       cifs)
> >               export TEST_FS_MOUNT_OPTS=$CIFS_MOUNT_OPTIONS
> >               ;;
> > @@ -501,8 +507,8 @@ _check_device()
> >       fi
> >
> >       case "$FSTYP" in
> > -     9p|tmpfs|virtiofs)
> > -             # 9p and virtiofs mount tags are just plain strings, so anything is allowed
> > +     9p|fuse|tmpfs|virtiofs)
> > +             # 9p, fuse and virtiofs mount tags are just plain strings, so anything is allowed
> >               # tmpfs doesn't use mount source, ignore
> >               ;;
> >       overlay)
> > diff --git a/common/rc b/common/rc
> > index d4b1f21f..1ae0746a 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -127,6 +127,8 @@ case "$FSTYP" in
> >        ;;
> >      9p)
> >        ;;
> > +    fuse)
> > +      ;;
> >      ceph)
> >        . ./common/ceph
> >        ;;
> > @@ -333,7 +335,7 @@ _try_scratch_mount()
> >               _overlay_scratch_mount $*
> >               return $?
> >       fi
> > -     _mount -t $FSTYP `_scratch_mount_options $*`
> > +     _mount -t $FSTYP$FUSE_SUBTYP `_scratch_mount_options $*`
>
> Should do the same to _test_mount().
>
> >  }
> >
> >  # mount scratch device with given options and _fail if mount fails
> > @@ -643,6 +645,9 @@ _test_mkfs()
> >      9p)
> >       # do nothing for 9p
> >       ;;
> > +    fuse)
> > +     # do nothing for fuse
> > +     ;;
> >      virtiofs)
> >       # do nothing for virtiofs
> >       ;;
> > @@ -683,6 +688,9 @@ _mkfs_dev()
> >      9p)
> >       # do nothing for 9p
> >       ;;
> > +    fuse)
> > +     # do nothing for fuse
> > +     ;;
> >      virtiofs)
> >       # do nothing for virtiofs
> >       ;;
> > @@ -750,7 +758,7 @@ _scratch_mkfs()
> >       local mkfs_status
> >
> >       case $FSTYP in
> > -     nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|virtiofs)
> > +     nfs*|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
> >               # unable to re-create this fstyp, just remove all files in
> >               # $SCRATCH_MNT to avoid EEXIST caused by the leftover files
> >               # created in previous runs
> > @@ -1271,7 +1279,7 @@ _df_device()
> >
> >      # Note that we use "==" here so awk doesn't try to interpret an NFS over
> >      # IPv6 server as a regular expression.
> > -    $DF_PROG 2>/dev/null | $AWK_PROG -v what=$1 '
> > +    $DF_PROG -a 2>/dev/null | $AWK_PROG -v what=$1 '
>
> Update DF_PROG definition instead, so all callers of $DF_PROG would
> print fuse mounts correctly.
>
> >          ($1==what) && (NF==1) {
> >              v=$1
> >              getline
> > @@ -1514,14 +1522,15 @@ _check_mounted_on()
> >       [ -n "$mount_rec" ] || return 1 # 1 = not mounted
> >
> >       # if it's mounted, make sure its on $mnt
> > -     if [ "$mount_rec" != "$dev $mnt" ]; then
> > +     # This check doesn't apply to FUSE since both mounts have the same device
> > +     if [[ "$FSTYP" != "fuse" && "$mount_rec" != "$dev $mnt" ]]; then
>
> As stated above, I don't think this check is needed. Any reason to do so?
>
> Thanks,
> Eryu
>
> >               echo "$devname=$dev is mounted but not on $mntname=$mnt - aborting"
> >               echo "Already mounted result:"
> >               echo $mount_rec
> >               return 2 # 2 = mounted on wrong mnt
> >       fi
> >
> > -     if [ -n "$type" -a "`_fs_type $dev`" != "$type" ]; then
> > +     if [ -n "$type" -a "`_fs_type $dev`" != "$type$FUSE_SUBTYP" ]; then
> >               echo "$devname=$dev is mounted but not a type $type filesystem"
> >               # raw $DF_PROG cannot handle NFS/CIFS/overlay correctly
> >               _df_device $dev
> > @@ -1545,7 +1554,7 @@ _require_scratch_nocheck()
> >                       _notrun "this test requires a valid \$SCRATCH_MNT"
> >               fi
> >               ;;
> > -     9p|virtiofs)
> > +     9p|fuse|virtiofs)
> >               if [ -z "$SCRATCH_DEV" ]; then
> >                       _notrun "this test requires a valid \$SCRATCH_DEV"
> >               fi
> > @@ -1701,7 +1710,7 @@ _require_test()
> >                       _notrun "this test requires a valid \$TEST_DIR"
> >               fi
> >               ;;
> > -     9p|virtiofs)
> > +     9p|fuse|virtiofs)
> >               if [ -z "$TEST_DEV" ]; then
> >                       _notrun "this test requires a valid \$TEST_DEV"
> >               fi
> > @@ -2863,7 +2872,7 @@ _mount_or_remount_rw()
> >
> >       if [ $USE_REMOUNT -eq 0 ]; then
> >               if [ "$FSTYP" != "overlay" ]; then
> > -                     _mount -t $FSTYP $mount_opts $device $mountpoint
> > +                     _mount -t $FSTYP$FUSE_SUBTYP $mount_opts $device $mountpoint
> >               else
> >                       _overlay_mount $device $mountpoint
> >               fi
> > @@ -3000,6 +3009,9 @@ _check_test_fs()
> >      9p)
> >       # no way to check consistency for 9p
> >       ;;
> > +    fuse)
> > +     # no way to check consistency for fuse
> > +     ;;
> >      virtiofs)
> >       # no way to check consistency for virtiofs
> >       ;;
> > @@ -3061,6 +3073,9 @@ _check_scratch_fs()
> >      9p)
> >       # no way to check consistency for 9p
> >       ;;
> > +    fuse)
> > +     # no way to check consistency for fuse
> > +     ;;
> >      virtiofs)
> >       # no way to check consistency for virtiofs
> >       ;;
> > --
> > 2.30.1

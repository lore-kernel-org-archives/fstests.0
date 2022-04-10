Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CC8C433EF
	for <linux-fstests@archiver.kernel.org>; Sun, 10 Apr 2022 12:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbiDJMNY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 10 Apr 2022 08:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbiDJMNX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Apr 2022 08:13:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69FC22D1EB
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649592671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q4fNYMuFlRxW2wSqGB+3FpzbpwR722N3iRQ84tYbzzE=;
        b=ZSfYRvt4n2hn9vkjWYud9fCQfiJ7JUKnkb3/0flyCydPM/K9oCRy9JlktqbYXJBSaLX583
        B7Sn9ekxUA/elontXrbPn35ar/84ghjx58B3JHLiMyxQ5osTV6az9HI/NLdwNysWa3D6Zr
        c/sVxHFEkeRdZU7XLecsqOcupAOKOvk=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-MH04g-FyOy-gA7FyJIFo4Q-1; Sun, 10 Apr 2022 08:11:10 -0400
X-MC-Unique: MH04g-FyOy-gA7FyJIFo4Q-1
Received: by mail-pf1-f197.google.com with SMTP id b6-20020a62a106000000b0050564d6fd75so6004423pff.22
        for <fstests@vger.kernel.org>; Sun, 10 Apr 2022 05:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=q4fNYMuFlRxW2wSqGB+3FpzbpwR722N3iRQ84tYbzzE=;
        b=0Pz9say4wVEcAfINVOOaVFPhUM01aEsRSgUhrbcibyUemzKTTnG/bp7wr1KEvQawUE
         Gbeidjy1d3gZOXAfP8EDSwX27JEMevvu3p3WMgrhjmAD0y81oKkJuk4Dh2VtaXwD6r/R
         r+8n8Yux0L4oPyMtICgKfiAlHXnu0eiSbVKLQjoYrTWgT8tW0rhyoQtC7KHKGgg09MKM
         7snCuxXylVB9FT9OLQ+mUfVpQlT3yAmNQWg0YrGb1/haIbxASce0oyOzEYU7kUAUZ4mb
         DcJL4YlNH3ZKOfFIcOHzVgGZiKWjkxelnzrXb5FaWjwaZYrJU26MAkSPewgdmjtyZtgJ
         mVlw==
X-Gm-Message-State: AOAM532qFA4SyCJcdB8FiNCOhQTtaXus2AIeBfqv47t+vclz2/JdogUU
        YiDEuNrTwCtKyR+YKjL1+jqZh+LHcmcvMJla+Nwdcy3ElQPZJ0DWcOZuQjNx8clE6RDZ7bx9etu
        lepOF7XeDIOmLLTZ6aQ==
X-Received: by 2002:a17:90b:3805:b0:1c7:6e7a:3e01 with SMTP id mq5-20020a17090b380500b001c76e7a3e01mr31261247pjb.213.1649592668458;
        Sun, 10 Apr 2022 05:11:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZcTXFyrP9adh/aiLMZTobCXNCYyivyGwDy2Wgy/4OM4mn6WNLRgfrml4IymxTOxu+/BZFYA==
X-Received: by 2002:a17:90b:3805:b0:1c7:6e7a:3e01 with SMTP id mq5-20020a17090b380500b001c76e7a3e01mr31261234pjb.213.1649592668123;
        Sun, 10 Apr 2022 05:11:08 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a27-20020aa795bb000000b00505a7541d7asm3297587pfk.35.2022.04.10.05.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 05:11:07 -0700 (PDT)
Date:   Sun, 10 Apr 2022 20:11:03 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] xfs: test xfsdump when an inode < root inode is
 present
Message-ID: <20220410121103.wk2hgixq57dogzah@zlang-mailbox>
Mail-Followup-To: "Darrick J. Wong" <djwong@kernel.org>,
        fstests@vger.kernel.org
References: <20220408170847.1088522-1-zlang@redhat.com>
 <20220409040056.GA14099@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409040056.GA14099@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 08, 2022 at 09:00:56PM -0700, Darrick J. Wong wrote:
> On Sat, Apr 09, 2022 at 01:08:47AM +0800, Zorro Lang wrote:
> > From: Eric Sandeen <sandeen@redhat.com>
> > 
> > This tests a longstanding bug where xfsdumps are not properly
> > created when an inode is present on the filesytsem which has
> > a lower number than the root inode.
> > 
> > Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> > ---
> > 
> > Friendly ping for reviewing.
> > 
> > Thanks,
> > Zorro
> > 
> >  common/dump       |  1 +
> >  tests/xfs/543     | 63 +++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/xfs/543.out | 47 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 111 insertions(+)
> >  create mode 100755 tests/xfs/543
> >  create mode 100644 tests/xfs/543.out
> > 
> > diff --git a/common/dump b/common/dump
> > index ea16d442..ab48cd13 100644
> > --- a/common/dump
> > +++ b/common/dump
> > @@ -219,6 +219,7 @@ _require_tape()
> >  
> >  _wipe_fs()
> >  {
> > +    [[ "$WIPE_FS" = "no" ]] && return
> 
> Is WIPE_FS intended as a general means to prevent wipefs -a between
> tests?  If so, it ought to be in the README.

Actually I don't know how to if I should say WIPE_FS means to prevent
wipefs -a between tests. Due to:

1) We have a _wipe_fs() in common/dump[1], it's very old, and it only
try to make a new xfs, although it calls wipe "fs"... And it's only used
for tests/xfs/* cases to call _create_dumpdir_*() function.

2) Then we have _try_wipe_scratch_devs() in common/rc [2], which calls
_try_wipe_scratch_xfs() in common/xfs [3] (which is newer), it's only
used in ./check script now.

So I'm wondering if we'd better to change the _wipe_fs() to:
_wipe_dump()
{
	[[ "$WIPE_DUMP" = "no" ]] && return
	_require_scratch

	_try_wipe_scratch_devs >>$seqres.full
	_scratch_mount >>$seqres.full
}

What do you think?

Thanks,
Zorro

[1]
_wipe_fs()
{
    [[ "$WIPE_FS" = "no" ]] && return
    _require_scratch

    _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
    _scratch_mount >>$seqres.full
}

[2]
_try_wipe_scratch_devs()
{
        test -x "$WIPEFS_PROG" || return 0

        # Do specified filesystem wipe at first
        case "$FSTYP" in
        "xfs")
                _try_wipe_scratch_xfs
                ;;
        esac

        # Then do wipefs on all scratch devices
        for dev in $SCRATCH_DEV_POOL $SCRATCH_DEV $SCRATCH_LOGDEV $SCRATCH_RTDEV; do
                test -b $dev && $WIPEFS_PROG -a $dev
        done
}

[3]
# Wipe the superblock of each XFS AGs
_try_wipe_scratch_xfs()
{
        local num='^[0-9]+$'
        local agcount
        local agsize
        local dbsize

        # Try to wipe each SB if there's an existed XFS
        agcount=`_scratch_xfs_get_sb_field agcount 2>/dev/null`
        agsize=`_scratch_xfs_get_sb_field agblocks 2>/dev/null`
        dbsize=`_scratch_xfs_get_sb_field blocksize 2>/dev/null`
        if [[ $agcount =~ $num && $agsize =~ $num && $dbsize =~ $num ]];then
                for ((i = 0; i < agcount; i++)); do
                        $XFS_IO_PROG -c "pwrite $((i * dbsize * agsize)) $dbsize" \
                                $SCRATCH_DEV >/dev/null;
                done
        fi

        # Try to wipe each SB by default mkfs.xfs geometry
        local tmp=`mktemp -u`
        unset agcount agsize dbsize
        _scratch_mkfs_xfs -N 2>/dev/null | perl -ne '
                if (/^meta-data=.*\s+agcount=(\d+), agsize=(\d+) blks/) {
                        print STDOUT "agcount=$1\nagsize=$2\n";
                }
                if (/^data\s+=\s+bsize=(\d+)\s/) {
                        print STDOUT "dbsize=$1\n";
                }' > $tmp.mkfs

        . $tmp.mkfs
        if [[ $agcount =~ $num && $agsize =~ $num && $dbsize =~ $num ]];then
                for ((i = 0; i < agcount; i++)); do
                        $XFS_IO_PROG -c "pwrite $((i * dbsize * agsize)) $dbsize" \
                                $SCRATCH_DEV >/dev/null;
                done
        fi
        rm -f $tmp.mkfs
}

> 
> --D
> 
> >      _require_scratch
> >  
> >      _scratch_mkfs_xfs >>$seqres.full || _fail "mkfs failed"
> > diff --git a/tests/xfs/543 b/tests/xfs/543
> > new file mode 100755
> > index 00000000..4e3c823a
> > --- /dev/null
> > +++ b/tests/xfs/543
> > @@ -0,0 +1,63 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 Red Hat, Inc. All Rights Reserved.
> > +#
> > +# FS QA Test 543
> > +#
> > +# Create a filesystem which contains an inode with a lower number
> > +# than the root inode. Ensure that xfsdump/xfsrestore handles this.
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick dump
> > +
> > +# Import common functions.
> > +. ./common/dump
> > +
> > +_supported_fs xfs
> > +_require_scratch
> > +
> > +# A large stripe unit will put the root inode out quite far
> > +# due to alignment, leaving free blocks ahead of it.
> > +_scratch_mkfs_xfs -d sunit=1024,swidth=1024 > $seqres.full 2>&1
> > +
> > +# Mounting /without/ a stripe should allow inodes to be allocated
> > +# in lower free blocks, without the stripe alignment.
> > +_scratch_mount -o sunit=0,swidth=0
> > +
> > +root_inum=$(stat -c %i $SCRATCH_MNT)
> > +
> > +# Consume space after the root inode so that the blocks before
> > +# root look "close" for the next inode chunk allocation
> > +$XFS_IO_PROG -f -c "falloc 0 16m" $SCRATCH_MNT/fillfile
> > +
> > +# And make a bunch of inodes until we (hopefully) get one lower
> > +# than root, in a new inode chunk.
> > +echo "root_inum: $root_inum" >> $seqres.full
> > +for i in $(seq 0 4096) ; do
> > +	fname=$SCRATCH_MNT/$(printf "FILE_%03d" $i)
> > +	touch $fname
> > +	inum=$(stat -c "%i" $fname)
> > +	[[ $inum -lt $root_inum ]] && break
> > +done
> > +
> > +echo "created: $inum" >> $seqres.full
> > +
> > +[[ $inum -lt $root_inum ]] || _notrun "Could not set up test"
> > +
> > +# Now try a dump and restore. Cribbed from xfs/068
> > +WIPE_FS="no"
> > +_create_dumpdir_stress
> > +
> > +echo -n "Before: " >> $seqres.full
> > +_count_dumpdir_files | tee $tmp.before >> $seqres.full
> > +
> > +# filter out the file count, it changes as fsstress adds new operations
> > +_do_dump_restore | sed -e "/entries processed$/s/[0-9][0-9]*/NUM/g"
> > +
> > +echo -n "After: " >> $seqres.full
> > +_count_restoredir_files | tee $tmp.after >> $seqres.full
> > +diff -u $tmp.before $tmp.after
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/xfs/543.out b/tests/xfs/543.out
> > new file mode 100644
> > index 00000000..a5224aaf
> > --- /dev/null
> > +++ b/tests/xfs/543.out
> > @@ -0,0 +1,47 @@
> > +QA output created by 543
> > +Creating directory system to dump using fsstress.
> > +
> > +-----------------------------------------------
> > +fsstress : -f link=10 -f creat=10 -f mkdir=10 -f truncate=5 -f symlink=10
> > +-----------------------------------------------
> > +xfsdump|xfsrestore ...
> > +xfsdump  -s DUMP_SUBDIR - SCRATCH_MNT | xfsrestore  - RESTORE_DIR
> > +xfsrestore: using file dump (drive_simple) strategy
> > +xfsrestore: searching media for dump
> > +xfsrestore: examining media file 0
> > +xfsrestore: dump description: 
> > +xfsrestore: hostname: HOSTNAME
> > +xfsrestore: mount point: SCRATCH_MNT
> > +xfsrestore: volume: SCRATCH_DEV
> > +xfsrestore: session time: TIME
> > +xfsrestore: level: 0
> > +xfsrestore: session label: ""
> > +xfsrestore: media label: ""
> > +xfsrestore: file system ID: ID
> > +xfsrestore: session id: ID
> > +xfsrestore: media ID: ID
> > +xfsrestore: searching media for directory dump
> > +xfsrestore: reading directories
> > +xfsrestore: NUM directories and NUM entries processed
> > +xfsrestore: directory post-processing
> > +xfsrestore: restoring non-directory files
> > +xfsrestore: restore complete: SECS seconds elapsed
> > +xfsrestore: Restore Status: SUCCESS
> > +xfsdump: using file dump (drive_simple) strategy
> > +xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
> > +xfsdump: dump date: DATE
> > +xfsdump: session id: ID
> > +xfsdump: session label: ""
> > +xfsdump: ino map <PHASES>
> > +xfsdump: ino map construction complete
> > +xfsdump: estimated dump size: NUM bytes
> > +xfsdump: /var/xfsdump/inventory created
> > +xfsdump: creating dump session media file 0 (media 0, file 0)
> > +xfsdump: dumping ino map
> > +xfsdump: dumping directories
> > +xfsdump: dumping non-directory files
> > +xfsdump: ending media file
> > +xfsdump: media file size NUM bytes
> > +xfsdump: dump size (non-dir files) : NUM bytes
> > +xfsdump: dump complete: SECS seconds elapsed
> > +xfsdump: Dump Status: SUCCESS
> > -- 
> > 2.31.1
> > 
> 


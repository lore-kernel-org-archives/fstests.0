Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692EDC0015E
	for <linux-fstests@archiver.kernel.org>; Tue, 25 Jul 2023 10:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjGYKha (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 Jul 2023 06:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbjGYKhX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 25 Jul 2023 06:37:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C832131
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 03:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690281396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TU5HnKfTT0SL1n4x/ey6vhMjJ8U7+Qg7Z6HJpjEgjE4=;
        b=T79EhrQGDyuuZYjD5JYixxeN/bQke1z7gxHdJOl47X0fdRLzlQX9BTqJszpGVpVeA/Zr/e
        0kpPZSCuAyWcxyuFYHkjKOB7gFyFuDGNp689WgvW+MtBZXgDpNndP1YzpW61ENj3N92Eg1
        OGpK9k26kGts7jZWXZvO5r4zh8Gze1o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-fkoss4D5Mj2yya2gMTWM2Q-1; Tue, 25 Jul 2023 06:36:33 -0400
X-MC-Unique: fkoss4D5Mj2yya2gMTWM2Q-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-55c79a5564cso2235763a12.3
        for <fstests@vger.kernel.org>; Tue, 25 Jul 2023 03:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690281392; x=1690886192;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TU5HnKfTT0SL1n4x/ey6vhMjJ8U7+Qg7Z6HJpjEgjE4=;
        b=V8VaLrhqvX6d9yoQpx/hl+sgHrVfMapZt4FFCPbdHGoU4CmsOSbmLUQuvKXfbohIjc
         eNusX+7zOmpMVJYYJZfyfAf9H4O2MK5j6rAWMBsI5KlLg3d+tde0NMgl65W4P4XpTtEG
         3H/C2CTycezJuSsThe9S4uNZAwlzJnd28lHyyefUqMKjezGQF0pVWG0YA1jNmy9ETWhQ
         EarDx/Xcr2f7qiBVSFaDmzBseYtCD5WMMtL5F/ljaKPVFE3HZUprSZEBEOBX8Y2Egjcj
         BtGga/GpmtD5C0r/rznWawwPsLcyXBi41QQXQMTFfDMG+3UzWnhJa60YWKVUbgJtwKkN
         +Tvw==
X-Gm-Message-State: ABy/qLb5GNich4nQ+oZKb055J3Vfn8mgz0bAt+a8AubzqpnMefL9W/8m
        cU218O2OPAMNlUvjckVXp4dMK+3TVkpWblOIBl6Qimmx1qLKLik9nbSjvAku88p4A4j5zEJ99/y
        l3CSSokvoTtlVjqIkZw==
X-Received: by 2002:a05:6a20:8e0e:b0:130:835b:e260 with SMTP id y14-20020a056a208e0e00b00130835be260mr10552613pzj.52.1690281392406;
        Tue, 25 Jul 2023 03:36:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGB1hKoRpTf4tTXIGyosiqJ4oEd0pcJK9rRfCwzPXBPik0n/413X7+kzGR3uthNWF5QiJkDkw==
X-Received: by 2002:a05:6a20:8e0e:b0:130:835b:e260 with SMTP id y14-20020a056a208e0e00b00130835be260mr10552593pzj.52.1690281392028;
        Tue, 25 Jul 2023 03:36:32 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bb11-20020a170902bc8b00b00198d7b52eefsm10591275plb.257.2023.07.25.03.36.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 03:36:31 -0700 (PDT)
Date:   Tue, 25 Jul 2023 18:36:28 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: add a test case to make sure scrub can repair
 parity corruption
Message-ID: <20230725103628.bd7sxyjgyit7t7t5@zlang-mailbox>
References: <20230724023606.91107-1-wqu@suse.com>
 <334de8f1-5f7f-5817-9c33-f7fac7b2a24b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <334de8f1-5f7f-5817-9c33-f7fac7b2a24b@oracle.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Jul 24, 2023 at 03:48:52PM +0800, Anand Jain wrote:
> On 24/7/23 10:36, Qu Wenruo wrote:
> > There is a kernel regression caused by commit 75b470332965 ("btrfs:
> > raid56: migrate recovery and scrub recovery path to use error_bitmap"),
> > which leads to scrub not repairing corrupted parity stripes.
> > 
> > So here we add a test case to verify the P/Q stripe scrub behavior by:
> > 
> > - Create a RAID5 or RAID6 btrfs with minimal amount of devices
> >    This means 2 devices for RAID5, and 3 devices for RAID6.
> >    This would result the parity stripe to be a mirror of the only data
> >    stripe.
> > 
> >    And since we have control of the content of data stripes, the content
> >    of the P stripe is also fixed.
> > 
> > - Create an 64K file
> >    The file would cover one data stripe.
> > 
> > - Corrupt the P stripe
> > 
> > - Scrub the fs
> >    If scrub is working, the P stripe would be repaired.
> > 
> >    Unfortunately scrub can not report any P/Q corruption, limited by its
> >    reporting structure.
> >    So we can not use the return value of scrub to determine if we
> >    repaired anything.
> > 
> > - Verify the content of the P stripe
> > 
> > - Use "btrfs check --check-data-csum" to double check
> > 
> > By above steps, we can verify if the P stripe is properly fixed.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Changelog:
> > v2:
> > - Rebase to the latest misc-next
> > - Use space_cache=v2 mount option instead of nospace_cache
> >    New features like block group tree and extent tree v2 requires v2
> >    cache
> > - Fix a white space error
> > ---
> >   tests/btrfs/297     | 85 +++++++++++++++++++++++++++++++++++++++++++++
> >   tests/btrfs/297.out |  2 ++
> >   2 files changed, 87 insertions(+)
> >   create mode 100755 tests/btrfs/297
> >   create mode 100644 tests/btrfs/297.out
> > 
> > diff --git a/tests/btrfs/297 b/tests/btrfs/297
> > new file mode 100755
> > index 00000000..852c3ace
> > --- /dev/null
> > +++ b/tests/btrfs/297
> > @@ -0,0 +1,85 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> 
> > +# Copyright (c) 2023 YOUR NAME HERE.  All Rights Reserved.
> 
> NIT: Actual name is required here.
> 
> Rest of the code looks good.

If there's not more review points, I can help to
   s/YOUR NAME HERE/SUSE Linux Products GmbH
when I merge it.

BTW, do you mean there's a RVB from you?

Thanks,
Zorro

> 
> Thanks.
> 
> > +#
> > +# FS QA Test 297
> > +#
> > +# Make sure btrfs scrub can fix parity stripe corruption
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick raid scrub
> > +
> > +. ./common/filter
> > +
> > +_supported_fs btrfs
> > +_require_odirect
> > +_require_non_zoned_device "${SCRATCH_DEV}"
> > +_require_scratch_dev_pool 3
> > +_fixed_by_kernel_commit 486c737f7fdc \
> > +	"btrfs: raid56: always verify the P/Q contents for scrub"
> > +
> > +workload()
> > +{
> > +	local profile=$1
> > +	local nr_devs=$2
> > +
> > +	echo "=== Testing $nr_devs devices $profile ===" >> $seqres.full
> > +	_scratch_dev_pool_get $nr_devs
> > +
> > +	_scratch_pool_mkfs -d $profile -m single >> $seqres.full 2>&1
> > +	# Use v2 space cache to prevent v1 space cache affecting
> > +	# the result.
> > +	_scratch_mount -o space_cache=v2
> > +
> > +	# Create one 64K extent which would cover one data stripe.
> > +	$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 64K 0 64K" \
> > +		"$SCRATCH_MNT/foobar" > /dev/null
> > +	sync
> > +
> > +	# Corrupt the P/Q stripe
> > +	local logical=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
> > +
> > +	# The 2nd copy is pointed to P stripe directly.
> > +	physical_p=$(_btrfs_get_physical ${logical} 2)
> > +	devpath_p=$(_btrfs_get_device_path ${logical} 2)
> > +
> > +	_scratch_unmount
> > +
> > +	echo "Corrupt stripe P at devpath $devpath_p physical $physical_p" \
> > +		>> $seqres.full
> > +	$XFS_IO_PROG -d -c "pwrite -S 0xff -b 64K $physical_p 64K" $devpath_p \
> > +		> /dev/null
> > +
> > +	# Do a scrub to try repair the P stripe.
> > +	_scratch_mount -o space_cache=v2
> > +	$BTRFS_UTIL_PROG scrub start -BdR $SCRATCH_MNT >> $seqres.full 2>&1
> > +	_scratch_unmount
> > +
> > +	# Verify the repaired content directly
> > +	local output=$($XFS_IO_PROG -c "pread -qv $physical_p 16" $devpath_p | _filter_xfs_io_offset)
> > +	local expect="XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................"
> > +
> > +	echo "The first 16 bytes of parity stripe after scrub:" >> $seqres.full
> > +	echo $output >> $seqres.full
> > +	if [ "$output" != "$expect" ]; then
> > +		echo "Unexpected parity content"
> > +		echo "has:"
> > +		echo "$output"
> > +		echo "expect"
> > +		echo "$expect"
> > +	fi
> > +
> > +	# Last safenet, let btrfs check --check-data-csum to do an offline scrub.
> > +	$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full 2>&1
> > +	if [ $? -ne 0 ]; then
> > +		echo "Error detected after the scrub"
> > +	fi
> > +	_scratch_dev_pool_put
> > +}
> > +
> > +workload raid5 2
> > +workload raid6 3
> > +
> > +echo "Silence is golden"
> > +status=0
> > +exit
> > diff --git a/tests/btrfs/297.out b/tests/btrfs/297.out
> > new file mode 100644
> > index 00000000..41c373c4
> > --- /dev/null
> > +++ b/tests/btrfs/297.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 297
> > +Silence is golden
> 


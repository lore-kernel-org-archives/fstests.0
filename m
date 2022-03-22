Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3DFC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbiCVQJ3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238891AbiCVQJ2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 12:09:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0B18CDBE
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 09:07:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 087D1B81CD8
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 16:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB10CC340F0;
        Tue, 22 Mar 2022 16:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647965276;
        bh=d5FmeP+EGsExfJcZ100im3SUI8usGSqet1ZHAlJqExg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1jl7nElKXlxjC2N2G5CWBP8F9dmWqjUjdff2lCn4y42vfqY6/4VKXUs1DOzIiFH7
         49LKQ+/0g55S1S9d/YlIu3ubJiRgNUt6ck1RAL3NxA4lEV1nA1C7K9H/Ka6v2PHbwj
         t3AWZgqivtxTQRtR6mpZQBhwrR8cCGxB5eTY9YFWgO59r51ivgywywswDtRYLyClgU
         vbQonbWi/EcFAtcjhw4vheIQfeKXnJjiNrFSLTupFMYV+NueZrLtTb+MBQpNZ5UtIB
         az7QhvpwyzeAyMwITOguiHbXeOwsc84qo2UcSNV0wpZBK4dWcrs7SlUeYBsrwp1AaU
         1DLCcTm1HwepA==
Date:   Tue, 22 Mar 2022 09:07:56 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com
Subject: Re: [PATCH] generic/108: use sysfs values for logical,physical block
 size in scsi_debug
Message-ID: <20220322160756.GM8200@magnolia>
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
 <20220301212947.28660-1-nj.shetty@samsung.com>
 <20220321202133.GJ8200@magnolia>
 <20220322082629.GA32722@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322082629.GA32722@test-zns>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 01:56:29PM +0530, Nitesh Shetty wrote:
>  Mon, Mar 21, 2022 at 01:21:33PM -0700, Darrick J. Wong wrote:
> > On Wed, Mar 02, 2022 at 02:59:47AM +0530, Nitesh Shetty wrote:
> > > scsi_debug device used for test, is created with assumption of 512 bytes
> > > logical and physical block size.
> > > This causes error in lvcreate step, when SCRATCH_DEV device lba is not
> > > 512 bytes. This can be solved by reading block size from sysfs of device.
> > > If sysfs is missing fallback to 512 bytes as default.
> > > 
> > > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > ---
> > >  tests/generic/108 | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tests/generic/108 b/tests/generic/108
> > > index ad43269f..db0e9bd0 100755
> > > --- a/tests/generic/108
> > > +++ b/tests/generic/108
> > > @@ -42,8 +42,11 @@ _require_non_zoned_device $SCRATCH_DEV
> > >  lvname=lv_$seq
> > >  vgname=vg_$seq
> > >  
> > > +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> > > +logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
> > 
> > This causes a regression if $SCRATCH_DEV is not a raw block device:
> > 
> Acked, I was testing for NVMe device, missed out sda sysfs.
> Let me see, if I can use other sysfs/utility to get block size of device.
> 
> Also I see many 4k LBA tests failing mainly because of setup failure in
> format command. This is not actually test failure, rather setup failure.
> So what do you suggest for those type of tests?

Ideally, fix the ones that can be fixed, and _notrun the rest.

> Should I put them in not run status or just report to community so that
> person with relevant expertise can add a fix?

For this specific problem I suggest creating a function that finds the
/sys/block/XXX path for any given block device or partition, and then
update all the open coded logic to use it.  Something like:

# Map a block device to its counterpart in sysfs
_sysfs_block() {
	local dev="$1"
	local shortdev="$(_short_dev "$dev")"

	# Full block devices are simple
	local ret="/sys/block/$shortdev"
	if [ -e "$ret" ]; then
		readlink -m "$ret"
		return 0
	fi

	# Partitions are a little trickier
	ret="/sys/class/block/$shortdev"
	if [ -e "$ret/partition" ]; then
		readlink -m "$ret/.."
		return 0
	fi

	# ???
	return 1
}

sysfsb=$(_sysfs_block $SCRATCH_DEV)
physical=$(cat $sysfsb/queue/physical_block_size)

--D

> 
> --Nitesh Shetty
> 
> 
> > # SCRATCH_DEV=/dev/sda4 ./check generic/108
> > ...
> > --- generic/108.out
> > +++ generic/108.out.bad
> > @@ -1,2 +1,4 @@
> >  QA output created by 108
> > +cat: /sys/block/sda4/queue/physical_block_size: No such file or directory
> > +cat: /sys/block/sda4/queue/logical_block_size: No such file or directory
> >  fsync: Input/output error
> > 
> > --D
> > 
> > > +
> > >  # _get_scsi_debug_dev returns a scsi debug device with 128M in size by default
> > > -SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 300`
> > > +SCSI_DEBUG_DEV=`_get_scsi_debug_dev ${physical:-512} ${logical:-512} 0 300`
> > >  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> > >  echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full
> > >  
> > > 
> > > base-commit: 2ea74ba4e70b546279896e2a733c8c7f4b206193
> > > -- 
> > > 2.25.1
> > > 
> > 



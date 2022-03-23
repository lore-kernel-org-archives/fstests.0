Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3105C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 23 Mar 2022 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239286AbiCWQyn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 23 Mar 2022 12:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239310AbiCWQym (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 23 Mar 2022 12:54:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6086121E26
        for <fstests@vger.kernel.org>; Wed, 23 Mar 2022 09:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1D6E7B81FB1
        for <fstests@vger.kernel.org>; Wed, 23 Mar 2022 16:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C56C340E8;
        Wed, 23 Mar 2022 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648054389;
        bh=UlY3D5hGte+BJ+GpbqIYbrh4/xplXTgy6lCUV3lDZ3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bju6+MLdT9CIxo7YCFvMXdNgr7M213KKri6VuDz7ti/0ZELESLy/9MqkJBVg6BNqT
         ZbmRRMqHFegb8zQRsWsjLuZc7MS5Pyt+eD5Jg8cyUsdJbsdIkZIT+mSqpXgh+P2g6Y
         O9bRXJtfZzQ6rcm6pXvp1oG8+rY+/VdqfkB4CSWFUupoDPWlLxnLI6fYtlzXHXnyoG
         4Lf8tUdUj9TdEJhJzMcwoXPR7tcZ08CmnzeAmn6i5evA0PoqPCRwcpKfIbdOO7bfP8
         yJLKt2B2LswXD9z/SrXwa3oFRXUD4r+u3VrKUs6pQnQ0ESgFrWAAffHC3C2PMweoug
         dhCpR4oAtOz9w==
Date:   Wed, 23 Mar 2022 09:53:09 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     fstests@vger.kernel.org, nitheshshetty@gmail.com
Subject: Re: [PATCH] generic/108: use sysfs values for logical,physical block
 size in scsi_debug
Message-ID: <20220323165309.GQ8200@magnolia>
References: <CGME20220301213455epcas5p30ff48390a70523f4bc3d99de0027d3bd@epcas5p3.samsung.com>
 <20220301212947.28660-1-nj.shetty@samsung.com>
 <20220321202133.GJ8200@magnolia>
 <20220322082629.GA32722@test-zns>
 <20220322160756.GM8200@magnolia>
 <20220323120718.GC19899@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323120718.GC19899@test-zns>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Mar 23, 2022 at 05:37:18PM +0530, Nitesh Shetty wrote:
> On Tue, Mar 22, 2022 at 09:07:56AM -0700, Darrick J. Wong wrote:
> > On Tue, Mar 22, 2022 at 01:56:29PM +0530, Nitesh Shetty wrote:
> > >  Mon, Mar 21, 2022 at 01:21:33PM -0700, Darrick J. Wong wrote:
> > > > On Wed, Mar 02, 2022 at 02:59:47AM +0530, Nitesh Shetty wrote:
> > > > > scsi_debug device used for test, is created with assumption of 512 bytes
> > > > > logical and physical block size.
> > > > > This causes error in lvcreate step, when SCRATCH_DEV device lba is not
> > > > > 512 bytes. This can be solved by reading block size from sysfs of device.
> > > > > If sysfs is missing fallback to 512 bytes as default.
> > > > > 
> > > > > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > > > > ---
> > > > >  tests/generic/108 | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/tests/generic/108 b/tests/generic/108
> > > > > index ad43269f..db0e9bd0 100755
> > > > > --- a/tests/generic/108
> > > > > +++ b/tests/generic/108
> > > > > @@ -42,8 +42,11 @@ _require_non_zoned_device $SCRATCH_DEV
> > > > >  lvname=lv_$seq
> > > > >  vgname=vg_$seq
> > > > >  
> > > > > +physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> > > > > +logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
> > > > 
> > > > This causes a regression if $SCRATCH_DEV is not a raw block device:
> > > > 
> > > Acked, I was testing for NVMe device, missed out sda sysfs.
> > > Let me see, if I can use other sysfs/utility to get block size of device.
> > > 
> > > Also I see many 4k LBA tests failing mainly because of setup failure in
> > > format command. This is not actually test failure, rather setup failure.
> > > So what do you suggest for those type of tests?
> > 
> > Ideally, fix the ones that can be fixed, and _notrun the rest.
> > 
> 
> Sure, will send a different patchset.
> 
> > > Should I put them in not run status or just report to community so that
> > > person with relevant expertise can add a fix?
> > 
> > For this specific problem I suggest creating a function that finds the
> > /sys/block/XXX path for any given block device or partition, and then
> > update all the open coded logic to use it.  Something like:
> > 
> > # Map a block device to its counterpart in sysfs
> > _sysfs_block() {
> > 	local dev="$1"
> > 	local shortdev="$(_short_dev "$dev")"
> > 
> > 	# Full block devices are simple
> > 	local ret="/sys/block/$shortdev"
> > 	if [ -e "$ret" ]; then
> > 		readlink -m "$ret"
> > 		return 0
> > 	fi
> > 
> > 	# Partitions are a little trickier
> > 	ret="/sys/class/block/$shortdev"
> > 	if [ -e "$ret/partition" ]; then
> > 		readlink -m "$ret/.."
> > 		return 0
> > 	fi
> > 
> > 	# ???
> > 	return 1
> > }
> > 
> > sysfsb=$(_sysfs_block $SCRATCH_DEV)
> > physical=$(cat $sysfsb/queue/physical_block_size)
> > 
> > --D
> >
> 
> As a alternate, using blockdev utility might reduce and simplify the
> changes required. how about below changes ?
> 
> -physical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/physical_block_size)
> -logical=$(cat /sys/block/$(_short_dev $SCRATCH_DEV)/queue/logical_block_size)
> +physical=`blockdev --getpbsz $SCRATCH_DEV`
> +logical=`blockdev --getss $SCRATCH_DEV`

Good idea! :)

--D

> --Nitesh Shetty



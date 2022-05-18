Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B756C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 18 May 2022 05:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiERFLO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 May 2022 01:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiERFLN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 May 2022 01:11:13 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DEB012AEE
        for <fstests@vger.kernel.org>; Tue, 17 May 2022 22:11:10 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-2-147.pa.nsw.optusnet.com.au [49.181.2.147])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 82CFE10E65B1
        for <fstests@vger.kernel.org>; Wed, 18 May 2022 15:11:08 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1nrBxi-00DKju-6p
        for fstests@vger.kernel.org; Wed, 18 May 2022 15:11:06 +1000
Date:   Wed, 18 May 2022 15:11:06 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH 08/12] generic/081: don't run on DAX capable devices
Message-ID: <20220518051106.GT2306852@dread.disaster.area>
References: <20220517070111.1381936-1-david@fromorbit.com>
 <20220517070111.1381936-9-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517070111.1381936-9-david@fromorbit.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=e9dl9Yl/ c=1 sm=1 tr=0 ts=62847fec
        a=ivVLWpVy4j68lT4lJFbQgw==:117 a=ivVLWpVy4j68lT4lJFbQgw==:17
        a=kj9zAlcOel0A:10 a=oZkIemNP1mAA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=CqFQbD7v1VHxSvSrZ1MA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 17, 2022 at 05:01:07PM +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> LVM/DM has conniptions when you try to use snapshots on a device
> that has DAX capability. It first sets up the underlying device as a
> DAX capable mapping (type 3 or DM_TYPE_DAX_BIO_BASED) but because
> snapshots require COW and shared mappings, it isn't supported on DAX
> capable devices. Hence creating the snapshot device fails because it
> requires a type 1 (DM_TYPE_BIO_BASED) device and DM can't change
> types on a loaded mapping.
> 
> Hence we get this obscure error message in the log:
> 
> device-mapper: ioctl: can't change device type (old=3 vs new=1) after initial table load.
> 
> and these obscure, unhelpful error messages from the LVM command
> outputs:
> 
>   device-mapper: reload ioctl on  (251:0) failed: Invalid argument
>   Failed to suspend logical volume vg_081/base_081.
>   Device vg_081-base_081-real (251:1) is used by another device.
>   Failed to revert logical volume vg_081/base_081.
>   Aborting. Manual intervention required.
> Failed to create snapshot
> 
> How to turn off DAX capability is not documented in dmsetup or LVM
> man pages, nor is dax mentioned anywhere in
> Documentation/admin/device-mapper/ so I have no idea how to tell
> LVM/DM "don't try to enable DAX support!".
> 
> As such, if the uderlying block device is dax capable, skip this
> test.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Self nack this one for now - this doesn't seem to be working
properly in the case of "no dax mount option" i.e. the default of
dax=inode. I think in that case __scratch_uses_fsdax() has to return
"no" so that the support check then falls through to
__scratch_dev_has_dax() to determine if DAX will be used or not.

I missed this because I have dax=never set by default on many of my
fstests configs because I use a mix of ramdisk and normal block
devices and I don't want them to use DAX at all when operating on a
ramdisk unless I'm running an explicit DAX-enabled test config.

I'll send an update to fix this soon.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

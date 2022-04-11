Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DDC2C433EF
	for <linux-fstests@archiver.kernel.org>; Mon, 11 Apr 2022 22:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350446AbiDKWbx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Apr 2022 18:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbiDKWbr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Apr 2022 18:31:47 -0400
Received: from mail105.syd.optusnet.com.au (mail105.syd.optusnet.com.au [211.29.132.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AABEB1EC4A
        for <fstests@vger.kernel.org>; Mon, 11 Apr 2022 15:29:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-233-190.pa.vic.optusnet.com.au [49.186.233.190])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 6E36A10C777B;
        Tue, 12 Apr 2022 08:29:30 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1ne2XJ-00Gb2R-Mj; Tue, 12 Apr 2022 08:29:29 +1000
Date:   Tue, 12 Apr 2022 08:29:29 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/attr: reduce MAX_ATTRVAL_SIZE for NFS
Message-ID: <20220411222929.GJ1609613@dread.disaster.area>
References: <20220408191943.27655-1-ddiss@suse.de>
 <20220411054714.GI1609613@dread.disaster.area>
 <20220411105752.2b11cb15@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411105752.2b11cb15@suse.de>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=deDjYVbe c=1 sm=1 tr=0 ts=6254abcb
        a=bHAvQTfMiaNt/bo4vVGwyA==:117 a=bHAvQTfMiaNt/bo4vVGwyA==:17
        a=kj9zAlcOel0A:10 a=z0gMJWrwH1QA:10 a=7-415B0cAAAA:8
        a=IRvuVu1dM5Lj-LG_Pa8A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Apr 11, 2022 at 10:57:52AM +0200, David Disseldorp wrote:
> Thanks for the review, Dave...
> 
> On Mon, 11 Apr 2022 15:47:14 +1000, Dave Chinner wrote:
> 
> > > This is due to the MAX_ATTRVAL_SIZE=65536 setting for NFS, which exceeds
> > > the Btrfs (and XFS) limit of MAX_ATTRVAL_SIZE=64. Change NFS to use this
> > > lower bound value.  
> > 
> > I think that what XFS/UDF/BTRFS set here is bogus.
> > 
> > There is *one* test - generic/020 - that uses MAX_ATTRS and
> > MAX_ATTRVAL_SIZE, and  it uses MAX_ATTRVAL_SIZE as a byte count.
> > 
> > Which means for those 3 filesytems, the correct value for them is
> > 65536, not 64....
> > 
> > This looks like it was broken back when the test was made generic
> > - the dd command before this used a bs=1024, so a maz size of 64
> > would have been correct. Except the dd command also go changed to
> > use bs=1, which meant 64 bytes....
> > 
> > So, yeah, the test got "broken" for XFS back in 2012 and so the
> > correct fix here is to change (at least) XFS and btrfs to have a
> > MAX_ATTRVAL_SIZE=65536....
> 
> I'll change XFS over to use a 64K bytes limit. It looks like we'll need
> a separate special case for Btrfs, as the size limit also takes the attr
> name length into account:
> 
>  79 int btrfs_setxattr(struct btrfs_trans_handle *trans, struct inode *inode,
>  80                    const char *name, const void *value, size_t size, int flags)
>  81 {
>  ...
>  91         if (name_len + size > BTRFS_MAX_XATTR_SIZE(root->fs_info))
>  92                 return -ENOSPC;
> 
> BTRFS_MAX_XATTR_SIZE() is also 16K by default on my test system. Given
> that this is for generic/020 only, my plan is to turn the existing
> MAX_ATTRVAL_SIZE logic into a helper function.

Sounds good! Can you do the same with MAX_ATTRS, too? It's a g/020
only value, too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

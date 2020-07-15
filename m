Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C81C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 04:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5575B2067D
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 04:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGOEQA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:16:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:63673 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgGOEP7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Jul 2020 00:15:59 -0400
IronPort-SDR: u3+NqsdEsRD+YB6o7i1OtyG1PcPPel5UAaY8bRptChDMAT2wz1TBjIkSkkGR2N+M5clFSO4ZBL
 2f73FZk6iD6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="167193772"
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="167193772"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 21:15:59 -0700
IronPort-SDR: bhjvaR3xyTqQ4Y1qQ4AUUCBWm7acbcQgTLQ/6czzwqcrG9knRbVgEHHdyNTOkEcnq+lEdJe+Lj
 VKP9JpHlqz0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,354,1589266800"; 
   d="scan'208";a="270179036"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2020 21:15:59 -0700
Date:   Tue, 14 Jul 2020 21:15:59 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, darrick.wong@oracle.com
Subject: Re: [PATCH v6 1/7] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
Message-ID: <20200715041559.GK3008823@iweiny-DESK2.sc.intel.com>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-2-yangx.jy@cn.fujitsu.com>
 <20200715015935.GG3008823@iweiny-DESK2.sc.intel.com>
 <5F0E75DE.8050508@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5F0E75DE.8050508@cn.fujitsu.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 15, 2020 at 11:19:58AM +0800, Xiao Yang wrote:
> On 2020/7/15 9:59, Ira Weiny wrote:
> > On Tue, Jul 14, 2020 at 05:40:03PM +0800, Xiao Yang wrote:
> > > 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> > > 2) _require_dax_iflag() checks FS_XFLAG_DAX
> > > 
> > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > Reviewed-by: Ira Weiny<ira.weiny@intel.com>
> Hi Ira,
> 
> Do you want to check if invalid parameter is passed to
> _require_scratch_dax_mountopt? Thought
> I think it is not necessary(user should pass correct parament).
> Like this:
> [ "$mountopt" != "dax" ] && [ "$mountopt" != "dax=always" ] && _notrun
> "$mountopt is invalid"

I thought this patch was just checking if the filesystem/device supported DAX
such that DAX tests could run using either old _or_ new dax support...

But after thinking about it I think we need something more complicated.

Something like:

if ('-o dax=inode')
	// FS is DAX with per file support (ie ext4 || XFS kernel >= 5.8)
else if ('-o dax')
	// FS is DAX (ie ext4 || XFS on kernel < 5.8)
else
	// FS has no dax support.

Do we do that with 2 functions?

	_require_scratch_dax_mountopt()
	_require_scratch_new_dax_mountopt()

If both fail we are in the else clause above?

We can use the dax=inode because it is a new option and is not necessarily the
option used while running the tests.  (I think.  as I said my xfstests skills
are not great so I'm not always sure of the correct patterns)

Ira

> 
> Best Regards,
> Xiao Yang
> > > ---
> > > 
> > > V5->V6:
> > > Simplify _require_scratch_dax_mountopt because it is enough to only check
> > > dax/dax=always mount option.  See the following reasons:
> > > 1) we cannot detect if underlying device supports dax by mounting dax=inode
> > >     or dax=never.
> > > 2) dax=always, dax=inode, dax=never are always introduced together.
> > > 
> > >   common/rc | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > > 
> > > diff --git a/common/rc b/common/rc
> > > index f17b19f2..aeec1f11 100644
> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -3188,6 +3188,28 @@ _require_scratch_dax()
> > >   	_scratch_unmount
> > >   }
> > > 
> > > +# Only accept dax/dax=always mount option becasue dax=always, dax=inode
> > > +# and dax=never are always introduced together.
> > > +_require_scratch_dax_mountopt()
> > > +{
> > > +	local mountopt=$1
> > > +
> > > +	_require_scratch
> > > +	_scratch_mkfs>  /dev/null 2>&1
> > > +	_try_scratch_mount "-o $mountopt">  /dev/null 2>&1 || \
> > > +		_notrun "mount $SCRATCH_DEV with $mountopt failed"
> > > +
> > > +	_fs_options $SCRATCH_DEV | egrep -q "dax(=always|,|$)" || \
> > > +		_notrun "$SCRATCH_DEV $FSTYP does not support -o $mountopt"
> > > +
> > > +	_scratch_unmount
> > > +}
> > > +
> > > +_require_dax_iflag()
> > > +{
> > > +	_require_xfs_io_command "chattr" "x"
> > > +}
> > > +
> > >   # Does norecovery support by this fs?
> > >   _require_norecovery()
> > >   {
> > > -- 
> > > 2.21.0
> > > 
> > > 
> > > 
> > 
> > .
> > 
> 
> 
> 

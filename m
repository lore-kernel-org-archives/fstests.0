Return-Path: <SRS0=5/bx=A2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4ADC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 880372065E
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Jul 2020 18:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgGOSAQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Jul 2020 14:00:16 -0400
Received: from mga01.intel.com ([192.55.52.88]:22018 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbgGOSAP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 15 Jul 2020 14:00:15 -0400
IronPort-SDR: YGImTRi+u3riNy4W0pfv0uY/TRCuERf8IG2nN4ZeEqp26bjvQIjfzDGaNXwfIkygRd+IotdXM8
 efRmpx70ooMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="167365309"
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; 
   d="scan'208";a="167365309"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 11:00:11 -0700
IronPort-SDR: zrpyzkeN/8NBeG/ysEUgR9dIPxih8qJdW9manDpYP5q38F5OdG6UaAklw9Y3hZy96qwCgUXbJt
 u7X3sxSY1mjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,356,1589266800"; 
   d="scan'208";a="282177565"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2020 11:00:11 -0700
Date:   Wed, 15 Jul 2020 11:00:11 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
Subject: Re: [PATCH v6 1/7] common/rc: Introduce new helpers for DAX mount
 options and FS_XFLAG_DAX
Message-ID: <20200715180008.GL3008823@iweiny-DESK2.sc.intel.com>
References: <20200714094009.8654-1-yangx.jy@cn.fujitsu.com>
 <20200714094009.8654-2-yangx.jy@cn.fujitsu.com>
 <20200715015935.GG3008823@iweiny-DESK2.sc.intel.com>
 <5F0E75DE.8050508@cn.fujitsu.com>
 <20200715041559.GK3008823@iweiny-DESK2.sc.intel.com>
 <5F0E9A42.5010807@cn.fujitsu.com>
 <20200715155631.GL7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715155631.GL7600@magnolia>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 15, 2020 at 08:56:31AM -0700, Darrick J. Wong wrote:
> On Wed, Jul 15, 2020 at 01:55:14PM +0800, Xiao Yang wrote:
> > On 2020/7/15 12:15, Ira Weiny wrote:
> > > On Wed, Jul 15, 2020 at 11:19:58AM +0800, Xiao Yang wrote:
> > > > On 2020/7/15 9:59, Ira Weiny wrote:
> > > > > On Tue, Jul 14, 2020 at 05:40:03PM +0800, Xiao Yang wrote:
> > > > > > 1) _require_scratch_dax_mountopt() checks both old and new DAX mount option
> > > > > > 2) _require_dax_iflag() checks FS_XFLAG_DAX
> > > > > > 
> > > > > > Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> > > > > Reviewed-by: Ira Weiny<ira.weiny@intel.com>
> > > > Hi Ira,
> > > > 
> > > > Do you want to check if invalid parameter is passed to
> > > > _require_scratch_dax_mountopt? Thought
> > > > I think it is not necessary(user should pass correct parament).
> > > > Like this:
> > > > [ "$mountopt" != "dax" ]&&  [ "$mountopt" != "dax=always" ]&&  _notrun
> > > > "$mountopt is invalid"
> > > I thought this patch was just checking if the filesystem/device supported DAX
> > > such that DAX tests could run using either old _or_ new dax support...
> > > But after thinking about it I think we need something more complicated.
> > > 
> > > Something like:
> > > 
> > > if ('-o dax=inode')
> > > 	// FS is DAX with per file support (ie ext4 || XFS kernel>= 5.8)
> > Hi Ira,
> > 
> > dax=inode/dax=never cannot check if underlying device supports dax, so I
> > perfer to use dax=always
> > For example:
> > XFS:
> > # mount -o dax=inode /dev/sda8 /mnt/xfstests/test/
> > # mount | grep sda8
> > /dev/sda8 on /mnt/xfstests/test type xfs
> > (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> > ...
> > # mount -o dax=always /dev/sda8 /mnt/xfstests/test/
> > # mount | grep sda8
> > /dev/sda8 on /mnt/xfstests/test type xfs
> > (rw,relatime,seclabel,attr2,dax=never,inode64,logbufs=8,logbsize=32k,noquota)
> > 
> > EXT4:
> > # mount -o dax=inode /dev/sda8 /mnt/xfstests/test/
> > # mount | grep sda8
> > /dev/sda8 on /mnt/xfstests/test type ext4 (rw,relatime,seclabel,dax=inode)
> > ...
> > # mount -o dax=always /dev/sda8 /mnt/xfstests/test/
> > mount: /mnt/xfstests/test: wrong fs type, bad option, bad superblock on
> > /dev/sda8, missing codepage or helper program, or other error.
> > # dmesg | grep DAX
> > [597988.165120] EXT4-fs (sda8): DAX unsupported by block device.
> > 
> > If we want to test new dax(i.e. dax=inode, dax=always or dax=never), so pass
> > "dax=always" to  _require_scratch_dax_mountopt
> > If we want to test old dax  or new dax=always(either of them), so pass "dax"
> > to _require_scratch_dax_mountopt
> 
> That does seem like the only way to figure out if a fs/device
> combination supports dax.
> 
> The valid arguments to the _require_scratch_dax* helpers are worth
> mentioning in a comment above the function, but I suspect that adding
> validation code is probably overkill.

Ok yes I see it now.

You are both correct.  I think a comment which indicates that one should pads
'-o dax' to check for 'old support' vs '-o dax=always' for 'new support' and
the test chooses which option to pass (based on the support it needs) to
_require_scratch_dax_mountopt()...

Sorry I was not completely following before!
Ira


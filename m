Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DEC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 02:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CC360BD3
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Oct 2021 02:57:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbhJLC71 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 11 Oct 2021 22:59:27 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:36055 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231791AbhJLC71 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Oct 2021 22:59:27 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UrWhcid_1634007443;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0UrWhcid_1634007443)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Oct 2021 10:57:24 +0800
Date:   Tue, 12 Oct 2021 10:57:23 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Anju T Sudhakar <anju@linux.vnet.ibm.com>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/4] generic/594: Fix test failure for xfs on older
 quota-tools
Message-ID: <20211012025723.GU60846@e18g06458.et15sqa>
References: <20211011075552.196688-1-anju@linux.vnet.ibm.com>
 <20211011075552.196688-3-anju@linux.vnet.ibm.com>
 <20211011164652.GF24282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211011164652.GF24282@magnolia>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Oct 11, 2021 at 09:46:52AM -0700, Darrick J. Wong wrote:
> On Mon, Oct 11, 2021 at 01:25:50PM +0530, Anju T Sudhakar wrote:
> > For xfs we need the quota-tools containing commit fdd774bf08e568
> > ("quota-tools: pass quota type to QCMD for Q_XFS_GETQSTAT")to run this
> > test. Otherwise this test will fail on xfs, as the grace time is not set
> > correctly. So check for the quota-tool with the required commit before
> > running this test on xfs.
> 
> This is a regression test for a kernel bug where Q_XGETQSTAT[V] ignores
> the quota type that userspace specifies in the system call and instead
> returns information about the first enabled quotatype.  It just so
> happens that quota-tools /also/ had a bug where it would never send the
> user's quota type to the kernel, so nobody noticed the nested herp and
> derp.
> 
> The test should probably have mentioned kernel commit 555b2c3da1fc
> ("quota: honor quota type in Q_XGETQSTAT[V] calls") directly to make
> this more obvious.

Agreed, and maybe mention the quota-tools commit as well.

Thanks,
Eryu

> 
> --D
> 
> > Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> > ---
> >  tests/generic/594 | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/tests/generic/594 b/tests/generic/594
> > index 88f9a0dc..668c1fae 100755
> > --- a/tests/generic/594
> > +++ b/tests/generic/594
> > @@ -6,6 +6,8 @@
> >  #
> >  # Test per-type(user, group and project) filesystem quota timers, make sure
> >  # each of grace time can be set/get properly.
> > +# For xfs, you need a quota-tools containing commit fdd774bf08e568 for this
> > +# test to run properly- v4.06 should do.
> >  #
> >  . ./common/preamble
> >  _begin_fstest auto quick quota
> > @@ -18,9 +20,13 @@ _begin_fstest auto quick quota
> >  _supported_fs generic
> >  _require_scratch
> >  _require_setquota_project
> > +version=$(setquota -V | head -n1 | cut -d" " -f4)
> >  # V4 XFS doesn't support to mount project and group quota together
> >  if [ "$FSTYP" = "xfs" ];then
> >  	_require_scratch_xfs_crc
> > +	if [ "$version" \< "4.06" ];then
> > +		_notrun "This test requires quota-tools 4.06 or greater"
> > +	fi
> >  fi
> >  _require_quota
> >  
> > -- 
> > 2.24.1
> > 

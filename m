Return-Path: <SRS0=39K/=5Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7505C43331
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 07:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78371206F5
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Mar 2020 07:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgCaHtn (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:49:43 -0400
Received: from verein.lst.de ([213.95.11.211]:37199 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgCaHtm (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Mar 2020 03:49:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7D6668C4E; Tue, 31 Mar 2020 09:49:40 +0200 (CEST)
Date:   Tue, 31 Mar 2020 09:49:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>, guaneryu@gmail.com,
        hch@lst.de, fstests@vger.kernel.org
Subject: Re: [PATCH v4] xfs/191: update mkfs.xfs input results
Message-ID: <20200331074940.GB24372@lst.de>
References: <1585304270-8790-1-git-send-email-xuyang2018.jy@cn.fujitsu.com> <20200330043659.GR14282@dhcp-12-102.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330043659.GR14282@dhcp-12-102.nay.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Mar 30, 2020 at 12:45:07PM +0800, Zorro Lang wrote:
> > +loopimg=$TEST_DIR/$seq.loopimg
> > +$XFS_IO_PROG -f -c "truncate $fssize" $loopimg
> > +loopdev=$(_create_loop_device $loopimg)
> > +SCRATCH_DEV=$loopdev
> 
> Hi,
> 
> I don't want to be picky, I think a "_require_test" would be better
> if we use $TEST_DIR, although we always have a mounted TEST_DIR generally :)
> If Eryu would like to add it, you can save one patch :)
> 
> Others looks good to me, test passed.
> Reviewed-by: Zorro Lang <zlang@redhat.com>

Same here, modulo a _require_test this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

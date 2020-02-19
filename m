Return-Path: <SRS0=KIFJ=4H=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E99FC34047
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3266A24656
	for <linux-fstests@archiver.kernel.org>; Wed, 19 Feb 2020 12:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBSMna (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 19 Feb 2020 07:43:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:55306 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgBSMna (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Feb 2020 07:43:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id F1E47C20A;
        Wed, 19 Feb 2020 12:43:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 78F1A1E0EB5; Wed, 19 Feb 2020 13:43:24 +0100 (CET)
Date:   Wed, 19 Feb 2020 13:43:24 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        fstests <fstests@vger.kernel.org>
Subject: Re: generic/269 hangs on lastest upstream kernel
Message-ID: <20200219124324.GO16121@quack2.suse.cz>
References: <00470e6d-0e1c-6060-225b-4c56dd33c083@cn.fujitsu.com>
 <20200213211011.GB6600@quack2.suse.cz>
 <062ac52c-3a16-22ef-6396-53334ed94783@cn.fujitsu.com>
 <20200214150059.GA22815@quack2.suse.cz>
 <a0b06474-f447-7943-1012-2a8d20b9e352@cn.fujitsu.com>
 <20200218082436.GF16121@quack2.suse.cz>
 <83cc6208-3fa3-86bb-eb91-77b90b22d98f@cn.fujitsu.com>
 <20200218110311.GI16121@quack2.suse.cz>
 <b0b82e0c-0e86-af5e-5a61-2fafb2ca85a0@cn.fujitsu.com>
 <73af3d5c-ca64-3ad3-aee2-1e78ee4fae4a@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <73af3d5c-ca64-3ad3-aee2-1e78ee4fae4a@cn.fujitsu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed 19-02-20 18:42:36, Yang Xu wrote:
> on 2020/02/19 18:09, Yang Xu wrote:
> > > > > 1) If you mount ext4 with barrier=0 mount option, does the
> > > > > problem go away?
> > > > Yes. Use barrier=0, this case doesn't hang,
> > > 
> > > OK, so there's some problem with how the block layer is handling flush
> > > bios...
> > > 
> > > > > 2) Can you run the test and at the same time run 'blktrace
> > > > > -d /dev/sdc' to
> > > > > gather traces? Once the machine is stuck, abort blktrace, process the
> > > > > resulting files with 'blkparse -i sdc' and send here
> > > > > compressed blkparse
> > > > > output. We should be able to see what was happening with the
> > > > > stuck request
> > > > > in the trace and maybe that will tell us something.
> > > > The log size is too big(58M) and our emali limit is 5M.
> > > 
> > > OK, can you put the log somewhere for download? Alternatively you could
> > > provide only last say 20s of the trace which should hopefully fit
> > > into the
> > > limit...
> > Ok. I will use split command and send you in private to avoid much noise.
> log as attach.

Thanks for the log. So the reason for the hang is clearly visible at the
end of the log:

  8,32   2   104324   164.814457402   995  Q FWS [fsstress]
  8,32   2   104325   164.814458088   995  G FWS [fsstress]
  8,32   2   104326   164.814460957   739  D  FN [kworker/2:1H]

This means, fsstress command has queued cache flush request (from
blkdev_issue_flush()), this has been dispatched to the driver ('D' event)
but it has never been completed by the driver and so blkdev_issue_flush()
never returns.

To debug this further, you probably need to start looking into what happens
with the request inside QEMU. There's not much I can help you with at this
point since I'm not an expert there. Do you use image file as a backing store
or a raw partition?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

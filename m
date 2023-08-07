Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED3BEB64DD
	for <linux-fstests@archiver.kernel.org>; Mon,  7 Aug 2023 11:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjHGLin (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjHGLiP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2023 07:38:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A5A49D7
        for <fstests@vger.kernel.org>; Mon,  7 Aug 2023 04:35:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E7E386732D; Mon,  7 Aug 2023 13:21:00 +0200 (CEST)
Date:   Mon, 7 Aug 2023 13:21:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zorro Lang <zlang@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230807112100.GB15405@lst.de>
References: <20230724152927.33094-1-hch@lst.de> <20230724152927.33094-2-hch@lst.de> <20230806141145.2lpntvfn7kqglads@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230806141145.2lpntvfn7kqglads@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 06, 2023 at 10:11:45PM +0800, Zorro Lang wrote:
> On Mon, Jul 24, 2023 at 08:29:26AM -0700, Christoph Hellwig wrote:
> > Test the removal of the underlying device when the file system still
> > has dirty data.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> 
> After I merge this case, it always hit a kernel warning about a "possible
> circular locking dependency detected", no matter on ext4 [1] or xfs. This
> test isn't hang actually. But it always fail this test (got a .dmesg file).
> Any ideas about that?

That's because xfs and ext4 do the blkdev_put of the non-main devices
in ->put_super and thus inside s_umount.  It's actually an old issue,
we now just trigger it reliably.  We'll need to move the dropping into
->kill_sb after dropping ->s_umount.  This has been on my plate for
a while.

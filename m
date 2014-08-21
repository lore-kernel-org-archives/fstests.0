Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:59474 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbaHUHgo (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 21 Aug 2014 03:36:44 -0400
Received: by mail-la0-f42.google.com with SMTP id pv20so8306649lab.15
        for <fstests@vger.kernel.org>; Thu, 21 Aug 2014 00:36:42 -0700 (PDT)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default block size from test_dev
In-Reply-To: <20140820231450.GI26465@dastard>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org> <1408194791-1797-2-git-send-email-dmonakhov@openvz.org> <20140820231450.GI26465@dastard>
Date: Thu, 21 Aug 2014 11:36:39 +0400
Message-ID: <87mwayqooo.fsf@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, 21 Aug 2014 09:14:50 +1000, Dave Chinner <david@fromorbit.com> wrote:
> On Sat, Aug 16, 2014 at 05:13:07PM +0400, Dmitry Monakhov wrote:
> > Currently default block size is frozen to 4096 which is bad for
> > various reasons for example:
> > 1) It ignores MKFS_OPT
> 
> It still ignores MKFS_OPTIONS. The test device is not made with
> those parameters unless you specifically remake it before every
> xfstests run with a different configuration.
Yes. Usually I recreate test_dev after config was updated.
And I tend to agree that this may not be suitable for others.
In order to fix original issue I'll remove block_size argument from
_scratch_mkfs_sized and pass MKFS_OPTIONS instead. This will be valid
change because currently no one pass block_size to _scratch_mkfs_sized anyway.
> 
> > 2) Not works for architectures where PG_SIZE != 4096
> 
> That I don't understand. 4k block size filesystems work just fine
> on architectures with page size > 4k....
Off course. But I meant to say that this arch may use different
block_size by default.
> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

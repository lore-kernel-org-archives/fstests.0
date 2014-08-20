Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:5649 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752775AbaHTXOx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Aug 2014 19:14:53 -0400
Date: Thu, 21 Aug 2014 09:14:50 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/6] common: _scratch_mkfs_sized should inherent default
 block size from test_dev
Message-ID: <20140820231450.GI26465@dastard>
References: <1408194791-1797-1-git-send-email-dmonakhov@openvz.org>
 <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1408194791-1797-2-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 16, 2014 at 05:13:07PM +0400, Dmitry Monakhov wrote:
> Currently default block size is frozen to 4096 which is bad for
> various reasons for example:
> 1) It ignores MKFS_OPT

It still ignores MKFS_OPTIONS. The test device is not made with
those parameters unless you specifically remake it before every
xfstests run with a different configuration.

> 2) Not works for architectures where PG_SIZE != 4096

That I don't understand. 4k block size filesystems work just fine
on architectures with page size > 4k....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

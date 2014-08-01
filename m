Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:41018 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750952AbaHAAWS (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 31 Jul 2014 20:22:18 -0400
Date: Fri, 1 Aug 2014 10:21:59 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] common: get fs type again using device canonical name
 in _fs_type
Message-ID: <20140801002159.GU26465@dastard>
References: <1406479050-10601-1-git-send-email-eguan@redhat.com>
 <1406803957-10488-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406803957-10488-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 31, 2014 at 06:52:37PM +0800, Eryu Guan wrote:
> When testing with lvm, a previous btrfsck run could change df output
> from something like
> 
> /dev/mapper/rhel_hp--dl388eg8--01-testlv1 btrfs 15728640 900 13602172 1% /mnt/btrfs
> 
> to
> 
> /dev/dm-3 btrfs 15728640 900 13602172 1% /mnt/btrfs

I don't follow you. Why would running btrfsck change the name of the
device? If the filesystem is umounted and mounted again, then the
device could change, but btrfsck should not be not doing the
unmount/mount, and so unless the TEST_DEV/SCRATCH_DEV is changing
the output of df should be identical...

So before we change the _fs_type() code, can you explain exactly
how, when and why the device name is changing to me?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

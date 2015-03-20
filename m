Return-Path: <zab@zabbo.net>
Date: Fri, 20 Mar 2015 11:56:41 -0700
From: Zach Brown <zab@zabbo.net>
Subject: Re: [PATCH 1/2] fstests: use mount/umount helpers everywhere
Message-ID: <20150320185641.GA17374@lenny.home.zabbo.net>
References: <550C46B2.8060407@sandeen.net>
 <550C473B.5010004@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550C473B.5010004@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 11:13:47AM -0500, Eric Sandeen wrote:
> Replace every explicit mount/umount of scratch or test devices
> with helper functions.  This allows the next patch to add in hooks
> to these functions in order to set up & tear down overlayfs on
> every mount/umount.

Yeah, I don't know about this.

For nfs testing we don't setup xfstests to test xfs on block devices and
then then magically configure nfs to export and mount it on the side.

Wouldn't we treat overlayfs the same way?  It'd be its own fstype whose
underlying resources are fs paths?

- z

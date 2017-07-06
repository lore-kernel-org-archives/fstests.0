Received: from mx1.redhat.com ([209.132.183.28]:48508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752493AbdGFFf1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 6 Jul 2017 01:35:27 -0400
Date: Thu, 6 Jul 2017 13:35:24 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/095, generic/247: unmount correct devices
Message-ID: <20170706053524.GA29475@eguan.usersys.redhat.com>
References: <20170706053136.6825-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706053136.6825-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Brian Foster <bfoster@redhat.com>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 05, 2017 at 10:31:36PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In commit d55123c080cb ("generic/247: filter out expected XFS warnings
> for mixed mmap/direct I/O"), _scratch_unmount was removed from
> generic/095 and added to generic/247.  But actually generic/095 *should*
> be unmounting SCRATCH_DEV; and generic/247 should be unmounting
> TEST_DEV, not SCRATCH_DEV, since it doesn't use a scratch device (it was
> failing if SCRATCH_DEV was not defined).  Fix it.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks a lot!

Eryu

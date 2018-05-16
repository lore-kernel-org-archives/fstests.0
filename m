Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:18694 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751489AbeEPArH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 May 2018 20:47:07 -0400
Date: Wed, 16 May 2018 10:47:04 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/3] generic/459: use xfs_freeze instead of fsfreeze
Message-ID: <20180516004704.GH10363@dastard>
References: <1526276991-23897-1-git-send-email-amir73il@gmail.com>
 <1526276991-23897-2-git-send-email-amir73il@gmail.com>
 <20180514230130.GD23861@dastard>
 <CAOQ4uxgEF7cHmb05AxFJyHaV1zWC+Zk08dDNPepfhZ0Foz31Hg@mail.gmail.com>
 <CAOQ4uxikFp-GsuhmPHud4QtKrSdojBNAnDB6yOfrG-11GU_jRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxikFp-GsuhmPHud4QtKrSdojBNAnDB6yOfrG-11GU_jRw@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, Ext4 <linux-ext4@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, May 15, 2018 at 04:50:04PM +0300, Amir Goldstein wrote:
> On Tue, May 15, 2018 at 8:25 AM, Amir Goldstein <amir73il@gmail.com> wrote:
> > On Tue, May 15, 2018 at 2:01 AM, Dave Chinner <david@fromorbit.com> wrote:
> >> On Mon, May 14, 2018 at 08:49:49AM +0300, Amir Goldstein wrote:
> >>> This is what all other tests use as well as _require_freeze
> >>>
> >>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >>> ---
> [...]
> >>
> >> Shouldn't these all be converted to XFS_FREEZE_PROG w/ a setup call
> >> to export XFS_FREEZE_PROG="`set_prog_path xfs_freeze`"?
> >>
> >
> > Yeh, I suppose I can take this one as part of the "freeze" cleanup.
> >
> 
> I looked again and xfs_freeze pattern repeats itself quite often with
> other xfs_* progs, so I guess I'll leave that cleanup for another time...

No worries, just add it to the pile...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

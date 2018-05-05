Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:37121 "EHLO
        ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751573AbeEEXhf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 5 May 2018 19:37:35 -0400
Date: Sun, 6 May 2018 09:37:32 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] README: document the new default run mode
Message-ID: <20180505233732.GH10363@dastard>
References: <20180505001951.5665-1-david@fromorbit.com>
 <CAOQ4uxgJ4+R05wfkgCA6DUEoQbPPJEhTGiE=5QDqoX5hjE7D7A@mail.gmail.com>
 <20180505140911.GE8373@desktop>
 <20180505222347.GO29205@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180505222347.GO29205@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: Eryu Guan <guaneryu@gmail.com>, Amir Goldstein <amir73il@gmail.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Sat, May 05, 2018 at 06:23:47PM -0400, Theodore Y. Ts'o wrote:
> On Sat, May 05, 2018 at 10:09:11PM +0800, Eryu Guan wrote:
> > t
> > The 'dangerous' group and 'auto' group are not mutually exclusive when
> > it was introduced, see commit 3f28d55c3954 ("add freeze and dangerouss
> > groups"). But from previous discussions[1][2], they should be mutually
> > exclusive.
> 
> What might be nice is if there was some way to declare that a test is
> dangerous given a particular kernel version (or some combination of
> kernel version and file system type).  Right now I have to manually
> exclude tests when testing stable kernels, e.g.:
> 
> gce-xfstests full --kernel gs://gce-xfstests/bzImage-3.18 -X generic/269 -X ext4/022

That's what expunge files are for.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

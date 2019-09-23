Received: from aserp2120.oracle.com ([141.146.126.78]:44398 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfIWUVl (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Sep 2019 16:21:41 -0400
Date: Mon, 23 Sep 2019 13:21:35 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: generic/495: swap on sparse file over NFS
Message-ID: <20190923202135.GD736475@magnolia>
References: <20190923200036.GA5085@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190923200036.GA5085@fieldses.org>
Sender: fstests-owner@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: fstests@vger.kernel.org, linux-nfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 23, 2019 at 04:00:36PM -0400, J. Bruce Fields wrote:
> I'm updating to a newer xfstests and seeing:
> 
> generic/495     - output mismatch (see
> /root/xfstests-dev/results//generic/495.out.bad)
>     --- tests/generic/495.out   2019-09-18 17:28:00.834721480 -0400
>     +++ /root/xfstests-dev/results//generic/495.out.bad 2019-09-20 13:34:01.1568
> 89741 -0400
>     @@ -1,5 +1,4 @@
>      QA output created by 495
>      File with holes
>     -swapon: Invalid argument
>      Empty swap file (only swap header)
>      swapon: Invalid argument
> 
> If I understand correctly, it's requiring swapon to fail on a sparse
> file, which isn't going to happen on NFS, where the sparsenes of the
> file isn't really the client's concern.

It looks that way to me... :)

> Is it really correct to *require* swapon to fail in this case?

Hm.  TBH I was expecting an fpunch call or something to guarantee that
we even /have/ a sparse file, since (for all we know) a filesystem could
interpret "truncate up" to imply that blocks should be speculatively
allocated all the way to the new EOF.

But no, I wouldn't expect swap-over-NFS to know or care if the file is
sparse on the server.  (Based on my limited knowledge of how that even
works...)

--D

> --b.

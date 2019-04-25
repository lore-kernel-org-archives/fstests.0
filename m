Received: from userp2120.oracle.com ([156.151.31.85]:59798 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbfDYVKO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 17:10:14 -0400
Date: Thu, 25 Apr 2019 14:10:07 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: generic: test statx attribute_mask setting
Message-ID: <20190425211007.GA755788@magnolia>
References: <CAH2r5mu9WFqz=15ENbt27wW+qP+XaJgyGs-B8Yq4_sn931vxnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mu9WFqz=15ENbt27wW+qP+XaJgyGs-B8Yq4_sn931vxnA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 25, 2019 at 01:39:40PM -0700, Steve French wrote:
> I noticed that the patch "generic: test statx attribute_mask setting"
> seems to cause a failure on xfstest 532.  I am trying with current
> xfsprogs and xfstests from git.kernel.org git trees for those.  The
> output is:
> 
> (generic/532    [not run] xfs_io statx command does not support attributes_mask)
> 
> due to this line:
> 
> 0ff18d367 (Darrick J. Wong 2019-03-04 13:19:35 -0800 35) get_attributes_mask() {
> 0ff18d367 (Darrick J. Wong 2019-03-04 13:19:35 -0800 36)
> $XFS_IO_PROG -r -c "statx -r" $1 | grep 'stat.attributes_mask =' | cut
> -d ' ' -f 3
> 
> But attributes_mask is not returned by current xfsprogs (instead it
> appears to be "mask"

That's stx_mask, which are the STATX_* flags.

> not "attributes_mask").   If you grep xfsprogs for "attributes_mask" -
> there are no hits.
> 
> Is this a typo in line 36 of tests/generic/532 where it is searching
> for "stat.attributes_mask" not "stat.mask"?

Nope, stx_attributes_mask is a "new" field that shows which
stx_attributes flags (STATX_ATTR_*) are known to the filesystem.  It's
not really new (it showed up in 4.11 along with the rest of statx) but
I only seemed to notice its existence recently.  Support for this new
field will appear in xfsprogs 5.0.

--D

> -- 
> Thanks,
> 
> Steve

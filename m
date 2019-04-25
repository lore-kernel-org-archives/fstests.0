Received: from mail-pg1-f193.google.com ([209.85.215.193]:36975 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbfDYVnI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Apr 2019 17:43:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so501364pgc.4
        for <fstests@vger.kernel.org>; Thu, 25 Apr 2019 14:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mu9WFqz=15ENbt27wW+qP+XaJgyGs-B8Yq4_sn931vxnA@mail.gmail.com>
 <20190425211007.GA755788@magnolia>
In-Reply-To: <20190425211007.GA755788@magnolia>
From: Steve French <smfrench@gmail.com>
Date: Thu, 25 Apr 2019 16:42:55 -0500
Message-ID: <CAH2r5msHjJAEZoH+N7+P4AeHgXaL_tkniOstAgQn=ndKgddLkA@mail.gmail.com>
Subject: Re: generic: test statx attribute_mask setting
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I verified that although the "attributes_mask"
 is not returned by current master branch of xfsprogs (in xfs_io statx -r),
I do see it with the for-next branch of xfsprogs.

I replaced xfsprogs with the for-next version and generic/532 runs
(and tested on smb3 mounts with cifs.ko and the test worked fine)

On Thu, Apr 25, 2019 at 4:10 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Apr 25, 2019 at 01:39:40PM -0700, Steve French wrote:
> > I noticed that the patch "generic: test statx attribute_mask setting"
> > seems to cause a failure on xfstest 532.  I am trying with current
> > xfsprogs and xfstests from git.kernel.org git trees for those.  The
> > output is:
> >
> > (generic/532    [not run] xfs_io statx command does not support attributes_mask)
> >
> > due to this line:
> >
> > 0ff18d367 (Darrick J. Wong 2019-03-04 13:19:35 -0800 35) get_attributes_mask() {
> > 0ff18d367 (Darrick J. Wong 2019-03-04 13:19:35 -0800 36)
> > $XFS_IO_PROG -r -c "statx -r" $1 | grep 'stat.attributes_mask =' | cut
> > -d ' ' -f 3
> >
> > But attributes_mask is not returned by current xfsprogs (instead it
> > appears to be "mask"
>
> That's stx_mask, which are the STATX_* flags.
>
> > not "attributes_mask").   If you grep xfsprogs for "attributes_mask" -
> > there are no hits.
> >
> > Is this a typo in line 36 of tests/generic/532 where it is searching
> > for "stat.attributes_mask" not "stat.mask"?
>
> Nope, stx_attributes_mask is a "new" field that shows which
> stx_attributes flags (STATX_ATTR_*) are known to the filesystem.  It's
> not really new (it showed up in 4.11 along with the rest of statx) but
> I only seemed to notice its existence recently.  Support for this new
> field will appear in xfsprogs 5.0.
>
> --D
>
> > --
> > Thanks,
> >
> > Steve



-- 
Thanks,

Steve

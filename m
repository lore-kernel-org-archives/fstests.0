Received: from mail-pg1-f171.google.com ([209.85.215.171]:45250 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfIPIra (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Sep 2019 04:47:30 -0400
Date: Mon, 16 Sep 2019 16:47:20 +0800
From: Murphy Zhou <jencce.kernel@gmail.com>
Subject: Re: seek sanity check failures
Message-ID: <20190916084720.l4ln6l3tv36aqbja@XZHOUW.usersys.redhat.com>
References: <20190915020810.jy5pxjtk7buenmqk@XZHOUW.usersys.redhat.com>
 <CAH2r5muncmiTKBuaYEie6L7PeXmQ-MjKsBy9WrET4v85f36=qA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muncmiTKBuaYEie6L7PeXmQ-MjKsBy9WrET4v85f36=qA@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Steve French <smfrench@gmail.com>
Cc: Murphy Zhou <jencce.kernel@gmail.com>, CIFS <linux-cifs@vger.kernel.org>, amir73il@gmail.com, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Sep 14, 2019 at 11:11:49PM -0500, Steve French wrote:
> Test 285 and 490 broke when xfstests were updated on the buildbot, and
> are temporarily deleted (commented out in the buildbot script).  We
> had a difficult choice - update xfstests and add 10 new tests but
> disable 3 tests which broke with updated tests, or not add the 10
> tests by keeping running last year's old xfstest test suite.
> 
> Ronnie and I did some investigation of why 285 and 490 failed and any
> additional data would help - since we both got distracted with other
> features and fixes

In Apr 2019, Amir updated seek_sanity_check:

(xfstests commit 34081087748)

pwrite a file, then double the filesize by ftruncate, then SEEK_HOLE.
If SEEK_HOLE returns EOF, and fstype is in this list:

+       btrfs|ext4|xfs|ceph|cifs|f2fs|gfs2|nfs*|ocfs2|tmpfs)

It's the default behavior and it's NOT allowed. Test prints error and exit.

If cifs is removed from above list, all seek sanity check tests pass on cifs.

cifs SEEK_DATA SEEK_HOLE support were added in May 2019 with Linux
commit dece44e381a

A xfstests patch removing cifs from the list can address these failures,
but is the "default behavior" of SEEK_HOLE on cifs expected?

If it's not expected and need to work on, we should keep current status.

Thanks!
M

> 
> On Sat, Sep 14, 2019 at 10:14 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> >
> > Hi,
> >
> > On latest Linus tree, several seek tests fails:
> >
> > generic/285 generic/490 generic/539    fails on v3.11 v3.02 v3.0
> > generic/285 generic/490                fails on v2.0 v2.1
> > generic/285 generic/448 generic/490    fails on v1.0
> >
> >
> > Are they expected or being worked on?
> >
> > Thanks!
> >
> >
> > FSTYP         -- cifs
> > PLATFORM      -- Linux/x86_64 hp-dl380pg8-14 5.3.0-rc8+ #1 SMP Thu Sep 12 07:31:21 EDT 2019
> > MKFS_OPTIONS  -- //hp-dl380pg8-14.rhts.eng.pek2.redhat.com/scratch
> > MOUNT_OPTIONS -- -o vers=3.11,mfsymlinks -o username=root,password=redhat -o context=system_u:object_r:nfs_t:s0 //hp-dl380pg8-14.rhts.eng.pek2.redhat.com/scratch /mnt/testarea/scratch
> >
> > generic/285     [failed, exit status 1]- output mismatch (see /var/lib/xfstests/results//generic/285.out.bad)
> >     --- tests/generic/285.out   2019-09-12 08:04:14.120990746 -0400
> >     +++ /var/lib/xfstests/results//generic/285.out.bad  2019-09-12 08:36:49.151230335 -0400
> >     @@ -1 +1,3 @@
> >      QA output created by 285
> >     +seek sanity check failed!
> >     +(see /var/lib/xfstests/results//generic/285.full for details)
> >     ...
> 
> 
> 
> -- 
> Thanks,
> 
> Steve

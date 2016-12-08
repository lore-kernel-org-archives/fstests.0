Received: from mx1.redhat.com ([209.132.183.28]:42244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751884AbcLHKRY (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 8 Dec 2016 05:17:24 -0500
Date: Thu, 8 Dec 2016 18:17:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2 2/2] fstests: btrfs: Use _require_btrfs_qgroup_report
 to replace open code
Message-ID: <20161208101722.GK29149@eguan.usersys.redhat.com>
References: <20161208081213.19675-1-quwenruo@cn.fujitsu.com>
 <20161208081213.19675-2-quwenruo@cn.fujitsu.com>
 <20161208084715.GJ29149@eguan.usersys.redhat.com>
 <a00f647f-7ec0-386c-67fa-07e7318cb22e@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a00f647f-7ec0-386c-67fa-07e7318cb22e@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Qu Wenruo <quwenruo@cn.fujitsu.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 08, 2016 at 05:20:49PM +0800, Qu Wenruo wrote:
> 
> 
> At 12/08/2016 04:47 PM, Eryu Guan wrote:
> > On Thu, Dec 08, 2016 at 04:12:13PM +0800, Qu Wenruo wrote:
> > > Introduce new _require_btrfs_qgroup_report function, which will check
> > > the accessibility to "btrfs check --qgroup-report", then set a global
> > > flag to info _check_scratch_fs() to do extra qgroup check.
> > > 
> > > Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
> > > ---
> > > v2:
> > >   Use "${RESULT_DIR}/require_scratch.require_qgroup_report" instead of
> > >   global variant
> > >   Rebased to latest master
> > >   Replace btrfsck with $BTRFS_UTIL_PROG check.
> > [snip]
> > > diff --git a/tests/btrfs/042 b/tests/btrfs/042
> > > index 498ccc9..dc9b762 100755
> > > --- a/tests/btrfs/042
> > > +++ b/tests/btrfs/042
> > > @@ -43,6 +43,7 @@ _cleanup()
> > >  _supported_fs btrfs
> > >  _supported_os Linux
> > >  _require_scratch
> > > +_require_btrfs_qgroup_report
> > > 
> > >  rm -f $seqres.full
> > > 
> > > @@ -84,10 +85,7 @@ for i in `seq 10 -1 1`; do
> > >  	total_written=$(($total_written+$filesize))
> > >  done
> > > 
> > > -#check if total written exceeds limit
> > > -if [ $total_written -gt $LIMIT_SIZE ];then
> > > -	_fail "total written should be less than $LIMIT_SIZE"
> > > -fi
> > > +# qgroup will be checked automatically at _check_scratch_fs() by fstest
> > 
> > This doesn't look like an equivalent replacement, and btrfs/042 fails
> > for me after this update (wrong qgroup numbers) on 4.9-rc4 kernel. Is
> > this change intentional?
> > 
> > Thanks,
> > Eryu
> > 
> > 
> Sorry, just a typo.For 042 only the _require_btrfs_qgroup_report line is
> need.
> 
> I also ran the test with v4.9-rc6 with some new btrfs patches (David's
> for-next branch), it ran without problem.
> 
> So the error seems to be a fixed btrfs qgroup problem.

Ok, good to know. Can you please send an updated patch?

Thanks,
Eryu

Received: from userp1040.oracle.com ([156.151.31.81]:42747 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbcGSCph (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 18 Jul 2016 22:45:37 -0400
Date: Mon, 18 Jul 2016 19:45:25 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] xfs/083: disable dmesg check
Message-ID: <20160719024525.GD5215@birch.djwong.org>
References: <1468302104-15288-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160713042555.GN2432@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160713042555.GN2432@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 13, 2016 at 12:25:55PM +0800, Eryu Guan wrote:
> On Tue, Jul 12, 2016 at 01:41:44PM +0800, Xiao Yang wrote:
> > xfs/083 will corrupt the fs intentionally, there will be WARNINGs
> > in dmesg as expected, so here disable dmesg check.
> > 
> > Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> > ---
> >  tests/xfs/083 | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/tests/xfs/083 b/tests/xfs/083
> > index d897754..040f3b6 100755
> > --- a/tests/xfs/083
> > +++ b/tests/xfs/083
> > @@ -102,6 +102,10 @@ scratch_repair() {
> >  }
> >  
> >  rm -f $seqres.full
> > +# This test will corrupt fs intentionally, so there will be WARNINGs
> > +# in dmesg as expected
> > +_disable_dmesg_check
> > +
> 
> This looks fine to me, but I'd like Darrick to review it as well :)

I'm convinced, so
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D


> 
> Thanks,
> Eryu
> 
> >  echo "See interesting results in $seqres.full" | sed -e "s,$RESULT_DIR,RESULT_DIR,g"
> >  SRCDIR=`pwd`
> >  test -z "${FUZZ_ARGS}" && FUZZ_ARGS="-3 -n 32"
> > -- 
> > 1.8.3.1
> > 
> > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html

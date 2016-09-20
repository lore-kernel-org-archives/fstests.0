Received: from aserp1040.oracle.com ([141.146.126.69]:19830 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750708AbcITEsW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2016 00:48:22 -0400
Date: Mon, 19 Sep 2016 21:48:09 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v2] common/rc: fix fsmap check
Message-ID: <20160920044809.GB3059@birch.djwong.org>
References: <20160920030332.GD10172@birch.djwong.org>
 <1474341339-22956-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160920035930.GD27776@eguan.usersys.redhat.com>
 <57E0BDD3.5060907@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57E0BDD3.5060907@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 12:40:51PM +0800, Xiao Yang wrote:
> On 2016/09/20 11:59, Eryu Guan wrote:
> >On Tue, Sep 20, 2016 at 11:15:39AM +0800, Xiao Yang wrote:
> >>I got an error about $TEST_DIR being a directory when running xfs/273,
> >>because xfs_io tried to open the directory first before it parsed the -T
> >I think the problem here is your xfs_io binary doesn't have -T support
> >(O_TMPFILE). So the commit log doesn't seem correct to me.
> >
> >Just curious, what's your xfsprogs version and what's the distrobution
> >you're running on? xfsprogs shipped with RHEL6 and RHEL7 both have
> >O_TMPFILE support.
> >
> Hi Eryu
> I ran this case with xfsprogs-4.5.0 on RHEL7.3Beta, I think that -T option
> has been supported.
> Is there another reason lead to this issue?

How about "We don't need -T to detect GETFSMAP and the flag doesn't
exist on really old versions of xfs_io, so just get rid of it."

I'm sorta mystified why it was argued that we shouldn't be calling
xfs_io against $TEST_DIR directly; any process with CAP_SYS_ADMIN is
allowed to query the fs space map via any open file descriptor in the
XFS filesystem -- files or directories.

--D

> 
> Thanks
> Xiao Yang
> >>options.  I get rid of -T to fix it because getfsmap doesn't care if it's
> >>run against a file or a directory.
> >>
> >>Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> >>---
> >>  common/rc | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >>diff --git a/common/rc b/common/rc
> >>index 13afc6a..ec5d73e 100644
> >>--- a/common/rc
> >>+++ b/common/rc
> >>@@ -2049,7 +2049,7 @@ _require_xfs_io_command()
> >>  			_notrun "xfs_io $command support is missing"
> >>  		;;
> >>  	"fsmap" )
> >>-		testio=`$XFS_IO_PROG -T -F -c "fsmap" \
> >>+		testio=`$XFS_IO_PROG -F -c "fsmap" \
> >>  			$TEST_DIR 2>&1`
> >I think it's better to operate on a file in $TEST_DIR not $TEST_DIR
> >itself. Previously xfs_io creates a tmpfile under $TEST_DIR (-T does
> >this) and runs fsmap on it. Now without -T option, we have to create the
> >file ourselves. And the "-F" option is not needed. So it ends up with:
> >
> >		testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
> >
> >Thanks,
> >Eryu
> >
> >>  		echo $testio | egrep -q "Inappropriate ioctl"&&  \
> >>  			_notrun "xfs_io $command support is missing"
> >>-- 
> >>1.8.3.1
> >>
> >>
> >>
> >>--
> >>To unsubscribe from this list: send the line "unsubscribe fstests" in
> >>the body of a message to majordomo@vger.kernel.org
> >>More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> >.
> >
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

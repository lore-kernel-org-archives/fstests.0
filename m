Received: from userp1040.oracle.com ([156.151.31.81]:28304 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbcITDDm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Sep 2016 23:03:42 -0400
Date: Mon, 19 Sep 2016 20:03:32 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] common/rc: fix fsmap check
Message-ID: <20160920030332.GD10172@birch.djwong.org>
References: <1474273575-9321-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160919223153.GY22388@dastard>
 <57E0A2BD.6050003@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57E0A2BD.6050003@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 10:45:17AM +0800, Xiao Yang wrote:
> On 2016/09/20 6:31, Dave Chinner wrote:
> >On Mon, Sep 19, 2016 at 04:26:15PM +0800, Xiao Yang wrote:
> >>I got an error about $TEST_DIR being a directory when xfs/273 ran, because
> >>xfs_io tried to open the directory first before it parsed the -T options.
> >>So fix it by checking this error.
> >Can I suggest that you read the man page and understand how the
> >command is supposed to work before posting patches to change the
> >test? i.e the -T option /requires/ a directory to be supplied to it:
> >
> >     -T  create a temporary file not linked into the filesystem
> >	namespace (O_TMPFILE).  The pathname passed must refer to a
> >	directory which is  treated as virtual parent for the newly
> >	created invisible file.  Can not be used together with the
> >	-r option.
> >
> >IOWs, there is nothing wrong with the test code - if you if
> >you are getting an EISDIR error here then something is broken with
> >the xfs_io binary you are using.
> >
> >And, because I haven't merged fsmap support into xfs_io yet, it's
> >very likely there is a problem in the prototype patchset you are
> >running. Perhaps that's worth reporting to the patchset author....

Just get rid of -T, getfsmap doesn't care if it's run against a file
or a directory.

Yes sorry that was my fault for cut-and-paste coding. :(

--D

> >
> >Cheers,
> >
> >Dave.
> Hi Dave
> 
> In xfstests/common/rc:2045
> "flink" )
>     testio=`$XFS_IO_PROG -T -F -c "flink $testfile" \
>     $TEST_DIR 2>&1`
>    echo $testio | egrep -q "invalid option|Is a directory" && \
>   _notrun "xfs_io $command support is missing"
> ;;
> 
> I found that someone has met the same error and sent a patch to fix flink
> check.
> Please see the following patch:
> https://git.kernel.org/cgit/fs/xfs/xfstests-dev.git/commit/common/rc?id=0fd4705782c3748b2f83a10ce7cb7f33ffc8ad77
> 
> Thanks
> Xiao Yang
> 
> 
> 

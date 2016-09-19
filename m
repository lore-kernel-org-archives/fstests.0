Date: Tue, 20 Sep 2016 08:31:53 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common/rc: fix fsmap check
Message-ID: <20160919223153.GY22388@dastard>
References: <1474273575-9321-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1474273575-9321-1-git-send-email-yangx.jy@cn.fujitsu.com>
To: Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 19, 2016 at 04:26:15PM +0800, Xiao Yang wrote:
> I got an error about $TEST_DIR being a directory when xfs/273 ran, because
> xfs_io tried to open the directory first before it parsed the -T options.
> So fix it by checking this error.

Can I suggest that you read the man page and understand how the
command is supposed to work before posting patches to change the
test? i.e the -T option /requires/ a directory to be supplied to it:

    -T  create a temporary file not linked into the filesystem
	namespace (O_TMPFILE).  The pathname passed must refer to a
	directory which is  treated as virtual parent for the newly
	created invisible file.  Can not be used together with the
	-r option.

IOWs, there is nothing wrong with the test code - if you if
you are getting an EISDIR error here then something is broken with
the xfs_io binary you are using.

And, because I haven't merged fsmap support into xfs_io yet, it's
very likely there is a problem in the prototype patchset you are
running. Perhaps that's worth reporting to the patchset author....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

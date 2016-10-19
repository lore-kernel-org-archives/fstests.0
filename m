Message-ID: <580703A1.9050402@cn.fujitsu.com>
Date: Wed, 19 Oct 2016 13:24:49 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs: fix __populate_check_xfs_dir
References: <1476759584-4150-1-git-send-email-yangx.jy@cn.fujitsu.com> <20161019044241.GJ14023@dastard>
In-Reply-To: <20161019044241.GJ14023@dastard>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org, darrick.wong@oracle.com
List-ID: <fstests@vger.kernel.org>

On 2016/10/19 12:42, Dave Chinner wrote:
> On Tue, Oct 18, 2016 at 10:59:44AM +0800, Xiao Yang wrote:
>> We need to remove unused ${SCRATCH_DEV} when calling __populate_check_xfs_dir
>> because __populate_check_xfs_dir function has been rewritten by Darrick.
> Can you reference the commit that the relevant change was contained
> in, please? Darrick has made lots of changes - saying "fix
> something after Darrick changed something else" isn't very
> meaningful, especially when someone looks at the commit in a few
> years time. Instead, try something like this:
>
> ----
> [PATCH] xfstests: remove the device parameter from __populate_check_xfs_dir
>
> In commit abcdef1234 ("rewrite the frobnozzle"), the need for
> callers to pass the device to populate into
> __populate_check_xfs_dir() was removed. We can now clean up all the
> callers by removing the device parameter."
> ----
>
> Cheers,
>
> Dave.
Hi Darrick, Dave

Sorry, it's my fault, I will rewrite this  commit.

Thanks,
Xiao Yang

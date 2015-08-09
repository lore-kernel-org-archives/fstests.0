Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:57511 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751344AbbHIXUt (ORCPT
	<rfc822;fstests@vger.kernel.org>); Sun, 9 Aug 2015 19:20:49 -0400
Date: Mon, 10 Aug 2015 09:20:46 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/038: speed up file creation
Message-ID: <20150809232046.GH16638@dastard>
References: <1438820848-13325-1-git-send-email-david@fromorbit.com>
 <20150806141722.GF17933@dhcp-13-216.nay.redhat.com>
 <20150806222127.GE3902@dastard>
 <20150809104558.GM17933@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150809104558.GM17933@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Aug 09, 2015 at 06:45:58PM +0800, Eryu Guan wrote:
> On Fri, Aug 07, 2015 at 08:21:27AM +1000, Dave Chinner wrote:
> > Seeing as you can reproduce the problem, I encourage you to work out
> > what the minimum number of files need to reproduce the problem is,
> > and update the test to use that so that it runs even faster...
> 
> I found that 50000 files per thread is good enough for me to reproduce
> the fs corruption, sometimes WARNINGs. With 20000 or 30000 files per
> thread, only 20% to 33% runs could hit some problems. So this is what
> I'm testing (comments are not updated)
> 
> [root@dhcp-66-87-213 xfstests]# git diff
> diff --git a/tests/generic/038 b/tests/generic/038
> index 3c94a3b..7564c87 100755
> --- a/tests/generic/038
> +++ b/tests/generic/038
> @@ -108,6 +108,7 @@ trim_loop()
>  #
>  # reating 400,000 files sequentially is really slow, so speed it up a bit
>  # by doing it concurrently with 4 threads in 4 separate directories.
> +nr_files=$((50000 * LOAD_FACTOR))
>  create_files()
>  {
>         local prefix=$1
> @@ -115,7 +116,7 @@ create_files()
>         for ((n = 0; n < 4; n++)); do
>                 mkdir $SCRATCH_MNT/$n
>                 (
> -               for ((i = 1; i <= 100000; i++)); do
> +               for ((i = 1; i <= $nr_files; i++)); do
>                         $XFS_IO_PROG -f -c "pwrite -S 0xaa 0 3900" \
>                                 $SCRATCH_MNT/$n/"${prefix}_$i" &> /dev/null
>                         if [ $? -ne 0 ]; then
> 
> Would you like a follow up patch from me or you can just make this one a v2?

Ok, I'll fold that into my original patch, update the comment and
the commit message with:

[Eryu Guan: reduced number of files to minimum needed to reproduce
 btrfs problem reliably, added $LOAD_FACTOR scaling for longer
 running.]

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

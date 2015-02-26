Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:40414 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753439AbbBZIs4 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Feb 2015 03:48:56 -0500
Received: by wesx3 with SMTP id x3so8566613wes.7
        for <fstests@vger.kernel.org>; Thu, 26 Feb 2015 00:48:55 -0800 (PST)
Message-ID: <54EEDDF5.5000007@plexistor.com>
Date: Thu, 26 Feb 2015 10:48:53 +0200
From: Boaz Harrosh <boaz@plexistor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] brd: Only request 4K sectors if DAX is enabled
References: <1424818479-10083-1-git-send-email-david@fromorbit.com> <1424818479-10083-2-git-send-email-david@fromorbit.com> <20150225161151.GC28053@bfoster.bfoster> <20150225223248.GH4251@dastard> <54EED5F6.2030804@plexistor.com> <54EEDC4A.8090000@plexistor.com>
In-Reply-To: <54EEDC4A.8090000@plexistor.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Jens Axboe <axboe@fb.com>, Brian Foster <bfoster@redhat.com>, fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 02/26/2015 10:41 AM, Boaz Harrosh wrote:
> 
> People systems have been using ramdisk with
> smaller-than-page-size blocks in their mkfs.
> 
> The 4K sectors is only important if we will be
> using brd with a DAX filesystem.
> 
> So only enable 4K sectors if DAX is configured
> 
> Signed-off-by: Boaz Harrosh <boaz@plexistor.com>
> ---
>  drivers/block/brd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> index 6e0775b..e875f12 100644
> --- a/drivers/block/brd.c
> +++ b/drivers/block/brd.c
> @@ -495,6 +495,7 @@ static struct brd_device *brd_alloc(int i)
>  	blk_queue_max_hw_sectors(brd->brd_queue, 1024);
>  	blk_queue_bounce_limit(brd->brd_queue, BLK_BOUNCE_ANY);
>  
> +#ifdef CONFIG_BLK_DEV_RAM_DAX
>  	/* This is so fdisk will align partitions on 4k, because of
>  	 * direct_access API needing 4k alignment, returning a PFN
>  	 * (This is only a problem on very small devices <= 4M,
> @@ -502,6 +503,7 @@ static struct brd_device *brd_alloc(int i)
>  	 *  is harmless)
>  	 */

Hi Dave

I was just thinking should we also do

+	if (part_show)
>  		blk_queue_physical_block_size(brd->brd_queue, PAGE_SIZE);

The rational is that if part_show is off then we are not using partitions
at all and then there can be no problems?

I'll try to run your tests here. I never test xfs always ext4, maybe I should
start to ;-). Actually I do have xfsprogs so why not. But if you could run
a quick test as well it could be great.

Thanks
Boaz

<>

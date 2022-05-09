Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D44C433EF
	for <linux-fstests@archiver.kernel.org>; Mon,  9 May 2022 13:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236447AbiEINrH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 9 May 2022 09:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbiEINq7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 9 May 2022 09:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BBB26A729
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 06:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1445E61568
        for <fstests@vger.kernel.org>; Mon,  9 May 2022 13:42:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DD8C385A8;
        Mon,  9 May 2022 13:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652103766;
        bh=/UTih63eYMvGaDG0Iy/YeLX01AKNETvDTIYWd7ao400=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RVQ/LUdaJSq2RIBrarz+I0YLAdeg3AfxMttwUZS1lTopHoAK9YZKJMET9f/aGixJP
         Rp4nTfhbZ2LNoQvSGBM47avonUi0PUQfjEiLlES4WerJGG1Sga2xXdgxrcmXSj1opE
         QpBj71KsE79RSSoC1jwAxaU1jo2clJ2lwi+Dr8CTUsSyCDSI1b7uJBiNjBY3hrDRwV
         27V2n1OlTogvrf9aQzVV1Kv3uDdrpwu+OFf1d3zlhiiowJmi/cXvkf1jx6XfIXqoQK
         0ZxFIMtFSkDaG8QNDEFIiTyJugebW1zPJ+2SC8PZNEpOO2pEQY6mqBAkskDdCT1D5O
         bdujnA2dLKqQw==
Date:   Mon, 9 May 2022 21:42:41 +0800
From:   Zorro Lang <zlang@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/298: Add 100ms sleep before scratch_umount
Message-ID: <20220509134241.2jfkh2rkmcaxnhc3@zlang-mailbox>
Mail-Followup-To: Yang Xu <xuyang2018.jy@fujitsu.com>,
        fstests@vger.kernel.org
References: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652079417-2255-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, May 09, 2022 at 02:56:57PM +0800, Yang Xu wrote:
> When testing this case on my machine, it reports the following error:
> umount: /mnt/xfstests/scratch: target is busy.
> xfs_db: /dev/sda11 contains a mounted filesystem
> 
> scratch_unmount failed, so  _scratch_xfs_db reports scratch_dev is a
> mounted filesystem. It seems filesystem has something to be doing.
> 
> To avoid this, just add a 100ms sleep before scratch_umount.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  tests/xfs/298 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/298 b/tests/xfs/298
> index b0153ebf..17510379 100755
> --- a/tests/xfs/298
> +++ b/tests/xfs/298
> @@ -51,6 +51,7 @@ while [ $SIZE -lt 1024 ];do
>  	rm $SYMLINK_FILE
>  # umount and check the number of extents on the inode. Should be 0.
>  	cd /
> +	sleep 0.1

Hi

Actually I was wondering if we can add a while loop trying in _scratch_unmount,
to avoid some random "device busy" problem, likes:

Change _scratch_unmount to __scratch_unmount, then:

_scratch_unmount()
{
	local n
	local is_unmounted=1

	__scratch_unmount > $tmp.scratch_unmount.err 2>&1
	if [ $? -ne 0 -a "$MULTI_SCRATCH_UNMOUNT" = "yes" ];then
		for ((n=0; n<5; n++));do
			sleep 0.1
			__scratch_unmount >> $tmp.scratch_unmount.err 2>&1
			if [ $? -eq 0 ];then
				is_unmounted=0
				break
			fi
		done
	else
		is_unmounted=0
	fi
	if [ $is_unmounted -ne 0 ];then
		cat $tmp.scratch_unmount.err
	fi
	rm -f $tmp.scratch_unmount.err
	return $is_unmounted
}

This's just an idea out of my head, hope to hear more suggestions from other
forks.

Thanks,
Zorro

>  	_scratch_unmount >/dev/null 2>&1
>  	_scratch_xfs_db  -c "inode $inode" -c "p core.nextents"
>  
> -- 
> 2.23.0
> 

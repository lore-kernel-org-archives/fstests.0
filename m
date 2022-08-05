Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B268EC00140
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Aug 2022 15:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241186AbiHEPCr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241193AbiHEPC3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Aug 2022 11:02:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7229D7C180
        for <fstests@vger.kernel.org>; Fri,  5 Aug 2022 08:00:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7705361133
        for <fstests@vger.kernel.org>; Fri,  5 Aug 2022 15:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A9DC433B5;
        Fri,  5 Aug 2022 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659711621;
        bh=n7TWH+kSO4rZkx16YVVqUcOc+xhuXEzeNu6yGe/qDYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GQBmyZ/srwH/s34LZT5kxrpZ+mOE49uHH6Hy7d4S1ptt0aqQ1x8m4Ij5XFt1yr3ok
         9UivfKU9MrGYpktRU61oM8a6u3al+6szhT9AyAbcHcTFhpjhU7u0uoPEgCqGk9fCq1
         fLlBynz5kM3xzVgbge19Auh/oxdVBUmRJOtMsAKswl8amXx3xtKgstY7qh5sFgxn6k
         IjqLo/SkqMKkhZ6/ljJsJ4mW0qXwArAVl0d1TGVTW8tEYCdtzCrGesALuHUjrws3mP
         xGDqmWuffF0bQBdY5zoGRMSIcjg5rt4bwRUNTqUebDemU1MVi1Kg5sSOfrG58r9Yr0
         3bK/H2uwKKsnQ==
Date:   Fri, 5 Aug 2022 08:00:21 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] src/t_ofd_locks.c: Reset errno to zero
Message-ID: <Yu0whQTezx3Mja5a@magnolia>
References: <1659593932-4158-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659593932-4158-1-git-send-email-xuyang2018.jy@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Aug 04, 2022 at 02:18:52PM +0800, Yang Xu wrote:
> It seems I met libcap errno bug again when using libcap-2.48-4.el8.x86_64.
> But this time, errno is EINVAL if c program link with lcap.
> Lastest upstream libcap doesn't have bug and it should be backport bug.
> 
> generic/478 will become not run because of this. To fix this that only
> exists on some distributions, reset errno to zero.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/t_ofd_locks.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> index e3b15ddc..e77f2659 100644
> --- a/src/t_ofd_locks.c
> +++ b/src/t_ofd_locks.c
> @@ -187,6 +187,8 @@ int main(int argc, char **argv)
>  	struct sembuf sop;
>  	int opt, ret, retry;
>  
> +	//avoid libcap errno bug
> +	errno = 0;

What sets errno to EINVAL here?  And what actually causes the program to
exit with code 22?

There aren't any library calls prior to this point, right?  Or is this
... libpcap has some initcall that runs quietly in the background before
main starts, so we enter main with errno==EINVAL, which then causes ...
something else to break?

--D

>  	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFd")) != -1) {
>  		switch(opt) {
>  		case 's':
> -- 
> 2.27.0
> 

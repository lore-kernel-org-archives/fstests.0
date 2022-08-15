Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC12FC25B0E
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Aug 2022 14:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243117AbiHOOaO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 15 Aug 2022 10:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiHOOaN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 15 Aug 2022 10:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967E324092
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 07:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B40160FAF
        for <fstests@vger.kernel.org>; Mon, 15 Aug 2022 14:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884F8C433D7;
        Mon, 15 Aug 2022 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660573811;
        bh=BTl2YierTJE7AUd7KVx4NWbe4qqtrS5D1uOyDNuyWyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZUhoGqV4DwIpf5LA5YjmeJCOpG6RKV2X9TRAmGvL0IFBqqQJ4bBAngE6Jx2rJfvBN
         gHZxI7Q6JOzop2iQOXyIaLDW9YUNZfeBey/1vRMQ9PmngoGrbt7OM1kqBczu1AuAJ/
         HnNu8qUrq9oGQulYd2zxQh0wDx067H4a4tHeKK5DoK4bCFdNVIjsN2H1Oqtrxm6zCS
         JeAJSg/mtqAzRLGzDFZzDAt/qoTzkBTgnALLNX1JqJhXN7CRWonZUk1eage9tBXTsP
         LB0eMR3X/8G/s+l2MeWC1Z6LfTZrQqDnYinxgurJd1TMVvOunE9WV8lk1O8XOqKbV7
         77x9EM+MuSDFw==
Date:   Mon, 15 Aug 2022 07:30:11 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH] src/t_ofd_locks.c: Reset errno to zero
Message-ID: <YvpYc6tHtgWIQAAF@magnolia>
References: <1659593932-4158-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Yu0whQTezx3Mja5a@magnolia>
 <585a8c5d-81c5-c40a-b7c2-b50f36d6fb0c@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <585a8c5d-81c5-c40a-b7c2-b50f36d6fb0c@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 15, 2022 at 10:06:59AM +0000, xuyang2018.jy@fujitsu.com wrote:
> 
> 
> on 2022/08/05 23:00, Darrick J. Wong wrote:
> > On Thu, Aug 04, 2022 at 02:18:52PM +0800, Yang Xu wrote:
> >> It seems I met libcap errno bug again when using libcap-2.48-4.el8.x86_64.
> >> But this time, errno is EINVAL if c program link with lcap.
> >> Lastest upstream libcap doesn't have bug and it should be backport bug.
> >>
> >> generic/478 will become not run because of this. To fix this that only
> >> exists on some distributions, reset errno to zero.
> >>
> >> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> >> ---
> >>   src/t_ofd_locks.c | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
> >> index e3b15ddc..e77f2659 100644
> >> --- a/src/t_ofd_locks.c
> >> +++ b/src/t_ofd_locks.c
> >> @@ -187,6 +187,8 @@ int main(int argc, char **argv)
> >>   	struct sembuf sop;
> >>   	int opt, ret, retry;
> >>   
> >> +	//avoid libcap errno bug
> >> +	errno = 0;
> > 
> > What sets errno to EINVAL here?  And what actually causes the program to
> > exit with code 22?
> > 
> > There aren't any library calls prior to this point, right?  Or is this
> > ... libpcap has some initcall that runs quietly in the background before
> > main starts, so we enter main with errno==EINVAL, which then causes ...
> > something else to break?
> Yes,
> 
> #include <stdio.h>
> #include <errno.h>
> int main(int argc, char **argv)
> {
>          printf("errno %d\n", errno);
>          return 0;
> }
> 
> gcc test.c -lcap -o test
> 
> then run test, errno is EINVAL.
> 
> But upstream libcap is ok and it should be a backport bug on libcap 
> distribution version.

Yay for still paying for poor decisions of the 1970s in 2022...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> Best Regards
> Yang Xu
> > 
> > --D
> > 
> >>   	while((opt = getopt(argc, argv, "sgrwo:l:PRWtFd")) != -1) {
> >>   		switch(opt) {
> >>   		case 's':
> >> -- 
> >> 2.27.0
> >>

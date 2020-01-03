Return-Path: <SRS0=PjwK=2Y=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE12CC00523
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 08:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA5DB22314
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Jan 2020 08:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgACI1i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:27:38 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:42447 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726295AbgACI1i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 3 Jan 2020 03:27:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=eguan@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TmihCOf_1578040002;
Received: from localhost(mailfrom:eguan@linux.alibaba.com fp:SMTPD_---0TmihCOf_1578040002)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Jan 2020 16:26:42 +0800
Date:   Fri, 3 Jan 2020 16:26:42 +0800
From:   Eryu Guan <eguan@linux.alibaba.com>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     fstests@vger.kernel.org, guaneryu@gmail.com
Subject: Re: [PATCH] ltp/fsx.c: Ignore unsupported keep_size flag even if
 it's specified by --replay-ops
Message-ID: <20200103082642.GE41863@e18g06458.et15sqa>
References: <20200103075451.12354-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200103075451.12354-1-yangx.jy@cn.fujitsu.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 03, 2020 at 03:54:51PM +0800, Xiao Yang wrote:
> Current fsx cannot drop keep_size flag if it is specified by --replay-ops but not
> supported by fallocate().  For example, running generic/469 got the following
> error on NFSv4.2:
> ----------------------------------------------------
> main: filesystem does not support fallocate mode FALLOC_FL_KEEP_SIZE, disabling!
> ...
> fallocate: 0x0 to 0x1000
> do_preallocate: fallocate: Operation not supported
> LOG DUMP (1 total operations):
> 1(  1 mod 256): FALLOC   0x0 thru 0x1000        (0x1000 bytes) PAST_EOF
> ...
> ----------------------------------------------------
> 
> Avoid calling fallocate(FALLOC_FL_KEEP_SIZE) in this case by ignoring keep_size flag.
> 
> BTW: NFSv4.2 doesn't support single keep_size flag，as below:
> ----------------------------------------------------
> if ((mode != 0) && (mode != (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE)))
>         return -EOPNOTSUPP;
> ----------------------------------------------------
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  ltp/fsx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4e..4da9d7d8 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1948,7 +1948,18 @@ test(void)
>  			size = log_entry.args[1];
>  			offset2 = log_entry.args[2];
>  			closeopen = !!(log_entry.flags & FL_CLOSE_OPEN);
> +
> +			/*
> +			 * Ignore unsupported keep_size flag even if it's specified
> +			 * by --replay-ops
> +			 */
>  			keep_size = !!(log_entry.flags & FL_KEEP_SIZE);
> +			if (!keep_size_calls && keep_size) {
> +				if (!quiet)
> +					prt("Ignoring unsupported keep_size flag\n");
> +				keep_size = 0;
> +			}
> +

I proposed a similar fix back in 2017[1], but Amir didn't like it
because my patch (and your patch) ignored keep_size silently (newly
generated ops list was different than the one fed to --replay-ops).

I proposed a new version in last Oct[2], which will record such ops as
skipped in the generated ops list, and Brian suggested to add a switch
to control the behavior if we want to fail fsx on unsupported ops. But I
didn't have time to work on it since then..

Would you like to help implement the switch Brian suggested based on my
second patch? Then I can apply my v2 patch & your switch patch.

Thanks!

Eryu

[1] https://spinics.net/lists/fstests/msg07953.html
[2] https://lore.kernel.org/fstests/20191023130934.GD59518@bfoster/
>  			goto have_op;
>  		}
>  		return 0;
> -- 
> 2.21.0
> 
> 

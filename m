Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7BFFC433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jan 2021 23:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81C2C64DD4
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Jan 2021 23:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbhA0Xq0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Jan 2021 18:46:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231652AbhA0XoZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 27 Jan 2021 18:44:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD34261601;
        Wed, 27 Jan 2021 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611791022;
        bh=Y7c8F8Eh4pI18c0OdNq/EChFWxufyJmw/EuHpY+CJ1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ldstb3+dSF0gKlFeS30pcrmtcXHMjE65fSNL0ySlQ5hslS+kZZP8ZeUqjuCwaiWiA
         pB3DOU/JmgKcPgz+t52P0ge9TseI7W0Jz/X4HOF6jfC2RPpsWvit/fc/KK8IDQMyev
         4nHlaeUfBYaWBf9OdA0LRrSwbxdnw6970cJNbni6Bvy+sD+kn3oNskdaj/a26EP4Oz
         US+YOqp9hZG/0uid1km5xc1F59qL/yJ0RsVdgbgPz+vGvocJHzqRm/STDrw5Ktbnrx
         H68pTME6WTCi9+q/TV6HmlhtVcl6i+4aXPAlyHDmAD2+5Yl9jRspX1U1aBp8CB8TRU
         XpVw9cYHPTjsA==
Date:   Wed, 27 Jan 2021 15:43:40 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/233,270: unlimit the max locked memory size for
 io_uring
Message-ID: <20210127234340.GD7695@magnolia>
References: <20210127072143.247849-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127072143.247849-1-zlang@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jan 27, 2021 at 03:21:43PM +0800, Zorro Lang wrote:
> The ltp/fsstress always fails on io_uring_queue_init() by returnning
> ENOMEM. Due to io_uring accounts memory it needs under the rlimit
> memlocked option, which can be quite low on some setups, especially
> on 64K pagesize machine. root isn't under this restriction, but
> regular users are. So only g/233 and g/270 which use $qa_user to run
> fsstress are failed.
> 
> To avoid this failure, set max locked memory to unlimited before doing
> fsstress, then restore it after test done.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  tests/generic/233 | 8 ++++++++
>  tests/generic/270 | 8 ++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/tests/generic/233 b/tests/generic/233
> index 7eda5774..342690c2 100755
> --- a/tests/generic/233
> +++ b/tests/generic/233
> @@ -43,6 +43,13 @@ _fsstress()
>  -f rename=10 -f fsync=2 -f write=15 -f dwrite=15 \
>  -n $count -d $out -p 7`
>  
> +	# io_uring accounts memory it needs under the rlimit memlocked option,
> +	# which can be quite low on some setups (especially 64K pagesize). root
> +	# isn't under this restriction, but regular users are. To avoid the
> +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> +	# temporarily.
> +	lmem=`ulimit -l`
> +	ulimit -l unlimited

Should this apply to all the other tests that run fsstress?

$ grep -l FSSTRESS_PROG tests/ | wc -l
94

--D

>  	echo "fsstress $args" >> $seqres.full
>  	if ! su $qa_user -c "$FSSTRESS_PROG $args" | tee -a $seqres.full | _filter_num
>  	then
> @@ -50,6 +57,7 @@ _fsstress()
>  		cat $tmp.out | tee -a $seqres.full
>  		status=1
>  	fi
> +	ulimit -l $lmem
>  }
>  
>  # real QA test starts here
> diff --git a/tests/generic/270 b/tests/generic/270
> index 3d8656d4..bd52d56e 100755
> --- a/tests/generic/270
> +++ b/tests/generic/270
> @@ -37,6 +37,13 @@ _workout()
>  	cp $FSSTRESS_PROG  $tmp.fsstress.bin
>  	$SETCAP_PROG cap_chown=epi  $tmp.fsstress.bin
>  
> +	# io_uring accounts memory it needs under the rlimit memlocked option,
> +	# which can be quite low on some setups (especially 64K pagesize). root
> +	# isn't under this restriction, but regular users are. To avoid the
> +	# io_uring_queue_init fail on ENOMEM, set max locked memory to unlimited
> +	# temporarily.
> +	lmem=`ulimit -l`
> +	ulimit -l unlimited
>  	(su $qa_user -c "$tmp.fsstress.bin $args" &) > /dev/null 2>&1
>  
>  	echo "Run dd writers in parallel"
> @@ -50,6 +57,7 @@ _workout()
>  	done
>  
>  	$KILLALL_PROG -w $tmp.fsstress.bin
> +	ulimit -l $lmem
>  }
>  
>  # real QA test starts here
> -- 
> 2.29.2
> 

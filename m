Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B94DCC6FA90
	for <linux-fstests@archiver.kernel.org>; Wed, 21 Sep 2022 02:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiIUCtM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 22:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiIUCtJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 22:49:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3607D7B6
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663728547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DNSURwBRlBUoJn8wukVAX6b1ATmPraLTlTKlLO+MF3U=;
        b=C+aRcAMM07Dd79y8J6LbxWY5UF/FyLnsuK9QAL2KconUa5Q2WirPVw5shzjYz1KY4ECGjs
        EFHiLTgozZHMVLUjIRBIF2juQhyBUmc9QDcAe+Nk4/RUR7fSlq78lkgQbYJIXwwUN/mCDQ
        xENCtC9KX4eHLm63DizRUw14XwjNahA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-557-si1NdbxINyC28BF0Gow6wA-1; Tue, 20 Sep 2022 22:49:03 -0400
X-MC-Unique: si1NdbxINyC28BF0Gow6wA-1
Received: by mail-qv1-f69.google.com with SMTP id oj15-20020a056214440f00b004ac6db57cacso3353701qvb.17
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 19:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DNSURwBRlBUoJn8wukVAX6b1ATmPraLTlTKlLO+MF3U=;
        b=tdmHwlRl9PndtD/rBCkbKDPA9Iaby9WHuD574QhDWz1p63DuBZIEKh5V9H4gb0pflz
         5xHs+J0KXr+Ti4zZsaSbxK/gXJuJjgGBKkTI0pAOHwten2MhCadnBLBJO93b5Nxj33B0
         i8ACHN1oe/SE+gRmTqBsCjwtuJHVc7QZgJcUDtAHy8ktXU+tnLGxbx+Rkn21Ac+7zu2e
         Xi1bOb1HlV8fuYDnyjVMOgR7uHrkdAKqfXtdIvXtfRpKstNRkfzuG3w+yBqE+SOTo1zi
         RVKgwe+X8kZ4rmPcS9sP/1X++RbFognom78HlGm6IdAm1CG2A/jDXHzDOHqqYBv+2tbO
         I/wQ==
X-Gm-Message-State: ACrzQf35hW13spa9uauNr/upoWkksWfoLDwCepkll904aeeMBLP5as3g
        4YHyp4HwQ5LM1dv8sVpckPAjUr87zKAe5Vd9hMzuAq46EaNMXDOHnKWtlgIrBnB0gdoGQQXA7x2
        DRkkPcxT2hLIS6WZOEw==
X-Received: by 2002:a05:622a:390:b0:35c:ee15:877e with SMTP id j16-20020a05622a039000b0035cee15877emr9339821qtx.72.1663728542643;
        Tue, 20 Sep 2022 19:49:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM51jhqVEWtLL25zDl4IrlqvzxeyjqgxRL8Xgit8zKdJTB9I4ElAWoPHEcFWszKf+Lw2OC/QOw==
X-Received: by 2002:a05:622a:390:b0:35c:ee15:877e with SMTP id j16-20020a05622a039000b0035cee15877emr9339812qtx.72.1663728542357;
        Tue, 20 Sep 2022 19:49:02 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bi10-20020a05620a318a00b006b953a7929csm1130092qkb.73.2022.09.20.19.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 19:49:01 -0700 (PDT)
Date:   Wed, 21 Sep 2022 10:48:57 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Pavel Reichl <preichl@redhat.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v3 1/2] common: new helper to alloacate fixed size files
Message-ID: <20220921024857.yyqrxniqfhvihyyx@zlang-mailbox>
References: <20220920073514.285136-1-preichl@redhat.com>
 <20220920073514.285136-2-preichl@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920073514.285136-2-preichl@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Sep 20, 2022 at 09:35:13AM +0200, Pavel Reichl wrote:
> Helper that creates files of specified size using falloc if supported,
> otherwise pwrite is used.
> 
> Signed-off-by: Pavel Reichl <preichl@redhat.com>
> ---
>  common/rc         | 13 +++++++++++++
>  tests/generic/694 |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index a25cbcd0..77866582 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4925,6 +4925,19 @@ hexdump()
>  	_fail "Use _hexdump(), please!"
>  }
>  
> +# Helper to write a file containing specified number of bytes using
> +# falloc if supported, otherwise use pwrite
> +_create_sizedfile()
> +{
> +	length=$1
> +	file=$2
> +
> +	$XFS_IO_PROG -F -fc "falloc 0 $length" $file 2>&1 | grep -q "Operation not supported"
> +	if [ $? -eq 0 ]; then
> +		$XFS_IO_PROG -F -fc "pwrite -W 0 $length" $file >/dev/null
> +	fi
> +}

I think about it more, above code might ignore a failed falloc, if it's not failed
by "Operation not supported" but really fails, this function won't print or return
any valid things.

So how about we write it like below (for reference only):

# Try to create a file which inode->i_blocks = $length (maybe a little bigger
# than expect)
_create_file_sized()
{
	local length=$1
	local file=$2
	local tmp=`mktemp -u`
	local ret=0

	$XFS_IO_PROG -ft -c "falloc 0 $length" $file >$tmp.out 2>&1
	ret=$?
	if (grep -Eq "Operation not supported|command .* not found" $tmp.out);then
		# fallocate isn't supported, fallback to general buffer write
		$XFS_IO_PROG -ft -c "pwrite 0 $length" $file >$tmp.out 2>&1
		ret=$?
	fi
	[ $ret -ne 0 ] && cat $tmp.out
	rm -f $tmp.out
	return $ret
}

Even though, I think this function might still not good, feel free to tell me if
anyone has better idea/suggestion about how to get a file with specified
inode->i_blocks.

Thanks,
Zorro

> +
>  init_rc
>  
>  ################################################################################
> diff --git a/tests/generic/694 b/tests/generic/694
> index dfd988df..64c3dd9a 100755
> --- a/tests/generic/694
> +++ b/tests/generic/694
> @@ -30,7 +30,7 @@ junk_dir=$TEST_DIR/$seq
>  junk_file=$junk_dir/junk
>  mkdir -p $junk_dir
>  
> -$XFS_IO_PROG -f -c "pwrite -W 0 4G" $junk_file > /dev/null
> +_create_sizedfile 4G $junk_file
>  
>  iblocks=`stat -c '%b' $junk_file`
>  
> -- 
> 2.37.3
> 


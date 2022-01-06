Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC76C433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 17:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiAFRKF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53720 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229666AbiAFRKE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 12:10:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641489004;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FtHPZ+t7FGvgx4+3WhHYt+boiwVYHmbXyEBphPMnxoA=;
        b=CV/vWp1WkO151QnZxWcbyR6VPyYRwCVJNQ/dz1M3HMYSjxMEBwLe0/mM/NXK9O5ifQHRaS
        yb7TYOP7Y/sNMJWFmF1kBocngNVyL5azSfo6PWaB1ZJj1xIcnkjHIZiQk7cTEmExKG0Kss
        LN1boOoQrBWuPPjcXh+/CBJaL41Ss/Q=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-5mzQ2kdePAiGnmxkLcuysA-1; Thu, 06 Jan 2022 12:10:02 -0500
X-MC-Unique: 5mzQ2kdePAiGnmxkLcuysA-1
Received: by mail-pg1-f200.google.com with SMTP id l6-20020a633e06000000b0034006440151so2049577pga.23
        for <fstests@vger.kernel.org>; Thu, 06 Jan 2022 09:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=FtHPZ+t7FGvgx4+3WhHYt+boiwVYHmbXyEBphPMnxoA=;
        b=X+Y4eVJ1f9s659A+4rh7euXJXpcEnIOUB4yHV1Fll4CvpO4MjhKaoXWjM8NCu2rTfB
         ryBKE768NL1v5MAMR8YSFh5BGRRAR0HhuIbylVR39NvM5FZr1jLXVbZdqyQi0fvKwIlY
         hPh9hsvYT4XV8ZimAG+PGIzTIUDVXlOywNK9LEgcYaHBFCIYu7UTKnDil1J2DiZ3/YbF
         Pghgc2NHTALHY0zPga/z4ghfhc9WasCFcII2SR/lvDP1SNeWZxg6RtuffJyXG7jSq51v
         wu5/Ooj3LWV6c7JTvcOfsJeIS+AjnCiQZOnyeSkIfWO5oULgx6uaEY/iR9/KHk+YI/Zb
         2+yw==
X-Gm-Message-State: AOAM530cyOhKo3txEiDRKunxzzlMvmHuikslkWLHziJkeq2mhou+mTzX
        lASiXZ4xRxbexD+sybylhVnawe3rACLyQwj98HQrGiA0ItVvoIphlvCNMMmk1ACSWcn27v+ZN8j
        q4cOB1x1MyhIvMElajw==
X-Received: by 2002:a17:902:dac7:b0:148:ea85:af4d with SMTP id q7-20020a170902dac700b00148ea85af4dmr59060556plx.131.1641489000772;
        Thu, 06 Jan 2022 09:10:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyVRoJhaUUApKFBlDf/qUgKKr2e5LvunD4LoCcNyp2GpoLCnIspxSe/vudJB0TwN06z75aYJg==
X-Received: by 2002:a17:902:dac7:b0:148:ea85:af4d with SMTP id q7-20020a170902dac700b00148ea85af4dmr59060528plx.131.1641489000443;
        Thu, 06 Jan 2022 09:10:00 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y37sm2483294pga.78.2022.01.06.09.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:10:00 -0800 (PST)
Date:   Fri, 7 Jan 2022 01:09:56 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH v2] common: handle ceph's new mount syntax
Message-ID: <20220106170956.f7bxe265wghmbqbh@zlang-mailbox>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, fstests@vger.kernel.org,
        guan@eryu.me
References: <20220106112316.6790-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106112316.6790-1-jlayton@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 06, 2022 at 06:23:16AM -0500, Jeff Layton wrote:
> Cephfs is introducing a new mount device syntax. Fix the fstests
> infrastructure to handle the new syntax correctly.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  common/config |  8 ++++++++
>  common/rc     | 34 ++++++++++++++++++++++++++++++++--
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> v2: more rigorous check for ceph mount device in _check_device
> 
> diff --git a/common/config b/common/config
> index e0a5c5df58ff..2b357746476b 100644
> --- a/common/config
> +++ b/common/config
> @@ -537,6 +537,14 @@ _check_device()
>  		# 9p and virtiofs mount tags are just plain strings, so anything is allowed
>  		# tmpfs doesn't use mount source, ignore
>  		;;
> +	ceph)
> +		# ceph has two different possible syntaxes for mount devices. The
> +		# network URL check above catches the legacy syntax. Check for the
> +		# new-style syntax here.
> +		if ( echo $dev | grep -qEv "=/" ); then
> +			_fatal "common/config: $name ($dev) is not a valid ceph mount string"
> +		fi
> +		;;

I have not objection with this, if the maintainer prefer:

-       if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//" ); then
+       if [ -b "$dev" ] || ( echo $dev | grep -qE ":|//|=/" ); then
                # block device or a network url
                return 0
        fi

>  	overlay)
>  		if [ ! -d "$dev" ]; then
>  			_fatal "common/config: $name ($dev) is not a directory for overlay"
> diff --git a/common/rc b/common/rc
> index 7973ceb5fdf8..4fa0b818d840 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1592,7 +1592,7 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> -	nfs*|ceph)
> +	nfs*)
>  		echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
>  			_notrun "this test requires a valid \$SCRATCH_DEV"
> @@ -1601,6 +1601,21 @@ _require_scratch_nocheck()
>  			_notrun "this test requires a valid \$SCRATCH_MNT"
>  		fi
>  		;;
> +	ceph)
> +		if [ -z "$SCRATCH_DEV" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_DEV"
> +		fi
> +		echo $SCRATCH_DEV | grep -q "=/" > /dev/null 2>&1
> +		if [ "$?" != "0" ]; then
> +			echo $SCRATCH_DEV | grep -q ":/" > /dev/null 2>&1
> +			if [ "$?" != "0" ]; then

Why not combine two "if condition" into one, likes:
  echo $SCRATCH_DEV | grep -Eq "=/|:/" >/dev/null 2>&1
  if [ "$?" != "0" ] ....

(Sorry I didn't metion this last time...)

Same below:
 
> +				_notrun "this test requires a valid \$SCRATCH_DEV"
> +			fi
> +		fi
> +		if [ ! -d "$SCRATCH_MNT" ]; then
> +			_notrun "this test requires a valid \$SCRATCH_MNT"
> +		fi
> +		;;
>  	pvfs2)
>  		echo $SCRATCH_DEV | grep -q "://" > /dev/null 2>&1
>  		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
> @@ -1770,7 +1785,7 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> -	nfs*|ceph)
> +	nfs*)
>  		echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
>  			_notrun "this test requires a valid \$TEST_DEV"
> @@ -1779,6 +1794,21 @@ _require_test()
>  			_notrun "this test requires a valid \$TEST_DIR"
>  		fi
>  		;;
> +	ceph)
> +		if [ -z "$TEST_DEV" ]; then
> +			_notrun "this test requires a valid \$TEST_DEV"
> +		fi
> +		echo $TEST_DEV | grep -q "=/" > /dev/null 2>&1
> +		if [ "$?" != "0" ]; then
> +			echo $TEST_DEV | grep -q ":/" > /dev/null 2>&1
> +			if [ "$?" != "0" ]; then
> +				_notrun "this test requires a valid \$TEST_DEV"
> +			fi
> +		fi
> +		if [ ! -d "$TEST_DIR" ]; then
> +			_notrun "this test requires a valid \$TEST_DIR"
> +		fi
> +		;;
>  	cifs)
>  		echo $TEST_DEV | grep -q "//" > /dev/null 2>&1
>  		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
> -- 
> 2.33.1
> 


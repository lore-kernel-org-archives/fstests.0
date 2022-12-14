Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D5BC4332F
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Dec 2022 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiLNUCK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Dec 2022 15:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLNT7x (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Dec 2022 14:59:53 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B862BB18
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 11:57:03 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o12so8099225pjo.4
        for <fstests@vger.kernel.org>; Wed, 14 Dec 2022 11:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9KA5UzORx8XHETx+1fQsz/eX07xZYpm8u5I5ex9CJ04=;
        b=Ci3D9/+3QI5VESPS4gwtgFLx8bYGI6ryLeM1j+GGhkXvMw5bfejtKxGuwO+IlUhutu
         XqVAyW2s0nPWXkBzI1Q6DyHZtd1lRTlzNHaa+qTebyM5Kvo8LKSIme0QD8Adx766PaGm
         84Wof7e43F+oaJ32MRi1WIw9oSX9EiC9Ah0ISNN1ZJtwiQZWIO84XafRLKj40HcxgMqx
         ahEkCIdDG+61xnUnOm6VDM0wcIslsfruS15gCUtPAv3TfPrb54Gg/IPCcK3QVkVc9TQH
         phcxGcxrUo8dTtRCpVaj9dcn8KHmcIDUJE/dBqNQPU9RmJlwtTKgAOY6BouhsScK3nvt
         wT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KA5UzORx8XHETx+1fQsz/eX07xZYpm8u5I5ex9CJ04=;
        b=MoYR/GSFdmHRJfptr0Xs7L7f8WU9DiizHDPF4FkjjVN5/65EpsQGJpe17VvEmkRkZj
         Hx6Wgnr0RVjXctMIbhA35SqZFdVnX+Q5PaHkkq131jjyr/crDJv9mHlYoWVd7jHza+vr
         FlpueE+TJ+dyyhUsEXIO59Xl+XeJ50I/bj2adtKM7f0B4VYBgP0GB3gwq0FxIIpfbhNS
         5CAIUZG5+zem53DeVeoACevfaoBH+c/wPcEtVyHOBt3rqtuiT/2w2/2xGN7Swwkr0Wza
         5deAq0MtDhxfDgCanhDJnkz+JegBzP13n763T03aj1XvmG8tlUw0su/vJ+L6M9jIVpVO
         kXmw==
X-Gm-Message-State: ANoB5pkcSKsJpX7Ua3zXubTdGxF2JL8hm96bHeE0BxcPmITIZj1QfEkM
        gYfenQ/m8j3Pa7YXljFgu+JmgdRzbrA=
X-Google-Smtp-Source: AA0mqf7bcaTniKPJVufhZG33OOqsHmil7ABnJir0S9/NzhAEFXWUIF6qKX2p+RqW8h0Au/5kimvYxQ==
X-Received: by 2002:a17:90a:e00a:b0:221:6db6:9660 with SMTP id u10-20020a17090ae00a00b002216db69660mr10680034pjy.11.1671047822607;
        Wed, 14 Dec 2022 11:57:02 -0800 (PST)
Received: from google.com ([2601:647:4701:18d0:591e:a21:c081:9a34])
        by smtp.gmail.com with ESMTPSA id s18-20020a17090a5d1200b00218f830c63esm1795795pji.1.2022.12.14.11.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 11:57:02 -0800 (PST)
Date:   Wed, 14 Dec 2022 11:56:59 -0800
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] check: use /var/tmp instead of /tmp
Message-ID: <Y5oqi3XdqDO/OcAE@google.com>
References: <20221212230646.4022294-1-leah.rumancik@gmail.com>
 <Y5e22dC9jxg4NnxS@magnolia>
 <Y5fb5viJh8Q7bVH0@google.com>
 <Y5fpJ168rNwwrfhI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5fpJ168rNwwrfhI@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Dec 12, 2022 at 06:53:27PM -0800, Darrick J. Wong wrote:
> 
> Does this help?

This should work for me! I'll go ahead and resend just the rm
tmp.arglist change.

Thanks,
Leah

> 
> --D
> 
> From: Darrick J. Wong <djwong@kernel.org>
> Subject: [PATCH] check: generate section reports between tests
> 
> Generate the section report between tests so that the summary report
> always reflects the outcome of the most recent test.  This is useful for
> fstests status reporting, for people who anxiously await results.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  check |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/check b/check
> index d2e5129620..997547247f 100755
> --- a/check
> +++ b/check
> @@ -841,6 +841,16 @@ function run_section()
>  		fi
>  		seqres="$REPORT_DIR/$seqnum"
>  
> +		# Generate the entire section report with whatever test results
> +		# we have so far.  Leave the $sect_time parameter empty so that
> +		# it's a little more obvious that this test run is incomplete.
> +		if $do_report; then
> +			local sect_now=`_wallclock`
> +			_make_section_report "$section" "${#try[*]}" \
> +					     "${#bad[*]}" "${#notrun[*]}" \
> +					     "" &> /dev/null
> +		fi
> +
>  		mkdir -p $RESULT_DIR
>  		rm -f ${RESULT_DIR}/require_scratch*
>  		rm -f ${RESULT_DIR}/require_test*

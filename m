Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA137EE57C0
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Sep 2023 05:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbjIHFAk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Sep 2023 01:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjIHFAj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Sep 2023 01:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD92A1997
        for <fstests@vger.kernel.org>; Thu,  7 Sep 2023 21:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694149190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omE/fqAi5L9tAoo0PSxtYu5iU2quEaNU33HuqqCYBpY=;
        b=gbG/m05LyR7zmWkp9kgWeM0N9egT1Lg5Q44q4RPgeVazxSlUdI1d4nMKaqr0/Sntx1mzmd
        3UHCVK5bR7EmQmEU3owrTHOLVpMYpMppB7BU7ATNq6XD0CiOqLLXTEvpcApNBl6vRHf4EB
        Kbnu32HC1Hu73hVY3cCJ85pMwD6o2AQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-lmoIw-z6PJy4imF0eTcq_w-1; Fri, 08 Sep 2023 00:59:48 -0400
X-MC-Unique: lmoIw-z6PJy4imF0eTcq_w-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-267f00f6876so2161224a91.3
        for <fstests@vger.kernel.org>; Thu, 07 Sep 2023 21:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694149187; x=1694753987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omE/fqAi5L9tAoo0PSxtYu5iU2quEaNU33HuqqCYBpY=;
        b=ExUEfXanX7BDRLN47NoUe81Dtcxj09l5pRStkeL0m9/L0QMEQWwrqpP3ix7fPVNfef
         zeFd6d7/fDSkI02YZFxmBvK1l7UKO1z08s6WhrOoQcptu5jtoDplmC7ThUE29xN5bRMs
         8dDFYphsWbcpJPuzhr55x7sm+mymY+wIhDzrecZBbiUjGC6jSWD50Sb3ildHNAiObTk+
         wYYzvEDlt0tCWeNyp0TuWT8ltFvCeirGb5VzxPEM5Lr4WfxEJIoOP3h2alZKztEjDBYu
         BgZk3cUyOqrpBanD/cL27KZXYXeg735tULDlrvajDMLFp1rsFtmY95vQqcer8Pv0tPY2
         A1mg==
X-Gm-Message-State: AOJu0Yy/Mr6pi8dg4T7FIbuEj7rgMfwUmA47eKwHQBCE9rCPmFXs86A+
        N/x//fq/85EhwE5eo4Hl+pTB3XjLDV0oWF/axwIT2aQsarJ9f3S9o2PhSxBbLJ2I3sFpW3BPltI
        HtCWHSpF6/LD/8ss1Ii8WuPihlQ1H
X-Received: by 2002:a17:90a:6549:b0:26b:17ef:7365 with SMTP id f9-20020a17090a654900b0026b17ef7365mr1327059pjs.48.1694149187173;
        Thu, 07 Sep 2023 21:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6NhQ62L0JiyHhxRneEm8r4PcuXeCDgEla5SbBaDU4m+lVBgWPmCsM/ZVIhm+osJC1RTOgew==
X-Received: by 2002:a17:90a:6549:b0:26b:17ef:7365 with SMTP id f9-20020a17090a654900b0026b17ef7365mr1327052pjs.48.1694149186860;
        Thu, 07 Sep 2023 21:59:46 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090332cd00b001b03cda6389sm597639plr.10.2023.09.07.21.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 21:59:46 -0700 (PDT)
Date:   Fri, 8 Sep 2023 12:59:43 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] tools/mvtests: ensure testcase is executable (755)
Message-ID: <20230908045943.k6jiwfbpdn6np2ay@zlang-mailbox>
References: <20230906071349.3643040-1-ruansy.fnst@fujitsu.com>
 <20230907113501.4119112-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907113501.4119112-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Sep 07, 2023 at 07:35:01PM +0800, Shiyang Ruan wrote:
> Some test cases lack executable permission ('x'). Before running each
> test case, `./check` checks and grants them 'x' permission. However,
> this always leads to a dirty git repo. And the absence of 'x' permission
> in test cases is often overlooked during reviews.
> 
> Since maintainers use mvtest to assign new case, add this change for
> convenience of maintainers.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  tools/mvtest | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/mvtest b/tools/mvtest
> index 99b154142..1ad775a3e 100755
> --- a/tools/mvtest
> +++ b/tools/mvtest
> @@ -34,6 +34,8 @@ did="$(basename "${dest}")"
>  
>  git mv "tests/${src}" "tests/${dest}"
>  git mv "tests/${src}.out" "tests/${dest}.out"
> +# make sure testcase is executable
> +test $(stat -c '%a' tests/${dest}) == 755 || chmod 755 "tests/${dest}"

I think `chmod 755 "tests/${dest}"` is enough at here. With this change:
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
>  sed -e "s/^QA output created by ${sid}$/QA output created by ${did}/g" -i "tests/${dest}.out"
>  sed -e "s/test-${sid}/test-${did}/g" -i "tests/${dest}.out"
> -- 
> 2.42.0
> 


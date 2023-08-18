Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256ABC7113E
	for <linux-fstests@archiver.kernel.org>; Fri, 18 Aug 2023 12:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346511AbjHRMfV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 18 Aug 2023 08:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359798AbjHRMfQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 18 Aug 2023 08:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A396114
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2023 05:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692362071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a4qu5KTlCd8QeM/N6zDYyk8NdIr2soUt+badkEvaFgY=;
        b=UAB57yRReuKswStF54I6x8otnGn+P9tccOU9ZI66hnRnubBl1PIRfCH2gKFe8SEajq8RMW
        Eo/vMum95pRy+2qhCoqrNhoASCQ2aXIwm6zGlPHp0BXoBLcBDdX/eIXSYXq0TomFz0lMg9
        CmNzJZ95ersSt1drHaZmYzs3/mJIrOI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-1K-F0mH6NgKeVAlKYSRfzQ-1; Fri, 18 Aug 2023 08:34:28 -0400
X-MC-Unique: 1K-F0mH6NgKeVAlKYSRfzQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3a78c2cdd77so982585b6e.1
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2023 05:34:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692362068; x=1692966868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4qu5KTlCd8QeM/N6zDYyk8NdIr2soUt+badkEvaFgY=;
        b=ZBLvL9DVI2eBHO+SRM6l/vGXautn/5usifWH3IKJw31gIBfW+v/lPXK8ciELXj42tu
         koqMhtd9F6NW3AZDqa8oduLRFAUOwduDbQlK0EPgD58pj8tUDwfaptPoMa+d9s4aUGCd
         yDZAzlVTJ/pqUwq3CDoCeHJeFcyAPjF29ubZCLqBeeUeIqskSeFN5d+Z2B5iDyhJNO/w
         gnuQIy5sl0gkXK02yAw+jR1zeoz1S9A9ca5F7eM5EAxP6nvyWyLZ9OLjpuLT868a4VFW
         4YGXaCv8l+EntnCXu167MzfQXyvhHzYYUqWW3sXLmIOTvvD3ll6T3A9QKTGSt9S65N9v
         +jHQ==
X-Gm-Message-State: AOJu0YwMZ5rm7bzPKoQ80HVRbqV7j8x5zE+GbACkpSLwP1Q9OZV1N6s1
        PAVoDJ7jlRidQ6d4IdisflFua6ssQuCmuBTXZjxM2ig7aZ+uO2gjH6wrPLx/N1AimvWla3AWJFc
        h3jX7XcA/iPXejSbwIg==
X-Received: by 2002:a05:6808:10c3:b0:3a7:4478:7139 with SMTP id s3-20020a05680810c300b003a744787139mr3312588ois.1.1692362068062;
        Fri, 18 Aug 2023 05:34:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeUJTpOhppxRJNpSQ1/EK6BqmcVwoNul+nCknL0eVkzyfIhQnU+enbvpUKDXbci+EE5ewm5g==
X-Received: by 2002:a05:6808:10c3:b0:3a7:4478:7139 with SMTP id s3-20020a05680810c300b003a744787139mr3312574ois.1.1692362067819;
        Fri, 18 Aug 2023 05:34:27 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k66-20020a633d45000000b0055fd10306a2sm1422604pga.75.2023.08.18.05.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 05:34:27 -0700 (PDT)
Date:   Fri, 18 Aug 2023 20:34:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Yuezhang Mo <Yuezhang.Mo@foxmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH v2] check: fix parsing expunge file with comments
Message-ID: <20230818123423.okbppe7iqqy26mg6@zlang-mailbox>
References: <20230814173132.767345-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814173132.767345-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 14, 2023 at 08:31:32PM +0300, Amir Goldstein wrote:
> commit 60054d51 ("check: fix excluded tests are only expunged in the
> first iteration") change to use exclude_tests array instead of file.
> 
> The check if a test is in expunge file was using grep -q $TEST_ID FILE
> so it was checking if the test was a non-exact match to one of the
> lines, for a common example: "generic/001 # exclude this test" would be
> a match to test generic/001.
> 
> The commit regressed this example, because the new code checks for exact
> match of [ "generic/001" == "generic/001 " ]. Change the code to match a
> regular expression to deal with this case and any other suffix correctly.
> 
> NOTE that the original code would have matched test generic/100 with lines
> like "generic/1000" when we get to 4 digit seqnum, so the regular
> expression does an exact match to the first word of the line.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Changes since v1:
> - Use regex for whole word match
> 
>  check | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 549725eb..71b9fbd0 100755
> --- a/check
> +++ b/check
> @@ -592,7 +592,9 @@ _expunge_test()
>  	local TEST_ID="$1"
>  
>  	for f in "${exclude_tests[@]}"; do
> -		if [ "${TEST_ID}" == "$f" ]; then
> +		# $f may contain traling spaces and comments
> +		local id_regex="^${TEST_ID}\b"
> +		if [[ "$f" =~ ${id_regex} ]]; then
>  			echo "       [expunged]"
>  			return 0
>  		fi
> -- 
> 2.34.1
> 


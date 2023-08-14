Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B473C001DB
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Aug 2023 14:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjHNOvM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Aug 2023 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbjHNOvF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Aug 2023 10:51:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDE810DE
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692024622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jfsLtxBikWhDlcdoWb4d+4R8oeeoO42qgcBWwlkALxs=;
        b=A5N8kA+IgaIvodCtUa43UQXFkq5l1+UulWzB8xteGTjlwP2sUMC+2g2XKkJ8N1u87zckGF
        3lB0am1KZSDYAHV3hni2slIKE6PCzTjApOINjqCb8bWiBx1uB4E5IOubOgDn11SBh47HNM
        PFrainlPdtNCpWm0ZHhnZ03XvB77uk8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-zLNJiT5TNbq_CpIK_OuRMA-1; Mon, 14 Aug 2023 10:50:20 -0400
X-MC-Unique: zLNJiT5TNbq_CpIK_OuRMA-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-26b2daf44c3so4186777a91.3
        for <fstests@vger.kernel.org>; Mon, 14 Aug 2023 07:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692024620; x=1692629420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfsLtxBikWhDlcdoWb4d+4R8oeeoO42qgcBWwlkALxs=;
        b=CKXCR3W8JmoFXmHCS1ODgXlL4sJmXEA3Xl8bWa3VoF0olZ8+LPM1T78wljFkz0N42b
         bOG/d2sCDC2aopq9b65gwYIfIhXGc2rw6Bo7m0UseKDBLDSRvzK81KuXvYH6C9NaDdDz
         NEIijcCvZIQ1vsw9gak7YsfwaOP9pLgb2NnPqBN38dsuxVMAbs9evCZBkQ3yhgsF+qcx
         Mw0UYhpExzSgAUc8IPXwBCrYb4sHzu35ygUFmzR7DsvQSxymUbCVttSNJ80F5a67qtOj
         rrXkHmaj/PpIDFwq5emnmFFEZgThKqyfPua8wUUxvCGhNt4RYyyhWF9F7+2pmzJ5qLgf
         DpSw==
X-Gm-Message-State: AOJu0YzHWysyuwpVhucaikfujT1DEVqX9xKIQjK5SPqhy/qXYonhQkBu
        zf86mx8fByxnI2sHV/J8SEru1RWLxQUVm63CcEa/BoklqGt01n0RFPVSfPlOMAy52RYU/pLfAqa
        RAC5JNeCssbaFP4/WdA==
X-Received: by 2002:a17:90b:144:b0:267:ffcf:e9e3 with SMTP id em4-20020a17090b014400b00267ffcfe9e3mr8775127pjb.46.1692024619802;
        Mon, 14 Aug 2023 07:50:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9D3W5tY7iwS/83LD4KC2z2GKMJuqf4+ugLo+e9LqUhNFn9PIjpEesItEiJfPtBVZvoqtMPw==
X-Received: by 2002:a17:90b:144:b0:267:ffcf:e9e3 with SMTP id em4-20020a17090b014400b00267ffcfe9e3mr8775117pjb.46.1692024619545;
        Mon, 14 Aug 2023 07:50:19 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 25-20020a17090a01d900b00263e4dc33aasm8413210pjd.11.2023.08.14.07.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 07:50:19 -0700 (PDT)
Date:   Mon, 14 Aug 2023 22:50:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH] check: fix parsing expunge file with comments
Message-ID: <20230814145015.6w6l2y7dxt4opvov@zlang-mailbox>
References: <20230813140950.678899-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813140950.678899-1-amir73il@gmail.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Aug 13, 2023 at 05:09:50PM +0300, Amir Goldstein wrote:
> commit 60054d51 ("check: fix excluded tests are only expunged in the
> first iteration") change to use exclude_tests array instead of file.
> 
> The check if a test is in expunge file was using grep -q $TEST_ID FILE
> so it was checking if the test was a non-exact match to one of the
> lines, for a common example: "generic/001 # exclude this test" would be
> a match to test generic/001.
> 
> The commit regressed this example, because the new code checks for exact
> match of [ "generic/001" == "generic/001 " ]. Change the code to use
> prefix match to deal with this case and any other suffix correctly.
> 
> While the original code would also match line "exclude test generic/001"
> I don't think that non-prefix match is a real use case.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  check | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index 549725eb..e8152f59 100755
> --- a/check
> +++ b/check
> @@ -592,7 +592,8 @@ _expunge_test()
>  	local TEST_ID="$1"
>  
>  	for f in "${exclude_tests[@]}"; do
> -		if [ "${TEST_ID}" == "$f" ]; then
> +		# $f may contain traling spaces and comments
> +		if [[ "$f" == ${TEST_ID}* ]]; then

We'll have seqnum with 4 numbers in one day, likes generic/1000. At that time,
generic/100[0-9] will match generic/100*. That's not what we want.

I think we'd better to do exact match, or better to match the end of a word,
for example

  local id_regex="^${TEST_ID}\b"
  if [[ "$f" =~ ${id_regex} ]];then
  ...

I think this will match "generic/100" and "generic/100 # xxxxx". But won't match
"generic/1001".

Thanks,
Zorro

>  			echo "       [expunged]"
>  			return 0
>  		fi
> -- 
> 2.34.1
> 


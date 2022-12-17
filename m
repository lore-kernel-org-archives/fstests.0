Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B213C4332F
	for <linux-fstests@archiver.kernel.org>; Sat, 17 Dec 2022 07:04:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiLQHEe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 17 Dec 2022 02:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiLQHEc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 17 Dec 2022 02:04:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5D12A738
        for <fstests@vger.kernel.org>; Fri, 16 Dec 2022 23:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671260623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXwkRCV2Lehr+PY5vASwViCRzQ5AnCpXqSZMZMs7CBA=;
        b=SA41JjA4sV7QdRE8WIrHGN+ehH+lkwMRNrdlzBTuqATmHJzJa1txpBnAWb3sFp9PPPpL6T
        UebCf72Xtn1aWkVTX0A2uzWGFPevyB4tFEX3rGXrSb7cJeDQYVDxVpdyIUvj4KXBFs8JEn
        BIZ6P/kizt8l12z46vjw09I/iaZ4p4o=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-gFvYR8k_PJKTKiumpoDP3g-1; Sat, 17 Dec 2022 02:03:35 -0500
X-MC-Unique: gFvYR8k_PJKTKiumpoDP3g-1
Received: by mail-pj1-f71.google.com with SMTP id om16-20020a17090b3a9000b002216006cbffso5343541pjb.3
        for <fstests@vger.kernel.org>; Fri, 16 Dec 2022 23:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXwkRCV2Lehr+PY5vASwViCRzQ5AnCpXqSZMZMs7CBA=;
        b=Bm582fMdZ2Sy4tFdbndrRohNkZSGY90f+HPARlwMqzowmTaYnrn1nGISVg2b+JTrtV
         D5g0gh8KkkILluxY2vBRa9WidN+H0Egx2l6SPGu7ZAfm/xSom4/aQL6IGDk6jFEeVqjF
         vBqPdP1oudt5w67KYEOAR7xlZSeFvKFa+fa+JhzCBDinfiSQPVog10OtRN4VD87yi5U7
         gERI2IoCjCQnDNDlkxqRmJNEZTDd8q5pajU4BB2aUt51vSbDN1o+L6w2grTWJqa/jFyU
         z9nwLSGm+Ug2Llv49NqcsAc5LBq5QYvvqGVTyTnS8w90mFYomvLopbyMiN4MaxR4rhlY
         6f4Q==
X-Gm-Message-State: ANoB5plv0TNr46KIOdQh43ROQ2hxOkzaCd8OXS2ZUnqAqgDgwznVJaCc
        6BXgBVSmxUvfV5EtkcMiXbp/OYV59nTn6zu3nlSz/PnNjZ65f00/gasfT2qzB4oXlMw9AiGxP7E
        bcKjuma8EhL/cIJMXYg==
X-Received: by 2002:a17:902:b087:b0:189:e81b:d25f with SMTP id p7-20020a170902b08700b00189e81bd25fmr34162611plr.56.1671260614824;
        Fri, 16 Dec 2022 23:03:34 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6+AOwgX7RwWHXJuhZlMKVDxvy7pxw5k37uKdVngnmh0+lpTJByajP0S6CGEsPYiYIEQz6rmg==
X-Received: by 2002:a17:902:b087:b0:189:e81b:d25f with SMTP id p7-20020a170902b08700b00189e81bd25fmr34162597plr.56.1671260614508;
        Fri, 16 Dec 2022 23:03:34 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id h11-20020a170902f54b00b00186ff402525sm2712006plf.213.2022.12.16.23.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 23:03:33 -0800 (PST)
Date:   Sat, 17 Dec 2022 15:03:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me
Subject: Re: [PATCH 4/4] fuzzy: don't fail on compressed metadumps
Message-ID: <20221217070329.holhjbwq6xcjrgsa@zlang-mailbox>
References: <167096070957.1750373.5715692265711468248.stgit@magnolia>
 <167096073394.1750373.2942809607367883189.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167096073394.1750373.2942809607367883189.stgit@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Dec 13, 2022 at 11:45:33AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This line in __scratch_xfs_fuzz_mdrestore:
> 
> 	test -e "${POPULATE_METADUMP}"
> 
> Breaks spectacularly on a setup that uses DUMP_COMPRESSOR to compress
> the metadump files, because the metadump files get the compression
> program added to the name (e.g. "${POPULATE_METADUMP}.xz").  The check
> is wrong, and since the naming policy is an implementation detail of
> _xfs_mdrestore, let's get rid of the -e test.
> 
> However, we still need a way to fail the test if the metadump cannot be
> restored.  _xfs_mdrestore returns nonzero on failure, so use that
> instead.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Looks good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/fuzzy |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> 
> diff --git a/common/fuzzy b/common/fuzzy
> index e634815eec..49c850f2d5 100644
> --- a/common/fuzzy
> +++ b/common/fuzzy
> @@ -156,10 +156,9 @@ __scratch_xfs_fuzz_unmount()
>  # Restore metadata to scratch device prior to field-fuzzing.
>  __scratch_xfs_fuzz_mdrestore()
>  {
> -	test -e "${POPULATE_METADUMP}" || _fail "Need to set POPULATE_METADUMP"
> -
>  	__scratch_xfs_fuzz_unmount
> -	_xfs_mdrestore "${POPULATE_METADUMP}" "${SCRATCH_DEV}" compress
> +	_xfs_mdrestore "${POPULATE_METADUMP}" "${SCRATCH_DEV}" compress || \
> +		_fail "${POPULATE_METADUMP}: Could not find metadump to restore?"
>  }
>  
>  __fuzz_notify() {
> 


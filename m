Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58339C61DA4
	for <linux-fstests@archiver.kernel.org>; Thu,  9 Feb 2023 15:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjBIPTI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjBIPTH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 9 Feb 2023 10:19:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582111A
        for <fstests@vger.kernel.org>; Thu,  9 Feb 2023 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675955902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWhspcrdA8JGurkoXO2AFlWlpIIswlVzwCA71sDnetc=;
        b=cshOMSakYJea5+OfHgkfkzDhHc+ZEMFg+zsvd5qf9KPMEBJ5KQ8dIapu5/rNp9iIGeXYw2
        ZIVa4w36WXFQV1UrydVufhg4ZJA31n17+SXXZli+iYqZKyIscah77eHoyZTWyQbg7K7R2v
        50+eWJUpY81W7BGrNNyic3jRkcuFOvY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-402-SiFMXxFJNraOUN45I-qFfw-1; Thu, 09 Feb 2023 10:18:20 -0500
X-MC-Unique: SiFMXxFJNraOUN45I-qFfw-1
Received: by mail-pl1-f199.google.com with SMTP id l1-20020a170903244100b0019a59370c75so1393252pls.7
        for <fstests@vger.kernel.org>; Thu, 09 Feb 2023 07:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWhspcrdA8JGurkoXO2AFlWlpIIswlVzwCA71sDnetc=;
        b=YkH6biaF8WmqEXFp4A4U6PYkapY+WUAyt8LREmd4q7oX3i+hKsePBXR+viGlRC1JcO
         WDxDQ7QipOfQdhGgZVCE8J4EQABTwQNC4/u/qZBUeht5q2ZCNjG2tz52rSDh1DIeG/xA
         +ftKXrtKnlMwznJowAQYtz51FfrRJX3vwWIEyMBqa+231TxzAmzfL/Uf5FII6QbZiI6/
         dx8kGtUSjoqXskaf+PXg3w4f/Jjwee4ArmT/vDJHalECODH4p4kMHu+wfnWQZvj0uxRC
         DnYYRi51SBJHynMUjZIK+CFFpmaE/Ck/al31aZMJD/Shmpjmj1oPS5AqOizE1GJf0qhX
         +rpQ==
X-Gm-Message-State: AO0yUKW08eAlZLIVlk25OJSXwpnVwAf1gJWwAEPPc8KdXhAHXPeKdsBP
        dlB1eryg/zX3HXoDXQq2DISIsCyVmhRfFkTCi97HRsMxjx+xYv/h/fs3KU+qtISSSJ/gtZkiOI2
        MPIew7I9Bw6AXBPpLtw==
X-Received: by 2002:a62:1a52:0:b0:58d:b8f8:5e2f with SMTP id a79-20020a621a52000000b0058db8f85e2fmr10098628pfa.10.1675955899889;
        Thu, 09 Feb 2023 07:18:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/9Ds8xuBbk1pI7fmEQ3mUavnNXjeFsr1s4AdVKL8UhDsNdsSOhxsGt+de/xrKMLXQ9EBiFng==
X-Received: by 2002:a62:1a52:0:b0:58d:b8f8:5e2f with SMTP id a79-20020a621a52000000b0058db8f85e2fmr10098607pfa.10.1675955899573;
        Thu, 09 Feb 2023 07:18:19 -0800 (PST)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0059242cd5469sm1626134pfn.13.2023.02.09.07.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:18:19 -0800 (PST)
Date:   Thu, 9 Feb 2023 23:18:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, shiina.hironori@gmail.com
Subject: Re: [PATCH] common/xfs: use whole-word matching for
 _require_xfsrestore_xflag
Message-ID: <20230209151815.tpyg4rvnv7bwersv@zlang-mailbox>
References: <Y+KDnDHVCKK07yzI@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+KDnDHVCKK07yzI@magnolia>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Feb 07, 2023 at 09:00:12AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> On my system, the path to the xfsrestore binary is:
> 
> /code/xfsdump/build-x86_64/restore/xfsrestore
> 
> The grep command in _require_xfsrestore_xflag matches on the "build-x86"
> part, even though my version of xfsrestore does not actually have a -x
> flag.  Fix the string parsing to match entire words so that we only look
> for -x in the help output.
> 
> (Maybe someone should patch xfsrestore -h to report basename(argv[0])
> instead of argv[0]...)
> 
> Fixes: 1ffa16c573 ("xfs: test for fixing wrong root inode number in dump")
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/xfs b/common/xfs
> index ba59889c3b..97c049e2ca 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -1529,7 +1529,7 @@ _xfs_filter_mkfs()
>  
>  _require_xfsrestore_xflag()
>  {
> -	$XFSRESTORE_PROG -h 2>&1 | grep -q -e '-x' || \
> +	$XFSRESTORE_PROG -h 2>&1 | grep -q -w -e '-x' || \
>  			_notrun 'xfsrestore does not support -x flag.'
>  }
>  
> 


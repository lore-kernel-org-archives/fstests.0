Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D56C433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 24 May 2022 16:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237648AbiEXQ7g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 24 May 2022 12:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239779AbiEXQ7g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 24 May 2022 12:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4BC6E6EC53
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 09:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653411574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b54mK8xYCAhXsjzahjRnSBRagXlWJQyhFWbgJ8hoi5w=;
        b=f8d6nYWI/f5juapLIv41B8NEcd+c3VcY1Df9WVtIPaJ9ncjPXOI9Ptgz5Hr0MzX6ZcBZrI
        WDkLLwfkoIRGeSS3ZUguIBZyHm8dmZlqelItEjcxFw7QeO+CpLDU3gnBa2bOxbwsGkhKhp
        1e8L4labOMYNb9b+sADv9i85YXY5180=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-udmrtF7vNhKYCrKcXf-t0w-1; Tue, 24 May 2022 12:59:32 -0400
X-MC-Unique: udmrtF7vNhKYCrKcXf-t0w-1
Received: by mail-qv1-f69.google.com with SMTP id dy10-20020ad44e8a000000b004625c7238edso1131095qvb.0
        for <fstests@vger.kernel.org>; Tue, 24 May 2022 09:59:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=b54mK8xYCAhXsjzahjRnSBRagXlWJQyhFWbgJ8hoi5w=;
        b=BEJsMhXhZpbF+BVOxqpO9B3UDpmKjDNCqCS5IJbZs4WepnwXsSNEPI2OV2Gyo664Vj
         85A5e6rX9UrK1q1F3APaDz+oWDk/E3MyjiN5/ZBp417aIH7j3MrbNRXTj3N7zNHfg0jq
         2M4SzDR0wcRXlU6BsTl5Nr+5aJQUnrEKh5cVDd8kfR4DSBx+847Na/Z3hUWYd807JVSJ
         stjYtjqS8+/RhV+dPRL55dx0+UpwnT9PQnNh6vchLeWsIwhSHywxT0qtfxM50vCQkXC4
         xvvFj5joY2AZoy1/Y/cTDHsnx26+T+Cm0PpjWylsteywd7RtzN+TI56Gdf034/bmQbKw
         ODEA==
X-Gm-Message-State: AOAM530/zg6923xSpTNiaON42BR47aqvHaeBUwEujNrjEopXHqV4s6Am
        lRlmkYn/Qtf1C11luM6ebzzFGDxbHmqnjqgrWwnatlJwsjYHVDRGQB2rGMnAiyZcXColjRphBNb
        Ymgo9zo4SjvGxrZJdOA==
X-Received: by 2002:a05:620a:b82:b0:6a3:9b26:d45 with SMTP id k2-20020a05620a0b8200b006a39b260d45mr6240288qkh.405.1653411572136;
        Tue, 24 May 2022 09:59:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPyK2cw49Zhkd3Nrx1cc7EK/KDdwr+rp6Aera4mFJx0isFVnaca45lMCeABPU1AAZM8KGS8A==
X-Received: by 2002:a05:620a:b82:b0:6a3:9b26:d45 with SMTP id k2-20020a05620a0b8200b006a39b260d45mr6240267qkh.405.1653411571864;
        Tue, 24 May 2022 09:59:31 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k12-20020a05620a138c00b0069fcc501851sm6179209qki.78.2022.05.24.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 09:59:31 -0700 (PDT)
Date:   Wed, 25 May 2022 00:59:26 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     =?utf-8?B?THXDrXM=?= Henriques <lhenriques@suse.de>
Cc:     fstests@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v2] ceph/001: skip metrics check if no copyfrom mount
 option is used
Message-ID: <20220524165926.dkighy46hi75mg6s@zlang-mailbox>
References: <20220524094256.16746-1-lhenriques@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220524094256.16746-1-lhenriques@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 24, 2022 at 10:42:56AM +0100, Luís Henriques wrote:
> Checking the metrics is only valid if 'copyfrom' mount option is
> explicitly set, otherwise the kernel won't be doing any remote object
> copies.  Fix the logic to skip this metrics checking if 'copyfrom' isn't
> used.
> 
> Signed-off-by: Luís Henriques <lhenriques@suse.de>
> ---
>  tests/ceph/001 | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> Changes since v1:
> - Quoted 'hascopyfrom' variable in 'if' statement; while there, added
>   quotes to the 'if' statement just above.

Good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> diff --git a/tests/ceph/001 b/tests/ceph/001
> index 7970ce352bab..060c4c450091 100755
> --- a/tests/ceph/001
> +++ b/tests/ceph/001
> @@ -86,11 +86,15 @@ check_copyfrom_metrics()
>  	local copies=$4
>  	local c1=$(get_copyfrom_total_copies)
>  	local s1=$(get_copyfrom_total_size)
> +	local hascopyfrom=$(_fs_options $TEST_DEV | grep "copyfrom")
>  	local sum
>  
> -	if [ ! -d $metrics_dir ]; then
> +	if [ ! -d "$metrics_dir" ]; then
>  		return # skip metrics check if debugfs isn't mounted
>  	fi
> +	if [ -z "$hascopyfrom" ]; then
> +		return # ... or if we don't have copyfrom mount option
> +	fi
>  
>  	sum=$(($c0+$copies))
>  	if [ $sum -ne $c1 ]; then
> 


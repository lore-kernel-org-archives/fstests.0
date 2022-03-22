Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83001C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 22 Mar 2022 12:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbiCVMVz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 22 Mar 2022 08:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiCVMVx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 22 Mar 2022 08:21:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A46C16D1BB
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647951624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ml5Wyh9lK0i95XVHZN4mud+3Otf/lNzb5i0mSIJTmJU=;
        b=MlE88q8xMBvOtXW5+YAb8D/d4erHxAdYoDWQuPOHfLNvn9XvwmDvhDbCM2fCc52bQ9W2Ib
        bUXHd3ubl7ZGTkzXFizg4NvQAhJkUX/2tt/w2dYCDVwJtuJSZ450HF1B4LI+I6QnVLpftk
        iFkBm8EZvBPqj9qBeiSxbhQh04tY9hI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-261-oHevQoMFOxCPA5dqhU7YXw-1; Tue, 22 Mar 2022 08:20:23 -0400
X-MC-Unique: oHevQoMFOxCPA5dqhU7YXw-1
Received: by mail-qv1-f72.google.com with SMTP id cl19-20020a05621404f300b0044103143211so8193061qvb.10
        for <fstests@vger.kernel.org>; Tue, 22 Mar 2022 05:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Ml5Wyh9lK0i95XVHZN4mud+3Otf/lNzb5i0mSIJTmJU=;
        b=RWz8eIop7kRDdzbtTcVzj+RyxkTnlhxru3Wky6DYpRRXrMV1vzdmEhEtBxRU/8Cl44
         o+/FXRCzZ4uUxRNyzU6vpNAyWjfBzljfwbriwNJ5Sn1KTtayR3ACIgJOjTKsJRishpEh
         IE2S+CRI5DMPAbWKAak6QnzJhKQecAbFd++JSx7hUn1M5qBEW48OTpyakHvqOCq/YMXG
         9hZGzWE5soVcN2Aeh8lKVAK90ZkPeLdZvWjTqooQowjSE87uIJmZorD7FBy/UdQMrEaR
         lrVf/FCzKB0ZMBwuEiSIIWuZ8lAqeqBQpz3mt9KsyOfZkzDklP6Z5qrTmHn6WLJKCsp1
         33Qw==
X-Gm-Message-State: AOAM531U72tl78s4myWXkJXgqhjJnSbqEg1iOSDB4bF5bYyozgQVMCat
        CySpGnMIAAOntp2Eas5aURqRNDfuChwZJl1APJgy+fW+ytVHoNwQ2HobA0Q6nFsAOPzwW98q0KG
        sDAPMhRtriAzo+IT2vQ==
X-Received: by 2002:ac8:5c09:0:b0:2e1:a64d:6f89 with SMTP id i9-20020ac85c09000000b002e1a64d6f89mr19782405qti.452.1647951622829;
        Tue, 22 Mar 2022 05:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/iaitxYmV69gcKzbiPMF5rrIuwDtb15LvasMDOzWF5d0Zvxut2JbC597FVUmtMNHGuujoAg==
X-Received: by 2002:ac8:5c09:0:b0:2e1:a64d:6f89 with SMTP id i9-20020ac85c09000000b002e1a64d6f89mr19782387qti.452.1647951622542;
        Tue, 22 Mar 2022 05:20:22 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id bm21-20020a05620a199500b0067d5e6c7bd8sm8865811qkb.56.2022.03.22.05.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 05:20:22 -0700 (PDT)
Date:   Tue, 22 Mar 2022 20:20:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests@vger.kernel.org, djwong@kernel.org,
        roman.penyaev@profitbricks.com
Subject: Re: [PATCH 1/2] xfstests: replace hexdump with od command
Message-ID: <20220322122015.7zd3qgdvvhmefa2y@zlang-mailbox>
Mail-Followup-To: Dave Chinner <david@fromorbit.com>,
        fstests@vger.kernel.org, djwong@kernel.org,
        roman.penyaev@profitbricks.com
References: <20220321110341.1323882-1-zlang@redhat.com>
 <20220321110341.1323882-2-zlang@redhat.com>
 <20220322052259.GC1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322052259.GC1609613@dread.disaster.area>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 22, 2022 at 04:22:59PM +1100, Dave Chinner wrote:
> On Mon, Mar 21, 2022 at 07:03:40PM +0800, Zorro Lang wrote:
> > The "od" is one of the most fundamental commands in GNU/Linux and
> > most Unix-like systems. So we nearly always can count on it, don't
> > need to check if it's installed.
> > 
> > The "hexdump" isn't such fundamental as "od", some systems don't
> > install it by default. And as "od" nearly can replace all functions
> > of "hexdump", so let's use an unified command "od" to do the hexdump
> > job in fstests cases.
> > 
> > Signed-off-by: Zorro Lang <zlang@redhat.com>
> 
> Looks good.
> 
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> 
> > ---
> > 
> > Hi,
> > 
> > As Dave and Darrick suggested, I did this change, I've tested most of cases,
> > except f2fs/001 and ceph/002, but I think they're good. And I used "od"
> > command directly in generic/404 and generic/042 for their special reason.
> 
> That generic/404 usage is ... strange. Why record md5sums of the
> encoded hexdump output of the file when you can just run md5sum on
> the file directly and get the same information?  i.e.
> 
> > diff --git a/tests/generic/404 b/tests/generic/404
> > index f1e8b0a8..939692eb 100755
> > --- a/tests/generic/404
> > +++ b/tests/generic/404
> > @@ -110,7 +110,7 @@ for (( block=3; block<=500; block++ )); do
> >  	# or blocks are in correct order, this commit:
> >  	#   2b3864b32403 ("ext4: do not polute the extents cache while shifting extents")
> >  	#
> > -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> > +	md5=`od -An -c $testfile | md5sum`
> >  	printf "#%d %s\n" "$block" "$md5"
> 
> Why isn't this just:
> 
> -	md5=`hexdump -e '16/1 "%_p" "\n"' $testfile | md5sum`
> -	printf "#%d %s\n" "$block" "$md5"
> +	echo -n "#$block "
> +	md5sum $testfile | _filter_test_dir

Yes, I thought about that too, but I can't be sure about it, so tried to keep
the logic of original code. If the original author doesn't have some special
reason, I'd like to change it as this way (cc roman.penyaev@profitbricks.com).

And for the generic/042:
-       if hexdump -v -e '/1 "%02X "' $file | grep -q "CD"; then
+       if od -An -tx1 -v $file | grep -q "CD"; then

I don't know what that "-v" option is needed (cc Darrick). I thought it might just
waste the time of grep running ?

> 
> Seperate patch, perhaps?

Sure, if no one object that, I'll change them in separated patch.

Thanks,
Zorro

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com
> 


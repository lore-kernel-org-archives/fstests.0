Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040B1FA3740
	for <linux-fstests@archiver.kernel.org>; Thu, 27 Oct 2022 12:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbiJ0MtU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 27 Oct 2022 08:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiJ0MtP (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Oct 2022 08:49:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A59716F424
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 05:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666874953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cHqvMwxRqRdRD6fhEnjExRRGq07E2A9r8/jZD1+Fv8Y=;
        b=Y+ODmrzv1o9aaryEyzeJAa6rCLHNn2xfaCI+zmm/jWCp/0fIzm+1qYfq/v7oUlZhhx3FBG
        /u2Cgk7Nch0jD7oYys9PtzS579OkhqGIxIgYnCMU16fPGH/OuBAxC8zCMMmBgmczsOKwvb
        5Sk4zg52x5m2qNoLhOIkn8JRmYuIFt4=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-153-kzockvZKMsC5lHk6XuAVWw-1; Thu, 27 Oct 2022 08:49:12 -0400
X-MC-Unique: kzockvZKMsC5lHk6XuAVWw-1
Received: by mail-pj1-f72.google.com with SMTP id nl16-20020a17090b385000b002138288fd51so123596pjb.6
        for <fstests@vger.kernel.org>; Thu, 27 Oct 2022 05:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cHqvMwxRqRdRD6fhEnjExRRGq07E2A9r8/jZD1+Fv8Y=;
        b=QH/ppsc2jaYW0v301312MMpEwlcxAu+y9OZgErgARu/pChu0ApvdyaQ4tl3dcgQbTM
         yLvD8pXbmdd6Uj1b432Iuos3r9+OnDFuLJNwJbIKnImrFEkvqkuQhqPsxVcWitxpiOvO
         gCs4pRHaDsvoCiIQvHK2nPGGhmnLeawNC9U3FED6hC3CBzC7Ovb4u7YKjwm3v9Tjv+AX
         rhmDBINlCHXJN72WOl2Apg6AYN2N4tzRYQAv86zBS5QyTcID6J64EsDUYUNvKguoQdhY
         i5xH/L5ykyluSB8Fehhk85YQwBs3yB7Fl2gfoDmz5iwgc6z+tCzNuyAyXAMzdYqAQfxj
         oThA==
X-Gm-Message-State: ACrzQf1fHHtlMmJUW8ehlG3Cgx4JtGgouz6A2FRDhQnM7iuPfQ7knhzh
        8tKSE4SVKVoq/2Tg5iDz/hrzCudW562PwZdRV18R3SqMU0N5yE75PDgxUSv+KeyJARxMTL2rl8e
        RGz+rBoG5qE8VQZ0I1Q==
X-Received: by 2002:aa7:94b1:0:b0:56c:8da8:4e3 with SMTP id a17-20020aa794b1000000b0056c8da804e3mr4133618pfl.62.1666874951250;
        Thu, 27 Oct 2022 05:49:11 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4BjVbAuCIJjG2mfjadC4PhqrAigrSHZs2aTxvBOrojc11nh9kg5IOgvPJ31z+dghdvh28emw==
X-Received: by 2002:aa7:94b1:0:b0:56c:8da8:4e3 with SMTP id a17-20020aa794b1000000b0056c8da804e3mr4133593pfl.62.1666874950919;
        Thu, 27 Oct 2022 05:49:10 -0700 (PDT)
Received: from zlang-mailbox ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001866049ddb1sm1153608plf.161.2022.10.27.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 05:49:10 -0700 (PDT)
Date:   Thu, 27 Oct 2022 20:49:04 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Xiubo Li <xiubli@redhat.com>
Cc:     fstests@vger.kernel.org, david@fromorbit.com, djwong@kernel.org,
        lhenriques@suse.de, ceph-devel@vger.kernel.org, jlayton@kernel.org,
        mchangir@redhat.com
Subject: Re: [PATCH v2] encrypt: add ceph support
Message-ID: <20221027124904.ibx62eqbyyqghdjm@zlang-mailbox>
References: <20221027030021.296548-1-xiubli@redhat.com>
 <20221027032023.6arvnrkl7fymdjqj@zlang-mailbox>
 <e5c876ce-8f0d-c51e-bb04-78c49ebf79c9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5c876ce-8f0d-c51e-bb04-78c49ebf79c9@redhat.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Oct 27, 2022 at 05:49:08PM +0800, Xiubo Li wrote:
> 
> On 27/10/2022 11:20, Zorro Lang wrote:
> > On Thu, Oct 27, 2022 at 11:00:21AM +0800, xiubli@redhat.com wrote:
> > > From: Xiubo Li <xiubli@redhat.com>
> > > 
> > > Signed-off-by: Xiubo Li <xiubli@redhat.com>
> > > ---
> > >   common/encrypt | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/common/encrypt b/common/encrypt
> > > index 45ce0954..1a77e23b 100644
> > > --- a/common/encrypt
> > > +++ b/common/encrypt
> > > @@ -153,6 +153,9 @@ _scratch_mkfs_encrypted()
> > >   		# erase the UBI volume; reformated automatically on next mount
> > >   		$UBIUPDATEVOL_PROG ${SCRATCH_DEV} -t
> > >   		;;
> > > +	ceph)
> > > +		_scratch_cleanup_files
> 
> Here I just skip ceph and it is enough. Because the
> _require_scratch_encryption() will do the same thing as I did in my V1's 2/2
> patch.

Great, actually that's what I hope to know. So the ceph encryption testing
can be supported naturally by just enabling ceph in _scratch_mkfs_encrypted.

And from the testing output you showed in last patch, it looks good on testing
ceph encryption. So I think this patch works as expected. I'll merger this
patch if no more review points from ceph list. And feel free to improve cases
in encrypt group later if someone fails on ceph.

Thanks,
Zorro

> 
> - Xiubo
> 
> > > +		;;
> > Any commits about that?
> > 
> > Sorry I'm not familar with cephfs, is this patch enough to help ceph to test
> > encrypted ceph? Due to you tried to do some "checking" job last time.
> > 
> > Can "./check -g encrypt" work on ceph? May you paste this test result to help
> > to review? And welcome review points from ceph list.
> > 
> > Thanks,
> > Zorro
> > 
> > [1]
> > $ grep -rsn _scratch_mkfs_encrypted tests/generic/
> > tests/generic/395:22:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/396:21:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/580:23:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/581:36:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/595:35:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/613:29:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/621:57:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/429:36:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/397:28:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/398:28:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/421:24:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/440:29:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/419:29:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/435:33:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/593:24:_scratch_mkfs_encrypted &>> $seqres.full
> > tests/generic/576:34:_scratch_mkfs_encrypted_verity &>> $seqres.full
> > 
> > >   	*)
> > >   		_notrun "No encryption support for $FSTYP"
> > >   		;;
> > > -- 
> > > 2.31.1
> > > 
> 


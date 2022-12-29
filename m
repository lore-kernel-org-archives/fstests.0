Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136D4C4332F
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Dec 2022 16:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiL2Qdi (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Dec 2022 11:33:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiL2Qdh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Dec 2022 11:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB0D11C26
        for <fstests@vger.kernel.org>; Thu, 29 Dec 2022 08:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672331569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qIrbQx5F/1RxpR2diUjM6XVDss325lOf5CffCy3YMeY=;
        b=HOQO+lP3EUtv0bro+XsRwaaagzJvr5m7GyS4n0XunS/e2mkLA6XzaeXDTELShqUtwWmnrf
        aI9lVp8qrw392D1HNQQEUeuFb5c2kmZSEkskhNh1tSsPL260xOuMxyzPsetqETUeWKcJ8H
        oLJ7Vj7jh3jIy1X2WpuKNWeXBMWTX+Y=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-231-rJhvfrwCMOWz0dkZ-vlLYw-1; Thu, 29 Dec 2022 11:32:32 -0500
X-MC-Unique: rJhvfrwCMOWz0dkZ-vlLYw-1
Received: by mail-pl1-f199.google.com with SMTP id l17-20020a170902f69100b001928d6b3efcso5125591plg.2
        for <fstests@vger.kernel.org>; Thu, 29 Dec 2022 08:32:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIrbQx5F/1RxpR2diUjM6XVDss325lOf5CffCy3YMeY=;
        b=iH3NUDQtBIdSeB5BChvqFXMB5QwNrkEAEtO6/miXlXXkS4LYC7G7uY/JUI2+S+b0Nt
         lb1igGLxnTvN8ipLPrOmSaMjmg2loA+h9Et7NyVxCjIzSrIpK7Ahvl/xjH11vraXjqJI
         x5CvMWTl4mHO1MsKedsKU174QQN7UYcaEbaqfMhVwFVqTQ7E5WpMeunxNr5ARscix5PH
         CjIokHj5c/u6p5VlAAUutNbk9WXcJrLdOfKce916oJsIYwEsj9Egj+ieOeaDq1qB65BL
         DXfsn4F3YJDm8qOyJzpe8BbmweRf47W0yTj/mhVAZ2/ZOsug9AUNgrvn0Z21U2BbDZ37
         p1FA==
X-Gm-Message-State: AFqh2kqpF/Nc/1v7x8s5YRlEaeJJ0oLcI3c6J9MSuabFIXNybB9T5jvi
        DPe/l9TgL4C57XspGW7nRA+nLUnAgY7+VjpTgRjt8mH+VXk74lzGagYHwPPWEvh7ddAb4ONMEcy
        1V1MU0mqbquwpnq0X7w==
X-Received: by 2002:a17:902:9b90:b0:192:8cd1:5e79 with SMTP id y16-20020a1709029b9000b001928cd15e79mr9924946plp.41.1672331541055;
        Thu, 29 Dec 2022 08:32:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsi6SEMhZp8y+IUR/NN9RdPeWOGqJFicBfVRJ8QotxARHFLlJiTpBDsjgLLJdNElFEEDTNT1w==
X-Received: by 2002:a17:902:9b90:b0:192:8cd1:5e79 with SMTP id y16-20020a1709029b9000b001928cd15e79mr9924921plp.41.1672331540632;
        Thu, 29 Dec 2022 08:32:20 -0800 (PST)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903404d00b00189ec622d23sm13217146pla.100.2022.12.29.08.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 08:32:20 -0800 (PST)
Date:   Fri, 30 Dec 2022 00:32:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v2 08/10] generic/574: test multiple Merkle tree block
 sizes
Message-ID: <20221229163215.zpwgul6faq2rhpay@zlang-mailbox>
References: <20221223010554.281679-1-ebiggers@kernel.org>
 <20221223010554.281679-9-ebiggers@kernel.org>
 <20221225124600.faouh6a7suhq2wuu@zlang-mailbox>
 <Y6kvXs33MmxVovNO@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6kvXs33MmxVovNO@sol.localdomain>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, Dec 25, 2022 at 09:21:34PM -0800, Eric Biggers wrote:
> On Sun, Dec 25, 2022 at 08:46:00PM +0800, Zorro Lang wrote:
> > > +	# Reading the full file via mmap should fail.
> > >  	bash -c "trap '' SIGBUS; $XFS_IO_PROG -r $fsv_file \
> > >  		-c 'mmap -r 0 $page_aligned_eof' \
> > > -		-c 'mread 0 $file_len'" |& filter_sigbus
> > > +		-c 'mread 0 $file_len'" >/dev/null 2>$tmp.out
> > > +	if ! grep -q 'Bus error' $tmp.out; then
> > > +		echo "Didn't see SIGBUS when reading file via mmap"
> > 
> > Hmm... will sigbus error really be output to stderr? From a testing, the
> > generic/574 fails as:
> > 
> > # ./check -s simpledev generic/574
> > SECTION       -- simpledev
> > FSTYP         -- ext4
> > PLATFORM      -- Linux/x86_64 xx-xxxxxx-xxx 6.1.0-rc3 #5 SMP PREEMPT_DYNAMIC Tue Nov  1 01:08:52 CST 2022
> > MKFS_OPTIONS  -- -F /dev/sdb
> > MOUNT_OPTIONS -- -o acl,user_xattr -o context=system_u:object_r:root_t:s0 /dev/sdb /mnt/scratch
> > 
> > generic/574       - output mismatch (see /root/git/xfstests/results//simpledev/generic/574.out.bad)
> >     --- tests/generic/574.out   2022-12-25 20:02:41.609104749 +0800
> >     +++ /root/git/xfstests/results//simpledev/generic/574.out.bad       2022-12-25 20:21:57.430719504 +0800
> >     @@ -1,6 +1,32 @@
> >      QA output created by 574
> >      
> >      # Testing block_size=FSV_BLOCK_SIZE
> >     +/root/git/xfstests/tests/generic/574: line 69: 1949533 Bus error               (core dumped) bash -c "trap '' SIGBUS; $XFS_IO_PROG -r $fsv_file            -c 'mmap -r 0 $page_aligned_eof'               -c 'mread 0 $file_len'" > /dev/null 2> $tmp.out
> >     +Didn't see SIGBUS when reading file via mmap
> 
> This test passes for me both before and after this patch series.
> 
> Both before and after, the way this is supposed to work is that in:
> 
> 	bash -c "trap '' SIGBUS; command_that_exits_with_sigbus"
> 
> ... bash should print "Bus error" to stderr due to
> 'command_that_exits_with_sigbus'.  That "Bus error" is then redirected.  Before
> it was redirected to a pipeline; after it is redirected to a file.
> 
> I think what's happening is that the version of bash your system has is not
> forking before exec'ing 'command_that_exits_with_sigbus'.  As a result, "Bus
> error" is printed by the *parent* bash process instead, skipping any redirection
> in the shell script.
> 
> Apparently skipping fork is a real thing in bash, and different versions of bash
> have had subtly different conditions for enabling it.  So this seems plausible.
> 
> Adding an extra command after 'command_that_exits_with_sigbus' should fix this:
> 
> 	bash -c "trap '' SIGBUS; command_that_exits_with_sigbus; true"

Thanks for this explanation, I think you're right!

I'm not sure if it's a bug of bash. If it's not a bug, I think we can do this
change (add a true) to avoid that failure. If it's a bug, hmmm..., I think we'd
better to avoid that failure too, due to we don't test for bash :-/

How about your resend this single patch (by version 2.1), to fix this problem.
Other patches looks good to me, I'd like to merge this patchset this weekend.

Thanks,
Zorro

> 
> The joy of working with a shell scripting system where everyone has different
> versions of everything installed...
> 
> - Eric
> 


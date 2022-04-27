Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115DBC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 17:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238449AbiD0RWq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 13:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234530AbiD0RWp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 13:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F090443E5
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 10:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651079971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y5+61Xho4ruc/mGDpb6uPTGctxk7ATFvHl1w70e5hFQ=;
        b=NERVnE9T4YF7BeXBCOuU/GDDKKtywRODcMYIUtDKLLuUAwQecKFFhcgzECvtdqyUqZcIFd
        Y2XVCXhEoYnbnk5kkc9CgXOevog7o884Q7us7XAk7o94nyijiOOQbOsoFZD325mX8WAizM
        +maMjdXsPRtRednzvaLtFGHdMU4GgZA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-442-KotmY17TPJOuzFWUOZ6xsA-1; Wed, 27 Apr 2022 13:19:30 -0400
X-MC-Unique: KotmY17TPJOuzFWUOZ6xsA-1
Received: by mail-qk1-f200.google.com with SMTP id u129-20020a372e87000000b0069f8a79378eso1595949qkh.5
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 10:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=y5+61Xho4ruc/mGDpb6uPTGctxk7ATFvHl1w70e5hFQ=;
        b=p7TMRTT1g0wZt7P7Pazot0Juh+NhrTY+wZ9rjP8NH9XMP5bau5FCgWSfo8yoiKk/UI
         sm0ZQWsapfh6XJhcY+BbyiGg0yc/zt2tkTJFRflqWCmiNAeqq/wvZOPoP5er4RoscdkF
         +FhMjKrLaJi9R/JEoPWkKvpCUlyAU+hCmXxygV6G6Wa7fV5QcbSu2VkEeqZ6bSYnI6Oh
         1bQRJSRUvb97A74G3jYg/oW9brmKOuo/5hb/dYG7WQ8ML+TSeKBr861K6s+ECuNE3QJc
         lY/X/6LslTQgSCfNy+jZXgcrQpZKB5+klgxglZZ6aFTLsjUvdg/t+HBRXERmtzAONGj2
         /yOw==
X-Gm-Message-State: AOAM532TIPa5SQ4gHW/G4HYmvsJTVAZiiXmM4gCeyeHRg7xv80HmrrOn
        7e80Kmfqasm2u2LXgLR5v7xePwFzUXzaOpua/xrtaaeKO5JAVN+hkhzJSsIBlRuI1/6uisFRTQr
        hU61i6JjrRxUfi5LLrw==
X-Received: by 2002:ad4:5bc7:0:b0:44c:57f4:207c with SMTP id t7-20020ad45bc7000000b0044c57f4207cmr20582633qvt.2.1651079969377;
        Wed, 27 Apr 2022 10:19:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzScr5ywRfDMSwSnYERGH1fJlYGy4WBKGRGEQpOw3Vbwve0jd/EePxavXGUfyVvuu20Z3iVvA==
X-Received: by 2002:ad4:5bc7:0:b0:44c:57f4:207c with SMTP id t7-20020ad45bc7000000b0044c57f4207cmr20582617qvt.2.1651079969099;
        Wed, 27 Apr 2022 10:19:29 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id g4-20020ac87d04000000b002e06b4674a1sm10896850qtb.61.2022.04.27.10.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 10:19:28 -0700 (PDT)
Date:   Thu, 28 Apr 2022 01:19:23 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <20220427171923.ab2duujwkljyatyv@zlang-mailbox>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org
References: <20220427005209.4188220-1-tytso@mit.edu>
 <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
 <YmlY5NhDodhRRpkU@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmlY5NhDodhRRpkU@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 27, 2022 at 10:53:24AM -0400, Theodore Ts'o wrote:
> On Wed, Apr 27, 2022 at 04:05:40PM +0800, Zorro Lang wrote:
> > 
> > "The DAX code currently only supports files with a block size equal to your
> > kernel's PAGE_SIZE" [1], so I suppose any cases with smaller blocksize (< pagesize)
> > should "_exclude_scratch_mount_option dax".
> > 
> > And if this supposition is right, we'd better do "skipping dax testing if blocksize
> > is less than pagesize" in a common helper. Good news is we have _scratch_mkfs_blocksized.
> > So how about do:
> >   if [ $blocksize < $pagesize ];then
> >       _exclude_scratch_mount_option dax
> >   fi
> > in _scratch_mkfs_blocksized? then let ext4/054 and ext4/055 turn to use _scratch_mkfs_blocksized.
> 
> That's a good thing to and it would work for ext4/054 and ext/022
> (which already uses "_exclude_scratch_mount_option dax" and
> "_scratch_mkfs").  However, a number of other tests, including
> ext4/055 and ext4/035 need to give additional parameters to mfks, such
> as "-O quota" or "-E resize=262144".
> 
> So _scratch_mkfs_blocksized isn't always going to work for tests in
> ext4/* where we often are passing ext4-specific mkfs options to
> mkfs.ext4.
> 
> So I can add your suggestion to _scratch_mkfs_blocksized, and use that
> for ext4/054, but it's not going to be a solution for ext4/055.

I just noticed that _scratch_mkfs_sized() and _scratch_mkfs_blocksized() both use
_scratch_mkfs_xfs for XFS, I'm wondering if ext4 would like to use _scratch_mkfs_ext4()
or even use _scratch_mkfs() directly in these two functions. Then you can do something
likes:
  MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota"
  _scratch_mkfs_blocksized 1024
or:
  MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota" _scratch_mkfs_blocksized 1024

Hmm... that might look a little ugly... it's doesn't matter if we write as:
  _exclude_scratch_mount_option dax
  _scratch_mkfs "-F -O quota -b 1024"

We just provide a helper to avoid someone forget 'dax', I don't object someone would
like to "exclude dax" by explicit method :) So if you don't have much time to do this
change, you can just do what you said above, then I'll take another time/chance to
change _scratch_mkfs_* things.

Maybe we should think about let all _scratch_mkfs_*[1] helpers use _scratch_mkfs
consistently. But that will change and affect too many things. I don't want to break
fundamental code too much, might be better to let each fs help to change and test
that bit by bit, when they need :)

Thanks,
Zorro


$ grep -rs _scratch_mkfs_.*() common/
common/casefold:_scratch_mkfs_casefold()
common/casefold:_scratch_mkfs_casefold_strict()
common/encrypt:_scratch_mkfs_encrypted()
common/encrypt:_scratch_mkfs_sized_encrypted()
common/encrypt:_scratch_mkfs_stable_inodes_encrypted()
common/verity:_scratch_mkfs_verity()
common/verity:_scratch_mkfs_encrypted_verity()
common/rc:_scratch_mkfs_options()
common/rc:_scratch_mkfs_sized()
common/rc:_scratch_mkfs_geom()
common/rc:_scratch_mkfs_blocksized()
common/rc:_scratch_mkfs_richacl()

> 
> Cheers,
> 
> 						- Ted
> 


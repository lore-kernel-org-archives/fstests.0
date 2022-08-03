Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7ECC19F28
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 10:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbiHCKkt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 06:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHCKkk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 06:40:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C0A21EC46
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 03:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659523235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=etycXZPf8C4SdNrwhjIFGKHUULXdQ66/YxDMBqyN+sA=;
        b=XxOi/X/81ImpP56RlAf2I1T24aFAsSDk0F0HPaNsqj6UVS2MhaxLB1Ex/tzzuRyCXDT4uL
        zLHzweyTqEFQlw7VxnQSMJ6v+BVcSWvPZcLKggMUneGjAQhsuLKuFtKSLVe/R8lv05ZwrB
        PhAZsDGI2msUV53z96mLYaNSMEp3LRg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-jb7NjB6gOiy8l7ur9Yt-iQ-1; Wed, 03 Aug 2022 06:40:34 -0400
X-MC-Unique: jb7NjB6gOiy8l7ur9Yt-iQ-1
Received: by mail-qk1-f199.google.com with SMTP id n15-20020a05620a294f00b006b5768a0ed0so13169249qkp.7
        for <fstests@vger.kernel.org>; Wed, 03 Aug 2022 03:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=etycXZPf8C4SdNrwhjIFGKHUULXdQ66/YxDMBqyN+sA=;
        b=PMRavN/yNRRdp0A91erVc9Bl2AEMGLuMima5kfYfU01Bj4ifC6W+MsBVUUYfDM58Sv
         uYnN4i792/i6c8xFFsXu2/5nlCu32WYrQR1h5dAWX4TSgNEa0wnwIdX52RBc8A7Jht5H
         teppeS+Rmbfyck5K9ah57kyde5TxZs76OzoxgvDDSLiQOUfe1ZJUx1aDbp9WKLlUfTO4
         FQvUTbdesLQ6Mn0YBIOj0LJwkGaSu9n3/PIPtVb2u1pQLTM8dSLETiyejw4kJ9YjUv/J
         IXv3S1uiiQWmrUbVtwRlORfGIVOuNh/pLGLCYvq/sFsassSnXZKeFT3Og19Jx8AOJgc4
         l2Zg==
X-Gm-Message-State: AJIora9bRYy+kILJam9Qbuu4QP7cHyTv01Km8WtwLKjwC7G3eQODFDz2
        H2q6US62WdMn+TEGe5Sx8qCz5iYvagh65ppBVK2db2bQwADLAcA03RxcrG/1ljdvIYazS3HbAPL
        8y1DWKTaeRNAhMa+7hw==
X-Received: by 2002:a05:620a:c52:b0:6b5:467f:4f6d with SMTP id u18-20020a05620a0c5200b006b5467f4f6dmr18334461qki.503.1659523233995;
        Wed, 03 Aug 2022 03:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vmKZvlo5ut3bnxCr2rTna7DHBYSH0uXGXSuhnMNqylWlW1cDAs7qxvqi8n6ZmnPQpmPW8hDQ==
X-Received: by 2002:a05:620a:c52:b0:6b5:467f:4f6d with SMTP id u18-20020a05620a0c5200b006b5467f4f6dmr18334453qki.503.1659523233735;
        Wed, 03 Aug 2022 03:40:33 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j10-20020a05620a410a00b006a65c58db99sm11965299qko.64.2022.08.03.03.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 03:40:33 -0700 (PDT)
Date:   Wed, 3 Aug 2022 18:40:27 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     "liuyd.fnst@fujitsu.com" <liuyd.fnst@fujitsu.com>
Cc:     Zorro Lang <zlang@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "djwong@kernel.org" <djwong@kernel.org>
Subject: Re: [PATCH] generic/688: Skip test if fs doesn't support security
Message-ID: <20220803104027.c5nme65zgwzccut5@zlang-mailbox>
References: <1659426760-2-1-git-send-email-liuyd.fnst@fujitsu.com>
 <20220802091700.d2e3u7defue7kwbd@zlang-mailbox>
 <4e39344d-bc71-1b6b-f23e-07627c76a983@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e39344d-bc71-1b6b-f23e-07627c76a983@fujitsu.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 03, 2022 at 06:48:47AM +0000, liuyd.fnst@fujitsu.com wrote:
> Hi Zorro
> 
> On 8/2/22 17:17, Zorro Lang wrote:
> > On Tue, Aug 02, 2022 at 07:52:40AM +0000, Liu Yiding wrote:
> >> This test require security attr. Skip test if fs doesn't support
> >> security attr. E.g. virtiofs
> >>
> >> Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
> >> ---
> > 
> > Hmm... looks like we can re-start this discussion long time ago:
> > 
> > https://lore.kernel.org/fstests/20220323023845.saj5en74km7aibdx@zlang-mailbox/
> > 
> > About how can we deal with those fs doesn't support capabilities, e.g. nfs, virtiofs??
> 
> Ahh, so I don't need to send a v2 patch until you finish above discussion.

Actually I'm not sure if we need a _require_capabilities(), or just use
"_require_attrs security" for all filesystems which support/unsupport
capabilities. Hope to hear more points.

If you'd like to send v2, there's not only g/688 need capabilities.

Thanks,
Zorro

> 
> > 
> > Thanks,
> > Zorro
> > 
> >>   tests/generic/688 | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/tests/generic/688 b/tests/generic/688
> >> index 426286b6..d11b4c21 100755
> >> --- a/tests/generic/688
> >> +++ b/tests/generic/688
> >> @@ -7,6 +7,7 @@
> >>   # Functional test for dropping capability bits as part of an fallocate.
> >>   #
> >>   . ./common/preamble
> >> +. ./common/attr
> >>   _begin_fstest auto prealloc quick
> >>   
> >>   # Override the default cleanup function.
> >> @@ -28,6 +29,7 @@ _require_command "$GETCAP_PROG" getcap
> >>   _require_command "$SETCAP_PROG" setcap
> >>   _require_xfs_io_command falloc
> >>   _require_test
> >> +_require_attrs security
> >>   _require_congruent_file_oplen $TEST_DIR 65536
> >>   
> >>   junk_dir=$TEST_DIR/$seq
> >> -- 
> >> 2.34.1
> >>


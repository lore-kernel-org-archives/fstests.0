Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CCC7C19F2B
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Aug 2022 09:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbiHDJKl (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Aug 2022 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiHDJKj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Aug 2022 05:10:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7241B9FE6
        for <fstests@vger.kernel.org>; Thu,  4 Aug 2022 02:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659604237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VjiO2BvVm8N1TZMdUjFyMFIx6VGo5fG70lfYk20hEkc=;
        b=Xyk9iUQiSi60CGqLB6AF0QBO6JZ0Wfi6a41bkhsjN1CUeNleCQNteUkTZNLbjXlufbPJu9
        VZeCQiU1+BqlEo2WuZ93TLPcAdkBRBmmzph6gxjzJBI0CNNVhCR2WAMry3CfIwGySEfMzB
        HQcxDTX2VazLThckyjJmj4VNjeuWAT0=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-G75-ctqfNxCDleNVEoN86w-1; Thu, 04 Aug 2022 05:10:36 -0400
X-MC-Unique: G75-ctqfNxCDleNVEoN86w-1
Received: by mail-pj1-f69.google.com with SMTP id o6-20020a17090ab88600b001f30b8c11c5so2569494pjr.2
        for <fstests@vger.kernel.org>; Thu, 04 Aug 2022 02:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VjiO2BvVm8N1TZMdUjFyMFIx6VGo5fG70lfYk20hEkc=;
        b=s6Xa9Vsfk2J3LBzaL3W4hemhWIyp0h3b6UIDUdIlMP+t0HmX7vtW9lvH03DtwF4kSD
         5RH+7a8/cs0OL/q03dSCdlXymPYZQBjWGC35v44zeDaHkMnKzJUV7PLySHsEa4kAKa9x
         ug4NzWNCwTd2VKOCsWJxI0eilct1+AMxjXEOFMxZp3ajY1LiXDgOrSIAscuNcPqTPjOp
         QRFdzqKJ50Pe7pTcqp4pAdQe1rgHh6ocNJ+Gp/55UwirMT8AkHHfPW7scWyyvPvGqJaH
         L5ulhOeAU/fwN2ouQMseqlRdiIZDOp+bvkiD0gxNUbq4yBdcRwql1FpBeqfAT+/1XST7
         NXCg==
X-Gm-Message-State: ACgBeo0pI8fzZizsR4VX4hsITzMA9SxhlXyBsN6dCH95pnjbFOtcpUyv
        FnzXZnhO0cuRF3JddgrvSJ/T/mIkfUcRwg7fwzQ2QPu6B07U+44iiJmvqcphMBsCW5fKglaTC9v
        NLO0ViiWqjj0C4VmAFg97AHDIz7wvCldo2Q==
X-Received: by 2002:a63:4847:0:b0:419:c8f4:4f88 with SMTP id x7-20020a634847000000b00419c8f44f88mr823027pgk.603.1659604235123;
        Thu, 04 Aug 2022 02:10:35 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7AGjrVABKZDJJmwgoZmBPok26v2YjmajbiOBn9mycI0DX1kOZ3BEKkQmidz1snudcu+5EWuQD37WmVA6CTiLc=
X-Received: by 2002:a63:4847:0:b0:419:c8f4:4f88 with SMTP id
 x7-20020a634847000000b00419c8f44f88mr823010pgk.603.1659604234765; Thu, 04 Aug
 2022 02:10:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220721022959.4189726-1-bxue@redhat.com> <YtjYxyhVmSPzzFoH@magnolia>
 <CAHLe9YaAVyBmmM8T27dudvoeAxbJ_JMQmkz7tdM1ZLnpeQW4UQ@mail.gmail.com>
 <Ytk7t0am8H4x2BbS@mit.edu> <YtlcwZ/66pJhpdiS@mit.edu> <E5C39D1E-3DB4-467A-8C6D-6630A2ADE97E@oracle.com>
 <6C27EF62-B619-4451-9CBC-B21CEC72F66D@oracle.com> <YtmVH8HNHHxVUyoM@mit.edu>
 <75AAE413-4142-45F2-BE8A-7A7867CC0DA4@oracle.com> <YtoJElcucHMtIYQT@mit.edu>
In-Reply-To: <YtoJElcucHMtIYQT@mit.edu>
From:   Boyang Xue <bxue@redhat.com>
Date:   Thu, 4 Aug 2022 17:10:23 +0800
Message-ID: <CAHLe9Ya7kS1FtOWZ0B9Arn2XwyxiVMK23rBQTEWARTfLAMy6oQ@mail.gmail.com>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Thank you everyone for the review and suggestions! Yes it's a real bug
rather than a test flaw, so we should fix the kernel code instead.

Jeff has posted a patchset to linux-nfs@ , and I have done testing
against the patchset. The results are all good. generic/476 would
complete within 30 mins typically in both localhost and multi-host
configurations. Please check out the link for the patchset:

https://www.spinics.net/lists/linux-nfs/msg92009.html

Thanks,
Boyang

On Fri, Jul 22, 2022 at 10:19 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Jul 21, 2022 at 06:13:48PM +0000, Chuck Lever III wrote:
> >
> > I agree that Q/A and dev testing needs are distinct, so a dev might
> > have a simpler series of tests to run and fewer resources to run them
> > in.
> >
> > That said, I've had it on my to-do list for some time to find an easy
> > way to run automated multi-host tests, and I've been told it should be
> > straight-forward, but I've been swamped lately.
>
> Yeah, in a cloud or VM environment it shouldn't be *that* hard.
> Especially for cloud setup, it's just a matter of launching another
> cloud VM with a metadata flag that says, "please provide an NFS server
> using the specified file system as the backing store", noting the IP
> address, and then passing it to the client VM.  The only slightly
> tricky part is that monitoring and saving the serial console of the
> server as a test artifact in case of an oops or triggers a BUG or
> WARN_ON.
>
> Unfortunately, like you, I've been swamped lately.  :-/
>
> > Many of us in the NFS community actually don't run the tests that
> > require a scratch dev, because many of them don't seem relevant to
> > NFS, or they take a long time to run. Someday we should sort through
> > all that :-)
>
> It doesn't take *that* long.  In loopback mode, as well as using the
> GCE Filestore Basic product as the remote NFS server, it takes between
> 2.5 and 3 hours to run the auto group with the test and scratch device
> sized to 5GB:
>
> nfs/filestore: 785 tests, 3 failures, 323 skipped, 9922 seconds
>   Failures: generic/258 generic/444 generic/551
> nfs/loopback: 814 tests, 2 failures, 342 skipped, 9364 seconds
>   Failures: generic/426 generic/551
>
> That's the same order of magnitude for ext4 or xfs running -g auto,
> and at least for me "gce-xfsetsts -c nfs/default -g auto" is fire and
> forget kind of thing.  2-3 hours later, the results show up in my
> inbox.  It's actually *analyzing* the test failures which takes time
> and NFS expertise, both of which I don't have a lot of at the moment.
>
> > For the particular issue with generic/476, I would like to see if
> > there's a reason that test takes a long time and fails with a small
> > scratch dev before agreeing that excluding it is the proper response.
>
> At the moment, my test runner setup assumes that if a single test
> takes more than hour, the system under test is hung and should be
> killed.  So if generic/476 is taking ~400 seconds for pre-5.10 LTS
> kernels, and over 24 hours if the watchdog safety timer isn't in use
> for 5.10+ kernels, I need to exclude it in my test runner, at least
> for now.
>
> Once it's fixed, I can use a linux versioned #ifdef to only exclude
> the test if the fix is not present.
>
> (Also on my todo wishlist is to have some way to automatically exclude
> a test if a specified fix commit isn't present on the tested kernel,
> but to run it automatically once the fix commit is present.
> Unfortunately, I don't have the time or the business case to put
> someone on it as a work project...)
>
>                                         - Ted
>


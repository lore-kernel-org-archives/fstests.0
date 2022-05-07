Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E21C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 12:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbiEGMyX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 08:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiEGMyV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 08:54:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64FF7E0AD
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651927829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X96ihtFmQESa7ZeL681lFM+HhsabV81QBSKYbSCNCng=;
        b=hBX/axxj0Kbksb0o/nn56sDnyAILDu9llJF1DLOjnDq5YsfNoDKt/6Yk2sbpJo14TVxfoI
        Efy0VIr5UXc+3jGq4KYjxO/vXvo8SgvSqWz/4aUIumWMCIh4AiHiNB1vaj37hUWyNaBB1H
        89CP42JNP6/kLHHAtpjjGIjbk7kDHgw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-32wBVjqGMFqUHZcxCumuDw-1; Sat, 07 May 2022 08:50:28 -0400
X-MC-Unique: 32wBVjqGMFqUHZcxCumuDw-1
Received: by mail-qt1-f197.google.com with SMTP id d13-20020ac85acd000000b002f3be21793dso5677204qtd.12
        for <fstests@vger.kernel.org>; Sat, 07 May 2022 05:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=X96ihtFmQESa7ZeL681lFM+HhsabV81QBSKYbSCNCng=;
        b=05sSkYRPT6E1EFlq+rp28hhThgYnPn7yU6tjjCnlcS8ynXYFMB9SK0E9BuxQA6djwx
         f45JY/5IORvX+LOQjVhFLeDDFwS1YmosJaBUr+Lz+bCG2wE9UO+3dRG4MLImGEE2HmGp
         Ell+Q1RmPc011RJ8Nz5pqWKJI0uZVbMVaD4Nl135ng65lx3HIfVWfsjPcbUpxEIJ4MNc
         AmRCTQwiwZFP7cObLCGCvIt3uGdpiBRfiyaASNaUovkBhkmmWHqHCWTv9FP2zTRjtNpj
         jNFjm9y5/iFoPN4H4S/q0afltZr2r/u8mFHQJ2IoJyPzcO1PUq078xmDpvkbYkLZur5e
         3JoA==
X-Gm-Message-State: AOAM533jGMJHD8b2RSdzPud6k96bii2Bhvk3/pJYzoEU2dL8wPWvGgol
        DIZL+YuZR2WN6fV2QYG+uGKodHQRcRjkrD1UI+6+f8bpPoxPC1WvL6OfXImGFNGJ9A2rdf2NEd3
        m7cIfefnJTsLqx6nKFQ==
X-Received: by 2002:a05:622a:143:b0:2e0:b7c8:3057 with SMTP id v3-20020a05622a014300b002e0b7c83057mr7286217qtw.179.1651927828020;
        Sat, 07 May 2022 05:50:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVoy7BcGCwROSitMrftbqOjf6lked5emQfwn0ndKyl7rGjQlLma1vJ+fp6111TdHODfS3PCw==
X-Received: by 2002:a05:622a:143:b0:2e0:b7c8:3057 with SMTP id v3-20020a05622a014300b002e0b7c83057mr7286193qtw.179.1651927827734;
        Sat, 07 May 2022 05:50:27 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id d5-20020ae9ef05000000b0069fc13ce1ebsm3917677qkg.28.2022.05.07.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 05:50:27 -0700 (PDT)
Date:   Sat, 7 May 2022 20:50:20 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 00/11] rename & split tests
Message-ID: <20220507125020.3po2gc36onouibuo@zlang-mailbox>
Mail-Followup-To: Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>, Christoph Hellwig <hch@lst.de>,
        Jan Kara <jack@suse.cz>, "Darrick J. Wong" <djwong@kernel.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        fstests <fstests@vger.kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
 <20220501114643.ypif3dzglroqlce4@zlang-mailbox>
 <20220507120309.7cjjfpmttjqtutxy@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507120309.7cjjfpmttjqtutxy@wittgenstein>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 07, 2022 at 02:03:09PM +0200, Christian Brauner wrote:
> On Sun, May 01, 2022 at 07:46:43PM +0800, Zorro Lang wrote:
> > On Thu, Apr 28, 2022 at 05:15:48PM +0200, Christian Brauner wrote:
> > > From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > > 
> > > Hey everyone,
> > > 
> > > As announced multiple times already we need to rename and split the
> > > idmapped mount testsuite into separate source files and also give it a
> > > better name to reflect the fact that it covers a lot more than just
> > > idmapped mounts.
> > > 
> > > I have decided against compiling different binaries for now. Instead we
> > > compile a single vfstest binary that can be called with various command
> > > line switches to run the various test suites. This is not different than
> > > what we did for the idmapped-mounts binary. Of course, nothing prevents
> > > us from using multiple binaries in the future.
> > > 
> > > Note that this will have a conflict with Jan's series at:
> > > https://lore.kernel.org/fstests/20220425131809.qzjrah7cw67mzzcw@zlang-mailbox/T/#m47d8da68ef1aff250918398e8d2228729a6acf97
> > 
> > Hi Christian,
> > 
> > Thanks for your patches! But even without above conflict patches, I still can't
> > merge your patchset, failures as below [1].
> 
> Hi Zorro!
> (Resending, since my last message had a messed-up To: line.)
> 
> The fstests list has a limit on how large a single patch can be in terms
> of number of lines (10.000, I believe). Since this patchset contains
> patches that change about 10.000 lines the fstests list drops those
> patches. I ran into this issue before when we added the testsuite in the
> first place but it has never been fixed.
> 
> The consequence of this is that b4 is missing patches since they are on
> no list. This becomes more obvious if you use b4's quilt option which
> creates a folder with individual patches:
> 
>   0001_src_rename_idmapped_mounts_folder.patch
>   0002_src_vfs_rename_idmapped_mounts_c_file.patch
>   0003_vfstest_rename_struct_t_idmapped_mounts.patch
>   0004_utils_add_missing_global_h_include.patch
>   0006_utils_move_helpers_into_utils.patch
>   0007_missing_move_sys_execveat_to_missing_h.patch
>   0008_utils_add_struct_test_suite.patch
>   0011_vfstest_split_out_remaining_idmapped_mount_tests.patch
>   series
> 
> so this is missing patches 9 and 10...

Oh, I didn't notice that. Let me check ...

> 
> > May you rebase your patches on latest fstests for-next branch, and send out
> > again? As Christoph Hellwig has Acked your patchset, we'd better to make it
> 
> I think we will have the same problem, i.e., patches will not be on the
> list since they are too large and so b4 won't work. To work around this
> I'll give you a signed tag to pull from in the cover letter.

Hmm...I just used another method(avoid b4) to merge your 11 patches, I think
it works:
# git log --oneline
14714a1b (HEAD -> for-brauner) vfstest: split out remaining idmapped mount tests
ed027078 vfstest: split out btrfs idmapped mounts test
fd026c1a vfstests: split idmapped mount tests into separate suite
1cec19ec utils: add struct test_suite
3dadfe72 missing: move sys_execveat() to missing.h
ba0370e4 utils: move helpers into utils
781f86e1 utils: add struct vfstest_info
e1ffed6b utils: add missing global.h include
4f68af21 vfstest: rename struct t_idmapped_mounts
8fcd0f72 src/vfs: rename idmapped-mounts.c file
0b03254e src: rename idmapped-mounts folder
fbc6486b (redhat/master, origin/master, origin/HEAD, rh-master, master) generic: test that renaming into a directory fails with EDQUOT
...
...

And yes, patch 9 and 10 are really huge:
$ git show ed027078 | wc -l
8223
$ git show fd026c1a | wc -l
15641

But I still can't merge it into for-next branch, so you have to do once rebase
at least. As we have 3 more idmapped patches to from XuYang to be merged,
you'd better to wait the fstests release this week, then do once rebase
on for-next branch. Hope that can save a little of your time.

Thanks,
Zorro

> 
> Christian
> 


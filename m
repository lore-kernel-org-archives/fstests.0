Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539AAC433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 15:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344213AbiEGPrk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 11:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiEGPrj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 11:47:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFFC2E9E1
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 08:43:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BC90612A4
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 15:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84405C385A6;
        Sat,  7 May 2022 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651938231;
        bh=sY0BOXqRbmUP5cmo03Zzx7ipGM0K6QSHBRG39UPowQM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=a8rdwrM578KT7XhM7NVIVnJfWbZF6xPxphgcwkMZtsW/2qSXCpCyGP4yigGwBEufy
         BFshVldBNDYlS/XJm+zlGWbhNUP5R/wjSpZZ3qAMXcjUXtZUlEo/0+Lz6wYhpbzwoK
         m/CKOLMxCFsG4g9SbZotnniO1hunn1K2gr6ic6ck/4/kvMAa/GZybWObOjGZCpHfLh
         M2kwTjkGhIOib5e1fV870RLVyByub1b2flTQ8L6il1v3HKjZ9gD2gksFUBhKczHNjB
         9mh1eoIgoXbiXFnhUiahqOH7Xch6iI+AOBrRJfDMCeFAO6JuBhC14vb1Uy4E8KK4nK
         WrHy6iYdFJUKQ==
Date:   Sat, 7 May 2022 17:43:46 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 00/11] rename & split tests
Message-ID: <20220507154346.oxfwcq547p325ti3@wittgenstein>
References: <20220428151559.947144-1-brauner@kernel.org>
 <20220501114643.ypif3dzglroqlce4@zlang-mailbox>
 <20220507120309.7cjjfpmttjqtutxy@wittgenstein>
 <20220507125020.3po2gc36onouibuo@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220507125020.3po2gc36onouibuo@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sat, May 07, 2022 at 08:50:20PM +0800, Zorro Lang wrote:
> On Sat, May 07, 2022 at 02:03:09PM +0200, Christian Brauner wrote:
> > On Sun, May 01, 2022 at 07:46:43PM +0800, Zorro Lang wrote:
> > > On Thu, Apr 28, 2022 at 05:15:48PM +0200, Christian Brauner wrote:
> > > > From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > > > 
> > > > Hey everyone,
> > > > 
> > > > As announced multiple times already we need to rename and split the
> > > > idmapped mount testsuite into separate source files and also give it a
> > > > better name to reflect the fact that it covers a lot more than just
> > > > idmapped mounts.
> > > > 
> > > > I have decided against compiling different binaries for now. Instead we
> > > > compile a single vfstest binary that can be called with various command
> > > > line switches to run the various test suites. This is not different than
> > > > what we did for the idmapped-mounts binary. Of course, nothing prevents
> > > > us from using multiple binaries in the future.
> > > > 
> > > > Note that this will have a conflict with Jan's series at:
> > > > https://lore.kernel.org/fstests/20220425131809.qzjrah7cw67mzzcw@zlang-mailbox/T/#m47d8da68ef1aff250918398e8d2228729a6acf97
> > > 
> > > Hi Christian,
> > > 
> > > Thanks for your patches! But even without above conflict patches, I still can't
> > > merge your patchset, failures as below [1].
> > 
> > Hi Zorro!
> > (Resending, since my last message had a messed-up To: line.)
> > 
> > The fstests list has a limit on how large a single patch can be in terms
> > of number of lines (10.000, I believe). Since this patchset contains
> > patches that change about 10.000 lines the fstests list drops those
> > patches. I ran into this issue before when we added the testsuite in the
> > first place but it has never been fixed.
> > 
> > The consequence of this is that b4 is missing patches since they are on
> > no list. This becomes more obvious if you use b4's quilt option which
> > creates a folder with individual patches:
> > 
> >   0001_src_rename_idmapped_mounts_folder.patch
> >   0002_src_vfs_rename_idmapped_mounts_c_file.patch
> >   0003_vfstest_rename_struct_t_idmapped_mounts.patch
> >   0004_utils_add_missing_global_h_include.patch
> >   0006_utils_move_helpers_into_utils.patch
> >   0007_missing_move_sys_execveat_to_missing_h.patch
> >   0008_utils_add_struct_test_suite.patch
> >   0011_vfstest_split_out_remaining_idmapped_mount_tests.patch
> >   series
> > 
> > so this is missing patches 9 and 10...
> 
> Oh, I didn't notice that. Let me check ...
> 
> > 
> > > May you rebase your patches on latest fstests for-next branch, and send out
> > > again? As Christoph Hellwig has Acked your patchset, we'd better to make it
> > 
> > I think we will have the same problem, i.e., patches will not be on the
> > list since they are too large and so b4 won't work. To work around this
> > I'll give you a signed tag to pull from in the cover letter.
> 
> Hmm...I just used another method(avoid b4) to merge your 11 patches, I think
> it works:
> # git log --oneline
> 14714a1b (HEAD -> for-brauner) vfstest: split out remaining idmapped mount tests
> ed027078 vfstest: split out btrfs idmapped mounts test
> fd026c1a vfstests: split idmapped mount tests into separate suite
> 1cec19ec utils: add struct test_suite
> 3dadfe72 missing: move sys_execveat() to missing.h
> ba0370e4 utils: move helpers into utils
> 781f86e1 utils: add struct vfstest_info
> e1ffed6b utils: add missing global.h include
> 4f68af21 vfstest: rename struct t_idmapped_mounts
> 8fcd0f72 src/vfs: rename idmapped-mounts.c file
> 0b03254e src: rename idmapped-mounts folder
> fbc6486b (redhat/master, origin/master, origin/HEAD, rh-master, master) generic: test that renaming into a directory fails with EDQUOT
> ...
> ...
> 
> And yes, patch 9 and 10 are really huge:
> $ git show ed027078 | wc -l
> 8223
> $ git show fd026c1a | wc -l
> 15641
> 
> But I still can't merge it into for-next branch, so you have to do once rebase
> at least. As we have 3 more idmapped patches to from XuYang to be merged,
> you'd better to wait the fstests release this week, then do once rebase

Yeah, sounds good!

Christian

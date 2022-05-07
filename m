Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B05C433EF
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 12:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391274AbiEGMHD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 08:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352692AbiEGMHC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 08:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6911C13E30
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 05:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07A76611A8
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 12:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17355C385A9;
        Sat,  7 May 2022 12:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651924995;
        bh=5ZzHJx1CV3hqjQ30mv7eU0rD7wd1wCzjSfGb5Qar1eo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zjq5HL4ZHlksA826LQKDVSsdy+e2rlxqtV2ENAQBjveXeYhB3tTfH53MRiNS2v3AK
         25cn5kWzSZHOmYGDq4sual3hqUJrwi5A6QFe/2mv9bRzCDV/TPIAGRQwqAUZvNjNPS
         iedbWSyGmD0H+swWy7JbYK+6k5MAPrQmreNgjITTzJQ3EQH+5zByp+C67s8C0LRVvU
         nXGkvaVLVFK5fHmUIMjYvDINVmTNPFg993ud7rHDe0QItczM6hcWM21+OnQnr0U2kP
         C26zdRx22jjKBTUtMG+tHWvA5jVczeYDJQ4qhQjs+dC3sev8cRtG1FlMEesAkHcKOD
         yrJ4M+Tg/KPZg==
Date:   Sat, 7 May 2022 14:03:09 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     "Christian Brauner (Microsoft)" <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH 00/11] rename & split tests
Message-ID: <20220507120309.7cjjfpmttjqtutxy@wittgenstein>
References: <20220428151559.947144-1-brauner@kernel.org>
 <20220501114643.ypif3dzglroqlce4@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220501114643.ypif3dzglroqlce4@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Sun, May 01, 2022 at 07:46:43PM +0800, Zorro Lang wrote:
> On Thu, Apr 28, 2022 at 05:15:48PM +0200, Christian Brauner wrote:
> > From: "Christian Brauner (Microsoft)" <brauner@kernel.org>
> > 
> > Hey everyone,
> > 
> > As announced multiple times already we need to rename and split the
> > idmapped mount testsuite into separate source files and also give it a
> > better name to reflect the fact that it covers a lot more than just
> > idmapped mounts.
> > 
> > I have decided against compiling different binaries for now. Instead we
> > compile a single vfstest binary that can be called with various command
> > line switches to run the various test suites. This is not different than
> > what we did for the idmapped-mounts binary. Of course, nothing prevents
> > us from using multiple binaries in the future.
> > 
> > Note that this will have a conflict with Jan's series at:
> > https://lore.kernel.org/fstests/20220425131809.qzjrah7cw67mzzcw@zlang-mailbox/T/#m47d8da68ef1aff250918398e8d2228729a6acf97
> 
> Hi Christian,
> 
> Thanks for your patches! But even without above conflict patches, I still can't
> merge your patchset, failures as below [1].

Hi Zorro!
(Resending, since my last message had a messed-up To: line.)

The fstests list has a limit on how large a single patch can be in terms
of number of lines (10.000, I believe). Since this patchset contains
patches that change about 10.000 lines the fstests list drops those
patches. I ran into this issue before when we added the testsuite in the
first place but it has never been fixed.

The consequence of this is that b4 is missing patches since they are on
no list. This becomes more obvious if you use b4's quilt option which
creates a folder with individual patches:

  0001_src_rename_idmapped_mounts_folder.patch
  0002_src_vfs_rename_idmapped_mounts_c_file.patch
  0003_vfstest_rename_struct_t_idmapped_mounts.patch
  0004_utils_add_missing_global_h_include.patch
  0006_utils_move_helpers_into_utils.patch
  0007_missing_move_sys_execveat_to_missing_h.patch
  0008_utils_add_struct_test_suite.patch
  0011_vfstest_split_out_remaining_idmapped_mount_tests.patch
  series

so this is missing patches 9 and 10...

> May you rebase your patches on latest fstests for-next branch, and send out
> again? As Christoph Hellwig has Acked your patchset, we'd better to make it

I think we will have the same problem, i.e., patches will not be on the
list since they are too large and so b4 won't work. To work around this
I'll give you a signed tag to pull from in the cover letter.

Christian

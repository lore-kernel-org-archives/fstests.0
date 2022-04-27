Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633D4C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 14:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiD0O4i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 10:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbiD0O4i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 10:56:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6A47051
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 07:53:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23RErOvc027011
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 10:53:25 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4DEE715C3EA1; Wed, 27 Apr 2022 10:53:24 -0400 (EDT)
Date:   Wed, 27 Apr 2022 10:53:24 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <YmlY5NhDodhRRpkU@mit.edu>
References: <20220427005209.4188220-1-tytso@mit.edu>
 <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 27, 2022 at 04:05:40PM +0800, Zorro Lang wrote:
> 
> "The DAX code currently only supports files with a block size equal to your
> kernel's PAGE_SIZE" [1], so I suppose any cases with smaller blocksize (< pagesize)
> should "_exclude_scratch_mount_option dax".
> 
> And if this supposition is right, we'd better do "skipping dax testing if blocksize
> is less than pagesize" in a common helper. Good news is we have _scratch_mkfs_blocksized.
> So how about do:
>   if [ $blocksize < $pagesize ];then
>       _exclude_scratch_mount_option dax
>   fi
> in _scratch_mkfs_blocksized? then let ext4/054 and ext4/055 turn to use _scratch_mkfs_blocksized.

That's a good thing to and it would work for ext4/054 and ext/022
(which already uses "_exclude_scratch_mount_option dax" and
"_scratch_mkfs").  However, a number of other tests, including
ext4/055 and ext4/035 need to give additional parameters to mfks, such
as "-O quota" or "-E resize=262144".

So _scratch_mkfs_blocksized isn't always going to work for tests in
ext4/* where we often are passing ext4-specific mkfs options to
mkfs.ext4.

So I can add your suggestion to _scratch_mkfs_blocksized, and use that
for ext4/054, but it's not going to be a solution for ext4/055.

Cheers,

						- Ted

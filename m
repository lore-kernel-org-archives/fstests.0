Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6FC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 27 Apr 2022 19:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbiD0Tts (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 27 Apr 2022 15:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbiD0Ts7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Apr 2022 15:48:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08CF2ED71
        for <fstests@vger.kernel.org>; Wed, 27 Apr 2022 12:45:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 23RJiwTj032303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Apr 2022 15:44:59 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8F6AC15C3EA1; Wed, 27 Apr 2022 15:44:58 -0400 (EDT)
Date:   Wed, 27 Apr 2022 15:44:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Subject: Re: [PATCH] ext4/054,ext4/055: don't run when using DAX
Message-ID: <YmmdOvsw7gJXqu9X@mit.edu>
References: <20220427005209.4188220-1-tytso@mit.edu>
 <20220427080540.o7tu3nz6g5ch6xpt@zlang-mailbox>
 <YmlY5NhDodhRRpkU@mit.edu>
 <20220427171923.ab2duujwkljyatyv@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427171923.ab2duujwkljyatyv@zlang-mailbox>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 28, 2022 at 01:19:23AM +0800, Zorro Lang wrote:
> I just noticed that _scratch_mkfs_sized() and _scratch_mkfs_blocksized() both use
> _scratch_mkfs_xfs for XFS, I'm wondering if ext4 would like to use _scratch_mkfs_ext4()
> or even use _scratch_mkfs() directly in these two functions. Then you can do something
> likes:
>   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota"
>   _scratch_mkfs_blocksized 1024
> or:
>   MKFS_OPTIONS="$MKFS_OPTIONS -F -O quota" _scratch_mkfs_blocksized 1024

I'd prefer to keep changing _scratch_mkfs_sized and
_scatch_mkfs_blocksized to use _scratch_mfks_ext4 as a separate
commit.  It makes sense to do that, but it does mean some behavioral
changes; specifically in the external log case,
"_scratch_mkfs_blocksized" will now create a file system using an
external log.  It's probably a good change, but there is some testing
I'd like to do first before makinig that change and I don't have time
for it.

> We just provide a helper to avoid someone forget 'dax', I don't object someone would
> like to "exclude dax" by explicit method :) So if you don't have much time to do this
> change, you can just do what you said above, then I'll take another time/chance to
> change _scratch_mkfs_* things.

Hmm, one thing which I noticed when searching through things.  xfs/432
does this:

_scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1

So in {gce,kvm}-xfstests we have an exclude file entry in
.../fs/xfs/cfg/dax.exclude:

# This test formats a file system with a 1k block size, which is not
# compatible with DAX (at least with systems with a 4k page size).
xfs/432

... in order to suppress a test failure.

Arguably we should add an "_exclude_scratch_mount_option dax" to this
test, as opposed to having an explicit test exclusion in my test
runner.  Or we figure out how to change xfs/432 to use
_scratch_mkfs_blocksized.  So there is a lot of cleanup that can be
done here, and I suspect we should do this work incrementally.  :-)

> Maybe we should think about let all _scratch_mkfs_*[1] helpers use _scratch_mkfs
> consistently. But that will change and affect too many things. I don't want to break
> fundamental code too much, might be better to let each fs help to change and test
> that bit by bit, when they need :)

Yep.   :-)

						- Ted

P.S.  Here's something else that should probably be moved from my test
runner into xfstests.  Again from .../xfs/cfg/dax.exclude:

# mkfs.xfs options which now includes reflink, and reflink is not
# compatible with DAX
xfs/032
xfs/205
xfs/294

Maybe _scratch_mkfs_xfs should be parsing the output of mkfs.xfs to
see if reflink is enabled, and then automatically asserting an
"_exclude_scratch_mount_option dax", perhaps?


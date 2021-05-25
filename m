Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512B6C2B9F8
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31A406140A
	for <linux-fstests@archiver.kernel.org>; Tue, 25 May 2021 16:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhEYQLa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 25 May 2021 12:11:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230150AbhEYQL3 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 25 May 2021 12:11:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFA8261408;
        Tue, 25 May 2021 16:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621959000;
        bh=gcNNZNoT1/48TSsMb+4Ae30BDVPX3SB4ecBcjIHeVKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCpkiMSFRf80xzvCxrlOVpOG75Iq0S7Y4Dz4MERpVTTHo5Lm+yYGDQSgKFHL3tUt7
         fA8vExrkYredelyDrJmbBtTSuYF06MsNryc5LEDFMHvafp2dlQ5HLI3XK+gGpeGMm2
         3XLOjtDaUST7WxTknTPrN2KK1J3CunBNhOezFH2GwSatdWtoy3XVLuGYepemQCiLzG
         830/lwM66t4gP+XrOYb1Ur19SMN33Adod6Ou/bpn90ICbyM+b0g11A6PvufpIjZkLW
         /VqeoU8RwMohZkiwU7mQyoKUw697RZHrVuHTQj6HXQUMOxFziY5qcvDvJXMsXPZbVq
         q71guQi3ral3A==
Date:   Tue, 25 May 2021 09:09:59 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/9] generic/294, afs: Allow for mknod subtest failing if
 mknod not supported
Message-ID: <20210525160959.GC202095@locust>
References: <162194962878.4011860.5561077785368723619.stgit@warthog.procyon.org.uk>
 <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162194964249.4011860.17729034205311880257.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, May 25, 2021 at 02:34:02PM +0100, David Howells wrote:
> If mknod is not supported, some of generic/294 will fail due to that rather
> than what's actually being tested - but the other subtests will still work
> as before.
> 
> Add a "_has_mknod" function that can be used to find out if the mknod tests
> should be skipped.  This is then used to allow the rest of generic/294 to
> be employed on AFS.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: linux-afs@lists.infradead.org
> ---
> 
>  common/rc                     |   10 ++++++++++
>  doc/requirement-checking.txt  |    9 +++++++++
>  tests/generic/294             |    8 ++++++++
>  tests/generic/294.cfg         |    1 +
>  tests/generic/294.out         |    5 -----
>  tests/generic/294.out.mknod   |    6 ++++++
>  tests/generic/294.out.nomknod |    7 +++++++
>  7 files changed, 41 insertions(+), 5 deletions(-)
>  create mode 100644 tests/generic/294.cfg
>  delete mode 100644 tests/generic/294.out
>  create mode 100644 tests/generic/294.out.mknod
>  create mode 100644 tests/generic/294.out.nomknod
> 
> diff --git a/common/rc b/common/rc
> index f24d0e87..4ffec9a2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4603,6 +4603,16 @@ _getcap()
>  	return ${PIPESTATUS[0]}
>  }
>  
> +_has_mknod()
> +{
> +	case $FSTYP in
> +	afs)
> +		return 1;;
> +	*)
> +		return 0;;
> +	esac
> +}
> +
>  init_rc
>  
>  ################################################################################
> diff --git a/doc/requirement-checking.txt b/doc/requirement-checking.txt
> index 45d2756b..d31ba3fb 100644
> --- a/doc/requirement-checking.txt
> +++ b/doc/requirement-checking.txt
> @@ -16,6 +16,8 @@ they have.  This is done with _require_<xxx> macros, which may take parameters.
>  
>  	_require_chattr <letters>
>  	_require_exportfs
> +	_require_mknod

I don't see a _require_mknod being added to common/rc?

Otherwise looks ok to me.

--D

> +	_has_mknod
>  
>   (3) System call requirements.
>  
> @@ -97,6 +99,13 @@ _require_exportfs
>       The test also requires the use of the open_by_handle_at() system call and
>       will be skipped if it isn't available in the kernel.
>  
> +_require_mknod
> +_has_mknod
> +
> +     The test requires that the $TEST_DEV filesystem supports mknod(2).
> +     _require_mknod will cause the test to be skipped; _has_mknod returns 0 if
> +     mknod is supported and 1 otherwise.
> +
>  
>  ========================
>  SYSTEM CALL REQUIREMENTS
> diff --git a/tests/generic/294 b/tests/generic/294
> index 55b24e12..4fc05082 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -8,6 +8,7 @@
>  # we ask to create an already-existing entity on an RO filesystem
>  #
>  seq=`basename $0`
> +seqfull=$0
>  seqres=$RESULT_DIR/$seq
>  echo "QA output created by $seq"
>  
> @@ -34,6 +35,13 @@ _require_scratch
>  _require_symlinks
>  _require_mknod
>  
> +features=""
> +if ! _has_mknod; then
> +	echo HAS NO MKNOD $?
> +	features="nomknod"
> +fi
> +_link_out_file "$features"
> +
>  rm -f $seqres.full
>  _scratch_mkfs > $seqres.full 2>&1 || _fail "Could not mkfs scratch device"
>  
> diff --git a/tests/generic/294.cfg b/tests/generic/294.cfg
> new file mode 100644
> index 00000000..c0466cde
> --- /dev/null
> +++ b/tests/generic/294.cfg
> @@ -0,0 +1 @@
> +nomknod: nomknod
> diff --git a/tests/generic/294.out b/tests/generic/294.out
> deleted file mode 100644
> index 78024728..00000000
> --- a/tests/generic/294.out
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -QA output created by 294
> -mknod: SCRATCH_MNT/294.test/testnode: File exists
> -mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
> -touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
> -ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> diff --git a/tests/generic/294.out.mknod b/tests/generic/294.out.mknod
> new file mode 100644
> index 00000000..4aea9d82
> --- /dev/null
> +++ b/tests/generic/294.out.mknod
> @@ -0,0 +1,6 @@
> +QA output created by 294
> +mknod: SCRATCH_MNT/294.test/testnode: Operation not permitted
> +mknod: SCRATCH_MNT/294.test/testnode: Read-only file system
> +mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
> +touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
> +ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> diff --git a/tests/generic/294.out.nomknod b/tests/generic/294.out.nomknod
> new file mode 100644
> index 00000000..43658aa8
> --- /dev/null
> +++ b/tests/generic/294.out.nomknod
> @@ -0,0 +1,7 @@
> +QA output created by 294
> +HAS NO MKNOD
> +mknod: SCRATCH_MNT/294.test/testnode: Operation not permitted
> +mknod: SCRATCH_MNT/294.test/testnode: Read-only file system
> +mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
> +touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
> +ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> 
> 

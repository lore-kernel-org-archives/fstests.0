Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB9FC47092
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 12:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5BD611EE
	for <linux-fstests@archiver.kernel.org>; Sun, 30 May 2021 12:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbhE3Mvj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 30 May 2021 08:51:39 -0400
Received: from out20-75.mail.aliyun.com ([115.124.20.75]:47065 "EHLO
        out20-75.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3Mvi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 30 May 2021 08:51:38 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07437422|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00605896-0.00117769-0.992763;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047211;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.KKvj-BB_1622378998;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.KKvj-BB_1622378998)
          by smtp.aliyun-inc.com(10.147.43.95);
          Sun, 30 May 2021 20:49:59 +0800
Date:   Sun, 30 May 2021 20:49:58 +0800
From:   Eryu Guan <guan@eryu.me>
To:     David Howells <dhowells@redhat.com>
Cc:     fstests@vger.kernel.org, linux-afs@lists.infradead.org
Subject: Re: [PATCH 2/9] generic/294, afs: Allow for mknod subtest failing if
 mknod not supported
Message-ID: <YLOJ9h734bmR140Z@desktop>
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

_require_mknod checks for mknod support by trying to mknod and _notrun
the test if mknod fails.

So does afs return any failure like EOPNOTSUPP? If so I think we could
refactor _require_mknod into something like

  _has_mknod || _notrun "xxxx"

and do the mknod check in _has_mknod, isntead of whitelist fs names.

Thanks,
Eryu

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

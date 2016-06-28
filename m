Received: from mx1.redhat.com ([209.132.183.28]:38155 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751740AbcF1Dai (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 27 Jun 2016 23:30:38 -0400
Date: Tue, 28 Jun 2016 11:30:35 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] generic/294: filter quotes from mknod
Message-ID: <20160628033035.GW23649@eguan.usersys.redhat.com>
References: <1467032008-16374-1-git-send-email-omzg@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467032008-16374-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 27, 2016 at 03:53:28PM +0300, Omer Zilberberg wrote:
> Since coreutils v8.25, mknod errors omit quotes around filenames, and
> this breaks generic/294's golden image.
> 
> Checked on Ubuntu 16.04.
> 
> See coreutils: 08e8fd7 all: avoid quoting file names when possible
> https://github.com/coreutils/coreutils/commit/08e8fd7e38f2dae7c69c54eb22d508b6517e66e5
> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>

Thanks for all the testing! I've queued it up for next pull request.

> 
> v2: added comment to _filter_mknod.

This should go under the "---" below so the revision history doesn't go
to commit log :)

Thanks,
Eryu

> ---
>  common/filter         | 7 +++++++
>  tests/generic/294     | 2 +-
>  tests/generic/294.out | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 244621a..8d9f489 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -385,5 +385,12 @@ _filter_od()
>  	'
>  }
>  
> +# Remove quotes from failed mknod calls. Starting with Coreutils v8.25,
> +# mknod errors print unquoted filenames
> +_filter_mknod()
> +{
> +	sed -e "s/mknod: '\(.*\)': File exists/mknod: \1: File exists/"
> +}
> +
>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/generic/294 b/tests/generic/294
> index 3fa6ba2..fb5d9aa 100755
> --- a/tests/generic/294
> +++ b/tests/generic/294
> @@ -55,7 +55,7 @@ THIS_TEST_DIR=$SCRATCH_MNT/$seq.test
>  
>  _create_files()
>  {
> -	mknod $THIS_TEST_DIR/testnode c 1 3
> +	mknod $THIS_TEST_DIR/testnode c 1 3 2>&1 | _filter_mknod
>  	mkdir $THIS_TEST_DIR/testdir
>  	touch $THIS_TEST_DIR/testtarget
>  	ln -s $THIS_TEST_DIR/testtarget $THIS_TEST_DIR/testlink 2>&1 | _filter_ln
> diff --git a/tests/generic/294.out b/tests/generic/294.out
> index 1ac1c67..7802472 100644
> --- a/tests/generic/294.out
> +++ b/tests/generic/294.out
> @@ -1,5 +1,5 @@
>  QA output created by 294
> -mknod: 'SCRATCH_MNT/294.test/testnode': File exists
> +mknod: SCRATCH_MNT/294.test/testnode: File exists
>  mkdir: cannot create directory 'SCRATCH_MNT/294.test/testdir': File exists
>  touch: cannot touch 'SCRATCH_MNT/294.test/testtarget': Read-only file system
>  ln: creating symbolic link 'SCRATCH_MNT/294.test/testlink': File exists
> -- 
> 2.5.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

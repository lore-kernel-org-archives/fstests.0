Received: from sandeen.net ([63.231.237.45]:51076 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbdALEGk (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 11 Jan 2017 23:06:40 -0500
Subject: Re: [PATCH] Revert "generic/38[3-6]: require project quota to be
 enabled on SCRATCH_DEV"
References: <20161221032654.24197-1-eguan@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <a043bce2-185d-5fa9-77c9-c8b02b480ab0@sandeen.net>
Date: Wed, 11 Jan 2017 22:06:38 -0600
MIME-Version: 1.0
In-Reply-To: <20161221032654.24197-1-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
Cc: sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On 12/20/16 9:26 PM, Eryu Guan wrote:
> Commit 23f60ef304d ("generic/38[3-6]: require project quota to be
> enabled on SCRATCH_DEV") introduced a regression that leads
> _require_projquota, which uses src/feature to call a quotactl,
> operate before the filesystem is mounted, and results in tests not
> run on XFS and ext4.
> 
> Revert the problematic patch first, because don't want to lose
> project quota test coverage on XFS and ext4. We can fix the false
> failure on ext3/2 later,
> 
> Reported-by: Eric Sandeen <sandeen@redhat.com>
> Signed-off-by: Eryu Guan <eguan@redhat.com>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  tests/generic/383 | 1 -
>  tests/generic/384 | 2 +-
>  tests/generic/385 | 2 +-
>  tests/generic/386 | 2 +-
>  4 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/generic/383 b/tests/generic/383
> index 93836ea..be5b19b 100755
> --- a/tests/generic/383
> +++ b/tests/generic/383
> @@ -54,7 +54,6 @@ _require_xfs_quota_foreign
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_enable_pquota
> -_require_prjquota $SCRATCH_DEV
>  
>  do_project_test()
>  {
> diff --git a/tests/generic/384 b/tests/generic/384
> index 4784e47..452d26e 100755
> --- a/tests/generic/384
> +++ b/tests/generic/384
> @@ -73,10 +73,10 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
>  _require_scratch
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_enable_pquota
> -_require_prjquota $SCRATCH_DEV
>  
>  _qmount_option "prjquota"
>  _qmount
> +_require_prjquota $SCRATCH_DEV
>  
>  report_quota()
>  {
> diff --git a/tests/generic/385 b/tests/generic/385
> index b7c5bd3..f07ae5d 100755
> --- a/tests/generic/385
> +++ b/tests/generic/385
> @@ -71,9 +71,9 @@ quota_cmd="$XFS_QUOTA_PROG -D $tmp.projects -P $tmp.projid"
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_enable_pquota
> -_require_prjquota $SCRATCH_DEV
>  _qmount_option "prjquota"
>  _qmount
> +_require_prjquota $SCRATCH_DEV
>  
>  #
>  # Create the project root
> diff --git a/tests/generic/386 b/tests/generic/386
> index 0ceb14d..3aede60 100755
> --- a/tests/generic/386
> +++ b/tests/generic/386
> @@ -127,10 +127,10 @@ echo $proj_num:$proj_dir > "$my_projects"
>  
>  _scratch_mkfs					>> "$seqres.full" 2>&1
>  _scratch_enable_pquota
> -_require_prjquota $SCRATCH_DEV
>  
>  _qmount_option "prjquota"
>  _qmount
> +_require_prjquota $SCRATCH_DEV
>  
>  mkdir -p "${proj_dir}"
>  
> 

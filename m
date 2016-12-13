Received: from sandeen.net ([63.231.237.45]:38398 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbcLMXlO (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Dec 2016 18:41:14 -0500
Subject: Re: [PATCH] generic/38[3-6]: require project quota to be enabled on
 SCRATCH_DEV
References: <1478976065-2060-1-git-send-email-eguan@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <2b0336f2-8311-8bf7-08f3-ff0dc637b3fd@sandeen.net>
Date: Tue, 13 Dec 2016 17:41:12 -0600
MIME-Version: 1.0
In-Reply-To: <1478976065-2060-1-git-send-email-eguan@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 11/12/16 12:41 PM, Eryu Guan wrote:
> generic/38[3-6] are made generic from xfs tests to test project
> quota on other filesystems, e.g. ext4. But we should make sure
> project quota is enabled in between of _scratch_enable_pquota and
> _qmount. Otherwise mount will fail if there's no project quota
> support on SCRATCH_DEV, e.g. ext2 and ext3.
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/383 | 1 +
>  tests/generic/384 | 2 +-
>  tests/generic/385 | 2 +-
>  tests/generic/386 | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/383 b/tests/generic/383
> index be5b19b..93836ea 100755
> --- a/tests/generic/383
> +++ b/tests/generic/383
> @@ -54,6 +54,7 @@ _require_xfs_quota_foreign
>  
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_enable_pquota
> +_require_prjquota $SCRATCH_DEV
>  
>  do_project_test()
>  {
> diff --git a/tests/generic/384 b/tests/generic/384
> index 452d26e..4784e47 100755
> --- a/tests/generic/384
> +++ b/tests/generic/384
> @@ -73,10 +73,10 @@ chmod a+rwx $seqres.full	# arbitrary users will write here
>  _require_scratch
>  _scratch_mkfs >/dev/null 2>&1
>  _scratch_enable_pquota
> +_require_prjquota $SCRATCH_DEV
>  
>  _qmount_option "prjquota"
>  _qmount
> -_require_prjquota $SCRATCH_DEV

This commit seems to break things, on ext4 as well as on xfs.
(Bill ran into this)

how can _require_projquota, which uses src/feature to call a quotactl,
operate before the filesystem is mounted:

# ./check  generic/384
FSTYP         -- xfs (non-debug)
PLATFORM      -- Linux/x86_64 bp-05 4.9.0-rc1+
MKFS_OPTIONS  -- -f -bsize=4096 /dev/sdb2
MOUNT_OPTIONS -- -o context=system_u:object_r:nfs_t:s0 /dev/sdb2 /mnt/scratch

generic/384	 [not run] Installed kernel does not support project quotas


did this work for you?

-Eric


Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47138 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750703AbaIYEBB (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 25 Sep 2014 00:01:01 -0400
Received: by mail-pd0-f178.google.com with SMTP id ft15so9857761pdb.9
        for <fstests@vger.kernel.org>; Wed, 24 Sep 2014 21:01:01 -0700 (PDT)
Date: Thu, 25 Sep 2014 12:00:57 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] btrfs: use _nocheck for btrfs/011 and btrfs/012
Message-ID: <20140925040057.GE13950@dhcp-13-216.nay.redhat.com>
References: <1410465748-1226-1-git-send-email-jbacik@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1410465748-1226-1-git-send-email-jbacik@fb.com>
Sender: fstests-owner@vger.kernel.org
To: Josef Bacik <jbacik@fb.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Sep 11, 2014 at 04:02:28PM -0400, Josef Bacik wrote:
> These two tests blow up on the scratch test, but 011 leaves the devices in a
> state where the first scratch dev is no longer part of any file system and 012
> leaves the scratch dev as an ext4 file system.  Thanks,
> 
> Signed-off-by: Josef Bacik <jbacik@fb.com>

Reviewed-by: Eryu Guan <eguan@redhat.com>

> ---
>  tests/btrfs/011 | 2 +-
>  tests/btrfs/012 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/011 b/tests/btrfs/011
> index faa0402..0207057 100755
> --- a/tests/btrfs/011
> +++ b/tests/btrfs/011
> @@ -61,7 +61,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  # real QA test starts here
>  _need_to_be_root
>  _supported_fs btrfs
> -_require_scratch
> +_require_scratch_nocheck
>  _require_scratch_dev_pool 4
>  _require_command $BTRFS_SHOW_SUPER_PROG btrfs-show-super
>  
> diff --git a/tests/btrfs/012 b/tests/btrfs/012
> index f7e5da5..407acbc 100755
> --- a/tests/btrfs/012
> +++ b/tests/btrfs/012
> @@ -52,7 +52,7 @@ _cleanup()
>  # Modify as appropriate.
>  _supported_fs btrfs
>  _supported_os Linux
> -_require_scratch
> +_require_scratch_nocheck
>  
>  BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
>  MKFS_EXT4_PROG="`set_prog_path mkfs.ext4`"
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

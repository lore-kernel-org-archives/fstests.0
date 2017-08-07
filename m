Received: from [183.91.158.132] ([183.91.158.132]:2878 "EHLO
        heian.cn.fujitsu.com" rhost-flags-FAIL-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751564AbdHGG2c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 7 Aug 2017 02:28:32 -0400
Message-ID: <59880880.2010708@cn.fujitsu.com>
Date: Mon, 7 Aug 2017 14:28:16 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] check: source common/rc again if TEST_DEV was recreated
References: <20170802143915.19585-1-eguan@redhat.com> <20170802143915.19585-2-eguan@redhat.com>
In-Reply-To: <20170802143915.19585-2-eguan@redhat.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2017/08/02 22:39, Eryu Guan wrote:
> If TEST_DEV is recreated by check, FSTYP derived from TEST_DEV
> previously could be changed too and might not reflect the reality.
> So source common/rc again with correct FSTYP to get fs-specific
> configs, e.g. common/xfs.
>
> For example, using this config-section config file, and run section
> ext4 first then xfs, you can see:
>
> our local _scratch_mkfs routine ...
> ./common/rc: line 825: _scratch_mkfs_xfs: command not found
> check: failed to mkfs $SCRATCH_DEV using specified options
>
> local.config:
> [default]
> RECREATE_TEST_DEV=true
> TEST_DEV=/dev/sda5
> SCRATCH_DEV=/dev/sda6
> TEST_DIR=/mnt/test
> SCRATCH_MNT=/mnt/scratch
>
> [ext4]
> MKFS_OPTIONS="-b 4096"
> FSTYP=ext4
>
> [xfs]
> FSTYP=xfs
> MKFS_OPTIONS="-f -b size=4k"
>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  check | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/check b/check
> index f8db3cd6dfab..07586ce463c4 100755
> --- a/check
> +++ b/check
> @@ -555,6 +555,10 @@ for section in $HOST_OPTIONS_SECTIONS; do
>  			status=1
>  			exit
>  		fi
> +		# TEST_DEV has been recreated, previous FSTYP derived from
> +		# TEST_DEV could be changed, source common/rc again with
> +		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
> +		. common/rc
>  		_prepare_test_list
>  	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
>  		_test_unmount 2> /dev/null
Hi Eryu,

Could we replace init_rc with common/rc to get correct FSTYP and call
init_rc?
Like this:

--------------------------------------------------------------------------------
--- a/check
+++ b/check
@@ -566,7 +566,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
fi
fi

- init_rc
+ . common/rc
---------------------------------------------------------------------------------

Thanks,
Xiao Yang.



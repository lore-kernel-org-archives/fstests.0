Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758CAC4338F
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Aug 2021 12:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E03060F4B
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Aug 2021 12:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhHOMgq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Aug 2021 08:36:46 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:46522 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhHOMgp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Aug 2021 08:36:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.439681|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0126859-0.0121226-0.975191;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=guan@eryu.me;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.L.disp2_1629030973;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.L.disp2_1629030973)
          by smtp.aliyun-inc.com(10.147.41.178);
          Sun, 15 Aug 2021 20:36:13 +0800
Date:   Sun, 15 Aug 2021 20:36:13 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fstests: use udevadm settle after pvremove
Message-ID: <YRkKPbRX17kiAgz+@desktop>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-2-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811154512.1813622-2-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 11, 2021 at 08:45:10AM -0700, Luis Chamberlain wrote:
> As with creation, we also need to use udevadm settle
> when removing a pv, otherwise we can trip on races with
> module removals for the block devices in use.
> 
> This reduces the amount of time in which a block device
> module refcnt for test modules such as scsi_debug spends
> outside of 0.
> 
> Races with the refcnt being greater than 0 means module
> removal can fail causing false positives. This helps
> ensure that the pv is really long gone. These issues
> are tracked for scsi_debug [0] and later found to be a
> generic issue regardless of filesystem with pvremove [1].
> 
> Using udevadm settle *helps*, it does not address all
> possible races with the refcnt as noted in the generic
> bug entry [1].
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=214015
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

I applied this patch for this week's update.

Thanks,
Eryu

> ---
>  tests/generic/081 | 5 ++++-
>  tests/generic/108 | 1 +
>  tests/generic/459 | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/081 b/tests/generic/081
> index f795b2c1..8e552074 100755
> --- a/tests/generic/081
> +++ b/tests/generic/081
> @@ -12,6 +12,7 @@ _begin_fstest auto quick
>  # Override the default cleanup function.
>  _cleanup()
>  {
> +	local pv_ret
>  	cd /
>  	rm -f $tmp.*
>  
> @@ -34,7 +35,9 @@ _cleanup()
>  		$UMOUNT_PROG $mnt >> $seqres.full 2>&1
>  		$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
>  		$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
> -		test $? -eq 0 && break
> +		pv_ret=$?
> +		$UDEV_SETTLE_PROG
> +		test $pv_ret -eq 0 && break
>  		sleep 2
>  	done
>  }
> diff --git a/tests/generic/108 b/tests/generic/108
> index 7dd426c1..b7797e8f 100755
> --- a/tests/generic/108
> +++ b/tests/generic/108
> @@ -21,6 +21,7 @@ _cleanup()
>  	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
>  	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
>  	$LVM_PROG pvremove -f $SCRATCH_DEV $SCSI_DEBUG_DEV >>$seqres.full 2>&1
> +	$UDEV_SETTLE_PROG
>  	_put_scsi_debug_dev
>  	rm -f $tmp.*
>  }
> diff --git a/tests/generic/459 b/tests/generic/459
> index e5e5e9ab..5b44e245 100755
> --- a/tests/generic/459
> +++ b/tests/generic/459
> @@ -29,6 +29,7 @@ _cleanup()
>  	$UMOUNT_PROG $SCRATCH_MNT >>$seqres.full 2>&1
>  	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
>  	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
> +	$UDEV_SETTLE_PROG
>  }
>  
>  # Import common functions.
> -- 
> 2.30.2

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F388C4338F
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Aug 2021 12:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A37D61103
	for <linux-fstests@archiver.kernel.org>; Sun, 15 Aug 2021 12:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhHOMfk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 15 Aug 2021 08:35:40 -0400
Received: from out20-14.mail.aliyun.com ([115.124.20.14]:46034 "EHLO
        out20-14.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhHOMfj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 15 Aug 2021 08:35:39 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08157421|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0116308-0.00864484-0.979724;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047209;MF=guan@eryu.me;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.L.eSNlm_1629030902;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.L.eSNlm_1629030902)
          by smtp.aliyun-inc.com(10.147.40.7);
          Sun, 15 Aug 2021 20:35:03 +0800
Date:   Sun, 15 Aug 2021 20:35:02 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fstests@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] common/scsi_debug: use the patient module remover
Message-ID: <YRkJ9rkFPyYUy8p5@desktop>
References: <20210811154512.1813622-1-mcgrof@kernel.org>
 <20210811154512.1813622-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811154512.1813622-4-mcgrof@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Aug 11, 2021 at 08:45:12AM -0700, Luis Chamberlain wrote:
> If you try to run tests such as generic/108 in a loop
> you'll eventually see a failure, but the failure can
> be a false positive and the test was just unable to remove
> the scsi_debug module.
> 
> We need to give some time for the refcnt to become 0. For
> instance for the test generic/108 the refcnt lingers between
> 2 and 1. It should be 0 when we're done but a bit of time
> seems to be required. The chance of us trying to run rmmod
> when the refcnt is 2 or 1 is low, about 1/30 times if you
> run the test in a loop on linux-next today.
> 
> Likewise, even when its 0 we just need a tiny breather before
> we can remove the module (sleep 10 suffices) but this is
> only required on older kernels. Otherwise removing the module
> will just fail.
> 
> Some of these races are documented on the korg#212337, and
> Doug Gilbert has posted at least one patch attempt to try
> to help with this [1]. The patch does not resolve all the
> issues though, it helps though.
> 
> [0] https://bugzilla.kernel.org/show_bug.cgi?id=212337
> [1] https://lkml.kernel.org/r/20210508230745.27923-1-dgilbert@interlog.com
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  common/scsi_debug | 6 ++++--

There're also some "modprobe -r" calls in common/module, should the be
replaced with _patient_rmmod as well?

>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/scsi_debug b/common/scsi_debug
> index e7988469..3c9cd820 100644
> --- a/common/scsi_debug
> +++ b/common/scsi_debug
> @@ -4,11 +4,13 @@
>  #
>  # Functions useful for tests on unique block devices
>  
> +. common/module
> +
>  _require_scsi_debug()
>  {
>  	# make sure we have the module and it's not already used
>  	modinfo scsi_debug 2>&1 > /dev/null || _notrun "scsi_debug module not found"
> -	lsmod | grep -wq scsi_debug && (rmmod scsi_debug || _notrun "scsi_debug module in use")
> +	lsmod | grep -wq scsi_debug && (_patient_rmmod scsi_debug || _notrun "scsi_debug module in use")

I don't think we should use _patient_rmmod here, if we set timeout to
forever and there's actually some other process using scsi_debug module,
we'll loop forever here. And a failure to remove scsi_debug only results
in _notrun, and won't cause false test failure.

>  	# make sure it has the features we need
>  	# logical/physical sectors plus unmap support all went in together
>  	modinfo scsi_debug | grep -wq sector_size || _notrun "scsi_debug too old"
> @@ -53,5 +55,5 @@ _put_scsi_debug_dev()
>  		$UDEV_SETTLE_PROG
>  		n=$((n-1))
>  	done

I think the above while loop could be removed as well?

Thanks,
Eryu

> -	rmmod scsi_debug || _fail "Could not remove scsi_debug module"
> +	_patient_rmmod scsi_debug || _fail "Could not remove scsi_debug module"
>  }
> -- 
> 2.30.2

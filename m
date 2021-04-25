Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC86C433B4
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 08:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6A361396
	for <linux-fstests@archiver.kernel.org>; Sun, 25 Apr 2021 08:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbhDYIpr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 25 Apr 2021 04:45:47 -0400
Received: from out20-3.mail.aliyun.com ([115.124.20.3]:42263 "EHLO
        out20-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhDYIpq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 25 Apr 2021 04:45:46 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.0746761|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_enroll_verification|0.00718834-0.00102558-0.991786;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=guan@eryu.me;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.K3mIR10_1619340305;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.K3mIR10_1619340305)
          by smtp.aliyun-inc.com(10.147.42.197);
          Sun, 25 Apr 2021 16:45:06 +0800
Date:   Sun, 25 Apr 2021 16:45:05 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Christian Brauner <brauner@kernel.org>
Cc:     fstests@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH] generic: extend fscaps test
Message-ID: <YIUsEQLLCYCvOSE2@desktop>
References: <20210423111539.3591487-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210423111539.3591487-1-brauner@kernel.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Apr 23, 2021 at 01:15:39PM +0200, Christian Brauner wrote:
> From: Christian Brauner <christian.brauner@ubuntu.com>
> 
> Add a test to verify that setting a v3 fscap that is valid in an
> ancestor user namespace works.

The subject is not clear which test it updates, I can only know it's
generic/633 that calls idmapped-mounts binary to do the test.

> 
> Cc: fstests@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
> ---
>  src/idmapped-mounts/idmapped-mounts.c | 56 +++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
> index 870a8fe7..4e3252ca 100644
> --- a/src/idmapped-mounts/idmapped-mounts.c
> +++ b/src/idmapped-mounts/idmapped-mounts.c
> @@ -3193,6 +3193,62 @@ static int fscaps_idmapped_mounts_in_userns(void)
>  		goto out;
>  	}
>  
> +	/*
> +	 * Verify we can set an v3 fscap for real root this was regressed at
> +	 * some point. Make sure this doesn't happen again!
> +	 */

We usually don't add new test cases to existing tests, as that may
introduce new failures and let people think there's a regression, then
find out it's the new case introduced the failure.

But this test was just merged last week, and the test is closely related
to existing cases and could re-use the test framework/setups, so I think
it's fine to add this case.

But as above comment said, this new cases is targeted to a regression
happened previously, I think it'd be better to put it in a seperate test
function, not folded into an existing test function.

And is there a commit that fixed the mentioned regression? Reference it
in the comments would help people find the correct fix, if there's any.

Thanks,
Eryu

> +	if (fremovexattr(file1_fd, "security.capability")) {
> +		log_stderr("failure: fremovexattr");
> +		goto out;
> +	}
> +	if (expected_dummy_vfs_caps_uid(file1_fd, -1)) {
> +		log_stderr("failure: expected_dummy_vfs_caps_uid");
> +		goto out;
> +	}
> +	if (errno != ENODATA) {
> +		log_stderr("failure: errno");
> +		goto out;
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		log_stderr("failure: fork");
> +		goto out;
> +	}
> +	if (pid == 0) {
> +		if (!switch_userns(attr.userns_fd, 0, 0, false))
> +			die("failure: switch_userns");
> +
> +		if (expected_dummy_vfs_caps_uid(file1_fd2, -1))
> +			die("failure: expected_dummy_vfs_caps_uid");
> +		if (errno != ENODATA)
> +			die("failure: errno");
> +
> +		if (set_dummy_vfs_caps(file1_fd2, 0, 0))
> +			die("failure: set_dummy_vfs_caps");
> +
> +		if (!expected_dummy_vfs_caps_uid(file1_fd2, 0))
> +			die("failure: expected_dummy_vfs_caps_uid");
> +
> +		if (!expected_dummy_vfs_caps_uid(file1_fd, 0) && errno != EOVERFLOW)
> +			die("failure: expected_dummy_vfs_caps_uid");
> +
> +		exit(EXIT_SUCCESS);
> +	}
> +
> +	if (wait_for_pid(pid))
> +		goto out;
> +
> +	if (!expected_dummy_vfs_caps_uid(file1_fd2, 10000)) {
> +		log_stderr("failure: expected_dummy_vfs_caps_uid");
> +		goto out;
> +	}
> +
> +	if (!expected_dummy_vfs_caps_uid(file1_fd, 0)) {
> +		log_stderr("failure: expected_dummy_vfs_caps_uid");
> +		goto out;
> +	}
> +
>  	fret = 0;
>  	log_debug("Ran test");
>  out:
> 
> base-commit: 15510d3a208187e234333f7974580786d54d52dc
> -- 
> 2.27.0

Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55DCC433E0
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 15:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B24464E04
	for <linux-fstests@archiver.kernel.org>; Sun, 31 Jan 2021 15:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhAaPGD (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 31 Jan 2021 10:06:03 -0500
Received: from out20-99.mail.aliyun.com ([115.124.20.99]:49871 "EHLO
        out20-99.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbhAaPFC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 31 Jan 2021 10:05:02 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.12916|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.583838-0.00099194-0.41517;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=guan@eryu.me;NM=1;PH=DS;RN=3;RT=3;SR=0;TI=SMTPD_---.JT3MDfj_1612105396;
Received: from localhost(mailfrom:guan@eryu.me fp:SMTPD_---.JT3MDfj_1612105396)
          by smtp.aliyun-inc.com(10.147.42.22);
          Sun, 31 Jan 2021 23:03:16 +0800
Date:   Sun, 31 Jan 2021 23:03:11 +0800
From:   Eryu Guan <guan@eryu.me>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, anju@linux.vnet.ibm.com
Subject: Re: [PATCH ] check: add CLI option to repeat and stop tests in case
 of failure
Message-ID: <20210131150311.GE2350@desktop>
References: <56a687e167af434fa54429558164ff7fee32c67d.1611823132.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56a687e167af434fa54429558164ff7fee32c67d.1611823132.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Jan 28, 2021 at 02:19:41PM +0530, Ritesh Harjani wrote:
> Currently with -i <n> option the test can run for many iterations,
> but in case if we want to stop the iteration in case of a failure,
> it is much easier to have such an option which could check the failed
> status and stop the test from further proceeding.
> 
> This patch adds such an option thereby extending the -i <n> option
> functionality.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> ---
>  check | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/check b/check
> index c6ad1d6c0733..6f3a5d47e212 100755
> --- a/check
> +++ b/check
> @@ -15,6 +15,7 @@ sum_bad=0
>  bad=""
>  n_notrun=0
>  notrun=""
> +tc_status=""
>  interrupt=true
>  diff="diff -u"
>  showme=false
> @@ -27,6 +28,7 @@ brief_test_summary=false
>  do_report=false
>  DUMP_OUTPUT=false
>  iterations=1
> +istop=false
> 
>  # This is a global variable used to pass test failure text to reporting gunk
>  _err_msg=""
> @@ -68,6 +70,7 @@ check options
>      -T			output timestamps
>      -r			randomize test order
>      -i <n>		iterate the test list <n> times
> +    -istop <n>		iterate the test list <n> times, but stops iterating further in case of any test failure

Perhaps '-I' is a better option?

>      -d			dump test output to stdout
>      -b			brief test summary
>      -R fmt[,fmt]	generate report in formats specified. Supported format: [xunit]
> @@ -300,6 +303,7 @@ while [ $# -gt 0 ]; do
>  	-n)	showme=true ;;
>          -r)	randomize=true ;;
>  	-i)	iterations=$2; shift ;;
> +	-istop) iterations=$2; istop=true; shift ;;

Same here.

>  	-T)	timestamp=true ;;
>  	-d)	DUMP_OUTPUT=true ;;
>  	-b)	brief_test_summary=true;;
> @@ -926,6 +930,11 @@ function run_section()
>  for ((iters = 0; iters < $iterations; iters++)) do
>  	for section in $HOST_OPTIONS_SECTIONS; do
>  		run_section $section
> +		if [ "$tc_status" = "fail" ] && [ "$istop" = true ]; then

$tc_status only records the status of last test in the test list, and if
the last test passed, the iteration continues. e.g. I tested
generic/00[12], and generic/001 fails while generic/002 passes

  ./check -i 2 generic/001 generic/002

check still run 2 iterations as "tc_status" of generic/002 is not
"fail".

I think we could check $sum_bad is 0 or not.

Thanks,
Eryu

> +			interrupt=false
> +			status=`expr $sum_bad != 0`
> +			exit
> +		fi
>  	done
>  done
> 
> --
> 2.26.2

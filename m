Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2A0C432BE
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 23:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2203F60F90
	for <linux-fstests@archiver.kernel.org>; Tue, 31 Aug 2021 23:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbhHaXyV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 31 Aug 2021 19:54:21 -0400
Received: from mail106.syd.optusnet.com.au ([211.29.132.42]:51431 "EHLO
        mail106.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231511AbhHaXyU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 31 Aug 2021 19:54:20 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail106.syd.optusnet.com.au (Postfix) with ESMTPS id A697C80E2ED;
        Wed,  1 Sep 2021 09:53:23 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mLDZA-007Fmf-2R; Wed, 01 Sep 2021 09:53:20 +1000
Date:   Wed, 1 Sep 2021 09:53:20 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] common/filter: add _filter_bash()
Message-ID: <20210831235320.GK2566745@dread.disaster.area>
References: <20210830114156.1106699-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830114156.1106699-1-tytso@mit.edu>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=Tu+Yewfh c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=7-415B0cAAAA:8
        a=7c2d_yUJVyY4J4LjOK0A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Mon, Aug 30, 2021 at 07:41:56AM -0400, Theodore Ts'o wrote:
> This is needed to account for bash 5.1 adding line number annotation
> when a command like "bash -c /etc/passwd" fails, e.g., with
> 
>      bash: line 1: /etc/passwd: Permission denid
> 
> instead of:
> 
>      bash: /etc/passwd: Permission denid
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/filter     | 11 +++++++++++
>  tests/generic/572 | 33 +++++++++++++++++++--------------
>  2 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index 2efbbd99..4b250e8b 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -661,5 +661,16 @@ _filter_quota_report()
>  		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
>  }
>  
> +#
> +# Bash 5.1+ adds "line 1: " when printing an error running an executable
> +# for example, "bash -c /etc/passwd" will result in the error
> +# "bash: line 1: /etc/passwd: Permission denied" where as earlier
> +# versions of bash will omit the "line 1: " annotation.
> +#
> +_filter_bash()
> +{
> +	sed -e "s/^bash: line 1: /bash: /"
> +}

If this remains, it needs a much more specific name. "filter_bash"
could mean just about anything...

>  # make sure this script returns success
>  /bin/true
> diff --git a/tests/generic/572 b/tests/generic/572
> index f131c7ed..cded9ac6 100755
> --- a/tests/generic/572
> +++ b/tests/generic/572
> @@ -36,6 +36,11 @@ _scratch_mount
>  fsv_orig_file=$SCRATCH_MNT/file
>  fsv_file=$SCRATCH_MNT/file.fsv
>  
> +filter_output()
> +{
> +    _filter_bash | _filter_scratch
> +}

But given that this is only needed by a single test, why create
a generic "_filter_bash" function? Surely this could simply be:

filter_output()
{
    sed -e "s/^bash: line 1: /bash: /" | _filter_scratch
}

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

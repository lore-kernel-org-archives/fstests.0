Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACF1C432BE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 07:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD56B6109E
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 07:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbhIAHQo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 03:16:44 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:48313 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242513AbhIAHQo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 03:16:44 -0400
Received: from dread.disaster.area (pa49-195-182-146.pa.nsw.optusnet.com.au [49.195.182.146])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 9274582AE1F;
        Wed,  1 Sep 2021 17:15:46 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1mLKTJ-007N0m-B8; Wed, 01 Sep 2021 17:15:45 +1000
Date:   Wed, 1 Sep 2021 17:15:45 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Murphy Zhou <xzhou@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Pavel Reichl <preichl@redhat.com>,
        fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH v2] common/rc: fix MKSWAP_PROG quoting
Message-ID: <20210901071545.GA1756565@dread.disaster.area>
References: <20210831030426.nwcoelcnshq4wrxx@xzhoux.usersys.redhat.com>
 <20210831052632.p4kaygjeujipo4w5@fedora>
 <3d064e8a-514d-4a98-3db1-0de490107368@redhat.com>
 <20210831134207.aa4e26xuyji4npia@fedora>
 <YS5hRsSXNHYQdUv9@mit.edu>
 <20210901054822.phzkg5xqoocx3duq@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901054822.phzkg5xqoocx3duq@xzhoux.usersys.redhat.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=QpfB3wCSrn/dqEBSktpwZQ==:117 a=QpfB3wCSrn/dqEBSktpwZQ==:17
        a=kj9zAlcOel0A:10 a=7QKq2e-ADPsA:10 a=20KFwNOVAAAA:8 a=7-415B0cAAAA:8
        a=V_Uy1zL_bVCsFN1x20YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 01, 2021 at 02:16:20PM +0800, Murphy Zhou wrote:
> After commit
>   0e4dd8b9 common/rc: fix ignoring of errors on
> we are getting this error message when running swapfiles tests:
>   +./common/rc: line 2553: MKSWAP_PROG: command not found
> 
> Rewrite the line and add a filter for mkswap.
> 
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
> ---
> 
> Thanks all for the suggestions!
> 
> v2:
>   rewrite the line and add a filter
>   source filters for generic/643
> 
>  common/filter     | 6 ++++++
>  common/rc         | 2 +-
>  tests/generic/643 | 1 +
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/common/filter b/common/filter
> index 2efbbd99..0883a3fd 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -661,5 +661,11 @@ _filter_quota_report()
>  		s|^(.*?) (\d+) (\d+) (\d+)|$1 @{[$2 * 1024 /'$bsize']} @{[$3 * 1024 /'$bsize']} @{[$4 * 1024 /'$bsize']}|'
>  }
>  
> +# Filter mkswap warning about the permissions
> +_filter_mkswap_stderr()
> +{
> +	grep -v "insecure permission"
> +}
> +

This is a one-off, specific filter and the "stderr" part of the name
makes no sense. If you want this to be a generic filter, the name
is "_filter_insecure_permission()", not it's calling context.

But that just shows that this does not need to be in the common
filter code - doing so just makes readers have to go look up what
the filter is. That is:

>  # make sure this script returns success
>  /bin/true
> diff --git a/common/rc b/common/rc
> index 46b6b220..0a3933a5 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -2550,7 +2550,7 @@ _format_swapfile() {
>  	$CHATTR_PROG +C "$fname" > /dev/null 2>&1
>  	_pwrite_byte 0x61 0 "$sz" "$fname" >> $seqres.full
>  	# Ignore permission complaints on filesystems that don't support perms
> -	$(MKSWAP_PROG "$fname" 2> >(grep -v 'insecure permission' >&2)) >> $seqres.full
> +	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | _filter_mkswap_stderr

	$MKSWAP_PROG "$fname" 2>&1 >> $seqres.full | \
		grep -v "insecure permission"

will do what you want and is much more readable and easier to
understand.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

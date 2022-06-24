Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2DFC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 24 Jun 2022 06:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiFXGPa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXGP3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 02:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C8164D623
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656051326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BgGKZ1rTK/W8KP3iYmuhln2eUyPDrpdaod5DPwo8jDE=;
        b=E7tiTVF69ZE93e9vMwl3Nz9ENiErtJL3WWEhELi3YIicfLtgJjaQooT1GJDP9izsifwgyJ
        leX1zVTjJYn2OG9tp1ebqutG7SwwwosnyOzQtQvIQ3vyyG1ZTO44iAalQAD703TVWOKUnh
        TkNoD00ni2ZSDTNbatpKmEL0uXUshCI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-_L3WEA0TNO-42j10bP8jcA-1; Fri, 24 Jun 2022 02:15:24 -0400
X-MC-Unique: _L3WEA0TNO-42j10bP8jcA-1
Received: by mail-qk1-f199.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso1648764qkb.11
        for <fstests@vger.kernel.org>; Thu, 23 Jun 2022 23:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BgGKZ1rTK/W8KP3iYmuhln2eUyPDrpdaod5DPwo8jDE=;
        b=V0DNdARG1YrhmiQiKT4XVXGw6k02LmWf+8yjZ13pE9+LAyenoYY6dRN6lcOq1ZKyMl
         VPKvoTHoZ5UhwCqXBDgw2+BbLZ49jmLE+MDDkpHtQ/e07kw9xqfrQMhGN910DyUKnjyz
         EkZWLywY83GDoI2ld4GlO2Erk/2RHKYIqMbH/TwxcjaN8N1nr6i11RMhROyU8jAxErJn
         Owb+GRuNtxxAAOl+MFPow0Xd4154/AUM6KUanbGqYOgzLmHsAfGjj/fDUs3dSnFOzNI0
         gf8VB+XWcqrvt9VqGafv2U61VLJHeb4hJ3b//gwaW0xDHvmzA5ulpdHRc7kBsj182RIU
         0Igg==
X-Gm-Message-State: AJIora/Fr8bEOSCB/dJ1sxSndklf0oqqtkC6+stwzArhZVaNs9ledKxm
        Ranpfua7zwc4sLU54MjH75mHnzULxpJg7uLr5dm/1tOB6xiSIKKrTw2Qu1gYu+jX5RzUhZAt4n5
        3nOJ9kZ9hQ5+QRtq5sQ==
X-Received: by 2002:a05:6214:20ec:b0:464:6293:be01 with SMTP id 12-20020a05621420ec00b004646293be01mr35757984qvk.98.1656051323971;
        Thu, 23 Jun 2022 23:15:23 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vyceu2tjcSU4xKLM4E/R44fEK5pa/5ewKkG3AeEOTuZM+BsthuTYkW8jadW5sD+53IPe00Nw==
X-Received: by 2002:a05:6214:20ec:b0:464:6293:be01 with SMTP id 12-20020a05621420ec00b004646293be01mr35757969qvk.98.1656051323670;
        Thu, 23 Jun 2022 23:15:23 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a290e00b006a6b498e23esm1479243qkp.81.2022.06.23.23.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 23:15:23 -0700 (PDT)
Date:   Fri, 24 Jun 2022 14:15:17 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] add option to rerun failed tests
Message-ID: <20220624061517.qkfeni7aup6nuxya@zlang-mailbox>
References: <20220621160153.29591-1-ddiss@suse.de>
 <YrVAm6dzTUh3ufb6@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrVAm6dzTUh3ufb6@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jun 24, 2022 at 12:42:03AM -0400, Theodore Ts'o wrote:
> On Tue, Jun 21, 2022 at 06:01:51PM +0200, David Disseldorp wrote:
> > This RFC patchset adds support to loop on failed tests, as proposed by
> > Ted Ts'o in https://lwn.net/Articles/897061/:
> >   add a mode that will immediately rerun a failed test 25 or 100 times
> >   to establish a failure percentage.
> > 
> > There are a couple of things which I'd like to resolve before dropping
> > the RFC flag, but would appreciate early feedback on the approach here.
> 
> This is really exciting!  I was hoping to try it out, but the first
> patch doesn't apply to origin/master on xfstests-dev.

Hi Ted,

The origin/for-next has latest (testing) update. But for this issue you hit
below, you might need this patchset:

  https://lore.kernel.org/fstests/20220620192934.21694-1-ddiss@suse.de/

David sent that at first, to fix/change something before having this feature.
I've acked that, and will merge it this week. For this patchset, I'd like to
give it more time to get more reivew points.

Thanks,
Zorro

> 
> For example this patch hunk:
> 
> @@ -729,9 +750,7 @@ function run_section()
>  	prev_seq=""
>  	for seq in $list ; do
>  		# Run report for previous test!
> -		if [ "$tc_status" == "fail" ]; then
> -			bad+=("$seqnum")
> -		fi
> +		_stash_test_status "$seqnum" "$tc_status"
>  		if $do_report && [[ ! $tc_status =~ ^(init|expunge)$ ]]; then
>  			_make_testcase_report "$prev_seq" "$tc_status"
>  		fi
> 
> The relevant section of check looks like this:
> 
> 		# Run report for previous test!
> 		if $err ; then
> 			bad="$bad $seqnum"
> 			n_bad=`expr $n_bad + 1`
> 			tc_status="fail"
> 		fi
> 
> And "git blame" shows that this part of check hasn't changed since
> 2018, and I'm on the latest version upstream version of xfstests:
> 
> commit 568ac9fffeb6afec03e5d6c9936617232fd7fc6d (HEAD, tag: v2022.06.05, origin/master, origin/HEAD, kernel/master)
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Fri Jun 3 11:54:13 2022 +1000
> 
>     xfs/189: systemd monitoring of /etc/fstab sucks
> 
> 
> Was your patch based xfstests with some out-of-tree patches?
> 
> > The caveats are:
> > - rerun tests will be tracked as a single failure in @try and @bad
> >   + xunit reports do not include any rerun details
> > - .bad files generated on failure will be overwritten by test reruns
> > 
> > For xunit reports, I think it'll make sense to stash the aggregates in a
> > separate <test>.agg-results file or something. Similarly for .bad file
> > overwrites, I could add a .<rerun #> suffix for capturing all failure
> > data.
> 
> For xunit results fie, was assuming that simply we would just have
> multiple repeated testcase entries stored in the single results.xml
> file.  For example:
> 
> <testcase classname="xfstests.global" name="generic/476" time="354">
> 		<failure message="Test  failed, reason unknown" type="TestFail" />
> 		<system-out>
> 		...
> 	</testcase>
> <testcase classname="xfstests.global" name="generic/476" time="343">
> 	</testcase>
> <testcase classname="xfstests.global" name="generic/476" time="353">
> 	</testcase>
> 	...
> 
> I don't know that we need a separate file for the rerun tests, since
> it's not that hard to create a python script which parses the results
> and calculates the pass/fail percentages for any test which is run
> mutiple times.
> 
> 
> As far as haivng the .bad and .full files, I agree that some kind of
> .rerun-NN suffix would make a lot of sense.
> 
> Cheers,
> 
> 						- Ted
> 


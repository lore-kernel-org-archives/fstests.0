Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD28C77B61
	for <linux-fstests@archiver.kernel.org>; Sat, 22 Apr 2023 01:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjDVBt2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Apr 2023 21:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjDVBt1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Apr 2023 21:49:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46B3C0F
        for <fstests@vger.kernel.org>; Fri, 21 Apr 2023 18:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FAD964D2E
        for <fstests@vger.kernel.org>; Sat, 22 Apr 2023 01:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6B6C433EF;
        Sat, 22 Apr 2023 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682128164;
        bh=L+eBB1avjeG9SuRBLJ9ighvBxut9r4bsfU36nwP5GPc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TPmHrvRVIJtiddFnkBDQhq8WK+HQEm3ttweh1NST4xx8cif8bvM5oZhzjZ0n/wfe/
         fGZlLAevKKKvfGZQUFbvZ25CQ0wu9Ds8lx4mmlfVu3KBRf2cGIek20rwY3FR2597I/
         fnT+ANQYpsJpLo7ADvRv0nATevvaANB6JEbXWp9PV1gcqqUSjWAt5IL3jzpoQWnaLN
         qUUInXa/bTG8R/1kHgIcet1FzrCcmRGKzfQWWVjhskO7lVluj6fE8VYaemwvHXZl0Z
         zA33VxD/TiKjEW8NLV+PnYe6wMMKrbVRpIAgrPBgLy7ksk96SD5zjIRvStVWI19wzn
         2w5++00+E1LSg==
Date:   Fri, 21 Apr 2023 18:49:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 2/2] test-appliance: support a timestamp specifier which
 contains a timezone
Message-ID: <20230422014924.GS360895@frogsfrogsfrogs>
References: <20230420160837.1083228-1-tytso@mit.edu>
 <20230420160837.1083228-3-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420160837.1083228-3-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, Apr 20, 2023 at 12:08:37PM -0400, Theodore Ts'o wrote:
> Commit 545315976e72 ("report: capture the time zone in the test report
> timestamp") in the fstests upstream adds a timezone to the timestamp.
> This is useful, but it breaks the strptime parsing of the timestamp.
> It's not entirely clear that adding a timezone is legal.  According to
> this schema[1] that it is a ISO 8061 date/time stamp where the
> "Timezone may not be specified".  However in this schema[2], the
> timestamp is just an optional string, and it says nothing about the
> format of the timestamp.
> 
> [1] https://gist.github.com/jclosure/45d7005d120d90ba6430130356e4cd61#file-xunit-xsd-L140
> [2] https://github.com/junit-team/junit5/blob/main/platform-tests/src/test/resources/jenkins-junit.xsd#L96
> 
> It's not entirely clear which schema is "official", but in the spirit
> of the second part of Jon Postel's Robustness principal --- "be
> liberal in what you accept" --- fix gen_results_summary.py to accept
> an ISO 8061 timestamp with or without the timestamp.

FWIW I added the explicit UTC offset because without it, we have to
assume local time.  That works poorly when your fstests cloud is
scattered around the world, because then the result timestamps go all
over the place.

> It might be that in the spirit of "be conservative in what you send",
> fstests upstream should use the moral equivalent of 'date -u +"%F %T" |
> sed -e "s/ /T/"' instead of 'date -Iseconds', but this change will
> work either way, as well as with both the older and newer versions of
> fstests.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Probably the only sane way to handle this, so...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  .../usr/lib/python3/dist-packages/gen_results_summary.py  | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py b/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py
> index ecf5dc1a..44fb07d2 100644
> --- a/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py
> +++ b/test-appliance/files/usr/lib/python3/dist-packages/gen_results_summary.py
> @@ -61,8 +61,12 @@ def parse_timestamp(timestamp):
>      """Parse an ISO-8601-like timestamp as found in an xUnit file."""
>      if timestamp == "":
>          return 0
> -    return time.mktime(datetime.strptime(timestamp,
> -                                         '%Y-%m-%dT%H:%M:%S').timetuple())
> +    for fmt in ('%Y-%m-%dT%H:%M:%S%z', '%Y-%m-%dT%H:%M:%S'):
> +        try:
> +            return time.mktime(datetime.strptime(timestamp, fmt).timetuple())
> +        except ValueError:
> +            pass
> +    raise ValueError('no valid timestamp format found')
>  
>  def failed_tests(testsuite):
>      """This iterator the failed tests from the testsuite."""
> -- 
> 2.31.0
> 

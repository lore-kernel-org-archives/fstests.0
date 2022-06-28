Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D0AC433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 14:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347551AbiF1O4t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 10:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbiF1O4m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 10:56:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3732EC8
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 07:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37EA9B81EA2
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A77C341C6;
        Tue, 28 Jun 2022 14:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656428197;
        bh=4P8k1ISzwqZdcRPZAJ79lfme7C6OZRA7Fltzl/fupd4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jEl1kHk1+u9ytYx09tdk2ioB78nZ1M1zMEUdMuwp3SMV0398KFw4pytwj0Ezvu3Hs
         3qoFEbjM6cP0nZfEW280AC6tNfHCWTAFdZuwQWU6tXYiJnjIK3kSHO5HGp9z0XzrNf
         rWVQpAZvgAxriukQHRLReusxG6f/O+uMpzyt/rt0Zn+JH+Ar6ZYjBZTgwDOkeqmAw3
         v6zyAthaeZaO/iFIj9eCX9lS5T2vd2irLAUZ8KpIWMApaODk4/8Ap56in98EPuMOFK
         tdjVv2L7qx9eH7/mCS53CpOP4dLmbTYnK5i3DhNOcUg1nHaIqpxlYZRTOAkC9rFl4R
         nzTJxD5kAQE0g==
Date:   Tue, 28 Jun 2022 07:56:37 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC PATCH v2 3/6] check: make a few variables local
Message-ID: <YrsWpSEJkw6ih7JJ@magnolia>
References: <20220627222256.14175-1-ddiss@suse.de>
 <20220627222256.14175-4-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627222256.14175-4-ddiss@suse.de>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Jun 28, 2022 at 12:22:53AM +0200, David Disseldorp wrote:
> The variables aren't used outside of function scope. Also convert one
> timestamp output to use the helper.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  check | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/check b/check
> index 9d60df45..f973dd28 100755
> --- a/check
> +++ b/check
> @@ -176,10 +176,10 @@ get_all_tests()
>  # the function from that list.
>  trim_test_list()
>  {
> -	test_list="$*"
> +	local test_list="$*"
>  
>  	rm -f $tmp.grep
> -	numsed=0
> +	local numsed=0
>  	for t in $test_list
>  	do
>  	    if [ $numsed -gt 100 ]; then
> @@ -204,7 +204,7 @@ _wallclock()
>  
>  _timestamp()
>  {
> -    now=`date "+%T"`
> +    local now=`date "+%T"`
>      echo -n " [$now]"
>  }
>  
> @@ -600,7 +600,7 @@ fi
>  
>  function run_section()
>  {
> -	local section=$1
> +	local section=$1 skip
>  
>  	OLD_FSTYP=$FSTYP
>  	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
> @@ -817,7 +817,7 @@ function run_section()
>  		rm -f core $seqres.notrun
>  
>  		start=`_wallclock`
> -		$timestamp && echo -n "	["`date "+%T"`"]"
> +		$timestamp && _timestamp
>  		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
>  		$LOGGER_PROG "run xfstest $seqnum"
>  		if [ -w /dev/kmsg ]; then
> -- 
> 2.35.3
> 

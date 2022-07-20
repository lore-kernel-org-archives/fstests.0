Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EBC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 20 Jul 2022 17:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiGTRfZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGTRfX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 20 Jul 2022 13:35:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363906346
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 10:35:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5BEFB8216C
        for <fstests@vger.kernel.org>; Wed, 20 Jul 2022 17:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69AA5C3411E;
        Wed, 20 Jul 2022 17:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658338519;
        bh=NLmyTG2aBtJ5LEGc+yDnficu3GTex5SDXgN8QKASi3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNB8r/MAnc8ZHdrecRgL+ffT6eOuETrz1u2PPw//xubGx9wxxn0M/yqBpee3erBky
         jbORkPdedYwV3ZXwi9z/8T677/7pr+gfFIIyt42Bwo+wsgBGFyzOOMVZMlGwsa2ljC
         hykvhZZjd/Br+5wlxeAfkQp4YHt0/TOtBUI1C9ptaWKJjOmXYOdn/NtndNyQy8Fowk
         knUNGdWsIGF9Zw9comVTBLpEyU53r6p7uvz3g2mnx0LUf3vLLH/mYpeOgZun1blg5y
         rJhyDRWnc/0vvj3nX/KkqEmKtovcMvUHuHtYYZNwG60nzkHYueUjCMmi/VFd7NsX7d
         bWpVBVC2WX5aQ==
Date:   Wed, 20 Jul 2022 10:35:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH 3/4] dmflakey: don't run dmflakey tests with an external
 log device
Message-ID: <Ytg81qFyO+MF4ANk@magnolia>
References: <20220720164356.4078789-1-tytso@mit.edu>
 <20220720164356.4078789-4-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720164356.4078789-4-tytso@mit.edu>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Jul 20, 2022 at 12:43:55PM -0400, Theodore Ts'o wrote:
> dmflakey works by dropping all writes before unmounting to simulate a
> crash/power loss.  This doesn't work if there is an external log
> device, since we only drop writes to the primary block device, and not
> the external log device.  Fixing this for real would require somehow
> arranging to atomically loading a new dmflakey table for two block
> devices at the same time, so for now, just skip tests using dmflakey
> if the external log device is enabled.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  common/dmflakey | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/common/dmflakey b/common/dmflakey
> index 52da3b10..c2be78e9 100644
> --- a/common/dmflakey
> +++ b/common/dmflakey
> @@ -12,6 +12,10 @@ _init_flakey()
>  {
>  	# Scratch device
>  	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
> +
> +	if test "$USE_EXTERNAL" = yes -a ! -z "$SCRATCH_LOGDEV" ; then
> +		_notrun "dmflakey tests don't work with an external log device"
> +	fi

I'm kinda surprised this still doesn't work -- last year Eryu merged a
patch[1] from me that's supposed to make common/dmflakey work with
external log devices.  What kind of failures do you see?

--D

[1] 9c1f3149 ("dmflakey: support external log and realtime devices")

>  	FLAKEY_DEV=/dev/mapper/flakey-test
>  	FLAKEY_TABLE="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 180 0"
>  	FLAKEY_TABLE_DROP="0 $BLK_DEV_SIZE flakey $SCRATCH_DEV 0 0 180 1 drop_writes"
> -- 
> 2.31.0
> 
